alias bot {
  botstart
  if ($1 == ON) || ($1 == START) {
    if ($2 != $null) { set %bot.onp2. [ $+ [ $network ] ] $2 }
    if (%bot.onp2. [ $+ [ $network ] ] == $null) { set %bot.onp2. [ $+ [ $network ] ] $network }
    if ($network == libera.chat) { set %bot.onp2. [ $+ [ $network ] ] libera.chat }
    if ($network == localNet) { set %bot.onp2. [ $+ [ $network ] ] local }
    if (%bot.onp2. [ $+ [ $network ] ] == local) {
      bot.check
      sockopen -n BotLocal irc.localdomain.net 6667
      $report(Bot,ON,$null,Local,irc.localdomain.net,6667).active
      return
    }
    if (%bot.onp2. [ $+ [ $network ] ] == ircgo) {
      bot.check
      sockopen -n BotIRCGo irc.IRCGo.org 6667
      $report(Bot,ON,$null,IRCGo,irc.IRCGo.org,6667).active
      return
    }
    if (%bot.onp2. [ $+ [ $network ] ] == dalnet) {
      bot.check
      sockopen -n BotDalNet irc.dal.net 6667
      $report(Bot,ON,$null,DalNet,irc.dal.net,6667).active
      return
    }
    if (%bot.onp2. [ $+ [ $network ] ] == libera.chat) {
      bot.check
      sockopen -n Botlibera.chat irc.libera.chat 6667
      $report(Bot,ON,$null,libera.chat,irc.libera.chat,6667).active
      return
    }
    if (%bot.onp2. [ $+ [ $network ] ] == undernet) {
      bot.check
      sockopen -n BotUnderNet us.undernet.org 6667
      $report(Bot,ON,$null,UnderNet,us.undernet.org,6667).active
      return
    }
    $report(Bot,$null,Input Error,$null,$null,$null,You need to do /Bot ON Local or IRCGO or DalNet or libera.chat or UnderNet Etc.).active
    return
  }
  if ($1 == OFF) || ($1 == STOP) {
    sockclose Bot [ $+ [ $network ] ]
    unset %clone.server. [ $+ [ $sockname ] ]
    set %Bot.active. [ $+ [ $network ] ] 0
    $report(Bot,OFF,$null,$null,$null,You selected off. It's off.).active
    $report(Bot,OFF,$null,Bot.active,%Bot.active. [ $+ [ $network ] ],$null).active
    return
  }
  if ($1 == ID) {
    .timer 1 2 sockwrite -n Bot [ $+ [ $network ] ] identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 4 sockwrite -n Bot [ $+ [ $network ] ] join %bot.work. [ $+ [ $network ] ]
    return
  }
  if ($1 == SET) {
    if ($2 == bot.disp) {
      if ($3 != $null) { bot.disp $3- }
      if ($3 == $null) { bot.disp.info | return }
      return
    }
    if ($2 == bot.work) {
      if ($3 == $null) { return }
      set %bot.work. [ $+ [ $network ] ] $3
      $botsay(SET,Option,$null,$null,bot.work, %bot.work. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.play) {
      if ($3 == $null) { return }
      set %bot.play. [ $+ [ $network ] ] $3
      $botsay(SET,Option,$null,$null,bot.play, %bot.play. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.nick) {
      if ($3 == $null) { return }
      set %bot.nick. [ $+ [ $network ] ] $3
      $botsay(SET,Option,$null,$null,bot.nick, %bot.nick. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.pass) {
      if ($3 == $null) { return }
      set %bot.pass. [ $+ [ $network ] ] $3
      $botsay(SET,Option,$null,$null,bot.pass, %bot.pass. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.value) {
      if (%bot.value == $null) { set %bot.value - }
      if ($3 == $null) { return }
      else { set %bot.value $3- }
      $botsay(Bot Action,Set,bot.value,is set to,%bot.value).active
      return
    }
    if ($2 == bot.trigger) {
      if (%bot.trigger. [ $+ [ $network ] ] == 1) { set %bot.trigger. [ $+ [ $network ] ] 0 }
      else { set %bot.trigger. [ $+ [ $network ] ] 1 }
      $botsay(Bot Action,Set,bot.trigger,is set to,%bot.trigger. [ $+ [ $network ] ]).active
      return
    }
    if ($2 == bot.showall) {
      if (%bot.showall. [ $+ [ $network ] ] == ON) { set %bot.showall. [ $+ [ $network ] ] OFF }
      else { set %bot.showall. [ $+ [ $network ] ] ON }
      $botsay(Bot Action,Set,bot.showall,is set to,%bot.showall. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.defense) {
      if (%bot.defense. [ $+ [ $network ] ] == ON) { set %bot.defense. [ $+ [ $network ] ] OFF }
      else { set %bot.defense. $+ $network ON }
      $botsay(Bot Action,Set,bot.defense,is set to, %bot.defense. [ $+ [ $network ] ] ).active
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
  if ($1 == KICK) {
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] kick $2  $3 : $+ $4- | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] kick # $2  : $+ $3- }
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
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part # }
    if ($2 != $null) && ($3 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part $2 }
    if ($2 != $null) && ($3 != $null) { sockwrite -n Bot [ $+ [ $network ] ] part $2 $3- }
    return
  }
  if ($1 == AJ) {
    .timerbaj $+ $network 1 2 sockwrite -n Bot [ $+ [ $network ] ] join $key(settings,autojoinspeed)
    return
  }
  if ($1 == CYCLE) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part # $cr join # }
    else { sockwrite -n Bot [ $+ [ $network ] ] part $2 :Cycling $cr join $2 }
    return
  }
  if ($1 == SAY) {
    if ($chr(35) isin $2) { sockwrite -n Bot [ $+ [ $network ] ] privmsg $2 : $+ $3- | return }
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] :Nothing to say. Ending. | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] : $+ $2- | return }
    return
  }
  if ($1 == WRITE) {
    if ($2 == $null) { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] :Nothing sent to write. Ending. | return }
    else { sockwrite -n Bot [ $+ [ $network ] ] privmsg %bot.work. [ $+ [ $network ] ] : $+ $2- | return }
  }
  if ($1 == DEBUG) {
    if ($2 == ON) {
      set %bot.showall. [ $+ [ $network ] ] ON
      $botsay(Bot Action,Debug,bot.showall,Set to,%bot.showall. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == OFF) {
      set %bot.showall. [ $+ [ $network ] ] OFF
      $botsay(Bot Action,Debug,bot.showall,Set to,%bot.showall. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == $null) {
      if (%bot.showall. [ $+ [ $network ] ] == ON) {
        set %bot.showall. [ $+ [ $network ] ] OFF
        $botsay(Bot Action,Debug,bot.showall,Set to,%bot.showall. [ $+ [ $network ] ] ).active
        return
      }
      else {
        set %bot.showall. [ $+ [ $network ] ] ON
        $botsay(Bot Action,Debug,bot.showall,Set to,%bot.showall. [ $+ [ $network ] ] ).active
        return
      }
      if (%bot.showall. [ $+ [ $network ] ] == OFF) {
        set %bot.showall. [ $+ [ $network ] ] ON
        $botsay(Bot Action,Debug,bot.showall,Set to,%bot.showall. [ $+ [ $network ] ] ).active
        return
      }
      else {
        set %bot.showall. [ $+ [ $network ] ] OFF
        $botsay(Bot Action,Debug,bot.showall,Set to,%bot.showall. [ $+ [ $network ] ] ).active
        return
      }
    }
    return
  }
  if ($1 == STATUS) {
    var %tmp.botn1 1
    var %tmp.botn2 $sock(bot*,0)
    $report($chain(45)).active
    $report(Bot Status,$null,Listing active servers).active
    while (%tmp.botn1 <= %tmp.botn2) {
      $report(Bot Status,On Server,%tmp.botn1,$sock(bot*,%tmp.botn1)).active
      inc %tmp.botn1
    }
    $report($chain(45)).active
    unset %tmp.botn1
    unset %tmp.botn2
    return
  }
  if ($1 == AGAIN) {
    ; This is a debug thing. If you think your bot is not ident'ing right, this is the USER method. Use it to send it AGAIN.
    sockwrite -n  Bot [ $+ [ $network ] ] user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    return
  }
  if ($1 == QUIT) {
    if ($2 == $null) {
      sockwrite -n Bot [ $+ [ $network ] ] quit :Goodbye
      return
    }
    else {
      sockwrite -n Bot [ $+ [ $network ] ] quit : $+ $2-
      return
    }
  }
  $botsay(Bot,$null,Options,$null,$null,$null,AGAIN, CYCLE, DEBUG, ID, AJ, JOIN, KICK, NICK, ON/START, OFF/STOP, PART, QUIT, SAY, SEND, SET, STATUS, SHOW, WRITE).active
  $botsay(Bot,$null,Options,$null,$null,$null,Try /BOT SHOW to get a look at the settings values and /BOT SET to figure out how to change them.).active
  return
}
alias bot.disp {
  if ($1 == $null) { set %bot.disp. [ $+ [ $network ] ] STATUS }
  if ($1 == REPORT) { $report(Bot Setting,bot.disp,is set to,%bot.disp. [ $+ [ $network ] ]).active | return }
  if ($1 == OFF) { 
    set %bot.disp. [ $+ [ $network ] ] $1
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == ACTIVE) { 
    set %bot.disp. [ $+ [ $network ] ] ACTIVE
    unset %bot.disp.dev. [ $+ [ $network ] ]
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == STATUS) {
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
      set %bot.disp. [ $+ [ $network ] ] CHANNEL
      set %bot.disp.dev. [ $+ [ $network ] ] $2
    }
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    $report(BotSay,SET,Option,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == MESSAGE) {
    if ($2 == $null) {
      $report(BOT SET ERROR,Information entered incorrectly).active
      $report(/BOT SET BOT.DIS MESSAGE <person's name to message>).active
      return
    }
    if ($2 != $null) {
      set %bot.disp. [ $+ [ $network ] ] MESSAGE
      set %bot.disp.dev. [ $+ [ $network ] ] $2
    }
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    $report(BotSay,SET,Option,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ]).active
    return
  }
  if ($1 == WINDOW) {
    if ($2 == $null) {
      $report(BOT SET ERROR,Information entered incorrectly).active
      $report(/BOT SET BOT.DIS MESSAGE <@windowname params>).active
      return
    }
    if ($2 != $null) {
      set %bot.disp. [ $+ [ $network ] ] WINDOW
      set %bot.disp.dev. [ $+ [ $network ] ] $2
      return
    }
    $report(BotSay,SET,Option,$null,bot.disp,%bot.disp. [ $+ [ $network ] ]).active
    $report(BotSay,SET,Option,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ]).active
    return
  }
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
  ;if (%bot.disp. [ $+ [ $network ] ] == ACTIVE) { return echo -at %bot.work [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == ACTIVE) { return echo -at # $sys %tmp.zbuild }
  ;if (%bot.disp. [ $+ [ $network ] ] == STATUS) { return echo -st %bot.work [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == STATUS) { return echo -st # $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == CHANNEL) { return echo -t %bot.disp.dev. [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == MESSAGE) { return msg %bot.disp.dev. [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp. [ $+ [ $network ] ] == WINDOW) { return echo -t %bot.disp.dev. [ $+ [ $network ] ] $sys %tmp.zbuild }
  return
}
on 1:SOCKOPEN:Bot*:{
  if ($sockerr > 0) { sockclose $sockname | $botsay(Sock Error,OPEN,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg).active | return }
  $report(Socket,OPEN,Socket Name,$sockname).active
  set %Bot.active. [ $+ [ $network ] ] 1
  ;if (%bot.nick. [ $+ [ $network ] ] == $null) { set %bot.nick. [ $+ [ $network ] ] $$?="Bot must have a nick, pick one:" }
  ;if (%bot.pass. [ $+ [ $network ] ] == $null) { set %bot.pass. [ $+ [ $network ] ] $$?="Password for that nick if you know it:" }
  if ($sockname == BotLocal) || ($sockname == BotIRCGo) {
    if ( %bot.pass. [ $+ [ $network ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $network ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $network ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  if ($sockname == BotDalNet) {
    sockwrite -n BotDalNet pass %bot.pass. [ $+ [ $network ] ]
    sockwrite -n BotDalNet nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n BotDalNet user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n BotDalNet identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n BotDalNet join %bot.work. [ $+ [ $network ] ]
    .timer 1 15 sockwrite -n BotDalNet identify %bot.pass. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  if ($sockname == Botlibera.chat) {
    if ( %bot.pass. [ $+ [ $network ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $network ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $network ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n $sockname join %bot.work. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  if ($sockname == BotUnderNet) {
    ;sockwrite -n BotUnderNet pass %bot.pass. [ $+ [ $network ] ]
    sockwrite -n BotUnderNet nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n BotUnderNet user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    ;.timer 1 5 sockwrite -n BotUnderNet identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n BotUnderNet join %bot.work. [ $+ [ $network ] ]
    .timer 1 15 sockwrite -n BotUnderNet identify %bot.pass. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  else {
    sockwrite -n $sockname user $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`)
    ;sockwrite -n $sockname nick $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`)
    sockmark $sockname nick %bot.nick. [ $+ [ $network ] ]
    if ( %bot.pass != $null ) { sockwrite -n $sockname nickserv identify %bot.nick. [ $+ [ $network ] ] %bot.pass. [ $+ [ $network ] ] }
    .timer 1 3 sockwrite -n $sockname privmsg nickserv :identify recess %bot.pass. [ $+ [ $network ] ]
    sockwrite -n $sockname join %bot.work. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  $botsay(BotSay,Bot.ERROR,No network given,$null,$null,Usage: /bot <on/start> <Dalnet/Local/Ircgo/libera.chat/etc>)
}
on 1:SOCKREAD:Bot*:{
  if ($sockerr > 0) { sockclose $sockname | $botsay(Sock Error,READ,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg)active | return }
  if (%bot.trigger. [ $+ [ $network ] ] == 1) {
    sockwrite -n $sockname privmsg %bot.work. [ $+ [ $network ] ] : $+ %bot.value
    .timer 1 1 set %bot.value -
    .timer 1 1 set %bot.trigger. [ $+ [ $network ] ] 0
  }
  :Botread
  sockread %Bot.readline
  if ($sockbr == 0) { return }
  if ($gettok(%Bot.readline,1,32) == PING) {
    sockwrite -n $sockname PONG $gettok(%Bot.readline,2,32)
    if (%bot.showall. [ $+ [ $network ] ] == ON) { $botsay(Pong,Sent Pong,to,$remove($gettok(%Bot.readline,2,32),:)).active }
    set %clone.server. [ $+ [ $sockname ] ] $remove($gettok(%Bot.readline,2,32),:)
  }
  if ($remove($left(%Bot.readline,$calc($pos(%Bot.readline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%Bot.readline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname NOTICE $me : $+ $chr(1) $+ PING $gettok(%Bot.readline,5-6,32) $+ $chr(1) }
  if ($gettok(%Bot.readline,2,32) == 353) { $botsay(BotSay,$remove($sockname,Bot) Users $+ $gettok(%Bot.readline,6-,32)) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 311) { $botsay(BotSay,Whois $remove($gettok(%Bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 312) { $botsay(BotSay,Whois $remove($gettok(%Bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 307) { $botsay(BotSay,Whois $remove($gettok(%Bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == 319) { $botsay(BotSay,Whois $remove($gettok(%Bot.readline,4-,32),:)) | goto bossout }
  if ($gettok(%Bot.readline,2,32) == PART) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Part $remove($gettok(%Bot.readline,1,33),:)  Left $remove($gettok(%Bot.readline,3,32),:)) }
  if ($gettok(%Bot.readline,2,32) == JOIN) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Join $remove($gettok(%Bot.readline,1,33),:) entered $remove($gettok(%Bot.readline,3,32),:)) }
  if ($gettok(%Bot.readline,2,32) == NOTICE) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) $remove($gettok(%Bot.readline,1,33),:) $+ @ $+ $remove($gettok(%Bot.readline,3,32),:) $+ : Notice - $remove($gettok(%Bot.readline,4-,32),:)) }
  if ($gettok(%Bot.readline,2,32) == NICK) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) NickChange $remove($gettok(%Bot.readline,1,33),:) is now know as $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,4-,32),:)) }
  if ($gettok(%Bot.readline,2,32) == QUIT) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Quit $remove($gettok(%Bot.readline,1,33),:) $remove($gettok(%Bot.readline,3-,32),:)) }
  if ($gettok(%Bot.readline,2,32) == TOPIC) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Topic $remove($gettok(%Bot.readline,1,33),:) set $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,4-,32),:)) }
  if ($gettok(%Bot.readline,2,32) == KICK) {
    $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Kick $remove($gettok(%Bot.readline,1,33),:) kicked $remove($gettok(%Bot.readline,4,32),:) from $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,5-,32),:))
    sockwrite -n $sockname join $remove($gettok(%Bot.readline,3,32),:) 
    ;if ( $remove($gettok(%Bot.readline,4,32),:) == %bot.name. [ $+ [ $network ] ] ) { sockwrite -n Bot [ $+ [ $network ] ] join $remove($gettok(%Bot.readline,3,32),:) }
    ;if ($sock($sockname).mark == $remove($gettok(%Bot.readline,4,32),:)) { sockwrite -n Bot [ $+ [ $network ] ] join $remove($gettok(%Bot.readline,3,32),:) }
  }
  if ($gettok(%Bot.readline,2,32) == MODE) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Mode $remove($gettok(%Bot.readline,1,33),:) set $remove($gettok(%Bot.readline,4-,32),:) on $remove($gettok(%Bot.readline,3,32),:)) }
  if ($gettok(%Bot.readline,2,32) == PRIVMSG) {
    ;if *-bc cycle*
    ;`
    ;Ctcp Handling
    ;
    if ($left($remove($gettok(%Bot.readline,4-,32),:),1) == $chr(1)) {
      if (* $+ $chr(1) $+ ACTION* iswm $remove($gettok(%Bot.readline,4-,32),:)) {
        $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Action  $+ $color(action) $+ $remove($gettok(%Bot.readline,1,33),:)  $left($remove($gettok(%Bot.readline,4-,32),: $+ $chr(1) $+ ACTION),-1))
        goto bossout
      }
      else { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Ctcp $remove($gettok(%Bot.readline,1,33),:) $+ @ $+ $remove($gettok(%Bot.readline,3,32),:) $+ : $remove($remove($gettok(%Bot.readline,4-,32),:),$chr(1)))
        goto bossout
      }
      goto Botread
    }
    if ($chr(35) isin $remove($gettok(%Bot.readline,3,32),:)) { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) $remove($gettok(%Bot.readline,3,32),:) $remove($gettok(%Bot.readline,1,33),:) $+ : $remove($gettok(%Bot.readline,4-,32),:)) }
    else { $botsay(BotSay,$gettok(%server.Bot. [ $+ [ $remove($sockname,Bot) ] ] ,1,44) Privmsg $remove($gettok(%Bot.readline,1,33),:) Whispered to $remove($gettok(%Bot.readline,3,32),:) $+ : $remove($gettok(%Bot.readline,4-,32),:)) }
    goto Botread
  }
  :bossout
  if (%bot.showall. [ $+ [ $network ] ] == ON) { $botsay(Full Info:,$null,$null,$null,$null,%Bot.readline).active }
  goto Botread
}
on 1:SOCKCLOSE:Bot*:{
  sockclose $sockname
  unset %clone.server. [ $+ [ $sockname ] ]
  set %Bot.active. [ $+ [ $network ] ] 0
  $botsay($sockname just closed Bot [ $+ [ $network ] ] $sock($sockname).wserr $sock($sockname).wsmsg).active
  ;if ($sockname == BotICQ) { .timer 1 1 ockopen BotICQ irc.icq.com 6667 | $botsay(ServerBot,ON,ICQ).active }
  ;if ($sockname == BotDalNet) { .timer 1 1 sockopen BotDalNet irc.dal.net 6667 | $botsay(ServerBot,ON,DalNet).active }
  ;if ($sockname == BotLocal) { .timer 1 1 sockopen BotLocal localhost 6667 | $botsay(ServerBot,ON,Local).active }
  ;if ($sockname == BotIRCgo) { .timer 1 1 sockopen BotIRCgo irc.ircgo.org 6667 | $botsay(ServerBot,ON,IRCgo).active }
  ;if ($sockname == BotCHAT) { .timer 1 1 sockopen BotCHAT irc.chatnet.org 6667 | $botsay(ServerBot,ON,CHAT).active }
}
alias bot.check {
  if (%Bot.active. [ $+ [ $network ] ] == 1) {
    $report(Bot Check,$null,$null,$null,The bot is running on $remove(Bot [ $+ [ $network ] ],Bot)).active
    halt
  }
  else { return }
}
alias botstart {
  if (%bot.disp. [ $+ [ $network ] ] == $null) { set %bot.disp. [ $+ [ $network ] ] STATUS }
  if (%bot.work. [ $+ [ $network ] ] == $null) { set %bot.work. [ $+ [ $network ] ] #StrangeScript }
  if (%bot.play. [ $+ [ $network ] ] == $null) { set %bot.play. [ $+ [ $network ] ] #StrangeScript }
  if (%bot.nick. [ $+ [ $network ] ] == $null) { set %bot.nick. [ $+ [ $network ] ] Guest00001 }
  if (%bot.pass. [ $+ [ $network ] ] == $null) { set %bot.pass. [ $+ [ $network ] ] DefaultPass }
  if (%bot.value. [ $+ [ $network ] ] == $null) { set %bot.value. [ $+ [ $network ] ] Some default text }
  if (%bot.trigger. [ $+ [ $network ] ] == $null) { set %bot.trigger. [ $+ [ $network ] ] 0 }
  if (%bot.showall. [ $+ [ $network ] ] == $null) { set %bot.showall. [ $+ [ $network ] ] OFF }
  if (%bot.defense. [ $+ [ $network ] ] == $null) { set %bot.defense. [ $+ [ $network ] ] OFF }
  return
}
alias bothelp {
  $report($chain(50)).active
  $report($chain(2),$null,$null,$null,use /Bot SET value.below to alter).active
  $report($chain(2),$null,$null,********************,********************).active
  $report($chain(2),$null,Bot Status,$sock($sockname).status,$sock($sockname).name).active 
  $report($chain(2),$null,$null,Current Network,$network).active
  $report($chain(2),$null,$null,bot.disp,%bot.disp. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.disp.dev,%bot.disp.dev. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.work, %bot.work. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.play, %bot.play. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.nick, %bot.nick. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.pass,%bot.pass. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.value,%bot.value. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.trigger,%bot.trigger. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.showall,%bot.showall. [ $+ [ $network ] ] ).active
  $report($chain(2),$null,$null,bot.defense,%bot.defense. [ $+ [ $network ] ] ).active  
  $report($chain(2),$null,$null,xxx,no value).active
  $report($chain(2),$null,$null,********************,********************).active
  $report($chain(2),$null,$null,$null,do /Bot SET to see a list.).active
  $report($chain(50)).active
  return
}
alias botvar {
  $report($chain(34)).active
  $report($chain(2),$null,$null,$null,use /Bot SET value.below).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.disp).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.work).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.play).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.nick).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.pass).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.value).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.trigger).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.showall).active
  $report($chain(2),SET,$null,Option,$null,$null,$null,bot.defense).active
  $report($chain(2),$null,$null,$null,$null,Use /BOT SET BOT.DISP for Options).active
  $report($chain(2),$null,$null,$null,$null,Use /BOT SHOW for full menu).active
  $report($chain(34)).active
  return
}
alias bot.disp.info {
  $report($chain(40)).active
  $report(The bot setting where bot will display activity).active
  $report(of all the channels it is on. Or not if it OFF.).active
  $report($chain(20)).active
  $report(BOT SET bot.disp  <OFF>).active
  $report(BOT SET bot.disp  <ACTIVE>).active
  $report(BOT SET bot.disp  <STATUS>).active
  $report(BOT SET bot.disp  <CHANNEL #name>).active
  $report(BOT SET bot.disp  <WINDOW @name>).active
  $report(BOT SET bot.disp  <MESSAGE name>).active
  $report($chain(40)).active
  return        
}
