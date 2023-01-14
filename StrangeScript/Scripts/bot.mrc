alias bot {
  if ($1 == ON) {
    if ($2 == human) {
      sockopen -n BotHuman localhost 6667
      return
    }
    if ($2 == ircgo) {
      sockopen -n BotIRCGo irc.IRCGo.org 6667
      return
    }
    $report(Bot,$null,Input Error,$null,$null,$null,You need to do /Bot ON HUMAN or IRCGO).active
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
      if ($3 != $null) {
        if ($3 == CHANNEL) || ($3 == MESSAGE) || ($3 == WINDOW) { set %bot.disp $3 | return }
        $report(Bot,Set,bot.disp,Error,Use:/bot set bot.disp CHANNEL/MESSAGE/WINDOW).active
        return      
      }
      return
    }
    if ($2 == work.chan) {
      if ($3 == $null) { return }
      set %work.chan. [ $+ [ $network ] ] $3
      return
    }
    if ($2 == play.chan) {
      if ($3 == $null) { return }
      set %play.chan. [ $+ [ $network ] ] $3
      return
    }
    if ($2 == bot.nick) {
      if ($3 == $null) { return }
      set %bot.nick. [ $+ [ $network ] ] $3
      return
    }
    if ($2 == bot.pass) {
      if ($3 == $null) { return }
      set %bot.pass. [ $+ [ $network ] ] $3
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
    $report(Bot SET,$null,$null,$null,use /Bot SET value.below).active
    $report(SET,$null,Option,$null,$null,$null,bot.disp).active
    $report(SET,$null,Option,$null,$null,$null,work.chan).active
    $report(SET,$null,Option,$null,$null,$null,play.chan).active
    $report(SET,$null,Option,$null,$null,$null,bot.nick).active
    $report(SET,$null,Option,$null,$null,$null,bot.pass).active
    $report(SET,$null,Option,$null,$null,$null,say.value).active
    $report(SET,$null,Option,$null,$null,$null,say.trigger).active
    $report(Bot SET,$null,$null,$null,*******************).active
    return
  }
  if ($1 == SHOW) {
    $report(Bot Menu,$null,$null,**********,************).active
    $report(Bot Menu,$null,$null,$null,use /Bot set value.below to alter).active
    $report(Bot Menu,$null,$null,************,*****************).active
    $report(Bot Menu,$null,$null,Current Network,$network).active
    $report(Bot Menu,$null,$null,bot.disp,%bot.disp).active
    $report(Bot Menu,$null,$null,work.chan, %work.chan. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,play.chan, %play.chan. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,bot.nick, %bot.nick. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,bot.pass,%bot.pass. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,say.value,%say.value).active
    $report(Bot Menu,$null,t,say.trigger,%say.trigger).active
    $report(Bot Menu,$null,$null,xxx,no value).active
    $report(Bot Menu,$null,$null,xxx,no value).active
    $report(Bot Menu,$null,$null,************,*****************).active
    return
  }
  if ($1 == SEND) {
    sockwrite -n Bot* privmsg %work.chan. [ $+ [ $network ] ] :Send not configured for some reason. Right Dana?
    return
  }
  if ($1 == KICK) {
    return
  }
  if ($1 == JOIN) {
    if ($2 != $null) { sockwrite -n Bot* join $2 }
    return
  }
  if ($1 == PART) {
    if ($2 != $null) { sockwrite -n Bot* part $2 $3- }
    return
  }
  if ($1 == CYCLE) {
    if ($2 == $null) { sockwrite -n Bot* part %work.chan [ $+ [ $network ] ] $cr join %work.chan [ $+ [ $network ] ] }
    else { sockwrite -n Bot* part $2 $cr join $2 }
    return
  }
  $report(Bot,$null,Options,$null,$null,$null,ON, OFF, WRITE, SET, JOIN, PART, CYCLE, SHOW, SEND).active
  return
}
alias bot.disp {
  if (%bot.disp == CHANNEL) { return sockwrite -n Bot* privmsg %work.chan. [ $+ [ $network ] ] : $+  }
  if (%bot.disp == MESSAGE) { return sockwrite -n Bot* privmsg $me : $+  }
  if (%bot.disp == WINDOW) { return sockwrite -n Bot* privmsg %tmp.window : $+  }
}
on 1:SOCKOPEN:Bot*:{
  if ($sockerr > 0) { sockclose $sockname | privmsg $me Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  $report(OPEN,Socket Name,$sockname).active
  if ($sockname == BotHuman) || ($sockname == BotIRCGo) {
    if (%bot.pass. [ $+ [ $network ] ] != $null) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $network ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $network ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n $sockname join %work.chan. [ $+ [ $network ] ]
    $bot.disp sockname is now open and set
    return
  }
  if ($sockname == BotDalNet) {
    if (%bot.pass != $null) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $network ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    if (%bot.pass !=$null) { sockwrite -n $sockname identify %bot.pass. $+ $network }
    sockwrite -n $sockname join %work.chan. [ $+ [ $network ] ]
    privmsg $me $sockname is now open and set
  }
  else {
    ;sockwrite -n $sockname user $remove(%bot.nick. [ $+ [ $network ] ],`) $remove(%bot.nick. [ $+ [ $network ] ],`) $remove(%bot.nick. [ $+ [ $network ] ],`) $remove(%bot.nick. [ $+ [ $network ] ],`)
    ;sockwrite -n $sockname nick $remove(%bot.nick. [ $+ [ $network ] ],`) $remove(%bot.nick. [ $+ [ $network ] ],`) $remove(%bot.nick. [ $+ [ $network ] ],`) $remove(%bot.nick. [ $+ [ $network ] ],`)
    ;sockmark $sockname %bot.nick. [ $+ [ $network ] ]
    ;if (%bot.pass != $null) { sockwrite -n $sockname nickserv identify %bot.nick. [ $+ [ $network ] ] %bot.pass. [ $+ [ $network ] ] }
    ;.timer 1 3 sockwrite -n $sockname privmsg nickserv :identify recess %bot.pass. [ $+ [ $network ] ]
    ;sockwrite -n $sockname join %work.chan. [ $+ [ $network ] ]
    ;privmsg $me $sockname is now open and set
    $report(Bot.ERROR,No network given,$null,$null,Usage: /bot on Dalnet/Human/Ircgo/etc).active
  }
}
on 1:SOCKREAD:Bot*:{
  if ($sockerr > 0) { sockclose $sockname | privmsg $me Sock Error: READ $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  if (%say.trigger == 1) {
    sockwrite -n $sockname privmsg %work.chan. [ $+ [ $network ] ] : $+ %say.value
    .timer 1 1 set %say.value -
    .timer 1 1 set %say.trigger 0
  }
  :Botread
  sockread %Bot.readline
  if ($sockbr == 0) { return }
  if ($gettok(%Bot.readline,1,32) == PING) {
    sockwrite -n $sockname PONG $gettok(%Bot.readline,2,32)
    ;privmsg $me sent pong to $remove($gettok(%Bot.readline,2,32),:)
    set %clone.server. [ $+ [ $sockname ] ] $remove($gettok(%Bot.readline,2,32),:)
  }
  if ($remove($left(%Bot.readline,$calc($pos(%Bot.readline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%Bot.readline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname privmsg $me : $+ $chr(1) $+ PING $gettok(%Bot.readline,5-6,32) $+ $chr(1) }
  if ($gettok(%Bot.readline,2,32) == 353) { privmsg $me $remove($sockname,Bot) Users $+ $gettok(%Bot.readline,6-,32) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 311) { privmsg $me Whois $remove($gettok(%Bot.readline,4-,32),:) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 312) { privmsg $me Whois $remove($gettok(%Bot.readline,4-,32),:) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 307) { privmsg $me Whois $remove($gettok(%Bot.readline,4-,32),:) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 319) { privmsg $me Whois $remove($gettok(%Bot.readline,4-,32),:) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == PART) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Part $remove($gettok(%Bot.readline,1,33),:)  Left $remove($gettok(%Bot.readline,3,32),:) }
  if ($gettok(%Bot.readline,2,32) == JOIN) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Join $remove($gettok(%Bot.readline,1,33),:) entered $remove($gettok(%Bot.readline,3,32),:) }
  if ($gettok(%Bot.readline,2,32) == NOTICE) {
    ;privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) $remove($gettok(%Bot.readline,1,33),:) $+ @ $+ $remove($gettok(%Bot.readline,3,32),:) $+ : Notice - $remove($gettok(%Bot.readline,4-,32),:)
    privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) $remove($gettok(%Bot.readline,1,33),:) $+ @ $+ $remove($gettok(%Bot.readline,3,32),:) $+ : Notice - $remove($gettok(%Bot.readline,4-,32),:)
  }
  if ($gettok(%Bot.readline,2,32) == NICK) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) NickChange $remove($gettok(%Bot.readline,1,33),:) is now know as $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,4-,32),:) }
  if ($gettok(%Bot.readline,2,32) == QUIT) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Quit $remove($gettok(%Bot.readline,1,33),:) $remove($gettok(%Bot.readline,3-,32),:) }
  if ($gettok(%Bot.readline,2,32) == TOPIC) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Topic $remove($gettok(%Bot.readline,1,33),:) set $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,4-,32),:) }
  if ($gettok(%Bot.readline,2,32) == KICK) {
    privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Kick $remove($gettok(%Bot.readline,1,33),:) kicked $remove($gettok(%Bot.readline,4,32),:) from $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,5-,32),:)
    if ($sock($sockname).mark == $remove($gettok(%Bot.readline,4,32),:)) { sockwrite -n $sockname join $remove($gettok(%Bot.readline,3,32),:) }
  }
  if ($gettok(%Bot.readline,2,32) == MODE) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Mode $remove($gettok(%Bot.readline,1,33),:) set $remove($gettok(%Bot.readline,4-,32),:) on $remove($gettok(%Bot.readline,3,32),:) }
  if ($gettok(%Bot.readline,2,32) == PRIVMSG) {
    ;if *-bc cycle*
    ;
    ;Ctcp Handling
    ;
    if ($left($remove($gettok(%Bot.readline,4-,32),:),1) == $chr(1)) {
      if (* $+ $chr(1) $+ ACTION* iswm $remove($gettok(%Bot.readline,4-,32),:)) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Action  $+ $color(action) $+ $remove($gettok(%Bot.readline,1,33),:)  $left($remove($gettok(%Bot.readline,4-,32),: $+ $chr(1) $+ ACTION),-1) | goto bossout }
      else { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Ctcp $remove($gettok(%Bot.readline,1,33),:) $+ @ $+ $remove($gettok(%Bot.readline,3,32),:) $+ : $remove($remove($gettok(%Bot.readline,4-,32),:),$chr(1)) | goto bossout }
      goto Botread
    }
    if ($chr(35) isin $remove($gettok(%Bot.readline,3,32),:)) { privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,1,33),:) $+ : $remove($gettok(%Bot.readline,4-,32),:) }
    else {
      privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Privmsg $remove($gettok(%Bot.readline,1,33),:) Whispered to $remove($gettok(%Bot.readline,3,32),:) $+ : $remove($gettok(%Bot.readline,4-,32),:)
      ;privmsg $me $gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Privmsg $remove($gettok(%Bot.readline,1,33),:) Whispered to $remove($gettok(%Bot.readline,3,32),:) $+ : $remove($gettok(%Bot.readline,4-,32),:)
    }
    goto Botread
  }
  :bossout
  ;privmsg $me $sockname %Bot.readline
  goto Botread
}
on 1:SOCKCLOSE:Bot*:{
  unset %clone.server. [ $+ [ $sockname ] ]
  privmsg $me $sockname just closed $sock($sockname).wserr $sock($sockname).wsmsg
  if ($sockname == BotICQ) { s.timer 1 1 ockopen BotICQ irc.icq.com 6667 | privmsg $me $report(ServerBot,ON,ICQ) }
  if ($sockname == BotDalNet) { .timer 1 1 sockopen BotDalNet irc.dal.net 6667 | privmsg $me $report(ServerBot,ON,DalNet) }
  if ($sockname == BotHuman) { .timer 1 1 sockopen BotHuman localhost 6667 | privmsg $me $report(ServerBot,ON,Human) }
  if ($sockname == BotIRCgo) { .timer 1 1 sockopen BotIRCgo irc.ircgo.org 6667 | privmsg $me $report(ServerBot,ON,IRCgo) }
  if ($sockname == BotCHAT) { .timer 1 1 sockopen BotCHAT irc.chatnet.org 6667 | privmsg $me $report(ServerBot,ON,CHAT) }
}
