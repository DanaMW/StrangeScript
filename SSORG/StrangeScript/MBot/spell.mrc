alias spell {
  if ($exists(spell.txt) == $true) { .remove spell.txt }
  unset %count*
  set %spell.room $1
  set %spell.word $2
  set %spell.write off
  unset %spell.count
  unset %spell.msg
  sockopen spell www.dictionary.com 80
}
on 1:sockopen:spell: {
  if ($sockerr > 0) { msg %spell.room Sockopen Error for $sockname | sockclose $sockname | return }
  msg %spell.room Trying to  get you a definition from dictionary.com, one moment ...
  if ($exists(spell.txt) == $true) { .remove spell.txt }
  sockwrite -tn spell GET http://dictionary.reference.com/search?q= $+ %spell.word  HTTP/1.1
  sockwrite -tn spell Host: www.dictionary.com 80
  sockwrite -tn spell Connection: Close
  sockwrite -tn spell $crlf
}
on 1:sockread:spell: {
  if ($sockerr > 0) { msg %spell.room Sockread Error for $sockname | sockclose $sockname | return }
  :read3 
  sockread %spell
  if ($sockbr == 0) { return }
  if (<h2 style="margin-bottom: 2em;"> isin %spell) {
    set %spell.write ON
    set %spell.msg $remove(%spell,<h2 style="margin-bottom: 2em;">,<i>,</i>,</h2>)
    set %spell.count $gettok(%spell.msg,1,32)
    write spell.txt $remove(%spell,<h2 style="margin-bottom: 2em;">,<i>,</i>,</h2>)
    goto read3
  }
  if (%spell.write == ON) && (</TABLE> isin %spell) { set %spell.write OFF }
  if (Antonyms isin %spell) { goto read3 }
  if (Middle English isin %spell) { goto read3 }
  if (SRC= isin %spell) { goto read3 }
  if (.gif isin %spell) { goto read3 }
  if (%spell.write == ON) {
    set %spell $remove(%spell,<OL TYPE="a"><LI TYPE="a">,<LI>,</LI>,<CITE>,</CITE>,<I>,</I>,<U>,</U>,<OL>,<B>,</B>,</OL>,<BR>,<TT>,</TT>,<LI TYPE="a">,<TD>,</TD>,<DL>,</DL>,<DD>,</DD>,<BLOCKQUOTE>,</BLOCKQUOTE>,<EM>,</EM>) 
    if (<A HREF isin %spell) { goto read3 }
    if (<HR ALIGN isin %spell) { goto read3 }
    if (ALIGN="BOTTOM isin %spell) { goto read3 }
    write spell.txt %spell
  }
  goto read3
}
on 1:sockclose:spell:{ .play %spell.room spell.txt | halt }
