/sep { if (%sc.seperater == $null) { return 10 } | else { if ($key(StrangeScript,sc.bold) == ON) { return  $+ %sc.seperater } | else { return  $+ %sc.seperater } } }
/lll return $chr(186) $+ (
/rrr return ) $+ $chr(186)
/lowcol { if (%sc1 == $null) { return 04 } | else { if ($key(StrangeScript,sc.bold) == ON) { return  $+ %sc1 } | else { return  $+ %sc1 } } }
/highcol { if (%sc2 == $null) { return 11 } | else { if ($key(StrangeScript,sc.bold) == ON) { return  $+ %sc2 } | else { return  $+ %sc2 } } }
/bright { if (%sc3 == $null) { return 08 } | else { if ($key(StrangeScript,sc.bold) == ON) { return  $+ %sc3 } | else { return  $+ %sc3 } } }
/white { if (%sc4 == $null) { return 00 } | else { if ($key(StrangeScript,sc.bold) == ON) { return  $+ %sc4 } | else { return  $+ %sc4 } } }
/space return $chr(160)
/spcm return $chr(44) $+ $chr(160)
/output return 11,11 
/sys return 4,4 
/sysp return 13,13 
/doda /col ?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
/send /dcc send $snick(#,1)
/chat /dcc chat $1
/ping { if ($1 == $null) { .ctcp # ping } | else { .ctcp $$1 ping } }
/sounddir return Sounds\
/textdir return Text\
/signout {
  /bot off
  /quitall
  /disconnect
  /quit
}
;chain return 04 $+ ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
chain {
  if ($1 != $null) { return $lowcol $+  $+ $str(=,$1) $+  }
  else { return $lowcol $+ ========================================================= }
}
/report {
  if ($1- == $null) { $report(StrangeScript,Error,$null,$null,No Text Sent to Report).active | halt }
  else { var %tmp.rbuild = %tmp.rbuild $sep $+ $chr(186) }
  if ($1 != $null) {
    if ($1 == $me) { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ 4 $1 $sep $+ ) $+ $chr(186) }
    else { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ $white $1 $sep $+ ) $+ $chr(186) }
  }
  if ($2 != $null) { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ $highcol $2 $sep $+ ) $+ $chr(186) }
  if ($3 != $null) { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ $bright $3 $sep $+ ) $+ $chr(186) }
  if ($4 != $null) { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ $lowcol $4 $sep $+ ) $+ $chr(186) }
  if ($5- != $null) {
    if ($me == $1) { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ $white $eval($5-) $sep $+ ) $+ $chr(186) $+  }
    else { var %tmp.rbuild = %tmp.rbuild $+ $sep $+ ( $+ $white $5- $sep $+ ) $+ $chr(186) $+  }
  }
  if ($prop == active) { return echo -at $sys $net $+ %tmp.rbuild }
  if ($prop == action) { return echo -at $sysp %tmp.rbuild }
  if ($prop == actions) { return echo -st $sysp %tmp.rbuild }
  if ($prop == status) { return echo -st $sys %tmp.rbuild }
  if ($prop == chan) { return echo -t # $sys %tmp.rbuild }
  if ($prop == text) { return echo -t # $output %tmp.rbuild }
  if ($prop == $null) { return %tmp.rbuild }
  halt
  return
}
/servjc {
  if ($exists(Text\ScriptInfo.ini) == $false) { /writeini -n keywrite StrangeScript n0 Registered }
  $report(StrangeScript,$null,$null,Running Server Joins Count).status
  if ($key(serverjoins,n0) == $null) { set %times.joined.server 0 }
  if ($key(serverjoins,n0) != $null) { set %times.joined.server $key(serverjoins,n0) }
  inc %times.joined.server
  keywrite serverjoins n0 %times.joined.server
  $report(StrangeScript,Server Connect Count,$null,$key(serverjoins,n0),Using:,$ver).active
  unset %tmp %times.joined.server
  return
}
/conset {
  $report(Welcome to,$ver,Running on $network).status
  $report(StrangeScript,$null,$null,Running Script Setup Check).status
  unset %count.* %temp* %tmp* %unmask*  %hex.* %n
  if ($key(StrangeScript,mode.default)  == $null) { keywrite StrangeScript mode.default -im+nt }
  if ($key(StrangeScript,key.writes)  == $null) { keywrite StrangeScript key.writes OFF }
  if ($key(StrangeScript,key.reads)  == $null) { keywrite StrangeScript key.reads OFF }
  if ($key(StrangeScript,part.message)  == $null) { keyhexwrite StrangeScript part.message You Know you will miss me. }
  if ($key(StrangeScript,partmessage.random)  == $null) { keyhexwrite StrangeScript partmessage.random OFF }
  if ($key(StrangeScript,quit.message)  == $null) { keyhexwrite StrangeScript quit.message 200 Billion stars in the MilkyWay,  but it is all about you. }
  if ($key(StrangeScript,quitmessage.random)  == $null) { keyhexwrite StrangeScript quitmessage.random OFF }
  if ($key(StrangeScript,away.message)  == $null) { keyhexwrite StrangeScript away.message Sleeping,have to do it sometime. }
  if ($key(StrangeScript,awaymessage.random)  == $null) { keyhexwrite StrangeScript awaymessage.random OFF }
  if ($key(StrangeScript,away.nick.add) == $null) { keywrite StrangeScript away.nick.add [Sleeping] }
  if ($key(StrangeScript,away.remind) == $null) { keywrite StrangeScript away.remind 900 }
  if ($key(StrangeScript,script.sounds)  == $null) { keywrite StrangeScript script.sounds ON }
  if ($key(StrangeScript,pingpong.show)  == $null) { keywrite StrangeScript pingpong.show ON }
  if ($key(StrangeScript,sc.bold)  == $null) { keywrite StrangeScript sc.bold ON }
  if ($key($network,ctcp.ignore)  == $null) { keywrite $network ctcp.ignore OFF }
  if ($key($network,away.iam)  == $null) { keywrite $network away.iam OFF }
  if ($key($network,away.iam)  == ON) { keywrite $network away.iam OFF }
  if ($key($network,recover.nick)  == $null) { keywrite $network recover.nick OFF }
  if ($key($network,boss)  == $null) { keywrite $network boss $me }
  if ($key($network,lagchk)  == $null) { keywrite $network lagchk OFF }
  if ($key($network,Lagmrcsecs)  == $null) { keywrite $network Lagmrcsecs 15 }
  if ($key($network,auto.ident)  == $null) { keywrite $network auto.ident OFF }
  if ($key($network,auto.join)  == $null) { keywrite $network auto.join OFF }
  if ($key($network,IrcMode)  == $null) { keywrite $network IrcMode IRCd }
  if (%sc.me == $null) { set %sc.me 04 }
  if (%sc1 == $null) { set %sc1 04 }
  if (%sc2 == $null) { set %sc1 11 }
  if (%sc3 == $null) { set %sc1 08 }
  if (%sc4 == $null) { set %sc1 00 }
  keywrite $network boss $me
  keywrite $network cycle.counter 0
  unset %mybar.temp %n 99 %tmp*
  set %setup.count 0
  .ignore -r *!*@*
  return
}
/roomset {
  if ($key($network,# $+ -topiclock)  == $null) { keywrite $network # $+ -topiclock OFF }
  if ($key($network,# $+ -modelock)  == $null) { keywrite $network # $+ -modelock OFF }
  if ($key($network,# $+ -mode)  == $null) { keywrite $network # $+ -mode +nt }
  if ($key($network,# $+ -autosetup)  == $null) { keywrite $network # $+ -autosetup OFF }
  if ($key($network,# $+ -autosetup)  == ON) {
    echo -t # $sys $report(StrangeScript,Room Auto Setup,$null,$null,Running Room Auto Setup)
    if ($key($network,# $+ -mode)  != $null) {
      if ($channel(#).mode !=  $key($network,# $+ -mode)) { mode # $key($network,# $+ -mode) }
      else { echo -t # $sys $report(StrangeScript,Room Auto Setup,$null,$null,Mode Correct) }
    }
    if ($key($network,# $+ -topic)  != $null) {
      if ($channel(#).topic != $unhex.ini($key($network,# $+ -topic))) { .raw topic # : $+ $unhex.ini($key($network,# $+ -topic)) }
      else { echo -t # $sys $report(StrangeScript,Room Auto Setup,$null,$null,Topic Correct) }
    }
  }
}
/cycle {
  if ($1 != $null) {
    .raw PART $1 : $+ $unhex.ini($key(StrangeScript,part.message))
    .raw join $1
    halt
  }
  else {
    .raw PART # : $+ $unhex.ini($key(StrangeScript,part.message))
    .raw join #
    halt
  }
}
/cycleall {
  keywrite $network rumble OFF
  set %tmp.ca 1
  while (%tmp.ca <= $chan(0)) {
    .raw PART $chan(%tmp.ca) : $+ $unhex.ini($key(StrangeScript,part.message))
    .raw join $chan(%tmp.ca)
    inc %tmp.ca
    if (%tmp.ca > $chan(0)) { break }
  }
  unset %tmp.ca
  halt
}
/upme {
  set %tmp.um 1
  while (%tmp.um <= $channel(0)) {
    if ($me !isop $channel(%tmp.um)) { .timerUPME $+ $network $+ $channel(%tmp.um) 1 %tmp.um /chanserv op $channel(%tmp.um) $me }
    inc %tmp.um
    if (%tmp.um > $channel(0)) { break }
  }
  unset %tmp.um
  return
}
/idnick {
  .timer 1 1 /recover $key($network,saved.nick.1)
  return
}
/auto.join {
  $report(StrangeScript,$null,$null,Preforming,Auto Joins).active
  IF (status !isin $window($active)) { $report(StrangeScript,$null,$null,Preforming,Auto Joins).status }
  .timeraj $+ $network 1 2 .raw join $key($network,auto.join.rooms)
  return
}
/auto.ident {
  if ($key($network,$me) == $null) {
    $report(StrangeScript,Auto-Ident,FAILED,$null,You have no saved password for your current nick).active
    if (status !isin $window($active)) { $report(StrangeScript,Auto-Ident,FAILED,$null,You have no saved password for your current nick).status }
    return
  }
  if ($key($network,auto.ident) == OFF) {
    $report(StrangeScript,Auto-Identify,$null,$key($network,auto.ident),$null,Auto Identification is off - skipping).active
    if (status !isin $window($active)) { $report(StrangeScript,Auto-Identify,$null,$key($network,auto.ident),$null,Auto Identification is off - skipping).status }
    return
  }
  ; Nick Ident
  if ($key($network,$me) != $null) {
    $report(StrangeScript,Auto-Identify,$null,$key($network,auto.ident),You are being Auto-Identified using,$key($network,$me)).active
    if (status !isin $window($active)) { $report(StrangeScript,Auto-Identify,$null,$key($network,auto.ident),You are being Auto-Identified using,$key($network,$me)).status }
    .timerANIdent $+ $network 1 2 /nickserv IDENTIFY $key($network,$me)
  }
  ; Chan Ident
  if ($network == IRCgo) || ($network != Rizon) || ($network == HumanNet) {
    $report(StrangeScript,Auto-Identify,$null,$network,Skipping room identify on this network.).active
    IF (status !isin $window($active)) { $report(StrangeScript,Auto-Identify,$null,$network,Skipping room identify on this network.).active }
    return
  }
  set %tmp.idc 1
  while (%tmp.idc <=  $gettok($key($network,auto.join.rooms),0,44)) {
    if ($network != freenode) && ($network != Libera.Chat) && ($network != Libera) {
      .timerACIdent $+ $network $+ $gettok($key($network,auto.join.rooms),%tmp.idc,44) 1 %tmp.idc /chanserv identify $gettok($key($network,auto.join.rooms),%tmp.idc,44) $key($network,$gettok($key($network,auto.join.rooms),%tmp.idc,44) $+ -pass)
    }
    inc %tmp.idc
    if (%tmp.idc > $gettok($key($network,auto.join.rooms),0,44)) { break }
  }
  unset %tmp.idc
  .timerFAI $+ $network 1 2 /upme
  return
}
/idchan {
  if ($network == IRCgo) || ($network != Rizon) || ($network == HumanNet) {
    $report(StrangeScript,Auto-Identify,$null,$network,Skipping room identify on this network.).active
    IF (status !isin $window($active)) { $report(StrangeScript,Auto-Identify,$null,$network,Skipping room identify on this network.).active }
    return
  }
  set %tmp.idc 1
  while (%tmp.idc <= $channel(0)) {
    if ($network != freenode) && ($network != Libera.Chat) { /chanserv identify $channel(%tmp.idc) $key($network,$channel(%tmp.idc) $+ -pass) }
    inc %tmp.idc
    if (%tmp.idc > $channel(0)) { break }
  }
  unset %tmp.idc
  .timer 1 2 /upme
  return
}
/recover  {
  if ($1 == OFF) { keywrite $network recover.nick OFF | .timerRECOV. $+ $network OFF | $report(Auto Nick Recover,Set,Off).active | return }
  if ($key($network,saved.nick.1) == $null) { keywrite $network recover.nick OFF | .timerRECOV. $+ $network OFF | $report(Auto Nick Recover,Set,Off,NO saved nick to recover).active | return }
  if (%recover.nick.count == $null) { set %recover.nick.count 0 }
  if ($1 == $null) {
    set %recover.nick $key($network,saved.nick.1)
    if ($me == %recover.nick) { goto iam.me }
    $report(Auto Nick Recover,%recover.nick,Attempting to Recover Nickname).active
    nick %recover.nick
    inc %recover.nick.count
    if ($me !=  %recover.nick) { .timerRECOV. $+ $network 0 10 recover %recover.nick | return }
    if ($me == %recover.nick) { goto iam.me }
  }
  if ($1 == ON) {
    set %recover.nick $key($network,saved.nick.1)
    if ($me == %recover.nick) { goto iam.me }
    $report(Auto Nick Recover,%recover.nick,Attempting to Recover Nickname).active
    nick %recover.nick
    inc %recover.nick.count
    if ($me !=  %recover.nick) { .timerRECOV. $+ $network 0 10 recover %recover.nick | return }
    if ($me == %recover.nick) { goto iam.me }
  }
  if ($1 != $null) {
    if ($me == %recover.nick) { goto iam.me }
    if ($me == $1) { goto iam.me }
    set %recover.nick $1
    $report(Auto Nick Recover,%recover.nick,Attempting to Recover Nickname).active
    nick %recover.nick
    if (%recover.nick.count == 4) { .nickserv release %recover.nick $key($network,%recover.nick) }
    if (%recover.nick.count == 2) { .nickserv ghost %recover.nick $key($network,%recover.nick) }
    if (%recover.nick.count == 4) { set %recover.nick.count 0 }
    inc %recover.nick.count
    if ($me !=  %recover.nick) { .timerRECOV. $+ $network 0 10 recover %recover.nick | return }
    if ($me == %recover.nick) { goto iam.me }
  }
  return
  :iam.me
  .timerRECOV. $+ $network OFF
  $report(Auto Nick Recover,$key($network,recover.nick),Done,Recover Complete).active
  if ($key($network,auto.ident) == ON) { .timerai $+ $network 1 2 /auto.ident }
  unset %recover.nick %recover.nick.count
  return
}
/part {
  if ($2 != $null) { .raw PART # : $+ $2- | halt }
  else { .raw PART # : $+ $unhex.ini($key(StrangeScript,part.message)) | halt }
  halt
}
/partall {
  set %tmp.pa 1
  while (%tmp.pa <= $chan(0)) {
    if ($1- != $null) { .raw part $chan(%tmp.pa) : $+ $1- }
    else { .raw PART $chan(%tmp.pa) : $+ $unhex.ini($key(StrangeScript,part.message)) }
    inc %tmp.pa
    if (%tmp.pa > $chan(0)) { break }
  }
  unset %tmp.pa
  halt
}
/quit {
  if ($1- != $null) { .raw quit $1- | return }
  elseif ($key(StrangeScript,quit.message) != $null) { .raw quit $unhex.ini($key(StrangeScript,quit.message)) | return }
  else {  .raw quit $ver | return }
}
/back {
  if ($away == $false) { if ($key($network,away.iam) == OFF) { $report(Back,Canceled,$null,You are not currently set away).active | return } }
  var %temp.away.variables = $time $+ , $+ $ctime
  var %temp.away1 = $calc($gettok(%temp.away.variables,2,44) - $gettok($key($network,away.variables),2,44))
  .raw away
  .nick $gettok($key($network,away.variables),3,44)
  ;echo -at $sys $report(Is Back) $report($null,$null,From:,$unhex.ini($key(StrangeScript,away.message))) $report($null,$null,Left:,$gettok($key($network,away.variables),1,44)) $report($null,$null,Was Gone:,$duration(%temp.away1))
  ;
  ; Switch above below for silence
  ;
  ame $report(Is Back) $report($null,$null,From:,$unhex.ini($key(StrangeScript,away.message))) $report($null,$null,Left:,$gettok($key($network,away.variables),1,44)) $report($null,$null,Was Gone:,$duration(%temp.away1))
  .timeraway. $+ $network OFF
  .keywrite $network away.iam OFF
  return
}
/away {
  if ($1 == RETURN) {
    .raw away $unhex.ini($key(StrangeScript,away.message))
    .nick $remove($me,$key(StrangeScript,away.nick.add)) $+ $key(StrangeScript,away.nick.add)
    .timer 1 0 away REMIND
    .timeraway. $+ $network 0 $master(settings,away.remind) away REMIND
    return
  }
  if ($1 == REMIND) {
    var %temp.away.variables = $time $+ , $+ $ctime
    var %temp.away1 = $calc($gettok(%temp.away.variables,2,44) - $gettok($key($network,away.variables),2,44))
    echo -at $sys $report(Still Away) $report($null,$null,Reason:,$unhex.ini($key(StrangeScript,away.message))) $report($null,$null,Left:,$gettok($key($network,away.variables),1,44)) $report($null,$null,So far:,$duration(%temp.away1))
    ;
    ; Switch above below for silence
    ;
    ;ame $report(Still Away) $report($null,$null,Reason:,$unhex.ini($key(StrangeScript,away.message))) $report($null,$null,Left:,$gettok($key($network,away.variables),1,44)) $report($null,$null,So far:,$duration(%temp.away1))
    return
  }
  if ($1- != $null) { keywrite StrangeScript away.message $hex.ini($1-) }
  keywrite $network away.variables $time $+ , $+ $ctime $+ , $+ $remove($me,$key(StrangeScript,away.nick.add))
  .nick $remove($me,$key(StrangeScript,away.nick.add)) $+ $key(StrangeScript,away.nick.add)
  ;echo -at $sys $report(Went Away) $report($null,$null,Reason:,$unhex.ini($key(StrangeScript,away.message))) $report($null,$null,Left:,$gettok($key($network,away.variables),1,44))
  ;
  ; Switch above below for silence
  ;
  ame $report(Went Away) $report($null,$null,Reason:,$unhex.ini($key(StrangeScript,away.message))) $report($null,$null,Left:,$gettok($key($network,away.variables),1,44))
  .raw away : $+ $replace($unhex.ini($key(StrangeScript,away.message)),$chr(32),$chr(160))
  .timeraway. $+ $network 0 $key(StrangeScript,away.remind) /away REMIND
  keywrite $network away.iam ON
  return
}
/close.windows {
  set %tmp.test1 1
  set %tmp.test2 $channel(0)
  while (%tmp.test1 <= %tmp.test2) {
    .timer 1 1 .window -c $channel(%tmp.test1)
    inc %tmp.test1
    if (%tmp.test1 > %tmp.test2) { break }
  }
  unset %tmp.test1 %tmp.test2
  return
}
/convert.unix { return $asctime($1, dddd mmm/dd/yyyy hh:mm tt) }
/regchan {
  if ($network == Freenode) { chanserv register # }
  if ($network == Libera.Chat) { chanserv register # }
  if ($network == Human) || ($network == ircgo) { chanserv register # }
  else { chanserv register # $key($network,# $+ -pass)  # }
}
/dana { say  04,05 $+ $chr(160) $+ $chr(160) $+ $1- $+ $chr(160) $+ $chr(160) $+  }
/twist {
  if ($1 == $null) { echo "Usage: /twist <text>" | return }
  var %count = 1
  var %msg = ""
  var %arg = $1-
  :floop
  if (%count <= $len(%arg)) {
    var %i = $mid(%arg,%count,1)
    if (%i == $chr(191)) { var %r = $rand(1,2) }
    if (%i == $chr(63)) { var %r = $rand(1,2) }
    if (%i != $chr(63)) { var %r = $rand(3,8) }
    if (%r == 1) { var %i = $chr(63) }
    if (%r == 2) { var %i = $chr(191) }
    if (%r == 3) { var %i = $upper(%i) }
    if (%r == 4) { var %i = $lower(%i) }
    if (%r == 5) { var %i =  $+ $upper(%i) $+  }
    if (%r == 6) { var %i =  $+ $lower(%i) $+  }
    if (%r == 7) { var %i =  $+ $upper(%i) $+  }
    if (%r == 8) { var %i =  $+ $lower(%i) $+  }
    var %msg = %msg $+ %i $+ 
    inc %count
    goto floop
  }
  :freakout
  say  $+ $rand(2,15) $+ %msg
  return
}
/freak {
  if ($1 == $null) {
    echo "Usage: /freak <text>"
    return
  }
  set %count 1
  set %msg ""
  set %arg $1-
  :floop
  if (%count <= $len(%arg)) {
    set %i $mid(%arg,%count,1)
    if (%i == $chr(63)) { set %r $rand(3,4) }
    if (%i == $chr(191)) { set %r $rand(3,4) }
    if (%i != $chr(63)) { set %r $rand(1,2) }
    if (%r == 1) { set %i $upper(%i) }
    if (%r == 2) { set %i $lower(%i) }
    if (%r == 3) { set %i $chr(63) }
    if (%r == 4) { set %i $chr(191) }
    set %msg %msg $+ %i $+ 
    inc %count
    goto floop
  }
  :freakout
  say  $+ $rand(2,15) $+ %msg
  unset %msg %r %i %arg %count
  return   
}
/col {
  if ($1 == $null) { echo "Usage: /col <text>" | return }
  var %count = 1
  var %arg = $1-
  var %msg ""
  var %doo ""
  while (%count <= $len(%arg)) {
    var %i = $mid(%arg,%count,1)
    if (%i == $chr(63)) { var %doo = $rand(3,4) }
    if (%doo == 3) { var %i = $chr(63) }
    if (%doo == 4) { var %i = $chr(191) }
    if (%i == $chr(32)) { var %msg = %msg $+ $chr(160) |  inc %count | goto m2 }
    ;if (%i == $chr(160)) { var %msg = %msg $+ $chr(160) |  inc %count | goto m2 }
    var %r = $rand(0,11)
    if (%r == 0) { var %i = 4 $+ %i } 
    elseif (%r == 1) { var %i = 9 $+ %i }
    elseif (%r == 2) { var %i = 10 $+ %i }
    elseif (%r == 3) { var %i = 11 $+ %i }
    elseif (%r == 4) { var %i = 12 $+ %i }
    elseif (%r == 5) { var %i = 13 $+ %i }
    elseif (%r == 6) { var %i = 14 $+ %i }
    elseif (%r == 7) { var %i = 15 $+ %i }
    elseif (%r == 8) { var %i = 3 $+ %i }
    elseif (%r == 9) { var %i = 4 $+ %i }
    elseif (%r == 10) { var %i = 7 $+ %i }
    else { var %i = 0 $+ %i }
    var %msg = %msg $+ %i
    inc %count
    :m2
    if (%count > $len(%arg)) { break }
  }
  say %msg
  return
}
/mix {
  if ($1 == $null) {
    echo "Usage: /mix <text>"
    return
  }
  set %count 1
  set %msg ""
  set %arg $1-
  :m1
  if (%count <= $len(%arg)) {
    set %i $mid(%arg,%count,1)
    if %i == $chr(160)  { goto isspc }
    set %r $rand(0,2)
    if (%r == 0) { 
      set %i  $+ %i $+ 
    }
    elseif (%r == 1) {
      set %i  $+ %i  $+ 
    }
    else {
      set %i  $+ %i $+ 
    }
    set %msg  %msg $+ %i
    inc %count
    goto m1
    :isspc   
    //set %msg %msg $+ $chr(160)
    inc %count
    goto m1 
  }
  say %msg
  unset %msg %r %i %count %arg
  return
}
/ascii.codes { 
  if ($window(@AsciiTable).x == $null) { window -al @AsciiTable 0 0 80 390 arial | titlebar @AsciiTable : StrangeScript }
  else window -a @AsciiTable
  set %chr.var 1 
  :asciloop
  if (%chr.var > 255) { goto done } 
  ;rline @AsciiTable %chr.var   %chr.var is $chr(%chr.var) 
  rline @AsciiTable %chr.var   $highcol $+ %chr.var $lowcol $+ is $highcol $+ $chr(%chr.var) 
  inc %chr.var 1 
  goto asciloop 
  :done
  unset %chr.var
}
/swho {
  if ($key(StrangeScript,which.window) == ACTIVE) {
    .enable #sswho
    $report($chain).active
    $report(StrangeWho,$1,$null,Processing...).active
    set %tempa 0
    set %tempb 1 
    if ($network == Human) { who # * $+ $1- $+ * }
    else { who $1 }
    goto swhodone
  }
  if ($key(StrangeScript,which.window) == ON) {
    window -al @UserInfo 0 0 420 270 @UserInfo arial 12
    titlebar @UserInfo DoubleClick line to send RighClick for options
    aline @UserInfo $sys $+ $lowcol $+ Trying A Who on $highcol $+ $1
    .enable #sswho
    aline @UserInfo $sys $+ $chain
    set %tempa 0
    set %tempb 1 
    who $1
    goto swhodone
  }
  else {
    $report(StrangeWho,$1,$null,Processing).status
    .enable #sswho
    $report($chain).status
    set %tempa 0
    set %tempb 1 
    who $1
  }
  :swhodone
  unset %tempa %tempb
}
/bluetop topic # $blue($1-)
/bluetalk say $blue($1-)
/blue {
  var %bluetop = $bluestart
  var %n = $len($1-)
  var %n2 = 1
  while (%n2 <= %n) {
    var %bluetop = %bluetop $blueletter($mid($1-,%n2,1))
    inc %n2
    if (%n2 > %n) { break }
  }
  var %bluetop = %bluetop $blueend
  return %bluetop
}
/bluestart { return 09..:]02,02 }
/blueend { return 09[:.. }
/blueappend { return 12:09,99 }
/blueletter { return 12(09 $+ $1 $+ 01) }
/tubetop tubes $iif($1 == $null,tubEweRKs,$1-) | topic # %tubewerks
/tubetalk tubes $1- | say %tubewerks
/tubeart {
  %n = 1
  while (%n <= 6) {
    set %tubewerks [ [ $tubeselect ] ]
    set %tubewerks $gettok(%tubewerks,1,32) $+ * $+ $gettok(%tubewerks,2,32)
    echo -a %tubewerks
    inc %n
  }
  %n = 5
  while (%n > 0) {
    set %tubewerks [ [ $tubeselect ] ]
    set %tubewerks $gettok(%tubewerks,1,32) $+ * $+ $gettok(%tubewerks,2,32)
    echo -a %tubewerks
    dec %n
  }
  %n = 2
  while (%n <= 6) {
    set %tubewerks [ [ $tubeselect ] ]
    set %tubewerks $gettok(%tubewerks,1,32) $+ * $+ $gettok(%tubewerks,2,32)
    echo -a %tubewerks
    inc %n
  }
  %n = 5
  while (%n > 0) {
    set %tubewerks [ [ $tubeselect ] ]
    set %tubewerks $gettok(%tubewerks,1,32) $+ * $+ $gettok(%tubewerks,2,32)
    echo -a %tubewerks
    dec %n
  }
}
/tubes { set %tubewerks [ [ $tubechoose ] ] | set %tubewerks $gettok(%tubewerks,1,32) $1- $gettok(%tubewerks,2,32) }
/tubechoose return $chr(36) $+ tubes $+ $rand(1,6)
/tubeselect return $chr(36) $+ tubes $+ %n
/tubes1 { return 12,2*9,3*13,6*11,10*4,5*8,7 4,5*11,10*13,6*9,3*12,2* }
/tubes2 { return 9,3*13,6*11,10*4,5*8,7*12,2 8,7*4,5*11,10*13,6*9,3* }
/tubes3 { return 13,6*11,10*4,5*8,7*12,2*9,3 12,2*8,7*4,5*11,10*13,6* }
/tubes4 { return 11,10*4,5*8,7*12,2*9,3*13,6 9,3*12,2*8,7*4,5*11,10* }
/tubes5 { return 4,5*8,7*12,2*9,3*13,6*11,10 13,6*9,3*12,2*8,7*4,5* }
/tubes6 { return 8,7*12,2*9,3*13,6*11,10*4,5 11,10*13,6*9,3*12,2*8,7* }
;/halfop { 
;  if ($1 != ?) && ($1 != $null) { .raw mode # +hhh $1 $2 $3 }
;  if ($1 != ?) && ($1 == $null) {
;    if ($modespl == $null) { var %tmp.num = 1 }
;    else { var %tmp.num = $modespl }
;    var %tmp.count = 1
;    var %tmp.total = 1
;    while (%tmp.count <= $numtok($snicks,44)) {
;      var %tmp.user = $addtok(%tmp.user,$snick(#,%tmp.count),44)
;      if (%tmp.total == %tmp.num) {
;        if ($network == Dalnet) { .raw mode # $str(+h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;        else { .raw mode # + $+ $str(h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;        unset %tmp.user
;        var %tmp.total = 0
;      }
;      inc %tmp.total
;      inc %tmp.count
;      if (%tmp.count > $snick(#,0)) { break }
;    }
;    if ($network == Dalnet) { .raw mode # $str(+h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;    else { .raw mode # + $+ $str(h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;    return
;  }
;}
;/halfdop {
;  if ($1 != ?) && ($1 != $null) { .raw mode # -hhh $1 $2 $3 }
;  if ($1 != ?) && ($1 == $null) {
;    if ($key(settings,ircx) == ON) { .raw access # clear owner }
;    if ($modespl == $null) { var %tmp.num = 1 }
;    else { var %tmp.num = $modespl }
;    var %tmp.count = 1
;    var %tmp.total = 1
;    while (%tmp.count <= $numtok($snicks,44)) {
;      var %tmp.user = $addtok(%tmp.user,$snick(#,%tmp.count),44)
;      if (%tmp.total == %tmp.num) {
;        if ($network == Dalnet) { .raw mode # $str(-h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;        else { .raw mode # - $+ $str(h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;        unset %tmp.user
;        var %tmp.total = 0
;      }
;      inc %tmp.total
;     inc %tmp.count
;      if (%tmp.count > $snick(#,0)) { break }
;    }
;    if ($network == Dalnet) { .raw mode # $str(-h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;    else { .raw mode # - $+ $str(h,$numtok(%tmp.user,44)) $replace(%tmp.user,$chr(44),$chr(32)) }
;  }
;}