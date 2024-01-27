alias cnn {
  unset %count*
  set %cnn.room $1
  set %cnn.user $2
  if ($3 == -r) { set %cnn.read $4 | sockopen cnn1 www.cnn.com 80 | return }
  if ($3 == -u) { set %cnn.url $4 | msg %cnn.room URL for link $4 $+ :  $+ $gettok($read(cnn.txt,$4),1,33) $+  | return }
  sockopen cnn www.cnn.com 80
}
on 1:sockopen:cnn: {
  if ($sockerr > 0) { msg %cnn.room Sockopen Error for $sockname | sockclose $sockname | return }
  msg %cnn.room Getting CNN news, one moment ...
  if ($exists(cnn.txt) == $true) { .remove cnn.txt }
  set %news.count 1
  sockwrite -tn cnn GET $chr(47) HTTP/1.1
  sockwrite -tn cnn Host: www.cnn.com 80
  sockwrite -tn cnn Connection: Close
  sockwrite -tn cnn $crlf
}
on 1:sockread:cnn: {
  if ($sockerr > 0) { msg %cnn.room Sockread Error for $sockname | sockclose $sockname | return }
  :read 
  sockread %cnn
  if ($sockbr == 0) { return }
  if (*<div class="cnnMainNewT2">&* iswm %cnn) {
    if (*span* iswm %cnn) { var %news. [ $+ [ %news.count ] ] http://www.cnn.com $+ $remove($gettok($remove(%cnn,>,</a,<br,<div,</div),5,61),",?cnn) $+ ! $+ $remove($gettok($gettok(%cnn,3,59),3,34),>,</a,<br,</div) }
    else { var %news. [ $+ [ %news.count ] ] http://www.cnn.com $+ $remove($gettok($gettok(%cnn,2,59),2,34),=) $+ ! $+ $remove($gettok($gettok(%cnn,2,59),3,34),>,</a,<br,</div) }
    write cnn.txt %news. [ $+ [ %news.count ] ]
    msg %cnn.room %news.count $+ . $gettok(%news. [ $+ [ %news.count ] ],2,33)
    inc %news.count
  }
  goto read
}
on 1:sockclose:cnn:{ msg %cnn.room Use .cnn -r $chr(35) for article. | msg %cnn.room Use .cnn -u $chr(35) for link. }
on 1:sockopen:cnn1: {
  if ($sockerr > 0) { msg %cnn.room Sockopen Error for $sockname | sockclose $sockname | return }
  msg %cnn.room Getting your chosen article, one moment ...
  if ($exists(cnn.tmp.txt) == $true) { .remove cnn.tmp.txt }
  sockwrite -tn cnn1 GET $gettok($read(cnn.txt, n,%cnn.read),1,33) HTTP/1.1
  sockwrite -tn cnn1 Host: www.cnn.com 80
  sockwrite -tn cnn1 Connection: Close
  sockwrite -tn cnn1 $crlf
}
on 1:sockread:cnn1: {
  if ($sockerr > 0) { msg %cnn.room Sockread Error for $sockname | sockclose $sockname | return }
  :read1 
  sockread %cnn1
  if ($sockbr == 0) { return }
  write cnn.tmp.txt %cnn1
  ;if (*<div class="cnnMainNewT2">&* iswm %cnn) {
  ;  if (*span* iswm %cnn) { var %news. [ $+ [ %news.count ] ] http://www.cnn.com $+ $remove($gettok($remove(%cnn,>,</a,<br,<div,</div),5,61),",?cnn) $+ , $+ $remove($gettok($gettok(%cnn,3,59),3,34),>,</a,<br,</div) }
  ;  else { var %news. [ $+ [ %news.count ] ] http://www.cnn.com $+ $remove($gettok($gettok(%cnn,2,59),2,34),=) $+ , $+ $remove($gettok($gettok(%cnn,2,59),3,34),>,</a,<br,</div) }
  ;  write cnn.txt %news. [ $+ [ %news.count ] ]
  ;  msg %cnn.room %news.count $+ . $gettok(%news. [ $+ [ %news.count ] ],2,44)
  ;  inc %news.count
  ;}
  goto read1
}
on 1:sockclose:cnn1:{
  cnn.find.article
  msg %cnn.room Article complete.
}
alias cnn.find.article {
  ;write -cn cnn.log links -dump $gettok($read(cnn.txt,%cnn.read),1,44) > ./cnn.art.txt
  ;run cmd.exe /K sh.exe < ./cnn.log
  ;run  cmd.exe /C links -dump $gettok($read(cnn.txt,%cnn.read),1,34) > $+ $mircdirmbot\cnn.art.txt
  ;goto ex1
  ;run cmd /K cnn.cmd $gettok($read(cnn.txt,%cnn.read),1,44)
  ;halt
  var %cnn.find = $read(cnn.tmp.txt, w, *<!-- /Alert Box Encapsulation -->*)
  if (%cnn.find == $null) { var %cnn.find = $read(cnn.tmp.txt, w, *Paste story between here*) }
  ;if (%cnn.find == $null) { var %cnn.find = $read(cnn.tmp.txt, w, *endclickprintexclude*) }
  if (%cnn.find == $null) { msg %cnn.room Error couldnt extract your story 1 | halt }
  else {
    set %count1 $calc($readn +1)
    ;msg %cnn.room Found starting point %count1
    ;var %cnn.find = $read(cnn.tmp.txt, w, *Paste story between here*,$calc(%count1 +1))
    var %cnn.find = $read(cnn.tmp.txt, w, *endclickprintinclude*,$calc(%count1 +1))
    if (%cnn.find == $null) {  msg %cnn.room Error couldnt extract your story 2 | halt }
    else {
      set %count2 $calc($readn -1)
      ;msg %cnn.room Found ending point %count2
      goto escape
    }
  } 
  halt
  :escape
  if ($exists(cnn.art.txt) == $true) { .remove cnn.art.txt }
  while (%count1 <= %count2) {
    var %xtmp = $remove($read(cnn.tmp.txt, n,%count1),</p>,<p>,<b,</b)
    var %xxtmp = $numtok(%xtmp,32)
    if (%xxtmp == 0) { goto nope }
    write cnn.art.txt $gettok(%xtmp,1-15,32)
    if ($numtok(%xtmp,32) > 15) { write cnn.art.txt $gettok(%xtmp,16-30,32) }
    if ($numtok(%xtmp,32) > 30) { write cnn.art.txt $gettok(%xtmp,31-45,32) }
    if ($numtok(%xtmp,32) > 45) { write cnn.art.txt $gettok(%xtmp,46-60,32) }
    :nope
    ;msg %cnn.room $remove($read(cnn.tmp.txt, n,%count1),</p>,<p>,<b,</b)
    inc %count1
    if (%count1 > %count2) { break }
  }
  :ex1
  if ($exists(cnn.art.txt) == $true) {
    var %count = 1
    while (%count <= $lines(cnn.art.txt)) {
      .msg %cnn.room $read(cnn.art.txt, n,%count)
      ;.notice %cnn.user $read(cnn.art.txt, n,%count)
      inc %count
    }
  }
}
