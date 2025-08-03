n0=;Groups Def. for "menu's"
;
on 1:SOCKOPEN:Protect*:{
  if ($sockerr > 0) { echo -st Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  sockwrite -n $sockname user $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999)
  sockwrite -n $sockname nick $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999)
}
on 1:SOCKREAD:Protect*:{
  if ($sockerr > 0) { Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  :bcread
  sockread %bcreadline
  if ($sockbr == 0) { return }
  if ($gettok(%bcreadline,1,32) == PING) { sockwrite -n $sockname PONG $gettok(%bcreadline,2,32) | echo -h $sockname 10[00OutBound10][00Me10] $+ : 04 $+ Sent Pong Event $gettok(%bcreadline,2,32) | set %clone.server [ $+ [ $right($sockname,-5) ] ] $gettok(%bcreadline,2,32) } 
  if ($remove($left(%bcreadline,$calc($pos(%bcreadline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%bcreadline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname notice $me : $+ $chr(1) $+ PING $gettok(%bcreadline,5-6,32) $+ $chr(1) }
  goto bcread
}
on 1:SOCKOPEN:Spy*:{
  if ($sockerr > 0) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44)  $report(SockError,OPEN,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg) | sockclose $sockname | return }
  if (*strange* iswm $sockname) { sockwrite -n $sockname pass %server.spy.pass.strange $cr user $remove(%boss. [ $+ [ $network ] ],`) $remove(%boss. [ $+ [ $network ] ],`) $remove(%boss. [ $+ [ $network ] ],`) $remove(%boss. [ $+ [ $network ] ],`) }
  else { sockwrite -n $sockname user $remove(%boss. [ $+ [ $network ] ],`) $remove(%boss. [ $+ [ $network ] ],`) $remove(%boss. [ $+ [ $network ] ],`) $remove(%boss. [ $+ [ $network ] ],`) }
  sockwrite -n $sockname nick %server.spy.nick. [ $+ [ $remove($sockname,Spy) ] ]
  sockmark $sockname %server.spy.nick. [ $+ [ $remove($sockname,Spy) ] ]
  sockwrite -n $sockname privmsg nickserv :identify %server.spy.pass. [ $+ [ $lower($remove($sockname,Spy)) ] ]
  .timer 1 3 sockwrite -n $sockname nickserv identify %server.spy.pass. [ $+ [ $lower($remove($sockname,Spy)) ] ]
  sockwrite -n $sockname join $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,3,44)
  .timer 1 3 sockwrite -n $sockname join $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,3,44)
  msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(SockOpen,$sockname is now open and set)
}
on 1:SOCKREAD:Spy*:{
  if ($sockerr > 0) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44)  $report(Sock Error,READ,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg) | sockclose $sockname | return }
  :spyread
  sockread %spy.readline
  if ($sockbr == 0) { return }
  .tokenize 32 %spy.readline
  if ($1 == PING) { 
    sockwrite -n $sockname PONG $2
    ;msg $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) sent pong to $remove($gettok(%spy.readline,2,32),:) $chr(93)
    set %clone.server. [ $+ [ $sockname ] ] $remove($2,:)
  }
  if (*having problems connecting* iswm $1-) {
    msg %boss. [ $+ [ $network ] ] $1-
    sockwrite -n $sockname pong $19
  }
  if ($remove($left(%spy.readline,$calc($pos(%spy.readline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%spy.readline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname notice $me : $+ $chr(1) $+ PING $gettok(%spy.readline,5-6,32) $+ $chr(1) }
  if ($2 == 353) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($remove($sockname,Spy),Users) $+ :  $+ $gettok(%spy.readline,6-,32) | goto bossout }
  if ($2 == 311) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 312) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 307) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 319) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 352) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Who) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 315) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Who) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 364) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Links) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == 365) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Links) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($2 == PART) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Part,$remove($gettok(%spy.readline,1,33),:),$gettok($gettok(%spy.readline,1,32),2,64),Left $remove($gettok(%spy.readline,3,32),:)) }
  if ($2 == JOIN) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Join,$remove($gettok(%spy.readline,1,33),:),$gettok($gettok(%spy.readline,1,32),2,64),entered $remove($gettok(%spy.readline,3,32),:)) }
  if ($2 == NOTICE) {
    if (*PING* iswm $1-) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : Ping Reply $duration($calc(($ticks - $remove($gettok(%spy.readline,4-,32),:,$chr(1),PING,$chr(160))) / 1000)) }
    else { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Notice,$remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:)) $+ : $remove($gettok(%spy.readline,4-,32),:) }
  }
  if ($2 == NICK) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93),NickChange,$remove($gettok(%spy.readline,1,33),:),is now know as,$remove($gettok(%spy.readline,3,32),:)) }
  ;from above in case i need it $chr(93) $remove($gettok(%spy.readline,4-,32),:)
  if ($2 == QUIT) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Quit,$remove($gettok(%spy.readline,1,33),:)) $+ :  $+ $remove($gettok(%spy.readline,3-,32),:) }
  if ($2 == TOPIC) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Topic,$remove($gettok(%spy.readline,1,33),:),set $remove($gettok(%spy.readline,3,32),:)) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) }
  if ($2 == KICK) {
    msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Kick $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) kicked $remove($gettok(%spy.readline,4,32),:) from $remove($gettok(%spy.readline,3,32),:) $chr(93) $chr(91) $remove($gettok(%spy.readline,5-,32),:) $chr(93) 
    if ($sock($sockname).mark == $remove($gettok(%spy.readline,4,32),:)) { sockwrite -n $sockname join $remove($gettok(%spy.readline,3,32),:) }
  }
  if ($2 == MODE) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Mode,$remove($gettok(%spy.readline,1,33),:),set $remove($gettok(%spy.readline,4-,32),:),on $remove($gettok(%spy.readline,3,32),:)) }
  if ($2 == PRIVMSG) {
    ;Ctcp Handling
    if ($left($remove($gettok(%spy.readline,4-,32),:),1) == $chr(1)) {
      if ($remove($remove($gettok(%spy.readline,4,32),:),$chr(1)) == PING) { sockwrite -n $sockname notice $remove($gettok(%spy.readline,1,33),:) : $+ $remove($gettok(%spy.readline,4-,32),:) }
      if (* $+ $chr(1) $+ ACTION* iswm $remove($gettok(%spy.readline,4-,32),:)) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93),Action) $+ :    $+ $color(action) $+ $remove($gettok(%spy.readline,1,33),:)  $left($remove($gettok(%spy.readline,4-,32),: $+ $chr(1) $+ ACTION),-1) | goto bossout }
      else { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Ctcp $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : $remove($remove($gettok(%spy.readline,4-,32),:),$chr(1)) | goto bossout }
    }
    if ($chr(35) isin $remove($3,:)) {
      ;msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) $remove($3,:) $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) $chr(93) $+ : $remove($gettok(%spy.readline,4-,32),:)
    msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),$remove($3,:),$remove($gettok(%spy.readline,1,33),:)) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:)    }
    else {
      notice %boss. [ $+ [ $network ] ] $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Privmsg $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) Whispered to $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : $remove($gettok(%spy.readline,4-,32),:) 
      ;msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Privmsg $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) Whispered to $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : $remove($gettok(%spy.readline,4-,32),:) 
    }
  }
  :bossout
  ;notice %boss. [ $+ [ $network ] ] $sockname %spy.readline
  goto spyread
}
on 1:SOCKCLOSE:Spy*:{
  unset %clone.server. [ $+ [ $sockname ] ]
  msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(SockClose,$sockname,just closed,$sock($sockname).wserr,$sock($sockname).wsmsg)
  if ($sockname == SpyRIZ) { s.timer 1 1 ockopen SpyRIZ irc.icq.com 6667 | notice %boss. [ $+ [ $network ] ] $report(ServerSpy,ON,RIZ) }
  if ($sockname == SpyDAL) { .timer 1 1 sockopen SpyDAL irc.dal.net 6667 | notice %boss. [ $+ [ $network ] ] $report(ServerSpy,ON,DAL) }
  if ($sockname == SpySTRANGE) { .timer 1 1 sockopen SpySTRANGE cos.selfip.biz 6667 | notice %boss. [ $+ [ $network ] ] $report(ServerSpy,ON,STRANGE) }
  if ($sockname == SpyXPEACE) { .timer 1 1 sockopen SpyXPEACE irc.xpeacex.com 6667 | notice %boss. [ $+ [ $network ] ] $report(ServerSpy,ON,XPEACE) }
  if ($sockname == SpyCHAT) { .timer 1 1 sockopen SpyCHAT irc.chatnet.org 6667 | notice %boss. [ $+ [ $network ] ] $report(ServerSpy,ON,CHAT) }
}
on *:NOTIFY: {
  notice %boss. [ $+ [ $network ] ] $report(NoteOn,$null,$nick graced us with his presence on,$network)
}
on *:UNOTIFY: {
  notice %boss. [ $+ [ $network ] ] $report(NoteOff,$null,We seem to have lost $nick from,$network)
}
on 1:text:8ball*:#: { 
  if (%8ball.Running  == ON) {
    if ($2 == $null) { msg # $report(You need to ask a yes or no question.,$null,Example: 8ball Am i cool?) | halt }
    if ($2 != $null) {
      msg # $report(8ball,$null,$null,$2-)
      msg # $report($read($Textdir $+ 8ball.txt))
      halt
    }
  }
}
alias 8 {
  if (%8ball.Running == OFF) && ($nick != $null) { $report(The 8ball is disabled).active | return }
  if ($1 == $null) && ($nick == $null) { msg # $report(You need to ask a yes or no question. Example: 8ball am i cool?) | return }
  if ($1 == $null) && ($nick != $null) { $report(You need to ask a yes or no question. Example: 8ball am i cool?).active | return }
  if ($nick == $null) { $report(8ball,$null,$null,$1-).active | $report($read($Textdir $+ 8ball.txt)).active }
  if ($nick != $null) { msg # $lowcol $+ $read($Textdir $+ 8ball.txt) }
  else { 
    if ($nick != $null) { notice $nick $report(The 8ball is disabled).active | return }
    if ($nick == $null) { msg # $report(The 8ball is disabled) | return }
  }
}
