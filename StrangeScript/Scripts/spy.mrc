alias spy {
  if ($1 == ON) {
    if ($2 == human) {
      sockopen -n SpyHuman localhost 6667
      return
    }
    if ($2 == ircgo) {
      sockopen -n SpyIRCGo irc.IRCGo.org 6667
      return
    }
    $report(Spy,$null,Input Error,$null,$null,$null,You need to do /SPY ON HUMAN or IRCGO).active
    return
  }
  if ($1 == OFF) {
    sockclose *
    return
  }
  if ($1 == WRITE) {
    set %say.value $2-
    set %say.trigger 1
    return
  }
  if ($1 == SET) {
    if ($2 == bot.disp) {
      if (%bot.disp == channel) { set %bot.disp message }
      else { set %bot.disp channel }
      return
    }
    if ($2 == work.chan) {
      if ($3 == $null) { return }
      set %work.chan $3
      return
    }
    if ($2 == bot.nick) {
      if ($3 == $null) { return }
      set %bot.nick $3
      return
    }
    if ($2 == bot.pass) {
      if ($3 == $null) { return }
      set %bot.pass $3
      return
    }
    if ($2 == say.value) {
      set %say.value $3-
      if (%say.value == $null) { set %say.value - }
      return
    }
    if ($2 == say.trigger) {
      if (%say.trigger == 1) { set %say.trigger 0 }
      else { set %say.trigger 1 }
      return
    }
    $report(Spy SET,$null,$null,$null,use /SPY SET value.below).active
    $report(SET,$null,Option,$null,$null,$null,bot.disp).active
    $report(SET,$null,Option,$null,$null,$null,work.chan).active
    $report(SET,$null,Option,$null,$null,$null,bot.nick).active
    $report(SET,$null,Option,$null,$null,$null,bot.pass).active
    $report(SET,$null,Option,$null,$null,$null,say.value).active
    $report(SET,$null,Option,$null,$null,$null,say.trigger).active
    $report(Spy SET,$null,$null,$null,*******************).active
    return
  }
  if ($1 == SHOW) {
    $report(Spy Show Menu,$null,$null,**********,************).active
    $report(Spy Show Menu,$null,$null,$null,use /spy set value.below to alter).active
    $report(Spy Show Menu,$null,$null,**********,************).active
    $report(Spy Show Menu,$null,t,bot.disp,%bot.disp).active
    $report(Spy Show Menu,$null,$null,work.chan,%work.chan).active
    $report(Spy Show Menu,$null,$null,bot.nick,%bot.nick).active
    $report(Spy Show Menu,$null,$null,bot.pass,%bot.pass).active
    $report(Spy Show Menu,$null,$null,say.value,%say.value).active
    $report(Spy Show Menu,$null,t,say.trigger,%say.trigger).active
    $report(Spy Show Menu,$null,$null,xxx,no value).active
    $report(Spy Show Menu,$null,$null,xxx,no value).active
    $report(Spy Show Menu,$null,$null,**********,************).active
    return
  }
  if ($1 == SEND) { sockwrite -n spy* privmsg %work.chan :Send not configured for some reason. Right Dana? }
  if ($1 == JOIN) {
    if ($2 != $null) { sockwrite -n Spy* join $2 }
    return
  }
  if ($1 == PART) {
    if ($2 != $null) { sockwrite -n Spy* part $2 }
    return
  }
  $report(SPY,$null,Options,$null,$null,$null,ON, OFF, WRITE, SET, JOIN, PART, SHOW, SEND).active
  return
}
on 1:SOCKOPEN:Spy*:{
  if ($sockerr > 0) { sockclose $sockname | privmsg $me Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  if ($sockname == SpyHuman) {
    sockwrite -n $sockname pass %bot.pass
    sockwrite -n $sockname nick %bot.nick
    sockwrite -n $sockname user $remove(%bot.nick,`) $remove(%bot.nick,`) $remove(%bot.nick,`) : $+ $remove(%bot.nick,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass
    .timer 1 6 sockwrite -n $sockname identify %bot.pass
    .timer 1 10 sockwrite -n $sockname join %work.chan
    privmsg $me $sockname is now open and set
  }
  if ($sockname == SpyIRCGo) {
    sockwrite -n $sockname pass %bot.pass
    sockwrite -n $sockname nick %bot.nick
    sockwrite -n $sockname user $remove(%bot.nick,`) $remove(%bot.nick,`) $remove(%bot.nick,`) : $+ $remove(%bot.nick,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass
    .timer 1 6 sockwrite -n $sockname identify %bot.pass
    .timer 1 10 sockwrite -n $sockname join %work.chan
    privmsg $me $sockname is now open and set
  }
  if ($sockname == SpyDalNet) {
    sockwrite -n $sockname pass %bot.pass
    sockwrite -n $sockname nick %bot.nick
    sockwrite -n $sockname user $remove(%bot.nick,`) $remove(%bot.nick,`) $remove(%bot.nick,`) : $+ $remove(%bot.nick,`)
    sockwrite -n $sockname identify %bot.pass
    sockwrite -n $sockname join %work.chan
    privmsg $me $sockname is now open and set
  }
  else {
    ;sockwrite -n $sockname user $remove(%botnick,`) $remove(%botnick,`) $remove(%botnick,`) $remove(%botnick,`)
    ;sockwrite -n $sockname nick $remove(%botnick,`) $remove(%botnick,`) $remove(%botnick,`) $remove(%botnick,`)
    ;sockmark $sockname %botnick
    ;sockwrite -n $sockname nickserv identify recess %botpass
    ;.timer 1 3 sockwrite -n $sockname privmsg nickserv :identify recess %botpass
    ;sockwrite -n $sockname join botchan
    ;privmsg $me $sockname is now open and set
  }
}
on 1:SOCKREAD:Spy*:{
  if ($sockerr > 0) { sockclose $sockname | privmsg $me Sock Error: READ $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  if (%say.trigger == 1) {
    sockwrite -n $sockname privmsg %work.chan : $+ %say.value
    .timer 1 1 set %say.value -
    .timer 1 1 set %say.trigger 0
  }
  :spyread
  sockread %spy.readline
  if ($sockbr == 0) { return }
  if ($gettok(%spy.readline,1,32) == PING) {
    sockwrite -n $sockname PONG $gettok(%spy.readline,2,32)
    ;privmsg $me sent pong to $remove($gettok(%spy.readline,2,32),:)
    set %clone.server. [ $+ [ $sockname ] ] $remove($gettok(%spy.readline,2,32),:)
  }
  if ($remove($left(%spy.readline,$calc($pos(%spy.readline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%spy.readline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname privmsg $me : $+ $chr(1) $+ PING $gettok(%spy.readline,5-6,32) $+ $chr(1) }
  if ($gettok(%spy.readline,2,32) == 353) { privmsg $me $remove($sockname,Spy) Users $+ $gettok(%spy.readline,6-,32) | goto bossout }
  if ($gettok(%spy.readline,2,32) == 311) { privmsg $me Whois $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($gettok(%spy.readline,2,32) == 312) { privmsg $me Whois $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($gettok(%spy.readline,2,32) == 307) { privmsg $me Whois $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($gettok(%spy.readline,2,32) == 319) { privmsg $me Whois $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
  if ($gettok(%spy.readline,2,32) == PART) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Part $remove($gettok(%spy.readline,1,33),:)  Left $remove($gettok(%spy.readline,3,32),:) }
  if ($gettok(%spy.readline,2,32) == JOIN) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Join $remove($gettok(%spy.readline,1,33),:) entered $remove($gettok(%spy.readline,3,32),:) }
  if ($gettok(%spy.readline,2,32) == NOTICE) { 
    ;privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $+ : Notice - $remove($gettok(%spy.readline,4-,32),:)
    privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $+ : Notice - $remove($gettok(%spy.readline,4-,32),:)
  }
  if ($gettok(%spy.readline,2,32) == NICK) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) NickChange $remove($gettok(%spy.readline,1,33),:) is now know as $remove($gettok(%spy.readline,3,32),:) $remove($gettok(%spy.readline,4-,32),:) }
  if ($gettok(%spy.readline,2,32) == QUIT) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Quit $remove($gettok(%spy.readline,1,33),:) $remove($gettok(%spy.readline,3-,32),:) }
  if ($gettok(%spy.readline,2,32) == TOPIC) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Topic $remove($gettok(%spy.readline,1,33),:) set $remove($gettok(%spy.readline,3,32),:) $remove($gettok(%spy.readline,4-,32),:) }
  if ($gettok(%spy.readline,2,32) == KICK) {
    privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Kick $remove($gettok(%spy.readline,1,33),:) kicked $remove($gettok(%spy.readline,4,32),:) from $remove($gettok(%spy.readline,3,32),:) $remove($gettok(%spy.readline,5-,32),:)
    if ($sock($sockname).mark == $remove($gettok(%spy.readline,4,32),:)) { sockwrite -n $sockname join $remove($gettok(%spy.readline,3,32),:) }
  }
  if ($gettok(%spy.readline,2,32) == MODE) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Mode $remove($gettok(%spy.readline,1,33),:) set $remove($gettok(%spy.readline,4-,32),:) on $remove($gettok(%spy.readline,3,32),:) }
  if ($gettok(%spy.readline,2,32) == PRIVMSG) {
    ;if *-bc cycle*
    ;
    ;Ctcp Handling
    ;
    if ($left($remove($gettok(%spy.readline,4-,32),:),1) == $chr(1)) {
      if (* $+ $chr(1) $+ ACTION* iswm $remove($gettok(%spy.readline,4-,32),:)) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Action  $+ $color(action) $+ $remove($gettok(%spy.readline,1,33),:)  $left($remove($gettok(%spy.readline,4-,32),: $+ $chr(1) $+ ACTION),-1) | goto bossout }
      else { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Ctcp $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $+ : $remove($remove($gettok(%spy.readline,4-,32),:),$chr(1)) | goto bossout }
      goto spyread
    }
    if ($chr(35) isin $remove($gettok(%spy.readline,3,32),:)) { privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $remove($gettok(%spy.readline,3,32),:) $remove($gettok(%spy.readline,1,33),:) $+ : $remove($gettok(%spy.readline,4-,32),:) }
    else {
      privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Privmsg $remove($gettok(%spy.readline,1,33),:) Whispered to $remove($gettok(%spy.readline,3,32),:) $+ : $remove($gettok(%spy.readline,4-,32),:)
      ;privmsg $me $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) Privmsg $remove($gettok(%spy.readline,1,33),:) Whispered to $remove($gettok(%spy.readline,3,32),:) $+ : $remove($gettok(%spy.readline,4-,32),:)
    }
    goto spyread
  }
  :bossout
  ;privmsg $me $sockname %spy.readline
  goto spyread
}
on 1:SOCKCLOSE:Spy*:{
  unset %clone.server. [ $+ [ $sockname ] ]
  privmsg $me $sockname just closed $sock($sockname).wserr $sock($sockname).wsmsg
  if ($sockname == SpyICQ) { s.timer 1 1 ockopen SpyICQ irc.icq.com 6667 | privmsg $me $report(ServerSpy,ON,ICQ) }
  if ($sockname == SpyDalNet) { .timer 1 1 sockopen SpyDalNet irc.dal.net 6667 | privmsg $me $report(ServerSpy,ON,DalNet) }
  if ($sockname == SpyHuman) { .timer 1 1 sockopen SpyHuman localhost 6667 | privmsg $me $report(ServerSpy,ON,Human) }
  if ($sockname == SpyIRCgo) { .timer 1 1 sockopen SpyIRCgo irc.ircgo.org 6667 | privmsg $me $report(ServerSpy,ON,IRCgo) }
  if ($sockname == SpyCHAT) { .timer 1 1 sockopen SpyCHAT irc.chatnet.org 6667 | privmsg $me $report(ServerSpy,ON,CHAT) }
}

/bot.write.method {
  if (%bot.write.method == channel) { return sockwrite -n spy* privmsg %work.chan : $+ }
  if (%bot.write.method == message) { return sockwrite -n spy* privmsg $me : $+ }
}
