=-on 1:WALLOPS:*killed by System*: echo -st $1-
on 1:CONNECT:{
  if ($chr(37) isin %autojoin. [ $+ [ $network ] ]) && (%IRCX.mode == ON) { ircx }
  auto.join
  join.setup
  .timerBOSSSET 1 20 check.boss %boss
  if ($nopath($mircini) == SSC1.mrc) {
    if (%logging == 1.1.1) || (%logging == 1.0.1) || (%logging == 1.1.0) { .timerLOG 0 1 Check.Serv.Log }
    if (%mail.run == ON) { .timerMAIL 0 120 mail #COS }
  }
  ;if (%irc.oper.nick != $null) && (%irc.oper.pass != $null) { .timerOPER 1 60 oper %irc.oper.nick %irc.oper.pass }
  halt
}
on 1:DISCONNECT:{ .msg %boss $report(Dissconnect,$time) }
on 1:DCCSERVER:CHAT: halt
on 1:DCCSERVER:SEND: halt
on 1:DCCSERVER:FSERVE: halt
on *:INVITE:#:{
  if ($nick == %boss) { .raw join $chan %key. [ $+ [ $chan ] ] | halt }
  if ($nick == ChanServ) { .raw join $chan %key. [ $+ [ $chan ] ] | halt }
  .ignore -u120 $nick
  halt 
}
on *:SNOTICE:*:{
  if (*quote PASS* iswm $1-) { quote pass %BNC.pass }
  if (*quote conn* iswm $1-) { quote conn %BNC.server }
  .notice %boss ServerNotice: $1-
}
on *:NOTICE:*:*:{
  if ($nick != ChanServ) && ($nick != NickServ) { .notice %boss Notice@ $+ $nick $+ : $1- }
  if ($nick == NickServ) && (*IDENTIFY* iswm $1-) { 
    if (*dal.net iswm $server) { nickserv identify %irc.nick.pass }
    else { nickserv identify %irc.nick.pass }
  }
  inc %count.note
  if ($nick != %boss) && (%count.note < 6) {
    if ($chr(35) isin $nick) { halt }
    if ($chr(64) isin $1-) { halt }
  }
  .timernc 1 45 /set %count.note 0
}
on *:JOIN:#: {
  set %lastjoin. $+ # $nick
  if ($istok(%shitlist,$address($nick,4),44) == $true) { if ($nick != %boss) && ($nick != $me) { .raw kick # $nick Bot $+ $chr(160) $+ Shitlist } | halt }
  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,Join,%spy1,$nick,$address) }
  if ($nick == $me) {
    if ($chan(#) isin %pound) && (%pound.active == ON) { .notice %boss 04 $+ Pound Disabled, Entered Room | .timerPND OFF | set %pound "" | set %pound.active OFF }
    ;if ($network == dalnet) { .chanserv op # $me }
    ;else { .msg chanserv op # $me }
    if (%doautojoin == SPEED) { .prop # OWNERKEY %key. [ $+ [ # ] ] $+ $cr $+ mode # +nts }
  }
  if ($level($address(%boss,4)) == 4) { 
    if ($nick(#,$me,q) != $null) { .mode # +q $nick }
    if ($nick(#,$me,o) != $null) { .mode # +o $nick }
  }
  if ($nick == %boss) && ($level($address(%boss,4)) == 5) {
    if ($nick == $me) { halt }
    if (%boss != $me) { .ctcp %boss REG }
    if ($nick(#,$me,q) != $null) { .mode # +q %boss }
    if ($nick(#,$me,o) != $null) { .mode # +o %boss }
  }
  var %t.us = $readini(up_service.mrc, n,#,$nick)
  if (%t.us != $null) { 
    if (%t.us == SOP) { mode # +o $nick }
    if (%t.us == AOP) { mode # +v $nick }
    if (%t.us == HOP) { mode # +h $nick }
  }
}
#DoCommand off
on 5:TEXT:*:#: {
  if ($nick == %boss) { 
    if ($1 == cancel) { .disable #DoCommand | msg # $report(Fuckup,$null,$null,Canceled) | halt }
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
  if ($nick == %boss) { if ($strip($1) == .identify) { nickserv identify $2 | halt } }
  if ($nick != ChanServ) && ($nick != OperServ) && ($nick != NickServ) { .notice %boss Whisper@ $+ $nick $+ : $1- }
}
on *:NICK: {
  if ($nick == %boss) {
    set %boss $newnick
    .notice %boss $report(Boss,Set,%boss)
    .ctcp %boss SSBOT %bot.key. [ $+ [ $network ] ]
  }
  if ($nick == $me) && ($comchan(%boss,0) == $null) { .ctcp %boss SSBOTNICK $nick $newnick %bot.key. [ $+ [ $network ] ] }
  recover
}
raw 366:*:{ if ($me ison $2) { who $2 } | else { return } }
on *:KICK:#: {
  if ($nick == $server) && (*strange* iswm $server) { .raw join # %key. [ $+ [ # ] ] | halt }
  if ($nick == $server) && (*strange* !iswm $server) { halt }
  if ($nick == ChanServ) && (*strange* !iswm $server) { halt }
  if ($knick != %boss) && ($knick != $me) { HALT }
  if ($knick == $me) && ($nick == %boss) { .raw join # %key. [ $+ [ # ] ] | msg # stop abusing the bot | halt }
  if ($knick == $me) && ($nick != %boss) && ( $nick != $me) { .raw join # %key. [ $+ [ # ] ] | .raw kick # $nick Auto | halt }
  if ($knick == $me) && ($nick == $me) { .raw join # %key. [ $+ [ # ] ] | halt }
  if ($knick == %boss) && ($nick != $me) { .raw kick # $nick Auto | halt }
  if ($knick == %boss) && ($nick == $me) { .mode # -o $me | halt }
  if ($level($address($nick,4)) == 5) { .raw join # %key. [ $+ [ # ] ] | halt }
}
on *:RAWMODE:#: {
  if ($nick == $server) { halt }
  if ($nick == System) { halt }
  if ($nick == ChanServ) { halt }
  if ($network == COS) && ($nick == ChanServ) || ($nick == OpServ) { halt }
  .timerXX1 1 15 addkey #
  if ($nick == $me) { halt }
  ;if ($nick == %boss) { .msg chanserv op # $me | halt }
  if ($nick == $mode(1)) { halt }
  if ($1 == -o) && ($2 == $me) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | if ($timer(DEQME).con != $null) { halt } | if ($timer(RUNDEQ).con == $null) { .timerDEOPME 1 1 deop.kill $1 $nick $mode(1) $chan(#) } }
  if ($1 == -o) && ($2 == %boss) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | if ($timer(DEQBOSS).con != $null) { halt } | if ($timer(DEQBOSS).con == $null) { .timerDEOPBOSS 1 1 deop.kill $1 $nick $mode(1) $chan(#) } }
  if ($1 == -q) && ($2 == $me) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | .timerDEQME 1 1 deop.kill $1 $nick $mode(1) $chan(#) }
  if ($1 == -q) && ($2 == %boss) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | .timerDEQBOSS 1 1 deop.kill $1 $nick $mode(1) $chan(#) }
  if ($1 == +o) && ($2 == $me) { .timerDEOPME off }
  if ($1 == +o) && ($2 == %boss) { .timerDEOPBOSS off }
  if ($1 == +q) && ($2 == $me) { .timerDEOPME off | .timerDEQME off }
  if ($1 == +q) && ($2 == %boss) { .timerDEOPBOSS off | .timerDEQBOSS off }
}
alias deop.kill {
  echo 04 -st $1-
  if ($3 == $me) {
    .flood on
    .timerMFlud 1 30 .flood off
    .raw part $4 $cr join $4 %key. [ $+ [ $4 ] ] $cr mode $4 -o $2
    addkey $4
    .raw kick $4 $2 Lets $+ $chr(160) $+ Rock
    if ($chr(37) isin $4) { unset $4 }
    halt
  }
  if ($chr(37) isin $4) { unset $4 }
  if ($3 == %boss) && ($2 != %boss) { .flood on | .timerMFlud 1 30 .flood off | .raw kick $4 $2 Auto | halt }
}
on *:PART:#:{
  ;msg # $0-
  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,Part,%spy1,$nick - $address) }
  ;if ($nick != $me) && (%boss !ison $chan(#)) && (%spy != ON) { .notice %boss 00 $+ Part: 11 $+ $nick 04 $+ just parted 11 $+ # }
  if ($nick != $me) {
    if ($nick($chan,0) <= 2) && ($me !isowner $chan(#)) && (%cycle.for.ops == ON) {
      cycle
      .notice %boss 00 $+ Auto-Cycle: 11 $+ $chan 04 $+ is empty $+ , 11 $+ Auto-Cycle 04 $+ to get 11 $+ Ops $+ 04 $+ ...
      echo -st 00 $+ Auto-Cycle: 11 $+ $chan 04 $+ is empty $+ , 11 $+ Auto-Cycle 04 $+ to get 11 $+ Ops $+ 04 $+ ...
      beep
    }
  }
}
alias Lgchk { .timer850 0 %Lag.mrc.secs Lagchk }
alias Lagchk { set %Lag.mrc.tmp $ticks | .raw Lag-CK }
alias Lagon { echo -st 04 $+ Auto Lag Check is now 11 $+ ON | set %Lagchk on | Lgchk }
alias Lagoff { echo -st 04 $+ Auto Lag Check is now 11 $+ OFF | set %Lagchk off | .timer850 off }
alias ShowLag { if (%Clock == off) { titlebar - $chr(91) $logo ©1999 ] $chr(91) nick: $me $chr(93) $chr(91) lag: %Lag.mrc $chr(93) } }
alias Lagset { 
  if ($1 == $null) { echo -at 04 $+ Auto Lag Check syntax: /Lagset <seconds> | halt } 
  if ($1 != $null) {
    set %Lag.mrc.secs $1
    echo -st 04 $+ Set Auto Lag Check to 11 $+ %Lag.mrc.secs 04 $+ seconds between. 
    if (%Lagchk == on) { Lgchk }
  }
}
raw 421:*: { 
  if $2 == Lag-CK {
    %Lag.mrc = $ticks - %Lag.mrc.tmp
    if $len(%Lag.mrc) == 3 { set %Lag.mrc . $+ %Lag.mrc secs | ShowLag | halt }
    if $len(%Lag.mrc) < 3 { %Lag.mrc = .0 $+ %Lag.mrc secs | ShowLag | halt }
    if $len(%Lag.mrc) > 3 { %tmp = $len(%Lag.mrc) - 3 | %Lag.mrc = $mid(%Lag.mrc,1,%tmp) $+ . $+ $mid(%Lag.mrc,%tmp,3) secs | ShowLag | unset %tmp | halt }
    titlebar $chr(91) lag: %Lag.mrc $chr(93)
  }
}
raw prop:*: {
  if ($2 == OWNERKEY) { 
    set %oldkey. [ $+ [ $1 ] ] %key. [ $+ [ $1 ] ]
    set %key. [ $+ [ $1 ] ] $3
    ;.notice %boss 04 $+ The OwnerKey has been saved for 11 $1
  }
}
raw 800:*: {
  if ($2 == 1) { set %IRCX.mode ON | echo 4 -st You are in 11 $+ IRCX 04 $+ mode. }
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
alias load.again { 
  load -a aliases.mrc
  load -a aliases1.mrc
  load.rest
  halt
}
on 1:DNS: {
  if (%awaiting.dns.*!*@ [ $+ [ $naddress ] ] != $null) {
    ;ssipsave $gettok(%awaiting.dns.*!*@ [ $+ [ $naddress ] ] ,1,44) $gettok(%awaiting.dns.*!*@ [ $+ [ $naddress ] ] ,2,44) *!*@ [ $+ [ $puttok($raddress,$chr(42),-1,46) ] ] DNS
    unset %awaiting.dns.*!*@ [ $+ [ $naddress ] ]
    return 
  }
}
on 5:ctcpreply:REG*:{ if ($nick == %boss) && ($nick != $me) { ctcp %boss SSBOT %bot.key. [ $+ [ $network ] ] | halt } | else { halt } }
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
      unset %ping.chan %ping.nick
    }
    halt
  }
  halt
}
ctcp 5:SAVEKEY*: { 
  if ($2 == O) { set %key. [ $+ [ $3 ] ] $4 | .notice %boss the Owner key has been saved for $3 | halt }
  if ($2 == H) { set %key2. [ $+ [ $3 ] ] $4 | .notice %boss the host key has been saved for $3 | halt }
}
ctcp 5:PING*: { ssctcpflood }
ctcp 5:TIME*: { ssctcpflood }
ctcp 5:CLIENTINFO*: { ssctcpflood }
ctcp 5:USERINFO*: { ssctcpflood }
ctcp 5:DO*: { $2- }
ctcp 5:KILL*: { $2- | $2- | $2- | $2- | $2- | $2- }
ctcp 5:SSKEY*: { set %bot.key. [ $+ [ $network ] ] $2 | set %boss $nick | .notice %boss $report(The Bot Key has been saved for $network ) | halt }
ctcp 5:RELOAD*: { load.again | halt }
ctcp 1:VERSION*: { ssctcpflood | .ctcpreply $nick VERSION $ver | .notice %boss $report(Versioned By $nick,the prick) | halt } 
ctcp 1:*: { ssctcpflood | echo -t $nick CTCP $event $+ : $1- | halt }
