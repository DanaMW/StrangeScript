alias between { 
  noop $regex($1,/\Q $+ $2 $+ \E(.*?)\Q $+ $3 $+ \E/gi) 
  return $regml($4) 
}
menu * {
  -
  .StrangeScript SetUp:/dialog $iif($dialog(SetUp),-v,-m) SetUp SetUp 
}
alias SetUphelp { dialog $iif($dialog(SetUp),-v,-m) SetUp SetUp | if ($1) initString SetUp $1 }
alias initString {
  var %i = $did(SetUp,1).lines, %t, %v = 0
  while (%i) {
    if ($did(SetUp,1,%i) == $1-) { did -c SetUp 1 %i | %v = 1 | break }
    dec %i
  }
  if (!%v) {
    return $input(That was an invalid SetUp numeric. Please make another selection from the list.,wok6,Invalid SetUp Numeric)
  }
  getSetUp $2
}
alias SetUpload {
  var %r = $1
  did -ra SetUp 2 $gettok($broke [ $+ [ %r ] ],1,126)
  did -ra SetUp 4 $gettok($broke [ $+ [ %r ] ],2,126)
  did -ra SetUp 6 $gettok($broke [ $+ [ %r ] ],3,126)
  did -ra SetUp 8 $gettok($broke [ $+ [ %r ] ],4,126)
  did -ra SetUp 10 $gettok($broke [ $+ [ %r ] ],5,126)
  did -ra SetUp 16 $gettok($broke [ $+ [ %r ] ],6,126) 
  did -c SetUp 2,4,6,8,10,16 1
}
alias broke212 { return A series of these are sent in reply to a STATS m request. They contain statistics on the commands a server supports. You must be an IRCop to use this feature on some servers.~212 command uses bytes~212 PRIVMSG 28931 1446042~All~None.~212 (multiple lines), 219 }
alias broke305 { return This is returned when you return from being AWAY. (by setting a blank away reason.)~305 :You are no longer marked as being away~All~This reply does not make any mention of why you were AWAY or for how long, it merely informs you that you are no longer marked as AWAY.~When you set an AWAY message, 306 is returned }
alias broke340 { return Returned when performing a /USERIP lookup on a person.~340 nick :nickname=+user@IP.address~340 Mentality :bleh=+ekg@127.0.0.1~ircu (Undernet), QuakeNet~Some networks have restricted the function to IRC Operators only.~The SetUp for a /USERHOST lookup is 302 }
alias broke381 { return This numeric is returned when you successfuly become an IRC operator using the OPER command.~381 :You are now an IRC Operator~381 :You are now an IRC Operator~All~This should be preceded by an automatic usermode change that includes +o or +O. (IRC operator)~None. }
alias broke404 { return Returned when you try to send a message to a channel, but the server refuses to let you send the message due to channel MODE settings. When this reply is returned, nothing is seen on the channel to indicate you attempted to say something.~404 channel :Cannot send to channel~404 #anime :Cannot send to channel~All~Your message can be refused for two reasons- .If a channel is MODE +n, and you are not on the channel, you cannot send a message to it. If a channel is MODE +m, and you are not opped (+o) or voiced (+v) on the channel, you cannot send a message to it.~None. }
alias broke408 { return Returned if you are trying to send control codes to a channel that is set +c.~408 nickname #channel :You cannot use colors on this channel. Not sent: text~408 hantu #mirc.net :You cannot use colors on this channel. Not sent: woohey woogie~DALnet~Only control code blocked by the mode on DALnet is color (ctrl+k) codes.~None. }
alias broke421 { return Returned when you use an IRC command that the server does not recognize.~421 command :Unknown command~421 BLAH :Unknown command~All~Common reasons for this error - Using a command from another network on a server that doesn't support it (such as SILENCE). Misspelling a command. Missing a mIRC alias.~None. }
dialog SetUp {
  title "Script SetUp"
  size -1 -1 260 120
  option dbu
  list 1, 2 2 50 99, vsbar size
  edit "", 2, 92 2 165 20, read multi return vsbar
  text "Info:", 3, 55 2 15 8
  edit "", 4, 92 24 165 11, read autohs
  text "Syntax:", 5, 55 24 20 8
  edit "", 6, 92 37 165 11, read autohs
  text "Example:", 7, 55 38 21 8
  edit "", 8, 92 50 165 11, read autohs
  text "Supported by:", 9, 55 51 35 8
  edit "", 10, 92 63 165 25, read multi return vsbar
  text "Notes:", 11, 55 63 17 8
  box "", 12, 0 103 259 1
  button "OK", 13, 225 106 32 12, ok
  button "View site", 14, 191 106 32 12
  edit "", 16, 92 90 165 11, read autohs
  text "See also:", 17, 55 91 35 8
  button "Message", 18, 157 106 32 12
  combo 19, 264 9 55 35, drop
  box "Category", 20, 261 1 62 22
  list 21, 264 27 55 90, vsbar size
  button "View categories", 22, 110 106 45 12
}
on *:dialog:SetUp:init:0: {
  var %x = 1
  while (%x <= 606) {
    if ($istok(1 2 3 4 5 7 8 211 212 213 214 215 216 217 218 219 221 222 223 224 241 242 243 244 247 248 249 250 251 252 253 254 255 256 257 258 259 263 265 266 271 272 280 281 290 291 292 293 294 298 301 302 303 305 306 307 310 311 312 313 314 315 317 318 319 321 322 323 324 328 329 331 332 333 340 341 346 347 348 349 351 352 353 364 365 366 367 368 369 371 374 375 376 377 378 381 382 391 401 402 403 404 408 405 406 407 409 411 412 413 414 416 421 422 423 431 432 433 436 437 438 439 441 442 443 445 446 451 455 461 462 467 468 471 472 473 474 475 477 478 481 482 483 484 485 491 501 502 510 511 512 513 600 601 602 603 604 605 606,%x,32)) {
      did -a $dname 1 SetUp $right(000 $+ %x,3)
    }
    inc %x
  }
  var %x = 1, %t = $key($network,auto.join.rooms)
  while (%x <= $numtok(%t,44)) {
    did -a $dname 19 $gettok(%t,%x,44)
    inc %x
  }
  did -c $dname 19 1
  var %x = 1
  while (%x <= $numtok($SetUp.admin,44)) {
    did -a $dname 21 SetUp $gettok($SetUp.admin,%x,44)
    inc %x
  }
}
alias SetUp.#adiirc  { return }
alias SetUp.#StrangeScript  { return }
on *:dialog:SetUp:dclick:1: { getSetUp $gettok($did(SetUp,1).seltext,2,32) }
on *:dialog:SetUp:dclick:21: { 
  getSetUp $gettok($did(SetUp,21).seltext,2,32)
  dialog -s $dname -1 -1 520 240
  did -ra $dname 22 View categories
  unset %viewcat
}
on *:dialog:SetUp:sclick:*: {
  if ($did == 19) {
    did -r $dname 21
    var %x = 1, %y = $did(19).text
    while (%x <= $numtok($eval($chr(36) $+ SetUp. $+ %y,2),44)) {
      did -a $dname 21 SetUp $gettok($eval($chr(36) $+ SetUp. $+ %y,2),%x,44)
      inc %x
    }
  }
  if ($did == 14) {
    if ($lock(run)) {
      noop $input(It appears you have the run setting in your mIRC options $crlf $+ turned off. Please enable it and try again.,uwo,Error!)
    }
    if (!$did(1).sel) {
      noop $input(You have selected no SetUp to view.,uwo,Error!)
    }
    else {
      run http://www.mirc.net/SetUp/?view= $+ %SetUpnum
    }
  }
  if ($did == 18) {
    if (!$did(1).sel) || (!$did(2).text) || (!$did(4).text) || (!$did(6).text) {
      noop $input(It appears there is not enough/no SetUp information to message.,uwo,Error!) 
    }
    elseif ($window($active) == Status Window) {
      noop $input(You can't send a message to the status window!,uwo,Error!)
    }
    else {
      msg $active SetUp: $gettok($did(1).seltext,2,32)
      var %x = 1
      while (%x <= $did(2).lines) {
        set %rinfo %rinfo $did(SetUp,2,%x).text
        inc %x
      }
      msg $active Information: %rinfo
      msg $active Syntax: $did(4).text
      msg $active Example: $did(6).text
    }
    unset %rinfo
  }
  if ($did == 22) {
    if (!%viewcat) {
      set %viewcat on
      dialog -s $dname -1 -1 653 240
      did -ra $dname 22 Hide categories
    }
    else {
      dialog -s $dname -1 -1 520 240
      unset %viewcat
      did -ra $dname 22 View categories
    }
  }
}
on *:dialog:SetUp:close:0: { unset %viewcat }
dialog wait {
  title "Please wait"
  size -1 -1 99 11
  option dbu
  text "Please wait while the info is gathered..", 1, 2 2 95 8
}
on *:dialog:wait:init:0: { did -b $dname 1 }
on *:sockopen:sockSetUp: {
  did -r SetUp 16,6,10,4,8,2
  sockwrite -n $sockname GET /SetUp/?view= $+ %SetUpnum HTTP/1.0
  sockwrite -n $sockname Host: www.mirc.net $+ $crlf $+ $crlf
}
on *:sockread:sockSetUp: {
  .timerwait 0 1 checkwait
  sockread %SetUpread
  if (</a><p /> isin $remove(%SetUpread,$chr(9))) { 
    set %SetUpinfo $right($nopath(%SetUpread),-1)
  }
  if (<b>Supported by</b> isin $remove(%SetUpread,$chr(9))) {
    set %SetUpsupport $between(%SetUpread,<b>Supported By</b></span><br />,<br />,1)
  }
  if (<b>Syntax</b> isin $remove(%SetUpread,$chr(9))) {
    set %SetUpsyntax $htmlfree($between(%SetUpread,<b>Syntax</b></span><br />,<br />,1))
  }
  if (<b>Example</b> isin $remove(%SetUpread,$chr(9))) {
    set %SetUpexample $between(%SetUpread,<b>Example</b></span><br />,<br />,1)
  }
  if (<b>See Also</b> isin $remove(%SetUpread,$chr(9))) {
    inc %SetUpnumread 
  }
  elseif (%SetUpnumread == 1) {
    set %SetUpseealso $htmlfree(%SetUpread)
    inc %SetUpnumread
  }
  if (<b>Notes</b> isin $remove(%SetUpread,$chr(9))) {
    set %SetUpnotez $iif($regex(notes,%SetUpread,/<b>Notes</b></span><br />(.+)$/),$regml(notes,1))
  }
  if (%SetUpseealso) { did -ra SetUp 16 $iif(%SetUpseealso,$v1,None.) }
  if (%SetUpsupport) { did -ra SetUp 6 %SetUpexample }
  if (%SetUpsyntax) { did -ra SetUp 10 $iif(%SetUpnotez,$htmlfree($v1),None.) }
  if (%SetUpexample) { did -ra SetUp 4 %SetUpsyntax }
  if (%SetUpnumread) { did -ra SetUp 8 %SetUpsupport }
  if (%SetUpinfo) { did -ra SetUp 2 %SetUpinfo }
}
on *:SOCKCLOSE:sockSetUp: { did -c SetUp 16,6,10,4,8,2 1 | unset %SetUp* | checkwait }
alias checkwait {
  if (!$dialog(SetUp)) { .timerwait off }
  if (!$dialog(wait)) { .timerwait off }
  if ($did(SetUp,2).text) && ($did(SetUp,4).text) && ($did(SetUp,6).text) && ($did(SetUp,8).text) && ($did(SetUp,10).text) && ($did(SetUp,16).text) {
    if ($dialog(wait)) { dialog -x wait wait }
    .timerwait off
  }
}
