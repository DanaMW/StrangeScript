/SL.PLAY {
  return
  ;.notice %boss 
}
log.value {
  if (%logging == 0.0.0) { return OFF }
  if (%logging == 1.1.1) { return ON all }
  if (%logging == 1.1.0) { return ON Security only }
  if (%logging == 1.0.1) { return On Query only }
  return
}
LOG.ADJUST {
  log.value
  if ($2 == ON) { set %logging 1.1.1 | .timerLOG 0 1 Check.Serv.Log | .msg $1 Your log reads set as %logging $logging.value $+ . | return }
  if ($2 == OFF) { set %logging 0.0.0 | .timerLOG OFF | .msg $1 Your log reads set as %logging $logging.value $+ . | return }
  if ($2 == SHOW) { .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . | return }
  if ($2 == -s) {
    if ($3 == OFF) { set %logging $puttok(%logging,0,2,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
    if ($3 == ON) { set %logging $puttok(%logging,1,2,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
    ;set %logging OFF | .timerLOG OFF | .msg $1 Your log reads set as %logging $logging.value $+ .
    return
  }
  if ($2 == -q) {
    if ($3 == OFF) { set %logging  $puttok(%logging,0,3,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
    if ($3 == ON) { set %logging  $puttok(%logging,1,3,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
    ; set %logging OFF | .timerLOG OFF | .msg $1 Your log reads set as %logging $logging.value $+ .
    return
  }
  return
}
SS.Command {
  if ($2 == OFF) {
    if ($3 == all) || ($3 == $chr(42)) { sockclose Spy* | unset %server.spy.on.* | msg # $report(ServerSpy,OFF,ALL) }
    if ($3 == icq) || ($3 == i) { sockclose SpyICQ | unset %server.spy.on.icq | msg # $report(ServerSpy,OFF,Icq) }
    if ($3 == dalnet) || ($3 == d) { sockclose SpyDALNET | unset %server.spy.on.dalnet | msg # $report(ServerSpy,OFF,Dalnet) }
    if ($3 == strange) || ($3 == s) { sockclose SpySTRANGE | unset %server.spy.on.strange | msg # $report(ServerSpy,OFF,Strange) }
    if ($3 == xpeace) || ($3 == x) { sockclose SpyXPEACE | unset %server.spy.on.xpeace | msg # $report(ServerSpy,OFF,Xpeace) }
    if ($3 == chat) || ($3 == c) { sockclose SpyCHAT | unset %server.spy.on.chat | msg # $report(ServerSpy,OFF,Chat) }
    if ($3 == splog) || ($3 == p) { sockclose SpySPLOG | unset %server.spy.on.splog | msg # $report(ServerSpy,OFF,sPlog) }
    if ($3 == jong) || ($3 == j) { sockclose SpyJONG | unset %server.spy.on.jong | msg # $report(ServerSpy,OFF,Jong) }
    if ($3 == blaze) || ($3 == b) { sockclose SpyBLAZE | unset %server.spy.on.blaze | msg # $report(ServerSpy,OFF,Blaze) }
    if ($3 == global) || ($3 == g) { sockclose SpyGLOBAL | unset %server.spy.on.global | msg # $report(ServerSpy,OFF,Global) }
    return
  }
  if ($2 == ON) {
    if ($3 == icq) || ($3 == i) { if (%server.spy.port.icq == $null) { set %server.spy.port.icq 6667 } | sockopen SpyICQ %server.spy.server.icq %server.spy.port.icq | set %server.spy.on.icq icq $+ , $+ $chan $+ , $+ %server.spy.chan.icq | msg # $report(ServerSpy,ON,Icq) }
    if ($3 == dalnet) || ($3 == d) { if (%server.spy.port.dalnet == $null) { set %server.spy.port.dalnet 6667 } | sockopen SpyDALNET %server.spy.server.dalnet %server.spy.port.dalnet | set %server.spy.on.dalnet dalnet $+ , $+ $chan $+ , $+ %server.spy.chan.dalnet | msg # $report(ServerSpy,ON,Dalnet) }
    if ($3 == strange) || ($3 == s) { if (%server.spy.port.strange == $null) { set %server.spy.port.strange 6667 } | sockopen SpySTRANGE %server.spy.server.strange %server.spy.port.strange | set %server.spy.on.strange strange $+ , $+ $chan $+ , $+ %server.spy.chan.strange | msg # $report(ServerSpy,ON,Strange) }
    if ($3 == xpeace) || ($3 == x) { if (%server.spy.port.xpeace == $null) { set %server.spy.port.xpeace 6667 } | sockopen SpyXPEACE %server.spy.server.xpeace %server.spy.port.xpeace | set %server.spy.on.xpeace xpeace $+ , $+ $chan $+ , $+ %server.spy.chan.xpeace | msg # $report(ServerSpy,ON,Xpeace) }
    if ($3 == chat) || ($3 == c) { if (%server.spy.port.chat == $null) { set %server.spy.port.chat 6667 } | sockopen SpyCHAT %server.spy.server.chat %server.spy.port.chat | set %server.spy.on.chat chat $+ , $+ $chan $+ , $+ %server.spy.chan.chat | msg # $report(ServerSpy,ON,Chat) }
    if ($3 == splog) || ($3 == p) { if (%server.spy.port.splog == $null) { set %server.spy.port.splog 6667 } | sockopen SpySPLOG %server.spy.server.splog %server.spy.port.splog | set %server.spy.on.splog splog $+ , $+ $chan $+ , $+ %server.spy.chan.splog | msg # $report(ServerSpy,ON,sPlog) }
    if ($3 == jong) || ($3 == j) { if (%server.spy.port.jong == $null) { set %server.spy.port.jong 6667 } | sockopen SpyJONG %server.spy.server.jong %server.spy.port.jong | set %server.spy.on.jong jong $+ , $+ $chan $+ , $+ %server.spy.chan.jong | msg # $report(ServerSpy,ON,Jong) }
    if ($3 == blaze) || ($3 == b) { if (%server.spy.port.blaze == $null) { set %server.spy.port.blaze 6667 } | sockopen SpyBLAZE %server.spy.server.blaze %server.spy.port.blaze | set %server.spy.on.blaze blaze $+ , $+ $chan $+ , $+ %server.spy.chan.blaze | msg # $report(ServerSpy,ON,Blaze) }
    if ($3 == global) || ($3 == g) { if (%server.spy.port.global == $null) { set %server.spy.port.global 6667 } | sockopen SpyGLOBAL %server.spy.server.global %server.spy.port.global | set %server.spy.on.global global $+ , $+ $chan $+ , $+ %server.spy.chan.global | msg # $report(ServerSpy,ON,Global) }
    return
  }
  if ($2 == STATS) { sl $3- }
  if ($2 == NICK) {
    if ($3 == icq) || ($3 == i) { set %server.spy.nick.icq $4 | msg # $report(ServerSpy,Nick,Icq,$4) }
    if ($3 == dalnet) || ($3 == d) { set %server.spy.nick.dalnet $4 | msg # $report(ServerSpy,Nick,Dalnet,$4) }
    if ($3 == strange) || ($3 == s) { set %server.spy.nick.strange $4 | msg # $report(ServerSpy,Nick,Strange,$4) }
    if ($3 == xpeace) || ($3 == x) { set %server.spy.nick.xpeace $4 | msg # $report(ServerSpy,Nick,Xpeace,$4) }
    if ($3 == chat) || ($3 == c) { set %server.spy.nick.chat $4 | msg # $report(ServerSpy,Nick,Chat,$4) }
    if ($3 == splog) || ($3 == p) { set %server.spy.nick.splog $4 | msg # $report(ServerSpy,Nick,sPlog,$4) }
    if ($3 == jong) || ($3 == j) { set %server.spy.nick.jong $4 | msg # $report(ServerSpy,Nick,Jong,$4) }
    if ($3 == blaze) || ($3 == b) { set %server.spy.nick.blaze $4 | msg # $report(ServerSpy,Nick,Blaze,$4) }
    if ($3 == global) || ($3 == g) { set %server.spy.nick.global $4 | msg # $report(ServerSpy,Nick,Global,$4) }
    return
  }
  if ($2 == SERVER) {
    if ($3 == icq) || ($3 == i) { set %server.spy.server.icq $4 | msg # $report(ServerSpy,Server,Icq,$4) }
    if ($3 == dalnet) || ($3 == d) { set %server.spy.server.dalnet $4 | msg # $report(ServerSpy,Server,Dalnet,$4) }
    if ($3 == strange) || ($3 == s) { set %server.spy.server.strange $4 | msg # $report(ServerSpy,Server,Strange,$4) }
    if ($3 == xpeace) || ($3 == x) { set %server.spy.server.xpeace $4 | msg # $report(ServerSpy,Server,Xpeace,$4) }
    if ($3 == chat) || ($3 == c) { set %server.spy.server.chat $4 | msg # $report(ServerSpy,Server,Chat,$4) }
    if ($3 == splog) || ($3 == p) { set %server.spy.server.splog $4 | msg # $report(ServerSpy,Server,sPlog,$4) }
    if ($3 == jong) || ($3 == j) { set %server.spy.server.jong $4 | msg # $report(ServerSpy,Server,Jong,$4) }
    if ($3 == blaze) || ($3 == b) { set %server.spy.server.blaze $4 | msg # $report(ServerSpy,Server,Blaze,$4) }
    if ($3 == global) || ($3 == g) { set %server.spy.server.global $4 | msg # $report(ServerSpy,Server,Global,$4) }
    return
  }
  if ($2 == PASS) {
    if ($3 == icq) || ($3 == i) { set %server.spy.pass.icq $4 | msg # $report(ServerSpy,Pass,Icq,$4) }
    if ($3 == dalnet) || ($3 == d) { set %server.spy.pass.dalnet $4 | msg # $report(ServerSpy,Pass,Dalnet,$4) }
    if ($3 == strange) || ($3 == s) { set %server.spy.pass.strange $4 | msg # $report(ServerSpy,Pass,Strange,$4) }
    if ($3 == xpeace) || ($3 == x) { set %server.spy.pass.xpeace $4 | msg # $report(ServerSpy,Pass,Xpeace,$4) }
    if ($3 == chat) || ($3 == c) { set %server.spy.pass.chat $4 | msg # $report(ServerSpy,Pass,Chat,$4) }
    if ($3 == splog) || ($3 == p) { set %server.spy.pass.splog $4 | msg # $report(ServerSpy,Pass,sPlog,$4) }
    if ($3 == jong) || ($3 == j) { set %server.spy.pass.jong $4 | msg # $report(ServerSpy,Pass,Jong,$4) }
    if ($3 == blaze) || ($3 == b) { set %server.spy.pass.blaze $4 | msg # $report(ServerSpy,Pass,Blaze,$4) }
    if ($3 == global) || ($3 == g) { set %server.spy.pass.global $4 | msg # $report(ServerSpy,Pass,Global,$4) }
    return
  }
  if ($2 == PORT) {
    if ($3 == icq) || ($3 == i) { set %server.spy.port.icq $4 | msg # $report(ServerSpy,Port,Icq,$4) }
    if ($3 == dalnet) || ($3 == d) { set %server.spy.port.dalnet $4 | msg # $report(ServerSpy,Port,Dalnet,$4) }
    if ($3 == strange) || ($3 == s) { set %server.spy.port.strange $4 | msg # $report(ServerSpy,Port,Strange,$4) }
    if ($3 == xpeace) || ($3 == x) { set %server.spy.port.xpeace $4 | msg # $report(ServerSpy,Port,Xpeace,$4) }
    if ($3 == chat) || ($3 == c) { set %server.spy.port.chat $4 | msg # $report(ServerSpy,Port,Chat,$4) }
    if ($3 == splog) || ($3 == p) { set %server.spy.port.splog $4 | msg # $report(ServerSpy,Port,sPlog,$4) }
    if ($3 == jong) || ($3 == j) { set %server.spy.port.jong $4 | msg # $report(ServerSpy,Port,Jong,$4) }
    if ($3 == blaze) || ($3 == b) { set %server.spy.port.blaze $4 | msg # $report(ServerSpy,Port,Blaze,$4) }
    if ($3 == global) || ($3 == g) { set %server.spy.port.global $4 | msg # $report(ServerSpy,Port,Global,$4) }
    return
  }
  if ($2 == CHANNEL) || ($2 == CHAN) {
    if ($3 == icq) || ($3 == i) { set %server.spy.chan.icq $4 | msg # $report(ServerSpy,Channel,Icq,$4) }
    if ($3 == dalnet) || ($3 == d) { set %server.spy.chan.dalnet $4 | msg # $report(ServerSpy,Channel,Dalnet,$4) }
    if ($3 == strange) || ($3 == s) { set %server.spy.chan.strange $4 | msg # $report(ServerSpy,Channel,Strange,$4) }
    if ($3 == xpeace) || ($3 == x) { set %server.spy.chan.xpeace $4 | msg # $report(ServerSpy,Channel,Xpeace,$4) }
    if ($3 == chat) || ($3 == c) { set %server.spy.chan.chat $4 | msg # $report(ServerSpy,Channel,Chat,$4) }
    if ($3 == splog) || ($3 == p) { set %server.spy.chan.splog $4 | msg # $report(ServerSpy,Channel,sPlog,$4) }
    if ($3 == jong) || ($3 == j) { set %server.spy.chan.jong $4 | msg # $report(ServerSpy,Channel,Jong,$4) }
    if ($3 == blaze) || ($3 == b) { set %server.spy.chan.blaze $4 | msg # $report(ServerSpy,Channel,Blaze,$4) }
    if ($3 == global) || ($3 == g) { set %server.spy.chan.global $4 | msg # $report(ServerSpy,Channel,global,$4) }
    return
  }
  return
}
UP.Service {
  ;$1 is message room
  ;$2 is hop,aop,sop
  ;$3 is #room
  ;$4 is ADD|DEL|LIST|WIPE
  ;$5 is nick
  if ($exists(up_service.ini) == $false) { write -c up_service.ini }
  if ($1 == $null) { $pointer $report(UP,$null,Error,Null in command to,UP.Service) | return }
  if ($2 == $null) || ($3 == $null) || ($4 == $null) { $pointer $report(UP,$null,Format: . $+ $UPPER($2) <#room> <-A/ADD|-d/DEL/|-lLIST|-w/WIPE> <nick>) | return }
  if ($4 != -A) && ($4 != ADD) && ($4 != -D) && ($4 != DEL) && ($4 != DELETE) && ($4 != -L) && ($4 != LIST) && ($4 != -W) && ($4 != WIPE) { $pointer $report(UP,$null,Format: . $+ $UPPER($2) <#room> <-A/ADD|-D/DEL|-L/LIST|-W/WIPE> <nick>) | return }
  if ($4 == -a) || ($4 == ADD) {
    if ($5 == $null) { $pointer $report(UP,$null,Format: . $+ $UPPER($2) <#room> <-A/ADD|-D/DEL|-L/LIST|-W/WIPE> <nick>) | return }
    var %t.us = $readini(up_service.ini, n,$3,$5)
    if (%t.us == $null) { .writeini -n up_service.ini $3 $5 $upper($2) | $pointer $report(UP,$null,Added $5 to $3 as an $upper($2)) | return }
    else { $pointer $report(UP,$null,Note,$5 is already listed, as an $upper(%t.us) in, $3) +| return }
    ;.timer -m 1 500 HOP.Service $1 LIST
    return
  }
  if ($4 == -d) || ($4 == DEL) || ($4 == DELETE) {
    if ($5 == $null) { $pointer $report(UP,$null,Format: . $+ $UPPER($2) <#room> <-A/ADD|-D/DEL/|-L/LIST|-W/WIPE> <nick>) | return }
    var %t.us = $readini(up_service.ini, n,$3,$5)
    if (%t.us == $null) || ($readini(up_service.ini, n,$3,$5) != $upper($2)) { $pointer $report(UP,$null,$5 is not listed as an $upper($2) in $3) | return }
    else { .remini up_service.ini $3 $5 | $pointer $report(UP,$null,Removed,$5 from $3.was $upper(%t.us))  | return }
    ;.timer -m 1 500 HOP.Service $1 LIST
    return
  }
  if ($4 == -l) || ($4 == LIST) {
    var  %t.us = $ini(up_service.ini,$3,0)
    if (%t.us < 1) { $pointer $report(UP,$null,Note,There are no HOP|AOP|SOP's listed for $3) | return }
    else {
      $pointer $report(UP,$null,HOP AOP SOP list for $3)
      var %lcount = 1
      while (%lcount <= %t.us) {
        if ($readini(up_service.ini, n,$3,$ini(up_service.ini,$3,%lcount)) == SOP) { var %t.1 = +o }
        if ($readini(up_service.ini, n,$3,$ini(up_service.ini,$3,%lcount)) == AOP) { var %t.1 = +v }
        if ($readini(up_service.ini, n,$3,$ini(up_service.ini,$3,%lcount)) == HOP) { var %t.1 = +h }
        $pointer $report($chr(91) %lcount $chr(93) $ini(up_service.ini,$3,%lcount) $+ $str(.,$calc(30 - $len($ini(up_service.ini,$3,%lcount)))) $+  ( %t.1 ))
        inc %lcount
        if (%lcount > %t.us) { break }
      }
      $pointer $report(UP,$null,End of List)
    }
    return
  }
  if ($4 == -w) || ($4 == WIPE) { .remini up_service.ini $3 | $pointer $report(UP,$1,Note,Wiped the room,$3) | return }
  $pointer $report(UP,$1,Format: . $+ $UPPER($2) <#room> <-A/ADD|-D/DEL|-L/LIST|-W/WIPE> <nick>)
  return
}
play.filter {
  ;$1 = room to play to
  ;$2 = file to play
  if ($1 == $null) { .msg # Error in play.filter, no params specified (Format: /play.filter <#room to play to> <file  to filter and play>) | halt }
  if ($exists($2) == $false) { msg # Error playing file, the fucking thing is missing ($2) | halt }
  var %xz = 1
  while (%xz <= $lines($2)) {
    if ($read($2, n,%xz) == $null) { .timer 1 $calc(2 + %xz) .msg $1 $chr(160) }
    else { .timer 1 $calc(2 + %xz) .msg $1 $replace($read($2, n,%xz),$chr(9),$chr(160)) }
    inc %xz
    if  (%xz > $lines($2)) { break }
  }
}
key {
  ;1=network 2=room 3=key
  var %tmp.fold = $network $+ .ini
  return $readini(%tmp.fold,$1,$2)
}
master {
  ;1=network 2=room 3=key
  var %tmp.fold = ScriptInfo.ini
  return $readini(%tmp.fold,$1,$2)
}
keywrite {
  ;keywrite Room key value
  if ($1 == $null) || ($2 == $null) { $report(Error In KeyWrite: Trying to delete key,$1-).active | return }
  var %tmp.fold = $network $+ .ini
  if ($3 != $null) { .writeini %tmp.fold $1 $2 $3- }
  else { .writeini %tmp.fold $1 $2 "" }
  return
}
masterwrite {
  ;masterwrite Room key value
  if ($1 == $null) || ($2 == $null) { $report(Error In MasterWrite: Trying to delete key,$1-).active | return }
  var %tmp.fold = ScriptInfo.ini
  if ($3 != $null) { .writeini %tmp.fold $1 $2 $3- }
  else { .writeini %tmp.fold $1 $2 "" | $report(MasterWrite: Clearing key,$1-).active }
  return
}
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
/hex.out {
  set %hex.word ""
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
  if ($1 == $2) { 
    if ($master(settings,Query.Windows) == ON) && ($window(=$nick) == $null) { /query $1 }
    if ($window(=$nick) == $null) { echo $color(highlight) -at WHISPER:  $+ %sc.me $+ $lll $white $+ $1  $+ %sc.me $+ $rrr $+  $report($null,UnHexed) $+  $replace(%hex.comp,$chr(95),$chr(160)) }
    if ($window(=$nick) != $null) { echo $color(highlight) -t $nick $output  $+ %sc.me $+ $lll $white $+ $1  $+ %sc.me $+ $rrr $+  $report($null,UnHexed) $+  $replace(%hex.comp,$chr(95),$chr(160)) }
  }
  else { echo -t $2 $output  $+ %sc.me $+ $lll $white $+ $1  $+ %sc.me $+ $rrr $+  $report($null,UnHexed) $+  $replace(%hex.comp,$chr(95),$chr(160)) }
  unset %hex.* %n
}
lcr {
  set %recon.L 0
  set %recon.C 0
  set %recon.R 0
  if (%reconnect. [ $+ [ $network ] ] == OFF) { set %recon.L 0 }
  if (%reconnect. [ $+ [ $network ] ] == ON) { set %recon.L 1 }
  return %recon.L $+ %recon.C $+ %recon.R
}
;/notice {
;  haltdef
;  if (%do.hex. [ $+ [ $network ] ] == ON) {
;    var %tmp.sendnote =  $+ $hex.ini($2-)
;    raw notice $1 : $+ %tmp.sendnote
;  }
;  else { raw notice $1 : $+ $2- }
;  halt
;}
/quit.Pick {
  var %tmp.QP1 = 1
  var %tmp.QP2 = $var(connected*,0)
  var %maxq = $var(connected*,0)
  if ($1 == $null) {
    set %QP.set YES
    $point $report(0,$null,All Exit/Quit)
    while (%tmp.QP1 <= %tmp.QP2) {
      if (%tmp.QP2 == 1) { $point $report(%tmp.QP1,$null,$var(connected*,%tmp.QP1).value,$var(connserv*,%tmp.QP1).value) | break }
      else { $point $report(%tmp.QP1,$null,$var(connected*,%tmp.QP1).value) $+ $report($null,$null,$var(connserv*,%tmp.QP1).value) }
      inc %tmp.QP1
      if (%tmp.QP1 > %tmp.QP2) { break }
    }
    $point $report(Select server to quit: 0 to %maxq $+ : ) 
  }
  else {
    if (%QP.set == $null) { $scid(0) }
    set %QP.set YES
    if ($1 == 0) { $point $report($null,Quiting) $+ $report($1) $+ $report($null,$null,$var(connected*,$scon($1)).value) | halt }
    else {
      $point $report($null,Quiting) $+ $report($1)
      scon $var(connserv*,$1).value
      msg #StrangeScript test
      ;quit $var(connserv*,$1).value Bosses Orders
    }
    unset %QP.set %tmp.QP1 %tmp.QP2
  }
