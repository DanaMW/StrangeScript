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
    if ($2 == dalnet) {
      sockopen -n BotDalNet irc.dal.net 6667
      return
    }
    if ($2 == libera) {
      sockopen -n BotLibera irc.libera.chat 6667
      return
    }
    $report(Bot,$null,Input Error,$null,$null,$null,You need to do /Bot ON HUMAN or IRCGO or DalNet or Libera Etc.).active
    return
  }
  if ($1 == START) {
    if ($2 == human) {
      sockopen -n BotHuman localhost 6667
      return
    }
    if ($2 == ircgo) {
      sockopen -n BotIRCGo irc.IRCGo.org 6667
      return
    }
    if ($2 == dalnet) {
      sockopen -n BotDalNet irc.dal.net 6667
      return
    }
    if ($2 == libera) {
      sockopen -n BotLibera irc.libera.chat 6667
      return
    }
    $report(Bot,$null,Input Error,$null,$null,$null,You need to do /Bot START HUMAN or IRCGO or DalNet or Libera Etc.).active
    return
  }
  if ($1 == OFF) {
    sockclose *
    return
  }
  if ($1 == STOP) {
    sockclose *
    return
  }
  if ($1 == ID) {
    .timer 1 2 sockwrite -n bot* identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 4 sockwrite -n bot* join %work.chan. [ $+ [ $network ] ]
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
      $report(SET,Option,$null,$null,work.chan, %work.chan. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == play.chan) {
      if ($3 == $null) { return }
      set %play.chan. [ $+ [ $network ] ] $3
      $report(SET,Option,$null,$null,play.chan, %play.chan. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.nick) {
      if ($3 == $null) { return }
      set %bot.nick. [ $+ [ $network ] ] $3
      $report(SET,Option,$null,$null,bot.nick, %bot.nick. [ $+ [ $network ] ] ).active
      return
    }
    if ($2 == bot.pass) {
      if ($3 == $null) { return }
      set %bot.pass. [ $+ [ $network ] ] $3
      $report(SET,Option,$null,$null,bot.pass, %bot.pass. [ $+ [ $network ] ] ).active
      $report(Bot Action,Debug,say.value,Set to,%say.value).active
      return
    }
    if ($2 == say.value) {
      if (%say.value == $null) { set %say.value - }
      else {
        set %say.value $3-
        $report(Bot Action,Set,say.value,Set to,%say.value).active
      }
      return
    }
    if ($2 == say.trigger) {
      if (%say.trigger == 1) {
        set %say.trigger 0
        $report(Bot Action,Set,say.trigger,Set to,%say.trigger).active
      }
      else {
        set %say.trigger 1
        $report(Bot Action,Set,say.trigger,Set to,%say.trigger).active
      }
      return
    }
    $botsay(Bot SET,$null,$null,$null,use /Bot SET value.below).active
    $report(SET,$null,Option,$null,$null,$null,bot.disp).active
    $report(SET,$null,Option,$null,$null,$null,work.chan).active
    $report(SET,$null,Option,$null,$null,$null,play.chan).active
    $report(SET,$null,Option,$null,$null,$null,bot.nick).active
    $report(SET,$null,Option,$null,$null,$null,bot.pass).active
    $report(SET,$null,Option,$null,$null,$null,say.value).active
    $report(SET,$null,Option,$null,$null,$null,say.trigger).active
    $report(SET,$null,Option,$null,$null,$null,bot.showall).active
    $report(Bot SET,$null,$null,$null,*******************).active
    return
  }
  if ($1 == SHOW) {
    $report(Bot Menu,$null,$null,********************,********************).active
    $report(Bot Menu,$null,$null,$null,use /Bot SET value.below to alter).active
    $report(Bot Menu,$null,$null,********************,********************).active
    $report(Bot Menu,$null,Bot Status,$sock(bot*).status,$sock(bot*).name).active
    $report(Bot Menu,$null,$null,Current Network,$network).active
    $report(Bot Menu,$null,$null,bot.disp,%bot.disp).active
    $report(Bot Menu,$null,$null,work.chan, %work.chan. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,play.chan, %play.chan. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,bot.nick, %bot.nick. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,bot.pass,%bot.pass. [ $+ [ $network ] ] ).active
    $report(Bot Menu,$null,$null,say.value,%say.value).active
    $report(Bot Menu,$null,$null,say.trigger,%say.trigger).active
    $report(Bot Menu,$null,$null,bot.showall,%bot.showall).active
    $report(Bot Menu,$null,$null,xxx,no value).active
    $report(Bot Menu,$null,$null,********************,********************).active
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
  if ($1 == NICK) {
    if ($2 == $null) { sockwrite -n Bot* msg %work.chan [ $+ [ $network ] ] :No nick given. Ending. |  return }
    else { sockwrite -n Bot* nick : $+ $2 }
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
  if ($1 == SAY) { 
    if ($chr(35) isin $2) { sockwrite -n Bot* privmsg $2 : $+ $3- | return }
    if ($2 == $null) { sockwrite -n Bot* privmsg %work.chan. [ $+ [ $network ] ] :Nothing to say. Ending. | return }
    else { sockwrite -n Bot* privmsg %work.chan. [ $+ [ $network ] ] : $+ $2- | return }
    return
  }
  if ($1 == WRITE) {
    if ($2 == $null) { sockwrite -n Bot* privmsg %work.chan. [ $+ [ $network ] ] :Nothing sent to write. Ending. | return }
    else { sockwrite -n Bot* privmsg %work.chan. [ $+ [ $network ] ] : $+ $2- | return }
  }
  if ($1 == DEBUG) {
    if ($2 == ON) {
      set %bot.showall ON
      $report(Bot Action,Debug,bot.showall,Set to,%bot.showall).active
      return
    }
    if ($2 == OFF) {
      set %bot.showall OFF
      $report(Bot Action,Debug,bot.showall,Set to,%bot.showall).active
      return
    }
    if ($2 == $null) {
      if (%bot.showall == ON) {
        set %bot.showall OFF
        $report(Bot Action,Debug,bot.showall,Set to,%bot.showall).active
        return
      }
      else {
        set %bot.showall ON
        $report(Bot Action,Debug,bot.showall,Set to,%bot.showall).active
        return
      }
      if (%bot.showall == OFF) {
        set %bot.showall ON
        $report(Bot Action,Debug,bot.showall,Set to,%bot.showall).active
        return
      }
      else {
        set %bot.showall OFF
        $report(Bot Action,Debug,bot.showall,Set to,%bot.showall).active
        return
      }
    }
    return
  }
  if ($1 == AGAIN) {
    sockwrite -n  $sock(*).name user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    return
  }
  if ($1 == QUIT) { $sockwrite -n $sock(*).name quit :This is good-bye | return }
  $report(Bot,$null,Options,$null,$null,$null,ON/START, OFF/STOP, WRITE, SET, SEND, JOIN, PART, CYCLE, NICK, KICK, SHOW, SAY, SEND, DEBUG).active
  return
}
alias bot.disp {
  if ($1 == $null) || ($1 == CHANNEL) {
    set %bot.disp CHANNEL
    $botsay(BotSay,SET,Option,$null,bot.disp,%bot.disp)
    return
  }
  if ($1 == MESSAGE) {
    if ($1 != $null) {
      set %bot.disp MESSAGE
      $botsay(BotSay,SET,Option,$null,bot.disp,%bot.disp)
      return
    }
  }
  if ($1 == WINDOW) {
    if ($1 != $null) {
      set %bot.disp WINDOW
      $botsay(BotSay,SET,Option,$null,bot.disp,%bot.disp)
      return
    }
  }
}
alias botsay {
  if ($1- == $null) { $botsay(BotSay,Bot Say,Error,$null,$null,No Text Sent to Report) | halt }
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
  if (%bot.disp == CHANNEL) { return echo -t %work.chan. [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp == MESSAGE) { return echo -t %work.chan. [ $+ [ $network ] ] $sys %tmp.zbuild }
  if (%bot.disp == WINDOW) { return echo -t %work.chan. [ $+ [ $network ] ] $sys %tmp.zbuild }
  halt
  return
}
on 1:SOCKOPEN:Bot*:{
  if ($sockerr > 0) { sockclose $sockname | privmsg $me Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
  $botsay(BotSay,OPEN,Socket Name,$sockname)
  if ($sockname == BotHuman) || ($sockname == BotIRCGo) {
    if ( %bot.pass. [ $+ [ $network ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $network ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $network ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n $sockname join %work.chan. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  if ($sockname == BotDalNet) {
    sockwrite -n BotDalNet pass %bot.pass. [ $+ [ $network ] ]
    sockwrite -n BotDalNet nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n BotDalNet user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n BotDalNet identify %bot.pass. [ $+ [ $network ] ]    
    .timer 1 10 sockwrite -n BotDalNet join %work.chan. [ $+ [ $network ] ]
    .timer 1 15 sockwrite -n BotDalNet identify %bot.pass. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  ; 
  if ($sockname == BotLibera) {
    if ( %bot.pass. [ $+ [ $network ] ] != $null ) { sockwrite -n $sockname pass %bot.pass. [ $+ [ $network ] ] }
    sockwrite -n $sockname nick %bot.nick. [ $+ [ $network ] ]
    sockwrite -n $sockname user $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) $remove( %bot.nick. [ $+ [ $network ] ] ,`) : $+ $remove( %bot.nick. [ $+ [ $network ] ] ,`)
    .timer 1 5 sockwrite -n $sockname identify $me %bot.pass. [ $+ [ $network ] ]
    .timer 1 6 sockwrite -n $sockname identify %bot.pass. [ $+ [ $network ] ]
    .timer 1 10 sockwrite -n $sockname join %work.chan. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  else {
    sockwrite -n $sockname user $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`)
    ;sockwrite -n $sockname nick $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`) $remove(%bot.nick. [ $+ [ $network ] ] ,`)
    sockmark $sockname nick %bot.nick. [ $+ [ $network ] ]
    if ( %bot.pass != $null ) { sockwrite -n $sockname nickserv identify %bot.nick. [ $+ [ $network ] ] %bot.pass. [ $+ [ $network ] ] }
    .timer 1 3 sockwrite -n $sockname privmsg nickserv :identify recess %bot.pass. [ $+ [ $network ] ]
    sockwrite -n $sockname join %work.chan. [ $+ [ $network ] ]
    $botsay(BotSay,$sockname is now open and set)
    return
  }
  $botsay(BotSay,Bot.ERROR,No network given,$null,$null,Usage: /bot <on/start> <Dalnet/Human/Ircgo/Libera/etc>)
}
on 1:SOCKREAD:Bot*:{
  if ($sockerr > 0) { sockclose $sockname | $report(Sock Error,READ,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg)active | return }
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
    if ($sock($sockname).mark == $remove($gettok(%Bot.readline,4,32),:)) { sockwrite -n $sockname join $remove($gettok(%Bot.readline,3,32),:) }
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
  if (%bot.showall == ON) { $report(Full Info:$null,$null,$bull,$null,%Bot.readline).active }
  goto Botread
}
on 1:SOCKCLOSE:Bot*:{
  unset %clone.server. [ $+ [ $sockname ] ]
  $report($sockname just closed $sock($sockname).wserr $sock($sockname).wsmsg).active
  ;if ($sockname == BotICQ) { s.timer 1 1 ockopen BotICQ irc.icq.com 6667 | $report(ServerBot,ON,ICQ).active }
  ;if ($sockname == BotDalNet) { .timer 1 1 sockopen BotDalNet irc.dal.net 6667 | $report(ServerBot,ON,DalNet).active }
  ;if ($sockname == BotHuman) { .timer 1 1 sockopen BotHuman localhost 6667 | $report(ServerBot,ON,Human).active }
  ;if ($sockname == BotIRCgo) { .timer 1 1 sockopen BotIRCgo irc.ircgo.org 6667 | $report(ServerBot,ON,IRCgo).active }
  ;if ($sockname == BotCHAT) { .timer 1 1 sockopen BotCHAT irc.chatnet.org 6667 | $report(ServerBot,ON,CHAT).active }
}
