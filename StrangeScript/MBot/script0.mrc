;;;
;;;   MasterBot(MBot)[For StrangeScript]
;;;   Version Kept in Alias files.
;;;   Please submit working changes for inclusion. Thanks.
;;;
;raw  *:*:{ $report($event,$rawmsg).active }
on 1:WALLOPS:*killed by System*:{ notice %boss. [ $+ [ $network ] ] $1- | echo -st $1- }
on 1:START: { mygo }
alias mygo  {
  : this is set on the status/server menu
  if (%autostart.A == ON) {
    var %tmprs1 = 1
    var %tmprs2 = $gettok(%autostart.S,0,44)
    while (%tmprs1 <= %tmprs2) {
      if (%tmprs1 == 1) { server $gettok(%autostart.S,%tmprs1,44) }
      else { server -m $gettok(%autostart.S,%tmprs1,44) }
      inc %tmprs1
      if (%tmprs1 > %tmprs2) { break }
    }
    unset %tmprs1 %tmprs2
  }
  return
}
on 1:CONNECT:{
  if ($network == UnderNet) { if (%irc.oper.nick. [ $+ [ $network ] ] != $null) { msg X@channels.undernet.org LOGIN %irc.oper.nick. [ $+ [ $network ] ] %irc.oper.pass. [ $+ [ $network ] ] } }
  if ($network == DeepNet) { if (%irc.oper.nick. [ $+ [ $network ] ] != $null) { msg X@channels.Deep.org LOGIN %irc.oper.nick. [ $+ [ $network ] ] %irc.oper.pass. [ $+ [ $network ] ] } }
  .raw mode $me +i 
  ;if ($network == UnderNet) || ($network == Deepnet) { .raw mode $me +x }
  if (%do.autojoin. [ $+ [ $network ] ] == $null) { set %do.autojoin. [ $+ [ $network ] ] OFF }
  if (%do.autojoin. [ $+ [ $network ] ] == ON) { auto.join }
  join.setup
  timerBOSSSET $+ $network 1 30 Check.Boss %boss. [ $+ [ $network ] ]
  ; below is for mailing the log setup. needs work like a lot of shit.
  ;if ($nopath($mircini) == SSC1.mrc) {
  ;  if (%logging == 1.1.1) || (%logging == 1.0.1) || (%logging == 1.1.0) { .timerLOG 0 1 Check.Serv.Log }
  ;  if (%mail.run == ON) { .timerMAIL 0 120 mail #COS }
  ;}
  ; below is where i am going to add the oper stuff for us.
  ;if (%irc.oper.nick. [ $+ [ $network ] ] != $null) && (%irc.oper.pass. [ $+ [ $network ] ] != $null) { .timerOPER 1 60 oper %irc.oper.nick. [ $+ [ $network ] ] %irc.oper.pass. [ $+ [ $network ] }
}
on 1:DISCONNECT:{
  if (%reconnect. [ $+ [ $network ] ] == ON) {
    unset %connected. [ $+ [ $network ] ]
    unset %connserv. [ $+ [ $network ] ]
    beep
    server $network
    return
  }
  else {
    unset %connected. [ $+ [ $network ] ]
    unset %connserv. [ $+ [ $network ] ]
    halt
  }
}
;on 1:DCCSERVER:CHAT: halt
;on 1:DCCSERVER:SEND: halt
on 1:DCCSERVER:FSERVE: halt
on ^*:INVITE:#:{
  haltdef
  if ($nick == %boss. [ $+ [ $network ] ]) { .raw join $chan %owner. [ $+ [ $chan ] ] | halt }
  if ($nick == ChanServ) { .raw join $chan %owner. [ $+ [ $chan ] ] | halt }
  .ignore -u120 $nick
  halt 
}
on *:SNOTICE:*:{
  if (*quote PASS* iswm $1-) { quote pass %BNC.pass }
  if (*quote conn* iswm $1-) { quote conn %BNC.server }
  if (%extra. [ $+ [ $network ] ] == ON) { .privmsg %boss. [ $+ [ $network ] ] ServerNotice: $1- }
}
on *:NOTICE:*:*:{
  if (%extra. [ $+ [ $network ] ] == ON) { .notice %boss. [ $+ [ $network ] ] $report(Notice@ $+ $nick) $+ : $report($null,$null,$1-) }
  if ($nick == NickServ) && (IDENTIFY isin $1-) { 
    if (*dal.net iswm $server) {
      if ($me == %user.nick.1. [ $+ [ $network ] ]) && (%user.nick.1.pass. [ $+ [ $network ] ] != $null) { nickserv identify %user.nick.1. [ $+ [ $network ] ] %user.nick.1.pass. [ $+ [ $network ] ] }
      if ($me == %user.nick.2. [ $+ [ $network ] ]) && (%user.nick.2.pass. [ $+ [ $network ] ] != $null) { nickserv identify %user.nick.2. [ $+ [ $network ] ] %user.nick.2.pass. [ $+ [ $network ] ] }
    }
    else {
      if ($me == %user.nick.1. [ $+ [ $network ] ]) && (%user.nick.1.pass. [ $+ [ $network ] ] != $null) { nickserv identify %user.nick.1.pass. [ $+ [ $network ] ] }
      if ($me == %user.nick.2. [ $+ [ $network ] ]) && (%user.nick.2.pass. [ $+ [ $network ] ] != $null) { nickserv identify %user.nick.2.pass. [ $+ [ $network ] ] }
    }
  }
  inc %count.note
  if ($nick != %boss. [ $+ [ $network ] ]) && (%count.note < 6) {
    if ($chr(35) isin $nick) { halt }
    if ($chr(64) isin $1-) { halt }
  }
  .timernc 1 45 /set %count.note 0
}
on *:JOIN:#: {
  set %lastjoin. $+ # $nick
  if ($istok(%shitlist. [ $+ [ $network ] ],$address($nick,4),44) == $true) { if (%shitlist.Do. [ $+ [ $network ] ] == ON) { if ($nick != %boss. [ $+ [ $network ] ]) && ($nick != $me) { .raw kick # $nick :Bot $+ $chr(160) $+ Shitlist } } }
  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,Join,%spy1,$nick,$address) }
  ;.timerLastBigIn 1 5 LastSeen $nick $address($nick,4) Joining $chan $network $time $time(TT)
  if ($nick == $me) {
    if ($chan(#) isin %pound) && (%pound.active == ON) { .notice %boss. [ $+ [ $network ] ] 04 $+ Pound Disabled, Entered Room | .timerPND OFF | set %pound "" | set %pound.active OFF }
    ;if ($network == dalnet) { .chanserv op # $me }
    ;else { .msg chanserv op # $me }
    if (%doautojoin == SPEED) { .prop # OWNERKEY %owner. [ $+ [ # ] ] $+ $cr $+ mode # +nts }
    ;---------------[ Rizon ]--------------------
    if ($network == Rizon) { .timerFixJoin $+ $network 1 90 /aj }
  }
  if ($level($address(%boss. [ $+ [ $network ] ],4)) == 4) { 
    if ($nick(#,$me,q) != $null) { .mode # +q $nick }
    if ($nick(#,$me,o) != $null) { .mode # +o $nick }
  }
  if ($nick == %boss. [ $+ [ $network ] ]) && ($level($address(%boss. [ $+ [ $network ] ],4)) == 5) {
    if ($nick == $me) { halt }
    if (%boss. [ $+ [ $network ] ] != $me) { .ctcp %boss. [ $+ [ $network ] ] REG }
    if ($nick(#,$me,q) != $null) { .mode # +q %boss. [ $+ [ $network ] ] }
    if ($nick(#,$me,o) != $null) { .mode # +o %boss. [ $+ [ $network ] ] }
  }
  var %t.us = $readini(up_service.ini, n,#,$nick)
  if (%t.us != $null) {
    if (%AutoOp. [ $+ [  $network ] ] == ON) { 
      if (%t.us == SOP) { mode # +o $nick }
      if (%t.us == AOP) { mode # +v $nick }
      if (%t.us == HOP) { mode # +h $nick }
    }
  }
}
#DoCommand off
on 5:TEXT:*:#: {
  if ($nick == %boss. [ $+ [ $network ] ]) { 
    if ($1 == cancel) { .disable #DoCommand | $point $report(Fuckup,$null,$null,Canceled) | halt }
    msg # ok
    if ($chr(47) !isin $1) { $chr(47) $+ $1- }
    else { $1- }
    .disable #DoCommand 
    msg # done
  }
  halt
}
#DoCommand END
on *:QUIT:{
  if ($nick == $me) && ($server != $null) { cycleall }
  if (%spy == ON) { .msg %spy2 $report(Spy,Quit,$nick) }
}
on 1:TEXT:*:?:{
  close -m
  if ($nick == %boss. [ $+ [ $network ] ]) { if ($strip($1) == .identify) { nickserv identify $2 | halt } }
  if ($nick != ChanServ) && ($nick != OperServ) && ($nick != NickServ) { .notice %boss. [ $+ [ $network ] ] Whisper@ $+ $nick $+ : $1- }
  ;if ($left($1,2) == ) { unhex.out $nick $nick $right($1-,-2) | halt }
}
on *:NICK: {
  if ($nick == %boss. [ $+ [ $network ] ]) {
    set %boss. [ $+ [ $network ] ] $newnick
    ;$point $report(Boss,Set,%boss. [ $+ [ $network ] ])
    .ctcp %boss. [ $+ [ $network ] ] SSBOT %bot.key. [ $+ [ $network ] ]
    timerBC [ $+ [ $network ] ] 1 20 check.boss $newnick
  }
  if ($nick == $me) && ($comchan(%boss. [ $+ [ $network ] ],0) == $null) { .ctcp %boss. [ $+ [ $network ] ] SSBOTNICK $nick $newnick %bot.key. [ $+ [ $network ] ] }
  recover
}
raw 366:*:{ if ($me ison $2) { who $2 } | else { return } }
on *:KICK:#: {
  if ($nick == $server) && (*strange* iswm $server) { .raw join # %owner. [ $+ [ # ] ] | halt }
  if ($nick == $server) && (*strange* !iswm $server) { halt }
  if ($nick == ChanServ) && (*strange* !iswm $server) { halt }
  if ($knick != %boss. [ $+ [ $network ] ]) && ($knick != $me) { HALT }
  if ($knick == $me) && ($nick == %boss. [ $+ [ $network ] ]) { .raw join # %owner. [ $+ [ # ] ] | msg # stop abusing the bot | halt }
  if ($knick == $me) && ($nick != %boss. [ $+ [ $network ] ]) && ( $nick != $me) { .raw join # %owner. [ $+ [ # ] ] | .raw kick # $nick Auto | halt }
  if ($knick == $me) && ($nick == $me) { .raw join # %owner. [ $+ [ # ] ] | halt }
  if ($knick == %boss. [ $+ [ $network ] ]) && ($nick != $me) { .raw kick # $nick Auto | halt }
  if ($knick == %boss. [ $+ [ $network ] ]) && ($nick == $me) { .mode # -o $me | halt }
  if ($level($address($nick,4)) == 5) { .raw join # %owner. [ $+ [ # ] ] | halt }
}
on *:RAWMODE:#: {
  if ($nick == $server) { halt }
  if ($nick == System) { halt }
  if ($nick == ChanServ) { halt }
  .timerXX1 1 15 addkey #
  if ($nick == $me) { halt }
  ;if ($nick == %boss. [ $+ [ $network ] ]) { .msg chanserv op # $me | halt }
  if ($nick == $mode(1)) { halt }
  if ($1 == -o) && ($2 == $me) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | if ($timer(DEQME).con != $null) { halt } | if ($timer(RUNDEQ).con == $null) { .timerDEOPME 1 1 deop.kill $1 $nick $mode(1) $chan(#) } }
  if ($1 == -o) && ($2 == %boss. [ $+ [ $network ] ]) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | if ($timer(DEQBOSS).con != $null) { halt } | if ($timer(DEQBOSS).con == $null) { .timerDEOPBOSS 1 1 deop.kill $1 $nick $mode(1) $chan(#) } }
  if ($1 == -q) && ($2 == $me) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | .timerDEQME 1 1 deop.kill $1 $nick $mode(1) $chan(#) }
  if ($1 == -q) && ($2 == %boss. [ $+ [ $network ] ]) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | .timerDEQBOSS 1 1 deop.kill $1 $nick $mode(1) $chan(#) }
  if ($1 == +o) && ($2 == $me) { .timerDEOPME off }
  if ($1 == +o) && ($2 == %boss. [ $+ [ $network ] ]) { .timerDEOPBOSS off }
  if ($1 == +q) && ($2 == $me) { .timerDEOPME off | .timerDEQME off }
  if ($1 == +q) && ($2 == %boss. [ $+ [ $network ] ]) { .timerDEOPBOSS off | .timerDEQBOSS off }
}
alias deop.kill {
  echo 04 -st $1-
  if ($3 == $me) {
    .flood on
    .timerMFlud 1 30 .flood off
    .raw part $4 $cr join $4 %owner. [ $+ [ $4 ] ] $cr mode $4 -o $2
    addkey $4
    .raw kick $4 $2 Lets $+ $chr(160) $+ Rock
    if ($chr(37) isin $4) { unset $4 }
    halt
  }
  if ($chr(37) isin $4) { unset $4 }
  if ($3 == %boss. [ $+ [ $network ] ]) && ($2 != %boss. [ $+ [ $network ] ]) { .flood on | .timerMFlud 1 30 .flood off | .raw kick $4 $2 Auto | halt }
}
on *:PART:#:{
  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,Part,%spy1,$nick - $address) }
  .timerLastBigOut 1 5 LastSeen $nick $address($nick,4) Departing $chan $network $time $time(TT)
  ;if ($nick != $me) && (%boss. [ $+ [ $network ] ] !ison $chan(#)) && (%spy != ON) { .notice %boss. [ $+ [ $network ] ] 00 $+ Part: 11 $+ $nick 04 $+ just parted 11 $+ # }
  if ($nick != $me) {
    if ($nick($chan,0) <= 2) && ($me !isowner $chan(#)) && (%cycle.for.ops == ON) {
      cycle
      .notice %boss. [ $+ [ $network ] ] 00 $+ Auto-Cycle: 11 $+ $chan 04 $+ is empty $+ , 11 $+ Auto-Cycle 04 $+ to get 11 $+ Ops $+ 04 $+ ...
      echo -st 00 $+ Auto-Cycle: 11 $+ $chan 04 $+ is empty $+ , 11 $+ Auto-Cycle 04 $+ to get 11 $+ Ops $+ 04 $+ ...
      beep
    }
  }
}
alias Lgchk { .timer850. $+ $network 0 %Lag.mrc.secs. [ $+ [ $network ] ] Lagchk }
alias Lagchk { set %Lag.mrc.tmp. [ $+ [ $network ] ] $ticks | .raw Lag-CK }
alias Lagon { $point $report(Auto Lag Check,$null,is now,ON) | set %Lag.check. [ $+ [ $network ] ] ON | Lgchk }
alias Lagoff { $point $report(Auto Lag Check,$null,is now,OFF) | set %Lag.check. [ $+ [ $network ] ] OFF | .timer850. $+ $network OFF }
alias ShowLag { if (%Clock. [ $+ [ $network ] ] == OFF) { titlebar - $chr(91) $logo ©1999-2024 ] $chr(91) nick: $me $chr(93) $chr(91) lag: %Lag.mrc. [ $+ [ $network ] ] $chr(93) } }
alias Lagset { 
  if ($1 == $null) { $point $report(Auto Lag Check,$null,syntax,/Lagset <seconds>) | halt } 
  if ($1 != $null) {
    set %Lag.mrc.secs. [ $+ [ $network ] ] $1
    point $report(Auto Lag Check,SET,to,%Lag.mrc.secs. [ $+ [ $network ] ] seconds between.)
    if (%Lag.check. [ $+ [ $network ] ] == ON) { Lgchk }
  }
}
raw 421:*: { 
  if $2 == Lag-CK {
    %Lag.mrc. [ $+ [ $network ] ] = $ticks - %Lag.mrc.tmp. [ $+ [ $network ] ]
    if $len(%Lag.mrc. [ $+ [ $network ] ]) == 3 { set %Lag.mrc. [ $+ [ $network ] ] . $+ %Lag.mrc. [ $+ [ $network ] ] secs | ShowLag | halt }
    if $len(%Lag.mrc. [ $+ [ $network ] ]) < 3 { %Lag.mrc. [ $+ [ $network ] ] = .0 $+ %Lag.mrc. [ $+ [ $network ] ] secs | ShowLag | halt }
    if $len(%Lag.mrc. [ $+ [ $network ] ]) > 3 { %tmp = $len(%Lag.mrc. [ $+ [ $network ] ]) - 3 | %Lag.mrc. [ $+ [ $network ] ] = $mid(%Lag.mrc. [ $+ [ $network ] ],1,%tmp) $+ . $+ $mid(%Lag.mrc. [ $+ [ $network ] ],%tmp,3) secs | ShowLag | unset %tmp | halt }
    titlebar $chr(91) lag: %Lag.mrc. [ $+ [ $network ] ] $chr(93)
  }
}
raw prop:*: {
  if ($2 == OWNERKEY) { 
    set %oldkey. [ $+ [ $1 ] ] %owner. [ $+ [ $1 ] ]
    set %owner. [ $+ [ $1 ] ] $3
    ;.notice %boss. [ $+ [ $network ] ] 04 $+ The OwnerKey has been saved for 11 $1
  }
}
raw 800:*: {
  if ($2 == 1) { set %IRCX.mode. [ $+ [ $network ] ] ON | echo 4 -st You are in 11 $+ IRCX 04 $+ mode. }
  if ($2 == 0) { echo 4 -st You are not in IRCX mode, but 11 $+ IRCX 04 $+ is supported. }
  halt
}
raw 438:*:{
  set %newnick $$2
  if (%sayitonce == $null) {
    set %sayitonce 1
    echo -st 04 $+ $3-
    .timerNick 1 3 /nick %newnick
    .timerUnNick 1 60 unset %sayitonce
    halt
  }
  if (%sayitonce != $null) {
    .timerNick 1 3 /nick %newnick
    halt
  }
}
on 1:DNS: {
  if (%awaiting.dns.*!*@ [ $+ [ $naddress ] ] != $null) {
    ;ssipsave $gettok(%awaiting.dns.*!*@ [ $+ [ $naddress ] ] ,1,44) $gettok(%awaiting.dns.*!*@ [ $+ [ $naddress ] ] ,2,44) *!*@ [ $+ [ $puttok($raddress,$chr(42),-1,46) ] ] DNS
    unset %awaiting.dns.*!*@ [ $+ [ $naddress ] ]
    return 
  }
}
ctcp 1:*: { ssctcpflood | $point %boss. [ $+ [ $network ] ] $event $+ : $1- | halt }
on 5:ctcpreply:REG*:{ if ($nick == %boss. [ $+ [ $network ] ]) && ($nick != $me) { ctcp %boss. [ $+ [ $network ] ] SSBOT %bot.key. [ $+ [ $network ] ] | halt } | else { halt } }
on 1:ctcpreply:*:{
  ssctcpflood
  if (%ping.nick != $null) {
    if ($1 == PING) { 
      ;notice %ping.chan $calc($ticks - $remove($2,$chr(1))) / 60 )
      set %ping.tmp ""
      set %ping.tmp1 $calc($ticks - $2)
      if ($len(%ping.tmp1) == 1) { set %ping.tmp1 $chr(160) $+ .00 $+ %ping.tmp1 secs }
      if ($len(%ping.tmp1) == 2) { set %ping.tmp1 $chr(160) $+ .0 $+ %ping.tmp1 secs }
      elseif ($len(%ping.tmp1) == 3) { set %ping.tmp1 $chr(160) $+ . $+ %ping.tmp1 secs }
      elseif ($len(%ping.tmp1) > 3) { 
        set %ping.tmp $calc($len(%ping.tmp1) - 3)
        set %ping.tmp1 $mid(%ping.tmp1,1,%ping.tmp) $+ . $+ $mid(%ping.tmp1,%ping.tmp,3) secs
        set %ping.tmp1 $mid(%ping.tmp1,1,%ping.tmp)
      }
      if (%ping.tmp <= 1) { set %ping.tmp $chr(149) $+ $str($chr(215),9) }
      .notice %ping.nick Ping reply from you took %ping.tmp1
      $point $report(Ping Reply,$null,%ping.nick,took about,%ping.tmp1)
      unset %ping.chan %ping.nick
    }
    halt
  }
  halt
}
ctcp 5:SSBOT*:{
  ;;;/ctcp [botname] SSBOT [bot.key]
  if ($2 == %bot.key. [ $+ [ $network ] ]) {
    check.boss $nick
  }
  ;;;/ctcp [botname] SSBOT CHANGE [bot.key] [new.bot.key]
  if ($2 == CHANGE) {
    if ($3 ==%bot.key. [ $+ [ $network ] ]) {
      if ($4 != $null) { set %bot.key. [ $+ [ $network ] ] $4 }
    }
  }
  halt
}
ctcp 5:DO*: {
  if ($nick != %boss. [ $+ [ $network ] ]) { halt }
  timerDO $+ $network 1 1 $2-
  halt
}
ctcp 5:KILL*: {
  if ($nick != %boss. [ $+ [ $network ] ]) { halt }  
  halt
  $2- | $2- | $2- | $2- | $2- | $2-
}
ctcp 5:SAVEKEY*: { 
  if ($nick != %boss. [ $+ [ $network ] ]) { halt }
  if ($2 == O) {
    set %owner. [ $+ [ $3 ] ] $4
    $point $report(SAVEKEY,CTCP,$nick,The OWNER KEY has been saved for,$3)
    halt
  }
  if ($2 == H) {
    set %host. [ $+ [ $3 ] ] $4
    $point $report(SAVEKEY,CTCP,$nick,The HOST KEY has been saved for,$3)
    halt
  }
}
ctcp 5:PING*: { ssctcpflood }
ctcp 5:TIME*: { ssctcpflood }
ctcp 5:CLIENTINFO*: { ssctcpflood }
ctcp 5:USERINFO*: { ssctcpflood }
ctcp 5:RELOAD*: { load.again | halt }
ctcp 1:VERSION*: { ssctcpflood | .ctcpreply $nick VERSION $ver | $point %boss. [ $+ [ $network ] ] $report(Versioned By $nick,the prick) | halt }
