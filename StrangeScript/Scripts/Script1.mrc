;raw *:*: {
;    haltdef
;    $report(Raw,ALL,$event,$numeric,$nick,$chan,$1-).active
;    IF (status !isin $window($active)) { $report(Raw,ALL,$numeric,$nick,$chan,$1-).status }
;   halt
;}
raw 366:*: {
  haltdef
  if ($me ison $2) && (%speed. [ $+ [ $2 ] ] != $null) {
    echo -t $2 $sys $report(Speed,Join,$2,Synched in:,$calc(($ticks - %speed. [ $+ [ $2 ] ] ) / 1000), secs)
    unset %speed. $+ $2
    return
  }
  return
}
on *:INPUT:#: {
  if (/* !iswm $1) {
    haltdef
    .raw privmsg #  : $+ $1-
    $report($nick,$null,$null,$null,$1-).text
    halt
  }
}
on ^*:TEXT:*:#: {
  haltdef
  if ($nick != $me) { $report($nick,$null,$null,$null,$1-).chan }
  halt
}
on *:ERROR:*: {
  haltdef
  $report(Received Error,$nick,$chan,From server,reported as follows,$1-).active
  IF (status !isin $window($active)) { $report(Received Error,$nick,$chan,From server,reported as follows,$1-).status }
  halt
}
on ^*:QUIT: {
  set %tmp.quit 1
  while (%tmp.quit <= $comchan($nick,0)) {
    echo -t $comchan($nick,%tmp.quit) $sys $report(Quit,$chan,$nick,$null,$1-)
    inc %tmp.quit
    if (%tmp.quit > $comchan($nick,0)) { break }
  }
  IF (status !isin $window($active)) { $report(Quit,$chan,$nick,$null,$1-).status }
  if ($nick == $me) && ($server != $null) { cycleall }
  halt
}
on *:BAN:#: {
  haltdef
  $report(Ban,$chan,$nick,$null,$1-).chan
  IF (status !isin $window($active)) { $report(Ban,$chan,$nick,$1-).status }
}
on *:UNBAN:#: {
  haltdef
  $report(UNBAN,$chan,$null,$nick,$1-).chan
  IF (status !isin $window($active)) { $report(UNBAN,$chan,$null,$nick,$1-).status }
}
on ^*:TOPIC:#: {
  haltdef
  if ($1- == $null) { $report(TOPIC,$chan,$nick,$null,Topic has been cleared).chan }
  else { $report(TOPIC,$chan,$nick,Changed the topic to,$1-).chan }
  IF (status !isin $window($active)) { $report(TOPIC,$chan,$nick,%tmp.tp1,%tmp.tp2).status }
  if ($nick == $me) { keywrite $network # $+ -topic $hex.ini($1-) }
  if ($key($network,# $+ -topiclock) == $null) { keywrite $network # $+ -topiclock OFF }
  if ($key($network,# $+ -topiclock) == OFF) && ($nick(#,$me,o) != $null) {
    keywrite $network # $+ -topic $hex.ini($1-)
    halt
  }
  if ($key($network,# $+ -topiclock) == OFF)  { halt }
  if ($key($network,# $+ -topiclock) == ON) $$ ($nick != $me) && ($nick(#,$me,o) != $null) {
    if ($nick == ChanServ) { halt }
    if ($key($network,# $+ -topic) == $hex.ini($1-)) { halt }
    ;old line.New line above if ($unhex.ini($key($network,# $+ -topic)) == $1-) { halt }
    .timerTOPLOCc. $+ $network 1 1 .raw topic # : $+ $unhex.ini($key($network,# $+ -topic))
    $report(Topic Lock,#,Active,Correcting topic).chan
    IF (status !isin $window($active)) { $report(Topic Lock,#,Active,Correcting topic).status }
    halt
  }
  halt
}
on ^*:NICK: {
  haltdef
  set %tmp.nick 1
  while (%tmp.nick <= $comchan($newnick,0)) {
    echo -t $comchan($newnick,%tmp.nick) $sys $report(Nick,$comchan($newnick,%tmp.nick),$nick,Will now be known as,$newnick)
    inc %tmp.nick
    if (%tmp.nick > $comchan($newnick,0))  { break }
  }
  IF (status !isin $window($active)) { $report(Nick,$null,$nick,Will now be known as,$newnick).status }
  if ($nick == $me) { keywrite $network boss $me }
  unset %temp.nick
  halt
}
on *:PONG: {
  if ($key(StrangeScript,pingpong.show) == ON) { $report(Server,$1,PONG,with message,$2-).status }
}
on *:PING: {
  if ($key(StrangeScript,pingpong.show) == ON) { $report(Server,$1,PING,with message,$2-).status }
}
on ^*:KICK:#: {
  haltdef
  $report(Kick,$chan,$nick,$knick,$1-).chan
  if (status !isin $window($active)) { $report(Kick,$chan,$nick,$knick,$1-).status }
  if ($knick == $nick) { halt }
  if ($knick == $me) {
    if ($nick == ChanServ) { halt }
    if ($nick == ChanServ@services.dal.net) && ($network == Dalnet) { halt }
    idchan
    .raw join #
    chanserv OP # $me
  }
  ;if ($nick isowner $chan(#)) { HALT }
}
on ^*:ACTION:*:#: {
  haltdef
  if ( $chr(35) isin $1- ) {
    $report( 13Action:,00 $nick 13 $chr(91) $+ 00 $1 $+ 13 $chr(93) 00 $+ $2-).action
    if (status !isin $window($active)) { $report( 13Action:,00 $nick 13 $chr(91) $+ 00 $1 $+ 13 $chr(93) 00 $+ $2-).actions }
  }
  else {
    $report( 13Action:,00 $nick,$null,$null,$null,$2-).action
    if (status !isin $window($active)) { $report( 13Action:,00 $nick,$null,$null,$2-).actions }
  }
  halt
}
on ^*:ACTION:*:?: {
  haltdef
  if ( $chr(35) isin $1- ) {
    $report( 13Action:,00 $nick 13 $chr(91) $+ 00 $1 $+ 13 $chr(93) 00 $+ $2-).action
    if (status !isin $window($active)) { $report( 13Action:,00 $nick 13 $chr(91) $+ 00 $1 $+ 13 $chr(93) 00 $+ $2-).actions }
  }
  else {
    $report( 13Action:,00 $nick,$null,$null,$null,$null,$2-).action
    if (status !isin $window($active)) { $report( 13Action:,00 $nick,$null,$null,$null,$2-).actions }
  }
  halt
}
RAW 421:*: {
  haltdef
  if (*Lag-CK* iswm $2) {
    var %lag.mrc.tmp = $null
    var %tmp.lag = $calc($ticks - $gettok($2,2,160))
    if ($len(%tmp.lag) < 3) { keywrite $network Lagmrc .0 $+ %tmp.lag secs }
    elseif ($len(%tmp.lag) = 3) { keywrite $network Lagmrc . $+ %tmp.lag secs }
    elseif ($len(%tmp.lag) = 4) { keywrite $network Lagmrc $left(%tmp.lag,1) $+ . $+ $right(%tmp.lag,-1) secs }
    elseif ($len(%tmp.lag) = 5) { keywrite $network Lagmrc $left(%tmp.lag,1) $+ . $+ $right(%tmp.lag,-1) secs }
    elseif ($len(%tmp.lag) > 5) { keywrite $network Lagmrc ERROR }
    if (%lag.mrc.tmp != $null) { lag.warn $gettok(%Lag.mrc,1,46) }
    mybar
    halt
  }
  $report(Server,421,Error,Sorry,the command,$2,is an,$3-,to me.).active
  IF (status !isin $window($active)) { $report(Server,421,Error,Sorry,the command,$2,is an,$3-,to me.).status }
}
raw 352:*: {
  inc %tempa
  set %user $+ %tempa $strip($3)
  set %host $+ %tempa $strip($4)
  set %server $+ %tempa $strip($5)
  set %handle $+ %tempa $strip($6-)
}
raw 311:*: {
  $report(IDENT,311,$null,$null,$2-).active
  IF (status !isin $window($active)) { $report(IDENT,311,$null,$null,$2-).status }
  halt
}
raw 315:*: {
  haltdef
  $report(315,$1-).status
  updatenl
  :sswholoop
  $report(Info $+ %tempb,$null,$null,%handle [ $+ [ %tempb ] ] %user [ $+ [ %tempb ] ]  $+ @ $+ %host [ $+ [ %tempb ] ]).active
  $report(Server,$null,$null,%server [ $+ [ %tempb ] ]).active
  if (%tempb >= %tempa) {
    $report($null,$null,Done).active
    $report($chain).active
    unset %handle* %user* %server* %host* %temp*
    .disable #sswho
    halt
  }
  else { inc %tempb | goto sswholoop }
  aline @UserInfo $sys $highcol $+ Who Reply number $white $+ %tempb 
  aline @UserInfo $sys $lowcol $+ Info: $highcol $+ %handle [ $+ [ %tempb ] ] %user [ $+ [ %tempb ] ]  $+ @ $+ %host [ $+ [ %tempb ] ]
  aline @UserInfo $sys $lowcol $+ Server: $highcol $+ %server [ $+ [ %tempb ] ]
  if (%tempb >= %tempa) {
    aline @UserInfo $sys $bright $+ Done
    aline @UserInfo $sys $+ $chain
    unset %handle* %user* %server* %host* %temp*
    .disable #sswho
    halt
  }
  else { inc %tempb | goto sswholoop }
  else {
    $report(Who Reply,$null,number,%tempb).status
    $report(Handle,$null,$null,%handle [ $+ [ %tempb ] ] %user [ $+ [ %tempb ] ]  $+ @ $+ %host [ $+ [ %tempb ] ] ).status
    $report(Serve,$null,$null,%server [ $+ [ %tempb ] ] ).status
    if (%tempb >= %tempa) {
      $report(Done).status
      $report($chain).status
      unset %handle* %user* %server* %host* %temp*
      .disable #sswho
      halt
    }
    else {  inc %tempb | goto sswholoop }
  }
}
on ^*:SNOTICE:*:{
  haltdef
  if (*disconnect* iswm $1-) { if ($key(StrangeScript,script.sounds) == ON) { script.play shit.wav } }
  if (*logoff* iswm $1-) { script.play logoff.wav }
  echo $color(notice) -at $sys $report($network,Server Notice,$null,$null,$1-)
  IF (status !isin $window($active)) { echo $color(notice) -st $sys $report($network,Server Notice,$null,$null,$1-) }
  halt
}
on ^*:NOTICE:*:*: {
  haltdef
  if ($nick == NickServ) {
    if (*IDENTIFY* iswm $1-) { .timerai $+ $network 1 2 /auto.ident }
    if (*40* iswm $1-) { /auto.ident }
  }
  if ($nick == ChanServ) {
    if (*IDENTIFY* iswm $1-) { /idchan }
  }
  if ($chan == $null) {
    echo $color(notice) -at $sys $net $+ $report(NOTICE) $+ :  $+ 14 $+ $lll $+ $white $nick  $+ 14 $+ $rrr  $1-
    IF (status !isin $window($active)) { echo $color(notice) -st $sys $net $+ $report(NOTICE) $+ :  $+ 14 $+ $lll $+ $white $nick  $+ 14 $+ $rrr  $1- }
  }
  if ($chan != $null) {
    echo $color(notice) -at $sys $net $+ $report(NOTICE) $+ :  $+ 14 $+ $lll $+ $white $nick 10 $+ $chr(91) $+  $bright $+ $chan 10 $+ $chr(93)  $+ 14 $+ $rrr  $1-
    IF (status !isin $window($active)) { echo $color(notice) -st $sys $net $+ $report(NOTICE) $+ :  $+ 14 $+ $lll $+ $white $nick 10 $+ $chr(91) $+  $bright $+ $chan 10 $+ $chr(93)  $+ 14 $+ $rrr  $1- }
  }
  halt
}
on ^*:INVITE:#: {
  haltdef
  if ($nick == ChanServ) {
    join $chan %key. [ $+ [ $chan ] ]
    if ($key(StrangeScript,script.sounds) == ON) { script.play invite.wav }
    $report(Invite,Auto Join,$nick,has just invited you to,$chan).active
    halt
  }
  if ($key(StrangeScript,script.sounds) == ON) { script.play invite.wav }
  $report(Invite,$nick,$null,has just invited you to,$chan).active
  if (status !isin $window($active)) { $report(Invite,$nick,$null,has just invited you to,$chan).status }
  halt
}
raw 421:*: {
  haltdef
  $report(Server,421,Error,Sorry,the command,$2,is an,$3-,to me.).active
  IF (status !isin $window($active)) { $report(Server,421,Error,Sorry,the command,$2,is an,$3-,to me.).status }
  halt
}
raw 352:*: {
  $report(StrangeScript,352,$null,$null,$1-).active
  IF (status !isin $window($active)) { $report(StrangeScript,352,$null,$null,$1-).status }
  halt
}
raw 315:*: {
  $report(StrangeScript,315,$null,$null,$1-).active
  IF (status !isin $window($active)) { $report(StrangeScript,315,$null,$null,$1-).status }
  ;haltdef
  ;updatenl
  ;%copdisplay $sys $bright $+ Done
  ;%copdisplay $sys $+ $chain
  ;unset %copdisplay
  ;.disable #opscan
  halt
}
raw 438:*: {
  haltdef
  set %temp.nick.change $2
  $report(Nick Change,Time Wait,$null,Your nick will be auto changed in,$9, Seconds).status
  .timerNick. $+ $network 1 $9 /nick %temp.nick.change
  .timerNC. $+ $network 1 $9 $report(Nick Change,$null,$null,Auto-Changing your NickName to,%temp.nick.change).status
}
raw 401:*: {
  haltdef
  $report(Server,401,Error,No Such Nick,$2).active
  unset %handle
  halt
}
on ^*:NOTIFY: {
  if ($key(StrangeScript,script.sounds) == ON) { script.play invite.wav }
  $report(NotifyOn,$nick,$null,is now online,$null).active
  if (status !isin $window($active)) { $report(NotifyOn,$nick,is now online,Notes: $notify($nick).note).status }
  whois $nick
  halt
}
on 1:UNOTIFY: {
  $report(NotifyOff,$nick,is now offline).active
  IF (status !isin $window($active)) { $report(NotifyOff,$nick,is now offline).status }
}
;RAW *:*: { $report(RAW TEST,$event,$numeric,$rawmsg).active }
;MOTD
raw 372:*:{ if ($3 == $null) { halt } | $report(MOTD,372,$null,$null,$null,$3-).active | halt }
raw 375:*:{ if ($3 == $null) { halt } | $report(MOTD,375,$null,$null,$null,$3-).active | halt }
raw 376:*:{ if ($3 == $null) { halt } | $report(MOTD,376,$null,$null,$null,$3-).active | halt }
;Notify-Watch info
raw 603:*:{ $report(603,Watch Info,603,$null,$2-).active | halt }
raw 605:*:{ $report(605,Watch Info,605,$null,$2-).active | halt }
raw 606:*:{ $report(606,Watch Info,606,$null,$2-).active | halt }
raw 607:*:{ $report(607,Watch Info,607,$null,$2-).active | halt }
raw 318:*:{ $report(318,Watch Info,318,$null,$2-).active | halt }
raw 319:*:{ $report(319,Watch Info,319,$null,$2-).active | halt }
raw 307:*:{ $report(307,Watch Info,307,$null,$2-).active | halt }
raw 312:*:{ $report(312,Watch Info,312,$null,$2-).active | halt }
;Server Information
raw 1:*:{ $report(1,Server Info,$null,$3-).active | halt }
raw 2:*:{ $report(2,Server Info,$null,$3-).active | halt }
raw 3:*:{ $report(3,Server Info,$null,$3-).active | halt }
raw 4:*:{ $report(4,Server Info,$null,$3-).active | halt }
raw 5:*:{ $report(5,Server Info,$null,$3-).active | halt }
;freenode whois info
raw 317:*:{ $report(317,WhoIs,$2,$3-).active | halt }
raw 330:*:{ $report(330,WhoIs,$3,is logged in as,$2).active | halt }
raw 671:*:{ $report(671,StrangeScript,$null,$null,$2-).active | halt }
raw 742:*:{ $report(742,StrangeScript,$1,$2,$3-).active | halt }
raw 303:*:{
  if ($key(StrangeScript,pingpong.show) == ON) { $report($null,Watch Info,$null,$2,is ONLINE).status }
  halt
}
raw 328:*:{ echo -t $2 $sys $report(Channel URL,$2,Set By:,$1,$3-) | halt }

raw 8:*:{ $report(8,Server Info,$null,$null,$2-).active | halt }
raw 290:*:{ $report(290,Server Info,$null,$null,$2-).active | halt }
raw 292:*:{ $report(292,Server Info,$null,$null,$2-).active | halt }
raw 221:*:{ $report(221,Server Info,$null,$null,$2-).active | halt }
raw 320:*:{ $report(320,Server Info,$null,$null,$2-).active | halt }
raw 251:*:{ $report(251,Server Info,$null,$null,$2-).active | halt }
raw 252:*:{ $report(252,Server Info,$null,$null,$2-).active | halt }
raw 253:*:{ $report(253,Server Info,$null,$null,$2-).active | halt }
raw 254:*:{ $report(254,Server Info,$null,$null,$2-).active | halt }
raw 255:*:{ $report(255,Server Info,$null,$null,$2-).active | halt }
raw 265:*:{ $report(265,Server Info,$null,$null,$2-).active | halt }
raw 266:*:{ $report(266,Server Info,$null,$null,$2-).active | halt }
raw 305:*:{ $report(305,Back,$1,$null,$2-).active | halt }
raw 306:*:{ $report(306,Away,$1,$null,$2-).active | halt }
raw 432:*:{ $report(432,Nick,$null,Failed,$2-).active | halt }
raw 433:*:{ $report(433,Nick,$2,Failed,$3-).active | idnick | halt }
raw 440:*:{ $report(440,Server Info,$null,$null,$2-).active | halt }
raw 502:*:{ $report(502,Server Info,$null,$null,$2-).active | halt }
raw 324:*:{ echo -t $2 $sys $report(324,$1,$2,$3-) | halt }
raw 329:*:{
  if ($network == freenode) {
    echo -t $2 $sys $report($null,Creation Info,Room was created,$null,$convert.unix($3))
    halt
  }
  if ($network == Libera.Chat) {
    echo -t $2 $sys $report($null,Creation Info,Room was created,$null,$convert.unix($3))
    halt
  }
  else {
    echo -t $2 $sys $report($null,Spawn Info,Room was spawned,$null,$convert.unix($calc($3 - 28800)))
    halt
  }
}
;
raw 335:*:{ $report(335,$1-).active | halt }
raw 310:*:{ $report($2,$null,$null,$3 $4 $5,$6-).active | halt }
raw 378:*:{ $report($2,$null,$null,$3 $4 $5,$6-).active | halt }
raw 379:*:{ $report($2,$null,$null,$3 $4 $5,$6-).active | halt }
raw 341:*:{ $report(Invite,Success,$2,has been invited to $3).active | halt }
raw 443:*:{ $report(Invite,Failed,$2,Already on $3).active | halt }
raw 518:*:{ $report(Invite,Failed,$2 $3,$4,$5,$6-).active | halt }
raw 471:*:{ $report(Join,Failed,Cant join $2,Room Limit Exceded).active | halt }
raw 473:*:{ $report(Join,Failed,Cant join $2,Invite Only).active | $report(Try to use ChanServ to auto invite you.).active | chanserv invite $2 $me | halt }
raw 474:*:{ $report(Join,Failed,Cant join $2,Banned IP).active | halt }
raw 475:*:{ $report(Join,Failed,Cant join $2,Wrong Member Key).active | halt }
raw 477:*:{ $report(Join,Failed,Cant join $2,Need Registered Nick).active | halt }
raw 404:*:{ $report(Server,Failed,$2,Can Not Send To Channel).active | halt }
raw 412:*:{ $report(Server,Failed,$null,No Text To Send).active | halt }
raw 441:*:{ $report(Server,Failed,$2,User Not On Channel).active | halt }
raw 442:*:{ $report(Server,Failed,$2,Your Not On Channel).active | halt }
raw 403:*:{ $report(Server,Failed,$2,No Such Channel).active | halt }
raw 407:*:{ $report(Server,Failed,$null,Too Many Targets).active | halt }
raw 381:*:{ $report(Server,Success,$null,$1-).active | halt }
on 1:CLOSE:@RoomKeys:{ haltdef | unset %tmp.keys $report(CLOSE,$1-).status | halt }
on 1:CONNECT:{
  $report(StrangeScript,Server Connect Event Triggered,$null,$null,$1-).status
  if ($network == $null) { $report(StrangeScript,ERROR,NO NETWORK).active | break }
  $report(Server,$null,$null,Set at,$network).active
  .servjc
  .conset
  if ($key($network,recover.nick) == ON) { .timerrn $+ $network 1 2 /recover $key($network,saved.nick.1) }
  if ($key($network,auto.ident) == ON) { .timerai $+ $network 1 2 /auto.ident }
  .timerBAR. $+ $network -om 0 500 mybar
  .timerrf $+ $network 1 1 $report($fullver).active
  if ($key($network,Lagchk) == ON)  { .timerlc $+ $network 1 1 lagon }
  if ($key($network,auto.join) == ON)  { .timeraj $+ $network 1 5 auto.join }
  halt
}
raw knock:*: {
  haltdef
  set %last.knock.reason $2
  if (471 isin $2) { var %last.knock.reason = Room Limit Exceded }
  if (473 isin $2) { var %last.knock.reason = Invite only }
  if (474 isin $2) { var %last.knock.reason = Banned IP }
  if (475 isin $2) { var %last.knock.reason = Wrong Member Key }
  if (913 isin $2) { var %last.knock.reason = ServerOp's Only }
  if ($key(StrangeScript,script.sounds) == ON) { script.play knock.wav }
  echo -t $1 $sys $report(Knock,$1,$nick,just knocked and got message,%last.knock.reason).status
  IF (status !isin $window($active)) { $report(Knock,$1,$nick,just knocked and got message,%last.knock.reason).status }
}
ctcp ^*:*:*: {
  haltdef
  if ($chr(43)  isin $1-) { halt }
  if ($chr(47) $+ con isin $2-) { halt }
  if ($chr(47) $+ aux isin $2-) { halt }
  if ($chr(47) $+ nul isin $2-) { halt }
  if ($1 == DCC) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    halt
  }
  if ($1 == SEND) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    halt
  }
  if ($1 == CHAT) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,$upper($1),With message:,$strip($2-)).status }
    halt
  }
  if ($1 == AWAY) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active;
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    halt
  }
  if ($1 == PING) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    ctcpreply $nick $1-
    if ($key(StrangeScript,script.sounds) == ON) { script.play ping.wav }
    halt
  }
  if ($1 == TIME) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    .ctcpreply $nick TIME $saytime
    if ($key(StrangeScript,script.sounds) == ON) { script.play bam.wav }
    halt
  }
  if ($1 == VERSION) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    .ctcpreply $nick VERSION $ver
    $report(Ctcp,$nick,Reply,$null,$null,$null,$ver).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Reply,$null,$null,$null,$ver).status }
    if ($key(StrangeScript,script.sounds) == ON) { script.play bam.wav }
    halt
  }
  if ($1 == SOUND) { halt }
  if ($1 == PAGE) {
    $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
    if ($key(StrangeScript,script.sounds) == ON) { script.play page.wav }
    halt
  }
  if ($1 == MESSAGE) { $report(Message,$nick,Script,Message as follows,$2-).active | halt }
  else { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).active }
  IF (status !isin $window($active)) { $report(Ctcp,$nick,Received,$upper($1),$strip($2-)).status }
  halt
}
on ^*:CTCPREPLY:*: {
  haltdef
  if ($1 == PING) && ($2 != $null) {
    set %temp.ping.calc $calc(($ticks - $remove($3,$chr(1))) / 1000)
    if (%temp.ping.calc < 60) {
      $report(Ctcp Reply,$nick,Reply was:,$strip($2-)).active 09 $+ : $lowcol $+ It took $highcol $+ %temp.ping.calc $lowcol $+ Seconds
      IF (status !isin $window($active)) { $report(Ctcp Reply,$nick,$upper($1),Reply was:,$strip($2-)).status 09 $+ : $lowcol $+ It took $highcol $+ %temp.ping.calc $lowcol $+ Seconds }
      halt
    }
    if (%temp.ping.calc > 60) {
      var %temp $calc($ctime - $2)
      $report(Ctcp Reply,$upper($1),$nick,Reply was:,$strip($2-)).active 09 $+ : $lowcol  It took $highcol $duration(%temp)
      IF (status !isin $window($active)) { $report(Ctcp Reply,$upper($1),$nick,Reply was:,$strip($2-)).status 09 $+ : $lowcol  It took $highcol $duration(%temp) }
      halt
    }
    halt
  }
  else {
    $report(Ctcp Reply,$1,$nick,Reply was:,$strip($2-)).active
    IF (status !isin $window($active)) { $report(Ctcp Reply,$1,$nick,Reply was:,$strip($2-)).status }
    halt
  }
  halt
}
ON 1:*:*:{ $report(1,$event,$rawmsg).active }
on 1:LOGON:*:{
  echo -at $sys $report(StrangeScript,Logon Event trigged)
}
on 1:START: {
  if ($key($network,saved.nick.1) != $null) { nick $key($network,saved.nick.1) }
  if ($key(StrangeScript,go.full) == ON) { .timer $+ Startgc 1 1 /showadiirc -x }
  $report(StrangeScript,Start Event,$1-).status
  unset %mybar*
  set %tmp.jj $input(Run Servers?,y,ServerRun,Run Servers)
  if (%tmp.jj == $true) { /join.servers }
  else { /serverlist -n DALnet }
}
ON 1:EXIT:{ if ($key($network,saved.nick.1) != $null) { nick $key($network,saved.nick.1) } }
on 1:CONNECTFAIL:{
  haltdef
  if ($key($network,saved.nick.1) != $null) { nick $key($network,saved.nick.1) }
  $report(Connect Fail,$1-).active
}
on 1:DISCONNECT:{
  haltdef
  if ($key($network,saved.nick.1) != $null) { nick $key($network,saved.nick.1) }
  unset %mybar*
  if ($key(StrangeScript,script.sounds) == ON) { script.play shit.wav }
  ;clearall
  close.windows
  $report(Disconnect,$nick,$server,$time,$1-).active
  IF (status !isin $window($active)) { $report(Disconnect,$nick,$server,$time,$1-).status }
}
on ^*:MODE:#: {
  haltdef
  .echo -t # $sys $report(Mode,$nick,$chan,$null,$1-)
  IF (status !isin $window($active)) { $report(Mode,$nick,$chan,$null,$1-).status }
  halt
}
on ^*:USERMODE:#: {
  haltdef
  .echo -t # $sys $report(UserMode,$nick,$chan,$null,$1-)
  IF (status !isin $window($active)) { $report(UserMode,$nick,$chan,$null,$1-).status }
  halt
}
on ^*:OWNER:#: {
  haltdef
  $report(Owner,$nick,$chan,$opnick,$1-).chan
  IF (status !isin $window($active)) { $report(Owner,$nick,$chan,$opnick,$1-).status }
  halt
}
on ^*:DEOWNER:#: {
  haltdef
  $report(DeOwnerp,$nick,$chan,$opnick,$1-).chan
  IF (status !isin $window($active)) { $report(DeOwner,$nick,$chan,$opnick,$1-).status }
  halt
}
on ^*:OP:#: {
  haltdef
  $report(Op,$nick,$chan,$opnick,$1-).chan
  IF (status !isin $window($active)) { $report(Op,$nick,$chan,$opnick,$1-).status }
  halt
}
on ^*:DEOP:#: {
  haltdef
  $report(DeOp,$nick,$chan,$opnick,$1-).chan
  IF (status !isin $window($active)) { $report(DeOp,$nick,$chan,$opnick,$1-).status }
  deop.protect
  halt
}
on ^*:VOICE:#: {
  haltdef
  $report(Voice,$nick,$chan,$vnick,$1-).chan
  IF (status !isin $window($active)) { $report(Voice,$nick,$chan,$vnick,$1-).status }
  halt
}
on ^*:DEVOICE:#: {
  haltdef
  $report(DeVoice,$nick,$chan,$vnick,$1-).chan
  IF (status !isin $window($active)) { $report(DeVoice,$nick,$chan,$vnick,$1-).status }
  halt
}
on ^*:HELP:#: {
  haltdef
  $report(HelpOp,$nick,$chan,$opnick,$1-).chan
  IF (status !isin $window($active)) { $report(HelpOp,$nick,$chan,$opnick,$1-).status }
  halt
}
on ^*:DEHELP:#: {
  haltdef
  $report(DeHelpOp,$nick,$chan,$opnick,$1-).chan
  IF (status !isin $window($active)) { $report(DeHelpOp,$nick,$chan,$opnick,$1-).status }
  deop.protect
  halt
}
on ^*:SERVERMODE:#: {
  haltdef
  .echo -t # $sys $report(ServerMode,$nick,$chan,$null,$1-)
  IF (status !isin $window($active)) { $report(ServerMode,$nick,$chan,$null,$1-).status }
  halt
}
on *:SERVEROP:#: { $report(SERVEROP,$1-).status }
on ^*:RAWMODE:#: {
  haltdef
  $report(RawMode,$nick,$chan,$2,$1-).chan
  IF (status !isin $window($active)) { $report(RawMode,$nick,$chan,$2,$1-).status }
  if ($nick == $server) { halt }
  if ($nick == System) { cycle | halt }
  if ($nick == $mode(1)) { halt }
  halt
}
on ^*1:JOIN:#: {
  haltdef
  if ($nick == $me) { set %speed. $+ # $ticks }
  if ($nick == $me) { .timerRS $+ # 1 15 roomset }
  if ($nick == $me) { chanserv op # $me }
  .echo -t # $sys $report(Join,$chan,$nick,$address)
  IF (status !isin $window($active)) { $report(Join,$chan,$nick,$address).status }
  halt
}
on ^*:PART:#: {
  haltdef
  echo -t # $sys $report(Part,$chan,$nick,$address,$1-)
  IF (status !isin $window($active)) { $report(Part,$chan,$nick,$fulladdress,$1-).status }
  halt
}