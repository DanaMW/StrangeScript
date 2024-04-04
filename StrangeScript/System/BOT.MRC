alias bot.go {
  if ($1 == $null) { set %temp.btoff $network }
  else { set %temp.btoff $1 }
  set %bot.onp2. [ $+ [ %temp.btoff ] ] %temp.btoff 
  $report(%bot.onp1. [ $+ [ %temp.btoff ] ] ,This).active
  ;
  if (%bot.onp2. [ $+ [ %temp.btoff ] ] == LocalNet) {
    bot.check %temp.btoff
    sockopen -n BotLocalNet irc.localdomain.net 6667
    botsetshow ON LocalNet irc.localdomain.net 6667
    return
  }
  if (%bot.onp2. [ $+ [ %temp.btoff ] ] == dalnet) {
    bot.check %temp.btoff
    sockopen -n BotDalNet irc.dal.net 6667
    botsetshow ON DalNet irc.dal.net 6667
    return
  }
  if (%bot.onp2. [ $+ [ %temp.btoff ] ] == libera.chat) {
    bot.check %temp.btoff
    sockopen -n Botlibera.chat irc.libera.chat 6667
    botsetshow ON libera.chat irc.libera.chat 6667
    return
  }
  if (%bot.onp2. [ $+ [ %temp.btoff ] ] == undernet) {
    bot.check %temp.btoff
    sockopen -n BotUnderNet us.undernet.org 6667
    botsetshow ON UnderNet us.undernet.org 6667
    return
  }
  if (%bot.onp2. [ $+ [ %temp.btoff ] ] == DeepNet) {
    bot.check %temp.btoff
    sockopen -n BotDeepNet irc.deepnet.chat 6667
    botsetshow ON DeepNet irc.DeepNet.chat 6667
    return
  }
  if (%bot.onp2. [ $+ [ %temp.btoff ] ] == ircgo) {
    bot.check %temp.btoff
    sockopen -n BotIRCGo irc.IRCGo.org 6667
    botsetshow ON IRCGo irc.IRCGo.org 6667
    return
  }
  if ($1 == $null) { set %bot.active. [ $+ [ $network ] ] 1 }
  if ($1 != $null)  { set %bot.active. [ $+ [ $1 ] ] 1 }
  ;else {
  ;
  ; Network Matched biot below      ;
  ;set %bot.active. [ $+ [ %temp.btoff ] ] 0
  ;$report(bot.onp2,$null,$null,%bot.onp2. [ $+ [ %temp.btoff ] ] ).active
  ;$report(bot.active,$null,$null,%bot.active. [ $+ [ %temp.btoff ] ] ).active
  ;$report(1,$null,$null,$1).active
  ;$report(2,$null,$null,$2).active
  ;if ($2 != $null) {
  ;if ($2 == local) || ($1 == localhost) { set %temp.addre irc.localdomain.net }
  ;if ($2 == dalnet) { set %temp.addre irc.dal.net }
  ;if ($2 == undernet) { set %temp.addre us.undernet.org }
  ;if ($2 == libera.chat) { set %temp.addre irc.libera.chat }
  ;if ($2 == deepnet) { set %temp.addre irc.deepnet.chat }
  ;else { set %temp.addre $$?="Enter IRC login Address" }
  ;bot.check $1
  ;sockopen -n Bot [ $+ [ $2 ] ] %temp.addre 6667
  ;botsetshow ON $1 %temp.addre 6667
  ;unset %temp.addre
  ;return
  ;}
  ;}
  ;$report(Bot,$null,Input Error,$null,$null,$null,Just do /BOT ON DeepNet or DalNet or just /BOT ON for your current network.).active
  return
}
alias bot {
  set %chew.1 $1
  set %chew.2 $2
  set %chew.2 $3-
  botstart
  if ($1 == ON) || if ($1 == START) {
    bot.go $2
    return
  }
  if ($1 == OFF) || ($1 == STOP) {
    if ($2 == $null) { set %temp.btoff $network }
    else { set %temp.btoff $2 }
    sockclose Bot [ $+ [ %temp.btoff ] ]
    if ($window(@botSay [ $+ [ %temp.btoff ] ]) != $null) { window -c @botSay [ $+ [ %temp.btoff ] ] }
    set %Bot.active. [ $+ [ %temp.btoff ] ] 0
    .timerfiredeepnet off
    botsetshow $chain(5) Bot Off $chain(12)
    botsetshow OFF You selected off. It's off.
    botsetshow bot.active %temp.btoff is set to %bot.active. [ $+ [ %temp.btoff ] ]
    botsetshow $chain(5) $chain(19)
    return
  }
  else {
  }
  if ($1 == ID) {
    .timer 1 2 sockwrite -n Bot [ $+ [ $network ] ] identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 4 sockwrite -n Bot [ $+ [ $network ] ] join %bot.work. [ $+ [ $network ] ]
    return
  }
  if ($1 == SET) {
    if ($2 == BOT.DISP) || ($2 == DISP) {
      if ($3 != $null) { bot.disp $3- }
      if ($3 == $null) { bot.disp.info | return }
      return
    }
    if ($2 == BOT.WORK) || ($2 == WORK) {
      if ($3 == $null) { return }
      set %bot.work. [ $+ [ $network ] ] $3
      botsetshow WORK bot.work channel is now %bot.work. [ $+ [ $network ] ]
      return
    }
    if ($2 == BOT.PLAY) || ($2 == PLAY) {
      if ($3 == $null) { return }
      set %bot.play. [ $+ [ $network ] ] $3-
      botsetshow PLAY bot.play channel is now %bot.play. [ $+ [ $network ] ]
      return
    }
    if ($2 == BOT.NICK) || ($2 == NICK) {
      if ($3 == $null) { return }
      set %bot.nick. [ $+ [ $network ] ] $3
      botsetshow NICK Your bot.nick is now set as %bot.nick. [ $+ [ $network ] ]
      return
    }
    if ($2 == BOT.PASS) || ($2 == PASS) {
      if ($3 == $null) { return }
      set %bot.pass. [ $+ [ $network ] ] $3
      botsetshow PASS bot.pass is set as %bot.pass. [ $+ [ $network ] ]
      return
    }
    if ($2 == BOT.VALUE) || ($2 == VALUE) {
      if (%bot.value. [ $+ [ $network ] ] == $null) { set %bot.value. [ $+ [ $network ] ] - }
      if ($3 == $null) { return }
      else { set %bot.value. [ $+ [ $network ] ] $3- }
      botsetshow VALUE bot.value is set to %bot.value. [ $+ [ $network ] ]
      return
    }
    if ($2 == BOT.TRIGGER) || ($2 == TRIGGER) {
      if (%bot.trigger. [ $+ [ $network ] ] == 1) { set %bot.trigger. [ $+ [ $network ] ] 0 }
      else { set %bot.trigger. [ $+ [ $network ] ] 1 }
      botsetshow TRIGGER bot.trigger is set to %bot.trigger. [ $+ [ $network ] ]
      return
    }
    if ($2 == BOT.SHOWALL) || ($2 == SHOWALL) || if ($2 == DEBUG) {
      if ($3 == ON) { set %bot.showall. [ $+ [ $network ] ] ON | botsetshow SHOWALL bot.showall or debug is set to %bot.showall. [ $+ [ $network ] ] | return }
      if ($3 == OFF) { set %bot.showall. [ $+ [ $network ] ] OFF | botsetshow SHOWALL bot.showall or debug is set to %bot.showall. [ $+ [ $network ] ] | return }
      if ($3 == $null) {
        if (%bot.showall. [ $+ [ $network ] ] == ON) { set %bot.showall. [ $+ [ $network ] ] OFF | botsetshow SHOWALL bot.showall or debug is set to %bot.showall. [ $+ [ $network ] ] | return }
        if (%bot.showall. [ $+ [ $network ] ] == OFF) { set %bot.showall. [ $+ [ $network ] ] ON | botsetshow SHOWALL bot.showall or debug is set to %bot.showall. [ $+ [ $network ] ] | return }
      }
      return
    }
    if ($2 == BOT.RELAY) || ($2 == RELAY) {
      if ($3 == ON) { set %bot.relay. [ $+ [ $network ] ] ON | botsetshow RELAY bot.relay is set to %bot.relay. [ $+ [ $network ] ] | return }
      if ($3 == OFF) { set %bot.relay. [ $+ [ $network ] ] OFF | botsetshow RELAY bot.relay is set to %bot.relay. [ $+ [ $network ] ] | return }
      if ($3 == $null) {
        if (%bot.relay. [ $+ [ $network ] ] == ON) { set %bot.relay. [ $+ [ $network ] ] OFF | botsetshow RELAY bot.relay is set to %bot.relay. [ $+ [ $network ] ] | return }
        if (%bot.relay. [ $+ [ $network ] ] == OFF) { set %bot.relay. [ $+ [ $network ] ] ON | botsetshow RELAY bot.relay is set to %bot.relay. [ $+ [ $network ] ] | return }
      }
      return
    }
    if ($2 == BOT.DEFENSE) || ($2 == DEFENSE) {
      if ($3 == ON) { set %bot.defense. [ $+ [ $network ] ] ON | botsetshow DEFENSE bot.defense is set to %bot.defense. [ $+ [ $network ] ] | return }
      if ($3 == OFF) { set %bot.defense. [ $+ [ $network ] ] OFF | botsetshow DEFENSE bot.defense is set to %bot.defense. [ $+ [ $network ] ] | return }
      if ($3 == $null) {
        if (%bot.defense. [ $+ [ $network ] ] == ON) { set %bot.defense. [ $+ [ $network ] ] OFF | botsetshow DEFENSE bot.defense is set to %bot.defense. [ $+ [ $network ] ] | return }
        if (%bot.defense. [ $+ [ $network ] ] == OFF) { set %bot.defense. [ $+ [ $network ] ] ON | botsetshow DEFENSE bot.defense is set to %bot.defense. [ $+ [ $network ] ] ] | return }
      }
      return
    }
    if ($2 == BOT.RECONNECT) || ($2 == RECONNECT) {
      if ($3 == ON) { set %bot.reconnect. [ $+ [ $network ] ] ON | botsetshow RECONNECT Bot reconnect after d/c Set to %bot.reconnect. [ $+ [ $network ] ] | return }
      if ($3 == OFF) { set %bot.reconnect. [ $+ [ $network ] ] OFF | botsetshow RECONNECT Bot reconnect after d/c Set to %bot.reconnect. [ $+ [ $network ] ] | return }
      if ($3 == $null) {
        if (%bot.reconnect. [ $+ [ $network ] ] == ON) { set %bot.reconnect. [ $+ [ $network ] ] OFF | botsetshow RECONNECT Bot reconnect after d/c Set to %bot.reconnect. [ $+ [ $network ] ] | return }
        if (%bot.reconnect. [ $+ [ $network ] ] == OFF) { set %bot.reconnect. [ $+ [ $network ] ] ON | botsetshow RECONNECT Bot reconnect after d/c Set to %bot.reconnect. [ $+ [ $network ] ] | return }
      }
      return
    }
    if ($2 == BOT.KILLWIN) || ($2 == KILLWIN) {
      if ($3 == ON) { set %bot.killwin. [ $+ [ $network ] ] ON | botsetshow KILLWIN Close Bot With It's Window Set to %bot.killwin. [ $+ [ $network ] ] | return }
      if ($3 == OFF) { set %bot.killwin. [ $+ [ $network ] ] OFF | botsetshow KILLWIN Close Bot With It's Window Set to %bot.killwin. [ $+ [ $network ] ] | return }
      if ($3 == $null) {
        if (%bot.killwin. [ $+ [ $network ] ] == ON) { set %bot.killwin. [ $+ [ $network ] ] OFF | botsetshow KILLWIN Close Bot With It's Window Set to %bot.killwin. [ $+ [ $network ] ] | return }
        if (%bot.killwin. [ $+ [ $network ] ] == OFF) { set %bot.killwin. [ $+ [ $network ] ] ON | botsetshow KILLWIN Close Bot With It's Window Set to %bot.killwin. [ $+ [ $network ] ] | return }
      }
      return
    }
    botvar
    return
  }
  if ($1 == SHOW) {
    if ($2 == ALL) { botvar }
    bothelp
    return
  }
  if ($1 == SEND) {
    $report(BotSend,$null,Warning!,Sending raw command to bot:).active
    $report(BotSend,$null,Command:,$null,-> $2- ->).active
    return
    sockwrite -n Bot [ $+ [ $network ] ] $2-
    return
  }
  if ($1 == OP) {
    if ($2- == $null) { sockwrite -n Bot [ $+ [ $network ] ] mode # +o $me | return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] mode $2 +o $3 | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] mode # +o $2 }
    return
  }
  if ($1 == DEOP) {
    if ($2- == $null) { sockwrite -n Bot [ $+ [ $network ] ] mode # -o $me | return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] mode $2 -o $3 | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] mode # -o $2 | return }
    return
  }
  if ($1 == HELPOP) {
    if ($2- == $null) { sockwrite -n Bot [ $+ [ $network ] ] mode # +h $me | return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] mode $2 +h $3 | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] mode # +h $2 }
    return
  }
  if ($1 == HELPDEOP) {
    if ($2- == $null) { sockwrite -n Bot [ $+ [ $network ] ] mode # -h $me | return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] mode $2 -h $3 | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] mode # -h $2 | return }
    return
  }
  if ($1 == VOICE) {
    if ($2- == $null) { sockwrite -n Bot [ $+ [ $network ] ] mode # +v $me | return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] mode $2 +v $3 | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] mode # +v $2 }
    return
  }
  if ($1 == DEVOICE) {
    if ($2- == $null) { sockwrite -n Bot [ $+ [ $network ] ] mode # -v $me | return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] mode $2 -v $3 | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] mode # -v $2 | return }
    return
  }
  if ($1 == KICK) {
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] kick $2  $3 : $+ $4- | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] kick # $2  : $+ $3- | return }
  }
  if ($1 == JOIN) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] join # }
    if ($2 != $null) { sockwrite -n Bot [ $+ [ $network ] ] join $2 }
    return
  }
  if ($1 == NICK) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] msg %bot.work. [ $+ [ $network ] ] :No nick given. Ending. |  return }
    else { sockwrite -n Bot [ $+ [ $network ] ] nick : $+ $2 }
    return
  }
  if ($1 == PART) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part # : $+ See ya! }
    if ($2 != $null) && ($3 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part $2 : $+ gotta go! }
    if ($2 != $null) && ($3 != $null) { sockwrite -n Bot [ $+ [ $network ] ] part $2 : $+ $3- }
    return
  }
  if ($1 == AJ) { .timerbaj $+ $network 1 2 sockwrite -n Bot [ $+ [ $network ] ] join $key(settings,autojoinspeed) | return }
  if ($1 == CYCLE) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part # $cr join # }
    else { sockwrite -n Bot [ $+ [ $network ] ] part $2 :Cycling $cr join $2 }
    return
  }
  if ($1 == SAY) {
    if ($2 == $null) { return }
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] privmsg $2 : $+ $3- | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] : $+ $2- | return }
    return
  }
  if ($1 == WRITE) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] :Nothing sent to write. Ending. | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] : $+ $2- | return }
  }
  if ($1 == STATUS) { bot.status | return }
  if ($1 == AGAIN) {
    ; This is a debug thing. If you think your bot is not ident'ing right, this is the USER method. Use it to send it AGAIN.
    sockwrite -n  Bot [ $+ [ $network ] ] user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    return
  }
  if ($1 == QUIT) {
    if ($2 == $null) {
      sockwrite -n Bot [ $+ [ $network ] ] quit :Goodbye
      if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
      return
    }
    else {
      if ($sock(bot [ $+ [ $network ] ]) != $null) { sockwrite -n Bot [ $+ [ $network ] ] quit : $+ $2- }
      if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
      return
    }
  }
  bot.end
  return
}
on 1:SOCKOPEN:Bot*:{
  if ($sockerr > 0) {
    $report(Sock Error,OPEN,Bot [ $+ [ $sockname ] ],$sock(Bot [ $+ [ $sockname ] ]).wserr,$sock(Bot [ $+ [ $sockname ] ]).wsmsg).active
    sockclose Bot [ $+ [ $sockname ] ]
    return
  }
  $report(Socket,OPEN,Socket Name,Bot [ $+ [ $network ] ]).active
  set %Bot.active. [ $+ [ $network ] ] 1
  ;
  ; These are seperate for fine tuning then we will combine into one when we know what works best for all of them
  ;
  if ($sockname == BotLocalNet) {
    if ( %bot.pass. [ $+ [ $remove($sockname,Bot) ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $remove($sockname,Bot) ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $$remove($sockname,Bot) ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $remove($sockname,Bot) ] ]
    sockmark $sockname %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  ;
  if ($sockname == BotDalNet) {
    $report(BOT,$null,$null,Using:,Dalnet config for setup of bot).active
    sockwrite -n $sockname pass %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 15 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    sockmark $sockname %bot.nick. [ $+ [ $network ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  ;
  if ($sockname == Botlibera.chat) {
    if ( %bot.pass. [ $+ [ $network ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $remove($sockname,Bot) ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $remove($sockname,Bot) ] ]
    sockmark $sockname %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  if ($sockname == BotUnderNet) {
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    ;sockwrite -n $sockname pass %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`)
    ;.timer 1 5 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 15 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $remove($sockname,Bot) ] ]
    sockmark $sockname %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  if ($sockname == BotDeepNet) {
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    ;sockwrite -n $sockname pass %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`)
    ;.timer 1 5 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 15 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $remove($sockname,Bot) ] ]
    sockmark $sockname %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  if ($sockname == BotIRCGo) {
    if ( %bot.pass. [ $+ [ $remove($sockname,Bot) ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $remove($sockname,Bot) ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`) $remove( %bot.nick. [ $+ [ $$remove($sockname,Bot) ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $remove($sockname,Bot) ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $remove($sockname,Bot) ] ]
    sockmark $sockname %bot.nick. [ $+ [ $remove($sockname,Bot) ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  else {
    halt
    sockwrite -n $sockname user $remove(%bot.nick. [ $+ [ $sockname ] ] ,`) $remove(%bot.nick. [ $+ [ $sockname ] ] ,`) $remove(%bot.nick. [ $+ [ $sockname ] ] ,`) $remove(%bot.nick. [ $+ [ $sockname ] ] ,`)
    ;sockwrite -n $sockname nick $remove(%bot.nick. [ $+ [ $sockname ] ] ,`) $remove(%bot.nick. [ $+ [ $sockname ] ] ,`) $remove(%bot.nick. [ $+ [ $sockname ] ] ,`) $remove(%bot.nick. [ $+ [ $sockname ] ] ,`)
    sockmark $sockname %bot.nick. [ $+ [ $sockname ] ]
    if ( %bot.pass != $null ) { sockwrite -n $sockname nickserv identify %bot.nick. [ $+ [ $sockname ] ] %bot.pass. [ $+ [ $sockname ] ] }
    .timer 1 3 sockwrite -n $sockname privmsg nickserv :identify recess %bot.pass. [ $+ [ $sockname ] ]
    sockwrite -n $sockname join %bot.work. [ $+ [ $sockname ] ]
    $report(BotSay,$sockname,is now open and set).active
    return
  }
  $report(BotSay,Bot.ERROR,No network given,$null,$null,Usage: /bot <on/start> <Dalnet/Local/Ircgo/libera.chat/etc>).active
}
alias bot.bullet {
  if ($1 == 1) { return $gettok(%bot.readline,1,32) }
  elseif ($1 == 2) { return $gettok(%bot.readline,2,32) }
  elseif ($1 == 3) { return $gettok(%bot.readline,3,32) }
  elseif ($1 == 4) { return $gettok(%bot.readline,4,32) }
  elseif ($1 == 5) { return $gettok(%bot.readline,5,32) }
  elseif ($1 == 6) { return $gettok(%bot.readline,6,32) }
  else ($1 == 7) { return $gettok(%bot.readline,7-,32) }
  halt
}
on 1:SOCKREAD:Bot*:{
  if ($sockerr > 0) { sockclose %bot.onp2. [ $+ [ $remove($sockname,Bot) ] ] | $botsay(Sock Error,READ,%bot.onp2. [ $+ [ $remove($sockname,Bot) ] ],$sock(%bot.onp2. [ $+ [ $remove($sockname,Bot) ] ]).wserr,$sock(%bot.onp2. [ $+ [ $remove($sockname,Bot) ] ]).wsmsg)active | return }
  if (%bot.trigger. [ $+ [ $remove($sockname,Bot) ] ] == 1) {
    sockwrite -n $sockname privmsg %bot.work. [ $+ [ $remove($sockname,Bot) ] ] : $+ %bot.value. [ $+ [ $remove($sockname,Bot) ] ]
    .timer 1 1 set %bot.value. [ $+ [ $remove($sockname,Bot) ] ] -
    .timer 1 1 set %bot.trigger. [ $+ [ $remove($sockname,Bot) ] ] 0
  }
  :Botread
  sockread %bot.readline
  if ($sockbr == 0) { return }
  if (%bot.showall. [ $+ [ $remove($sockname,Bot) ] ] == ON) { $botsay(Full Info:,$null,$null,$null,$null,%bot.readline) }
  if ($gettok(%bot.readline,1,32) == PING) {
    sockwrite -n $sockname PONG $gettok(%bot.readline,2,32)
    if (%bot.showall. [ $+ [ $remove($sockname,Bot) ] ] == ON) { $botsay(Pong,Sent Pong,to,$remove($gettok(%bot.readline,2,32),:)) }
  }
  ;if ($remove($left(%bot.readline,$calc($pos(%bot.readline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%bot.readline,4,32),:,$chr(1)) == PING)  { sockwrite -n Bot [ $+ [ $network ] ] NOTICE $me : $+ $chr(1) $+ PING $gettok(%bot.readline,5-6,32) $+ $chr(1) }
  if ($gettok(%bot.readline,2,32) == 353) { $botsay(BotSay,$remove(%bot.onp2. [ $+ [ $network ] ],Bot),Users $+ $gettok(%bot.readline,6-,32)) | goto bossout }
  if ($gettok(%bot.readline,2,32) == 311) { $botsay(BotSay,Whois $remove($gettok(%bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%bot.readline,2,32) == 312) { $botsay(BotSay,Whois $remove($gettok(%bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%bot.readline,2,32) == 307) { $botsay(BotSay,Whois $remove($gettok(%bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%bot.readline,2,32) == 319) { $botsay(BotSay,Whois $remove($gettok(%bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%bot.readline,2,32) == PART) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),Part,$remove($gettok(%bot.readline,1,33),:),Left,$remove($gettok(%bot.readline,3,32),:) saying: $remove($gettok(%bot.readline,4-,32),:)) }
  if ($gettok(%bot.readline,2,32) == JOIN) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),Join,$remove($gettok(%bot.readline,1,33),:),entered,$remove($gettok(%bot.readline,3,32),:)) }
  if ($gettok(%bot.readline,2,32) == NOTICE) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),$remove($gettok(%bot.readline,1,33),:) $+ @ $+ $remove($gettok(%bot.readline,3,32),:) $+ : Notice - $remove($gettok(%bot.readline,4-,32),:)) }
  if ($gettok(%bot.readline,2,32) == NICK) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),NickChange,$remove($gettok(%bot.readline,1,33),:),is now know as,$remove($gettok(%bot.readline,3,32),:),$remove($gettok(%bot.readline,4-,32),:)) }
  if ($gettok(%bot.readline,2,32) == QUIT) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),Quit,$remove($gettok(%bot.readline,1,33),:),$remove($gettok(%bot.readline,3-,32),:)) }
  if ($gettok(%bot.readline,2,32) == TOPIC) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),Topic,$remove($gettok(%bot.readline,1,33),:),set $remove($gettok(%bot.readline,3,32),:),$remove($gettok(%bot.readline,4-,32),:)) }
  if ($gettok(%bot.readline,2,32) == KICK) {
    $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],Bot),1,44),Kick,$remove($gettok(%bot.readline,1,33),:),kicked,$remove($gettok(%bot.readline,4,32),:),from,$remove($gettok(%bot.readline,3,32),:),$remove($gettok(%bot.readline,5-,32),:))
    sockwrite -n $sockname join $remove($gettok(%bot.readline,3,32),:) 
    return
  }
  if ($gettok(%bot.readline,2,32) == MODE) { $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $remove($sockname,Bot) ] ],Bot),1,44),Mode,$remove($gettok(%bot.readline,1,33),:),set,$remove($gettok(%bot.readline,4-,32),:) on $remove($gettok(%bot.readline,3,32),:)) }
  if ($gettok(%bot.readline,2,32) == PRIVMSG) {
    ;Ctcp Handling
    if ($left($remove($gettok(%bot.readline,4-,32),:),1) == $chr(1)) {
      if (* $+ $chr(1) $+ ACTION* iswm $remove($gettok(%bot.readline,4-,32),:)) {
        $botsay(BotSay,$gettok($remove(%bot.onp2. [ $+ [ $remove($sockname,Bot) ] ],Bot),1,44) Action  $+ $color(action) $+ $remove($gettok(%bot.readline,1,33),:),$left($remove($gettok(%bot.readline,4-,32),: $+ $chr(1) $+ ACTION),-1))
        goto bossout
      }
      else {
        ;$botsay(Full Info:,At else,$null,$null,$null,%bot.readline)
        $botsay(BotSay,$null,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],bot),1,44),Ctcp,$remove($gettok(%bot.readline,1,33),:) $+ @ $+ $remove($gettok(%bot.readline,3,32),:) $+ :,$remove($remove($gettok(%bot.readline,4-,32),:), ))
        goto bossout
      }
      goto botread
    }
    if ($chr(35) isin $remove($gettok(%bot.readline,3,32),:)) { $botsay(BotSay,$null,$gettok($remove(%bot.onp2. [ $+ [ $network ] ],bot),1,44) $remove($gettok(%bot.readline,3,32),:),$remove($gettok(%bot.readline,1,33),:),$remove($gettok(%bot.readline,4-,32),:)) }
    else { $botsay(BotSay,$remove($gettok(%bot.readline,3,32),:),privmsg,$remove($gettok(%bot.readline,1,33),:),--> Whispered -->,$remove($gettok(%bot.readline,3,32),:),$remove($gettok(%bot.readline,4-,32),:)) }
    goto Botread
  }
  :bossout
  goto Botread
}
on 1:SOCKCLOSE:Bot*:{
  sockclose Bot [ $+ [ $network ] ]
  if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] ] }
  set %Bot.active. [ $+ [ $network ] ] 0
  botsetshow BotClose ClosingBot [ $+ [ $network ] ] $sock(Bot [ $+ [ $network ] ] ).wserr $sock(Bot [ $+ [ $network ] ] ).wsmsg
  if (%bot.reconnect. [ $+ [ $network ] ] == ON) { timerfire $+ $network 1 1 goto bot start $network }
}
alias botsay {
  if ($1- == $null) { $report(BotSay,Bot Say,Error,$null,$null,No Text Sent to Report) | return }
  else { var %tmp.zbuild = %tmp.zbuild $sep $+ $chr(186) }
  if ($1 != $null) {
    if ($1 == $me) { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ 4 $1 $sep $+ ) $+ $chr(186) }
    else { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ $white $1 $sep $+ ) $+ $chr(186) }
  }
  if ($2 != $null) { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ $highcol $2 $sep $+ ) $+ $chr(186) }
  if ($3 != $null) { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ $bright $3 $sep $+ ) $+ $chr(186) }
  if ($4 != $null) { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ $lowcol $4 $sep $+ ) $+ $chr(186) }
  if ($5- != $null) {
    if ($me == $1) { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ $white $eval($5-) $sep $+ ) $+ $chr(186) $+  }
    else { var %tmp.zbuild = %tmp.zbuild $+ $sep $+ ( $+ $white $5- $sep $+ ) $+ $chr(186) $+  }
  }
  if (%bot.disp. [ $+ [ $network ] ] == OFF) { return }
  if (%bot.disp. [ $+ [ $network ] ] == ACTIVE) { return echo -at # $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == STATUS) { return echo -st # $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == CHANNEL) { return echo -t %bot.disp.dev. [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == MESSAGE) { return msg %bot.disp.dev. [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == WINDOW) {
    window -g1e0 %bot.disp.dev. [ $+ [ $network ] ]
    return aline -p %bot.disp.dev. [ $+ [ $network ] ] $sys %tmp.zbuild
  }
  return
}
alias bot.disp {
  if ($1 == $null) { set %bot.disp. [ $+ [ $network ] ] STATUS }
  if ($1 == REPORT) { $report(Bot Setting,bot.disp,is set to,%bot.disp. [ $+ [ $network ] ]).active | $report(Bot Setting,bot.disp.dev,is set to,%bot.disp.dev. [ $+ [ $network ] ]).active | return }
  if ($1 == OFF) { 
    if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
    set %bot.disp. [ $+ [ $network ] ] $1
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == ACTIVE) { 
    if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
    set %bot.disp. [ $+ [ $network ] ] ACTIVE
    unset %bot.disp.dev. [ $+ [ $network ] ]
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == STATUS) {
    if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
    set %bot.disp. [ $+ [ $network ] ] STATUS
    unset %bot.disp.dev. [ $+ [ $network ] ]

    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == CHANNEL) {
    if ($2 == $null) {
      set %bot.disp. [ $+ [ $network ] ] CHANNEL
      set %bot.disp.dev. [ $+ [ $network ] ] #
    }
    if ($2 != $null) {
      if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
      set %bot.disp. [ $+ [ $network ] ] CHANNEL
      set %bot.disp.dev. [ $+ [ $network ] ] $2
    }
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    $report(BotSay,SET,Option,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == MESSAGE) {
    if ($2 == $null) {
      $report(Bot Set ERROR,Information entered incorrectly).active
      $report(/bot set bot.disp MESSAGE <person's_name).active
      return
    }
    if ($2 != $null) {
      if ($window(@botSay [ $+ [ $network ] ]) != $null) { window -c %bot.disp.dev. [ $+ [ $network ] ] }
      set %bot.disp. [ $+ [ $network ] ] MESSAGE
      set %bot.disp.dev. [ $+ [ $network ] ] $2
    }
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    $report(BotSay,SET,Option,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == WINDOW) {
    if ($2 == $null) {
      $report(Bot Set ERROR,Information entered incorrectly).active
      $report(/bot set bot.disp WINDOW <@windowname>).active
      return
    }
    if ($2 != $null) {
      var %tmp.winmake $2 [ $+ [ $network ] ]
      set %bot.disp. [ $+ [ $network ] ] WINDOW
      set %bot.disp.dev. [ $+ [ $network ] ] $chr(64) $+ $remove(%tmp.winmake,$chr(64))
      window -a $chr(64) $+ $remove(%tmp.winmake,$chr(64))
      return
    }
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    $report(BotSay,SET,Option,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ]).active
    return
  }
}
alias bot.check {
  if ($1 != $null) {
    if (%Bot.active. [ $+ [ $1 ] ] == 1) {
      $report($chain(18) Bot Check $chain(18)).active
      $report(The bot is listed as,$null,$null,RUNNING,on $remove(Bot [ $+ [ $1 ] ],Bot)).active
      $report($null,$null,$null,To reset use /BOT OFF then /BOT ON <address>).active
      $report($chain(46)).active
      halt
    }
    else { return }
  }
  else {
    if (%Bot.active. [ $+ [ $network ] ] == 1) {
      $report($chain(18) Bot Check $chain(18)).active
      $report(The bot is listed as,$null,$null,RUNNING,on $remove(Bot [ $+ [ $network ] ],Bot)).active
      $report($null,$null,$null,To reset use /BOT OFF then /BOT ON <address>).active
      $report($chain(46)).active
      halt
    }
    else { return }
  }
}
alias botstart {
  if ($1 != $null) { set %tmp.bsrt $1 }
  else { set %tmp.bsrt $network }
  if (%bot.disp. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.disp. [ $+ [ %tmp.bsrt ] ] STATUS }
  if (%bot.work. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.work. [ $+ [ %tmp.bsrt ] ] #StrangeScript }
  if (%bot.play. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.play. [ $+ [ %tmp.bsrt ] ] #StrangeScript }
  if (%bot.nick. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.nick. [ $+ [ %tmp.bsrt ] ] Guest00001 }
  if (%bot.pass. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.pass. [ $+ [ %tmp.bsrt ] ] DefaultPass }
  if (%bot.value. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.value. [ $+ [ %tmp.bsrt ] ] Some default text }
  if (%bot.trigger. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.trigger. [ $+ [ %tmp.bsrt ] ] 0 }
  if (%bot.showall. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.showall. [ $+ [ %tmp.bsrt ] ] OFF }
  if (%bot.defense. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.defense. [ $+ [ %tmp.bsrt ] ] OFF }
  if (%bot.reconnect. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.reconnect. [ $+ [ %tmp.bsrt ] ] OFF }
  if (%bot.killwin. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.killwin. [ $+ [ %tmp.bsrt ] ] ON }
  if (%bot.relay. [ $+ [ %tmp.bsrt ] ] == $null) { set %bot.relay. [ $+ [ %tmp.bsrt ] ] OFF }
  unset %tmp.bsrt
  return
}
alias bothelp {
  if ($1 != $null) { set %tmp.bhlp $1 }
  else { set %tmp.bhlp $network }
  $report($chain(18) Settings Display $chain(18)).active
  $report($chain(2),$null,$null,$null,"/Bot SET BOT.xxx <value>" to alter).active
  $report($chain(2),$null,$null,$null,or "/Bot SET xxx <value>" works too).active
  $report($chain(2),$null,$null,********************,********************).active
  $report($chain(2),$null,Bot Status,$sock(Bot [ $+ [ %tmp.bhlp ] ]).status,$sock(Bot [ $+ [ %tmp.bhlp ] ] ).name).active 
  $report($chain(2),$null,$null,Current Network,%tmp.bhlp).active
  $report($chain(2),$null,$null,bot.disp,%bot.disp. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.work, %bot.work. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.play, %bot.play. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.nick, %bot.nick. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.pass,%bot.pass. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.value,%bot.value. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.trigger,%bot.trigger. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.showall,%bot.showall. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.defense,%bot.defense. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.reconnect,%bot.reconnect. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.killwin,%bot.killwin. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,bot.relay,%bot.relay. [ $+ [ %tmp.bhlp ] ] ).active
  $report($chain(2),$null,$null,xxx,no value).active
  $report($chain(2),$null,$null,********************,********************).active
  $report($chain(2),$null,$null,$null,do /Bot SET to see a list.).active
  $report($chain(50)).active
  unset %tmp.bhlp
  return
}
alias botvar {
  $report($chain(15) Set Display $chain(15)).active
  $report($chain(2),$null,$null,use,/Bot SET BOT.XXX value).active
  $report($chain(2),$null,$null,or,/BOT SET XXX value).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.disp).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.work).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.play).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.nick).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.pass).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.value).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.trigger).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.showall).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.defense).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.reconnect).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.killwin).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.relay).active
  $report($chain(2),$null,$null,$null,$null,Use /BOT SET BOT.DISP for Options).active
  $report($chain(2),$null,$null,$null,$null,Use /BOT SHOW for full menu).active
  $report($chain(34)).active
  return
}
alias bot.disp.info {
  $report($chain(60)).active
  $report($null,$null,The bot setting where bot will display activity).active
  $report($null,$null,of all the channels it is on. Or not if it OFF.).active
  $report($chain(40)).active
  $report(BOT SET bot.disp  <OFF> (The bot has no output.)).active
  $report(BOT SET bot.disp  <ACTIVE> (The bot displays to your active channel.)).active
  $report(BOT SET bot.disp  <STATUS> (The bot displays to the network status.)).active
  $report(BOT SET bot.disp  <CHANNEL #name> (To a channel window.)).active
  $report(BOT SET bot.disp  <WINDOW @name> (To a named @window.)).active
  $report(BOT SET bot.disp  <MESSAGE name> (To a person as private message.)).active
  $report(BOT SET bot.disp  REPORT (Is a quick status.)).active
  $report($chain(60)).active
  return
}
alias bot.status {
  var %tmp.botn1 1
  var %tmp.botn2 $sock(bot*,0)
  $report($chain(11) Listing Active Bots $chain(11)).active
  while (%tmp.botn1 <= %tmp.botn2) {
    $report(Bot Status,On Server,%tmp.botn1,$remove($sock(bot*,%tmp.botn1),Bot)).active
    $report(Using,$null,%bot.disp. [ $+ [ $network ] ] $+ %bot.disp.dev. [ $+ [ $network ] ]).active
    $report($chain(37)).active
    inc %tmp.botn1
  }
  ;$report($chain(35)).active
  unset %tmp.botn1
  unset %tmp.botn2
  return
}
alias bot.end {
  $report($chain(13) Bot Commands $chain(13)).active
  $report(ON/START - OFF/STOP - SET - SHOW).active
  $report(ID - SEND - OP - DEOP - KICK - JOIN).active
  $report(PART - AJ - CYCLE - SAY - DEBUG).active
  $report(NICK - STATUS - AGAIN - QUIT).active
  $report($null,$null,Try /BOT SHOW to get a look at the values.).active
  $report($null,$null,and /BOT SET to work out how to change them.).active
  $report($null,$null,/BOT SET BOT.DISP for info on where the bot puts its text output.).active
  $report($chain(40)).active
  return
}
on *:CLOSE:@: {
  if ($target == @BotSay [ $+ [ $network ] ] ) {
    if (%bot.killwin. [ $+ [ $network ] ]  == ON) {
      $report(Closing this bot since it's window was closed.).status
      bot quit :Closing the window
      sockclose Bot [ $+ [ $network ] ]
      .timerclsb [ $+ [ $network ] ] 1 1 bot off
    }
  }
}
alias botsetshow { $report(Bot Setting,$null,SET,$1,$2-).active | script.play Notify.wav }
;on ^1:INPUT:@:{
;  if ($remove($target,@BotSay) == Dalnet) { 
;    ;privmsg #StrangeScript : $+ $1- 
;    ;$report(Test,$1-).status
;    sockwrite -n Bot [ $+ [ $remove($target,@BotSay) ] ] privmsg $StrangeScript : $+ $1-
;    return
;  }
;  return
;}
