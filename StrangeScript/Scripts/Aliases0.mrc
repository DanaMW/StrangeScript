/fullver return $report($ver,$null,$null,$null,04 $+ $chr(169) $+ 1999-2023 Dana L. Meli-Wischman)
/ver return 10S04trange10S04cript10[v157.44.01.12.202310]
/myver say $fullver
/mytopic topic # $fullver
/key {
  ;1=network/value 2=key
  set %tmp.fold Text\ScriptInfo.ini
  return $readini(%tmp.fold,$1,$2)
}
/keywrite {
  ; 01/08/2023
  ; 1-network 2-key 3-value
  if ($1 == $null) || ($2 == $null) { $report(Error In keywrite: Trying to delete key,$1-).active | if (status !isin $window($active)) { $report(Error In keywrite: Trying to delete key,$1-).status } | return }
  set %tmp.fold Text\ScriptInfo.ini
  if ($3 != $null) {
    .writeini %tmp.fold $1 $2 $3-
    if ($key(StrangeScript,key.writes) == ON) { $report(StrangeScript,keywrite,$1,$2,$3-).active } 
  }
  else {
    .writeini %tmp.fold $1 $2 ""
    if ($key(StrangeScript,key.writes) == ON) { $report(StrangeScript,keywrite,Clearing key,$1-).active }
  }
  unset %tmp*
  return
}
/keyedit {
  set %tmp.ke1 $1
  set %tmp.ke2 $2
  set %tmp.ke3 $3-
  set %tmp.sq $$?="%tmp.ke3"
  if (%tmp.sq == $null) { return }
  keywrite %tmp.ke1 %tmp.ke2 %tmp.sq
  $report(StrangeScript,%tmp.ke1,%tmp.ke2,Set to,$key(%tmp.ke1,%tmp.ke2)).active
  unset %tmp.ke* %tmp.sq
  return
}
/keyhexedit {
  set %tmp.ke1 $1
  set %tmp.ke2 $2
  set %tmp.ke3 $3-
  set %tmp.sq $$?="%tmp.ke3"
  set %tmp.sqh $hex.ini(%tmp.sq)
  if (%tmp.sq == $null) { return }
  keywrite %tmp.ke1 %tmp.ke2 %tmp.sqh
  $report(StrangeScript,%tmp.ke1,%tmp.ke2,Set to,$unhex.ini($key(%tmp.ke1,%tmp.ke2))).active
  unset %tmp.ke* %tmp.sq %tmp.sqh
  return
}
pingpong {
  if ($1 == ON) {
    keywrite StrangeScript pingpong.show ON
    $report(StrangeScript,$null,PingPong Show,Set To,ON).active
    return
  }
  if ($1 == OFF) {
    keywrite StrangeScript pingpong.show OFF
    $report(StrangeScript,$null,PingPong Show,Set To,OFF).active
    return
  }
  return
}
ctcp.ignore {
  if ($1 == ON) {
    keywrite $network ctcp.ignore ON
    $report(StrangeScript,$null,Ctcp Ignore,Set To,ON).active
    return
  }
  if ($1 == OFF) {
    keywrite $network ctcp.ignore OFF
    $report(StrangeScript,$null,Ctcp Ignore,Set To,OFF).active
    return
  }
  return
}
script.sounds {
  if ($1 == ON) {
    keywrite StrangeScript script.sounds ON
    $report(StrangeScript,$null,Script Sounds,Set To,ON).active
    return
  }
  if ($1 == OFF) {
    keywrite StrangeScript script.sounds OFF
    $report(StrangeScript,$null,Script Sounds,Set To,OFF).active
    return
  }
  return
}
/script.play {
  if ($key(StrangeScript,script.sounds) != ON) { return }
  if ($right($1-,3) == wav) {
    if ($inwave != $true) { splay -w $1- }
  }
  if ($right($1-,3) == mp3) || ($right($1-,3) == wma) {
    if ($insong != $true) { splay -p $1- }
  }
  ;$report(Playing a *. $+ $upper($right($1,3)) sound file).status
  return
}
/setupshow { $report(System Setting,$null,SET,$null,$1-).active | script.play Notify.wav }
/make.auto.join {
  $report(StrangeScript,Create-AutoJoin,$null,$null,Creating your autojoin list).active
  set %tmp.iaj 1
  unset %tmp.iaj1
  while (%tmp.iaj <= $chan(0)) {
    set %tmp.iaj1 $addtok(%tmp.iaj1,$chan(%tmp.iaj),44)
    $report(Insta-AutoJoin,$null,Adding,$null,$chan(%tmp.iaj)).active
    inc %tmp.iaj
    if (%tmp.iaj > $chan(0)) { break }
  }
  keywrite $network auto.join.rooms %tmp.iaj1
  $report(StrangeScript,Create-AutoJoin,$null,Done,$key($network,auto.join.rooms,Creating your autojoin list)).active
  unset %tmp.iaj %tmp.iaj1
}
Key.writes {
  if ($1 == ON) {
    keywrite strangescript key.writes ON
    $report(StrangeScript,$null,Key Writes,Set To,ON).active
    return
  }
  if ($1 == OFF) {
    keywrite strangescript key.writes OFF
    $report(StrangeScript,$null,Key Writes,Set To,OFF).active
    return
  }
  return
}
Key.reads {
  if ($1 == ON) {
    keywrite strangescript key.reads ON
    $report(StrangeScript,$null,Key Reads,Set To,ON).active
    return
  }
  if ($1 == OFF) {
    keywrite strangescript key.reads OFF
    $report(StrangeScript,$null,Key Reads,Set To,OFF).active
    return
  }
  return
}
/op /mode # +ooo $$1 $2 $3
/dop /mode # -ooo $$1 $2 $3
/j /join #$$1 $2-
/p /part #
/n /names #$$1
/w /whois $$1
/k /kick # $$1 $2-
/q /query $$1-
/s /server $$1-
/i /invite $$1 #$$2
/send /dcc send $1 $2
/chat /dcc chat $1
/ping /ctcp $$1 ping
/cmode /mode # $1-
/umode /mode $$me $1-
/kickban /ban -k # $$1 $2-
/autojoin /halt
/aj auto.join
/hexit say $hex.ini($1-)
/unhexit say $unhex.ini($1-)
/hex.ini {
  unset %hex.*
  set %hex.word $replace($1-,$chr(32),$chr(95))
  set %n 1
  while (%n <= $len(%hex.word)) {
    set %hex.char $asc($mid(%hex.word,%n,1))
    set %hex.val1 $int($calc(%hex.char / 16))
    set %hex.val2 $calc($calc(%hex.char - (%hex.val1 * 16)))
    if (%hex.val1 == 10) { set %hex.val1 A }
    if (%hex.val1 == 11) { set %hex.val1 B }
    if (%hex.val1 == 12) { set %hex.val1 C }
    if (%hex.val1 == 13) { set %hex.val1 D }
    if (%hex.val1 == 14) { set %hex.val1 E }
    if (%hex.val1 == 15) { set %hex.val1 F }
    if (%hex.val2 == 10) { set %hex.val2 A }
    if (%hex.val2 == 11) { set %hex.val2 B }
    if (%hex.val2 == 12) { set %hex.val2 C }
    if (%hex.val2 == 13) { set %hex.val2 D }
    if (%hex.val2 == 14) { set %hex.val2 E }
    if (%hex.val2 == 15) { set %hex.val2 F }
    set %hex.char %hex.val1 $+ %hex.val2
    set %hex.comp %hex.comp $+ %hex.char
    inc %n
    if (%n > $len(%hex.word)) { break }
  }
  .timer 1 1 unset %hex.* %n
  return %hex.comp
}
/unhex.ini {
  unset %hex.*
  set %hex.word $1-
  set %hex.word $remove(%hex.word,',^)
  set %n 1
  while (%n <= $len(%hex.word)) {
    set %hex.char $mid(%hex.word,%n,1)
    if (%hex.char == A) { set %hex.char 10 }
    if (%hex.char == B) { set %hex.char 11 }
    if (%hex.char == C) { set %hex.char 12 }
    if (%hex.char == D) { set %hex.char 13 }
    if (%hex.char == E) { set %hex.char 14 }
    if (%hex.char == F) { set %hex.char 15 }
    set %hex.val $calc(16 * %hex.char)
    inc %n
    set %hex.char $mid(%hex.word,%n,1)
    if (%hex.char == A) { set %hex.char 10 }
    if (%hex.char == B) { set %hex.char 11 }
    if (%hex.char == C) { set %hex.char 12 }
    if (%hex.char == D) { set %hex.char 13 }
    if (%hex.char == E) { set %hex.char 14 }
    if (%hex.char == F) { set %hex.char 15 }
    set %hex.val $calc(%hex.val + %hex.char)
    set %hex.val $chr(%hex.val)
    set %hex.comp %hex.comp $+ %hex.val
    inc %n
    if (%n > $len(%hex.word)) { break }
  }
  .timer 1 1 unset %hex.* %n
  return $replace(%hex.comp,$chr(95),$chr(160))
}
/Lgchk { .timer850. $+ $network 0 $key($network,Lagmrcsecs) Lagchk }
/Lagchk { .raw Lag-CK $+ $chr(160) $+ $ticks }
/showLag { /mybar | return }
/msg {
  if ($1 == $null) { $report(StrangeScript,MSG,Error,$null,No Channel or user destination).active | halt }
  if ($2 == $null) { $report(StrangeScript,MSG,Error,$null,No text to send was specified).active | halt }
  if (=* iswm $1) { msg $1- | return }
  .raw privmsg $1 : $+ $2-
  if ($chr(35) isin $1) && ($chan($1) != $null)  { echo -t $1 $output $report($me,$null,$null,$null,$2-) }
  if ($chr(35) !isin $1) && ($query($1) != $null) { echo -t $1 $output $report($me,$null,$null,$null,$1-) }
  if ($chr(35) !isin $1) && ($query($1) == $null) { $report(Privmsg to $1,$null,--->,$2-).active }
  return
}
/amsg {
  if ($1 == $null) { $report(StrangeScript,AMSG,Error,$null,No text to send was specified).active | halt }
  if ($chan(0) < 1) { return }
  set %amsg.count 1
  while (%amsg.count <= $chan(0)) {
    .raw privmsg $chan(%amsg.count) : $+ $1-
    if ($network == Dalnet) { echo -t $chan(%amsg.count) $output  $Report($me,$null,$null,$null,$1-) }
    var %amsg = $addtok(%amsg,$chan(%amsg.count),44)
    inc %amsg.count
    if (%amsg.count > $chan(0)) { break }
  }
  return
}
/notice {
  if ($1 == $null) { $report(StrangeScript,Notice,Error,$null,Nothing to do here. No channel or user destination or message).active | halt }
  if ($chr(35) !isin $1) {
    set %tmp.n #
    set %tmp.m $1-
  }
  if ($chr(35) isin $1) {
    set %tmp.n $1
    set %tmp.m $2-
  }
  .raw NOTICE %tmp.n : $+ %tmp.m
  if ($chr(35) isin %tmp.n) && ($chan(%tmp.n) != $null) { echo -t %tmp.n $output $report(Notice,--->,%tmp.m) }
  if ($chr(35) isin %tmp.n) && ($chan(%tmp.n) == $null) { $report(Notice to,%tmp.n,$null,--->,%tmp.m).active }
  if ($chr(35) !isin %tmp.n) && ($query(%tmp.n) != $null) { echo -t %tmp.n $output $report(Notice,--->,%tmp.m) }
  if ($chr(35) !isin %tmp.n) && ($query(%tmp.n) == $null) { $report(Notice to %tmp.n,$null,--->,%tmp.m).active }
  unset %tmp.n %tmp.m
  return
}
/me {
  if ($1 == $null) { $report(StrangeScript,ME,Error,$null,Nothing to do here. No channel or user destination or message).active | halt }
  if (=* iswm $active) { describe $active $1- | halt }
  .raw privmsg $active : $+ ACTION $1- $+ 
  echo $color(action) -t $active $sysp Action:  $+ %sc.me $+ $lll $+ $white $me  $+ %sc.me $+ $rrr $+  $1-
  if ($network == Dalnet) { echo $color(action) -t $active $sysp Action:  $+ %sc.me $+ $lll $+ $white $me  $+ %sc.me $+ $rrr $+  $1- }
  halt
}
/ame {
  if ($1 == $null) { $report(StrangeScript,AME,Error,$null,No text to send was specified).active | halt }
  set %n 1
  while (%n <= $chan(0)) {
    .raw privmsg $chan(%n) : $+ ACTION $1- $+ 
    if ($network == Dalnet) { echo $color(action) -t $chan(%n) $sysp Action:  $+ %sc.me $+ $lll $+ $white $me  $+ %sc.me $+ $rrr $+  $1- }
    inc %n
    if (%n > $chan(0)) { break }
  }
  return
}
/ctcp {
  if ($1 == $null) { $report(StrangeScript,CTCP,Error,$null,Nothing to do here. No channel or user destination or message).active | halt }
  if ($2 == PING) {
    $report(Sending a $upper(ping) to $1).active
    raw -q privmsg $1 : $+ $chr(1) $+ PING $ctime $ticks $+ $chr(1)
    halt
  }
  if ($2 != PING) {
    $report(Ctcp,$1,Sending,$upper($2),$3-).active
    if ($3 == $null) { raw -q privmsg $1 : $+ $chr(1) $+ $upper($2) $+ $chr(1) }
    if ($3 != $null) { raw -q privmsg $1 : $+ $chr(1) $+ $upper($2) $3- $+ $chr(1) }
    halt
  }
}
/cycle {
  if ($key($network,cycle.counter) >= 2) { return }
  keywrite $network cycle.counter $calc($key($network,cycle.counter) + 1)
  if ($1 == $null) { .raw part # $cr join # $key(#,ownerkey) }       
  if ($1 != $null) { .raw part $1 $cr join $1 $key($1,ownerkey)
  }
  .timerCYC1a. $+ $network 1 5 keywrite $network cycle.counter 0
  .timerCYC1b. $+ $network 1 5 echo -t # $sys $report(StrangeScript,Cycle Counter,$null,$null,Reset to,,0)
}  
/hex.out {
  set %hex.word %null
  set %hex.word $replace($1-,$chr(32),$chr(95))
  set %n 1
  :begin
  if (%n > $len(%hex.word)) { goto end }
  set %hex.char $asc($mid(%hex.word,%n,1))
  set %hex.val1 $int($calc(%hex.char / 16))
  set %hex.val2 $calc($calc(%hex.char - (%hex.val1 * 16)))
  if (%hex.val1 == 10) { set %hex.val1 A }
  if (%hex.val1 == 11) { set %hex.val1 B }
  if (%hex.val1 == 12) { set %hex.val1 C }
  if (%hex.val1 == 13) { set %hex.val1 D }
  if (%hex.val1 == 14) { set %hex.val1 E }
  if (%hex.val1 == 15) { set %hex.val1 F }
  if (%hex.val2 == 10) { set %hex.val2 A }
  if (%hex.val2 == 11) { set %hex.val2 B }
  if (%hex.val2 == 12) { set %hex.val2 C }
  if (%hex.val2 == 13) { set %hex.val2 D }
  if (%hex.val2 == 14) { set %hex.val2 E }
  if (%hex.val2 == 15) { set %hex.val2 F }
  set %hex.char %hex.val1 $+ %hex.val2
  set %hex.comp %hex.comp $+ %hex.char
  inc %n
  goto begin
  :end
  .privmsg $active  $+ %hex.comp
  echo -t # $output  $+ %sc.me $+ $lll $white $+ $me  $+ %sc.me $+ $rrr $+  $report($null,Hexed) $+  $1-
  unset %hex.* %n
  return
}
/unhex.out {
  set %hex.word ""
  set %hex.word $3-
  set %hex.word $remove(%hex.word,',^)
  set %n 1
  :begin
  if (%n > $len(%hex.word)) { goto end }
  set %hex.char $mid(%hex.word,%n,1)
  if (%hex.char == A) { set %hex.char 10 }
  if (%hex.char == B) { set %hex.char 11 }
  if (%hex.char == C) { set %hex.char 12 }
  if (%hex.char == D) { set %hex.char 13 }
  if (%hex.char == E) { set %hex.char 14 }
  if (%hex.char == F) { set %hex.char 15 }
  set %hex.val $calc(16 * %hex.char)
  inc %n
  set %hex.char $mid(%hex.word,%n,1)
  if (%hex.char == A) { set %hex.char 10 }
  if (%hex.char == B) { set %hex.char 11 }
  if (%hex.char == C) { set %hex.char 12 }
  if (%hex.char == D) { set %hex.char 13 }
  if (%hex.char == E) { set %hex.char 14 }
  if (%hex.char == F) { set %hex.char 15 }
  set %hex.val $calc(%hex.val + %hex.char)
  set %hex.val $chr(%hex.val)
  set %hex.comp %hex.comp $+ %hex.val
  inc %n
  goto begin
  :end
  echo -t $2 $output  $+ %sc.me $+ $lll $white $+ $1  $+ %sc.me $+ $rrr $+  $report($null,UnHexed) $+  $replace(%hex.comp,$chr(95),$chr(160))
  unset %hex.* %n
}
/saytime {
  ;##saytime (Sends the time in my format to the channel)
  var %temp = $lowcol $+ $date(dddd) $+ $bright $+ , $+ $chr(160) $+ $lowcol $+ $date(mmmm)
  var %temp = %temp $+ $chr(160) $+ the $lowcol $+ $ord($date(dd)) $+ $bright $+ , $+ $chr(160) $+ $lowcol $+ $date(yyyy)
  var %temp = %temp $+ $chr(160) $+ at $lowcol $+  $time(h) $+ $bright $+ : $+ $lowcol $+ $time(nn)
  var %temp = %temp $+ $chr(160) $+ $lower($time(tt)) $+ $chr(160) $+ $bright $+ ( $+ $lowcol $+ $right($time(zzz),-1) $+ $bright $+ )
  /notice # $report(%temp)
  ;if ($1 == $null) {
  ;  var %temp = $date(dddd) $+ , $date(mmmm)
  ;  var %temp = %temp the $ord($date(dd)) $+ , $date(yyyy)
  ;  var %temp = %temp at $time(h) $+ : $+ $time(nn)
  ;  var %temp = %temp $lower($time(tt)) ( $+ $right($time(zzz),-1) $+ )
  ;  /notice # %temp#
  ;  return
  ;}
}
/year { var %a 0 | while (%a <= 9) { msg $chan $+($1,%a) $+ . $date | inc %a } }