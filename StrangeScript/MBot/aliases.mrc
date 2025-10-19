;Major version  (xx)
ut1 return 03
;
;Minor version (xx)
ut2 return 16
;
;month (xx)
ut3 return 10
;
;day (xx)
ut4 return 19
;
;year (xxxx)
ut5 return 2025
;-----------------------------------------------------
name return 10M04aster10B04ot
ss return 10S04trange10S04cript
ver return $name 10 $+ $chr(91) v00 $+ $ut1 $+ 10. $+ 00 $+ $ut2 $+ 10. $+ 00 $+ $ut3 $+ 10. $+ 00 $+ $ut4 $+ 10. $+ 00 $+ $ut5 10 $+ $chr(93) $+ 00
;coded for $ss
;-----------------------------------------------------
all scid -a $1-
aj auto.join
ca cycleall
sysdir return $mircdirsystem\
botdir return $mircdirMBot\
textdir return $mircdirtext\
myecho if (@.* !isin $active) { return echo $color(normal text) -at < $+ $me $+ > }
long { set %long ** | return }
lowcol { if (%sc1 == $null) { return  $+ 04 } | else { if (%sc.bold == ON) { return  $+ %sc1 } | else { return  $+ %sc1 } } }
highcol { if (%sc2 == $null) { return  $+ 11 } | else { if (%sc.bold == ON) { return  $+ %sc2 } | else { return  $+ %sc2 } } }
bright { if (%sc3 == $null) { return  $+ 08 } | else { if (%sc.bold == ON) { return  $+ %sc3 } | else { return  $+ %sc3 } } }
white { if (%sc4 == $null) { return  $+ 00 } | else { if (%sc.bold == ON) { return  $+ %sc4 } | else { return  $+ %sc4 } } }
sep { if (%sc.seperater == $null) { return  $+ 10 } | else { if (%sc.bold == ON) { return  $+ %sc.seperater } | else { return  $+ %sc.seperater } } }
space return $chr(160)
spcm return $chr(44) $+ $chr(160)
output return 11,11 
sys return 4,4 
;lll return $chr(124) $+ $chr(91)
;rrr return $chr(93) $+ $chr(124)
lll return $chr(186) $+ (
rrr return ) $+ $chr(186)
cls clear
clsa clearall
chain {
  if ($1 != $null) { return $lowcol $+  $+ $str(¤,$1) $+  }
  else { return $lowcol $+ ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤ }
}
reload load.again
load.again { 
  .timer 1 2 load.rest
  load -a aliases.mrc
  halt
}
load.rest {
  load -a aliases1.mrc
  load -rs script0.mrc
  load -rs script1.mrc
  load -rs script2.mrc
  load -rs unmask.mrc
  load -rs spell.mrc
  load -rs seen.mrc
  msg %boss Reload Complete
  halt
}
slc {
  if ($1 == $null) { .msg # Format: .slc <-s|-r> | return }
  if ($1 == -s) {
    if (%log.query == $null) { set %log.query 1 }
    if (%log.qso == $null) { set %log.query 0 }
    .msg #StrangeScript SLC / ISC Bind Read.
    .msg #StrangeScript Query readings $lines(c:\dns\etc\namedb\query.log) ( $+ %log.query $+ ) ( $+ %log.qso $+ )
    .msg #StrangeScript Security readings $lines(c:\dns\etc\namedb\security.log) ( $+ %log.security $+ ) ( $+ %log.Sso $+ )
  }
  if ($1 == -r) {
    set %log.query $lines(c:\dns\etc\namedb\query.log)
    set %log.security $lines(c:\dns\etc\namedb\security.log)
    set %log.qso 0
    set %log.sso 0
    .msg #StrangeScript Query readings $lines(c:\dns\etc\namedb\query.log) ( $+ %log.query $+ ) ( $+ %log.qso $+ )
    .msg #StrangeScript Security readings $lines(c:\dns\etc\namedb\security.log) ( $+ %log.security $+ ) ( $+ %log.Sso $+ )
  }
}
Check.Serv.Log {
  if (%logging == 0.0.0) { return }
  if ($lines(c:\IRC\services\services.log) > 0) {
    %method %boss $read(c:\IRC\services\services.log, 1)
    write -dl1 c:\IRC\services\services.log
  }
  ;
  if (%log.query == $null) { set %log.query 1 }
  if (%log.qso == $null) { set %log.qso 0 }
  if ($lines(c:\dns\etc\namedb\query.log) < %log.query) { .msg #COS ISC BIND Query file has changed, running reset. | slc -r }
  if ($lines(c:\dns\etc\namedb\query.log) > %log.query) { set %log.qso 0 }
  if ($lines(c:\dns\etc\namedb\query.log) >= %log.query) && (%log.qso != 1) {
    if ($lines(c:\dns\etc\namedb\query.log) == %log.query) { set %log.qso 1 }
    if ($lines(c:\dns\etc\namedb\query.log) > %log.query) { inc %log.query | set %log.qso 0 }
    var %tmp.log = $read(c:\dns\etc\namedb\query.log, %log.query)
    ;if (%log.qso != 1) && (client 68.187.32.* !iswm %tmp.log) && (*IN PTR* !iswm %tmp.log) && (client 192.168.0.* !iswm %tmp.log) { %method %boss Query ( $+ %log.query $+ ) -- %tmp.log }
    if (%log.qso != 1) { %method %boss Query ( $+ %log.query $+ ) -- %tmp.log }
    ;if (*IN MX* iswm %tmp.log) { .msg #COS Incoming mail (MX) from $gettok($remove($gettok(%tmp.log,2,32),:),1,35) }
  }
  ;
  ;goto endit
  ;
  if (%log.security == $null) { set %log.security 1 }
  if (%log.sso == $null) { set %log.sso 0 }
  if ($lines(c:\dns\etc\namedb\security.log) < %log.security) { .msg #COS ISC BIND Security file has changed, running reset. | slc -r }
  if ($lines(c:\dns\etc\namedb\security.log) > %log.security) { set %log.sso 0 }
  if ($lines(c:\dns\etc\namedb\security.log) >= %log.security) && (%log.sso != 1) {
    if ($lines(c:\dns\etc\namedb\security.log) == %log.security) { set %log.sso 1 }
    if ($lines(c:\dns\etc\namedb\security.log) > %log.security) { inc %log.security | set %log.sso 0 }
    var %tmp.log = $read(c:\dns\etc\namedb\security.log, %log.security)
    ;if (%log.sso != 1) && (client 68.187.32.* !iswm %tmp.log) && (client 192.168.0.* !iswm %tmp.log) {
    if (%log.sso != 1)  {
      if ($gettok(%tmp.log,3,32) == update) || ($gettok(%tmp.log,3,32) == query) { %method %boss Security ( $+ %log.security $+ ) -- %tmp.log }
    }
  }
  :endit 
  return
}
/check.boss {
  notice %boss. [ $+ [ $network ] ] $report(Boss,$null,Checking/Repairing the Boss keys and settings.)
  ;if ($1 != $null) { set %boss. [ $+ [ $network ] ] $1 | notice %boss. [ $+ [ $network ] ] $report(Boss,$null,You better hope you're you.) }
  if (%boss. [ $+ [ $network ] ] == $null) { notice %boss. [ $+ [ $network ] ] $report(Check.Boss,Error,CB variable is null,Line 127 alias) | halt }
  notice %boss. [ $+ [ $network ] ] $report(Boss,Set,%boss. [ $+ [ $network ] ])
  ctcp %boss. [ $+ [ $network ] ] SSBOT %bot.key. [ $+ [ $network ] ]
  auser 5 $address(%boss. [ $+ [ $network ] ],4) %boss. [ $+ [ $network ] ]
  ;guser 5 $address(%boss. [ $+ [ $network ] ],4) %boss. [ $+ [ $network ] ]
  notice %boss. [ $+ [ $network ] ] $report(Boss,Adding User,level 5 $address(%boss. [ $+ [ $network ] ],4) %boss. [ $+ [ $network ] ])
  return
}
/fix.mode {
  mode $me +iowghrpaAsxNWHt
  mode $me +s +kcFfjvGenq
  mode $me
  return
}
/recover {
  if ($1 == OFF) {
    unset %recover. [ $+ [ $network ] ]
    .timerRECOV. $+ $network off
    $point $report(Nick Recover,Set,Off)
    return
  }
  if ($1 == $null) {
    if (%recover. [ $+ [ $network ] ] == $null) {
      $point $report(Nick Recover,Error,No Nick To Recover)
      $point $report(Nick Recover,$null,Include the nick to recover .recover <nick>)
      halt
    }
    ;set %recover. [ $+ [ $network ] ] %bot.nick.1. [ $+ [ $network ] ]
    .timerRECOV. $+ $network 0 15 assimilate %recover. [ $+ [ $network ] ]
    $point $report(Nick Recover,$null,On,Recovering Nickname,%recover. [ $+ [ $network ] ])
    assimilate %recover. [ $+ [ $network ] ]
    return
  }
  if ($1 != $null) { 
    set %recover. [ $+ [ $network ] ] $1
    .timerRECOV. $+ $network 0 15 assimilate %recover. [ $+ [ $network ] ]
    assimilate %recover. [ $+ [ $network ] ]
    return
  }
}
/assimilate {
  if (guest* iswm $me) { set %recover. [ $+ [ $network ] ] %bot.nick.1. [ $+ [ $network ] ] }
  if (%recover. [ $+ [ $network ] ] == $null) {
    if (timer(RECOV. [ $+ [ $network ] ] ) != $null) { .timerRECOV. $+ $network off }
    return
  } 
  if ($me == %recover. [ $+ [ $network ] ]) {
    $point $report(Auto Nick Recover,$null,Done,Recover Complete,%recover. [ $+ [ $network ] ])
    .timerRECOV. $+ $network off
    if ($me == %bot.nick.1. [ $+ [ $network ] ]) { nickserv identify %recover. [ $+ [ $network ] ] %bot.nick.1.pass. [ $+ [ $network ] ] }
    if ($me == %bot.nick.2. [ $+ [ $network ] ]) { nickserv identify %recover. [ $+ [ $network ] ] %bot.nick.2.pass. [ $+ [ $network ] ] }
    unset %recover. [ $+ [ $network ] ]
    mode $me
    recover off
    halt
  }
  if ($me != %recover. [ $+ [ $network ] ]) {
    if (%recover. [ $+ [ $network ] ] != $null) { nick %recover. [ $+ [ $network ] ] } 
    $point $report(Auto Nick Recover,$null,Attempting to Recover Nickname,%recover. [ $+ [ $network ] ])
    return
  }
}
/op.me {
  set %tmp.om2 $1
  set %tmp.om1 1
  while (%tmp.om1 <= $chan(0)) {
    mode $chan(%tmp.om1) +o %tmp.om2
    inc %tmp.om1
    if (%tmp.om1 > $chan(0)) { break }
  }
  unset %tmp.om1 %tmp.om2
}
/report1 {
  .msg $1 10 $+ $chr(91) $+ 00,01 $+ %report $+ 10 $+ $chr(93) $chr(91) $+ 11,01 $+ $2- $+  $+ 10 $+ $chr(93)
  return
}
/report {
  if ($1- == $null) { return No Text Sent to Report | return }
  else { var %tmp.rbuild = %tmp.rbuild 05 $+ $chr(124) }
  if ($1 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 15 $1 10 $+ $chr(93) $+ 05 $+ $chr(124) }
  if ($2 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 10 $2 10 $+ $chr(93) $+ 05 $+ $chr(124) }
  if ($3 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 14 $3 10 $+ $chr(93) $+ 05 $+ $chr(124) }
  if ($4 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 04 $4 10 $+ $chr(93) $+ 05 $+ $chr(124) }
  if ($5- != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 15 $5- 10 $+ $chr(93) $+ 05 $+ $chr(124) }
  if (%do.hex. [ $+ [ $network ] ] == ON) { var %tmp.rbuild =  $+ $hex.ini(%tmp.rbuild) }
  if ($prop == active) { return echo -at $sys %tmp.rbuild }
  if ($prop == status) { return echo -st $sys %tmp.rbuild }
  if ($prop == $null) { return %tmp.rbuild }
}
/do.var { set %tmp % $+ $1 | return %tmp }
/is.sock {
  if ($read -ns $1 $remove($mircdir,mbot\) $+ text\Socket.Nick.txt != $null) { return $true }
  else { return $false }
}
/do.aop {
  if ($1 isowner $chan($2)) { return }
  elseif ($1 isop $chan($2)) { return }
  mode $2 +ao $1 $1
  return
}
/do.aop {
  if ($1 isowner $chan($2)) { return }
  elseif ($1 isop $chan($2)) { return }
  mode $2 +o $1
  return
}
/do.hop {
  if ($1 isowner $chan($2)) { return }
  elseif ($1 isop $chan($2)) { return }
  mode $2 +h $1
  return
}
/take { mkall # }
info return StrangeServer
mybar { titlebar - $chr(91) Clone $mid($nopath($mircini),4,2) ] $chr(91) nick: $me $chr(93) $chr(91) lag: %Lag.mrc. [ $+ [ $network ] ] $chr(93) $chr(91) IRCX: %IRCX.mode. [ $+ [ $network ] ] $chr(93) $chr(91) $server $chr(93) }
/join { jn $1 $2 $3 $4 $5 $6- }
/jn {
  if ($2 != $null) { .raw join $1 $2- }
  if ($2 == $null) && (%owner. [ $+ [ $1 ] ] != $null) { .raw join $1 %owner. [ $+ [ $1 ] ] }
  else { .raw join $1 }
}
/jns { .raw join $replace($1-,$chr(32),$chr(160)) }
/set.auto.joinN {
  return
  set %tmp 1
  set %count 1
  :loop
  if (%count == 11) goto second.halfN
  if (%autojoin [ $+ [ %count ] ] != $null) {
    set %temp [ $+ [ %tmp ] ] %autojoin [ $+ [ %count ] ]
    inc %tmp
    inc %count
    goto loop
  }
  if (%autojoin [ $+ [ %count ] ] == $null) { inc %count | goto loop }
  echo -at 11 ERROR IN SET.AUTO.JOIN NORMAL
  halt
  :second.halfN
  set %autojoin1 %temp1 
  set %autojoin2 %temp2 
  set %autojoin3 %temp3 
  set %autojoin4 %temp4 
  set %autojoin5 %temp5 
  set %autojoin6 %temp6 
  set %autojoin7 %temp7 
  set %autojoin8 %temp8 
  set %autojoin9 %temp9 
  set %autojoin10 %temp10
  unset %tmp %temp* %count
}
/pound {
  if ($me ison %pound) { set %pound "" | set %pound.active OFF | .notice %boss. [ $+[ $network ] ] Pound Disabled, Entered Room | halt } 
  .timerPND 1 10 /pound
  .raw join %pound
}
/ssctcpflood {
  /inc %attempt
  if (%attempt > 2) {
    /ignore -ntu45 *!*@*
    .timerFloodOver 1 45 /set %attempt 0
    if (%attempt == 3) { 
      .notice %boss. [ $+[ $network ] ] 00 $+ CTCP 04 $+ Flood Protection has been 11 $+ ACTIVATED 04 $+ by 11 $+ $nick
      echo -st 00 $+ CTCP 04 $+ Flood Protection has been 11 $+ ACTIVATED 04 $+ by 11 $+ $nick
    }
    return
  }
  .timerFloodOver 1 15 /set %attempt 0
  return
}
/sstalkflood {
  /inc %attempt.talk
  if (%attempt.talk > 3) {
    /ignore -u30 *!*@*
    .timerFloodTalk 1 30 /set %attempt.talk 0
    return
  }
  .timerFloodTalk 1 10 /set %attempt.talk 0
  return
}
/mkall {
  var %mass2
  var %mass 0
  :incl
  if (%mass < $nick($1,0)) {
    inc %mass 1
    if ($nick($1,%mass) != $me) { set %mass2 %mass2 $+ , $+ $nick($1,%mass) }
    goto incl
  }
  .raw kick $1 %mass2
  unset %mass %mass1 %mass2
}
/auto.join {
  var %tmp.oo = 1
  while (%tmp.oo <= $numtok(%autojoin.rooms. [ $+ [ $network ] ],44)) {
    .raw join $gettok(%autojoin.rooms. [ $+ [ $network ] ],%tmp.oo,44) %owner. [ $+ [ $gettok(%autojoin.rooms. [ $+ [ $network ] ],%tmp.oo,44) ] ]
    inc %tmp.oo
    if (%tmp.oo > $numtok(%autojoin.rooms. [ $+ [ $network ] ],44)) { break }
  }
  return
}
/join.setup {
  beep
  set %connected. [ $+ [ $network ] ] $network
  set %connserv. [ $+ [ $network ] ] $server
  if (%boss. [ $+ [ $network ] ] != $me) { .ctcp %boss. [ $+ [ $network ] ] REG }
  .raw mode $me +i
  set %IRCX.mode. [ $+ [ $network ] ] OFF
  if ($network == IRCx) { ircx | set %IRCX.mode. [ $+ [ $network ] ] ON }
  if (%IRCX.mode. [ $+ [ $network ] ] == OFF) {
    if ($network == dalnet) {
      if ($me == %bot.nick.1. [ $+ [ $network ] ]) { nickserv identify %bot.nick.1. [ $+ [ $network ] ] %bot.nick.1.pass. [ $+ [ $network ] ] }
      if ($me == %bot.nick.2. [ $+ [ $network ] ]) { nickserv identify %bot.nick.2. [ $+ [ $network ] ] %bot.nick.2.pass. [ $+ [ $network ] ] }
    }
    else {
      if ($me == %bot.nick.1. [ $+ [ $network ] ]) { nickserv identify %bot.nick.1. [ $+ [ $network ] ] %bot.nick.1.pass. [ $+ [ $network ] ] }
      if ($me == %bot.nick.2. [ $+ [ $network ] ]) { nickserv identify %bot.nick.2. [ $+ [ $network ] ] %bot.nick.2.pass. [ $+ [ $network ] ] }
    }
  }
  if ($ial != $true) { .ial on }
  if (%display. [ $+ [ $network ] ] == $null) { set %display. [ $+ [ $network ] ] = CHAN }
  if (%autojoin.rooms. [ $+ [ $network ] ] == $null) { set %autojoin.rooms. [ $+ [ $network ] ] = #StrangeScript }
  if (%do.hex. [ $+ [ $network ] ] == $null) { set %do.hex. [ $+ [ $network ] ] OFF }
  set %count.note 0
  set %pound.active OFF
  if (%GetNick. [ $+ [ $network ] ] == ON) && ($me != %bot.nick.1. [ $+ [ $network  ] ]) { recover %bot.nick.1. [ $+ [ $network  ] ] } 
  set %spy OFF
  set %spy1 ""
  set %spy2 ""
  set %server.spy* ""
  if ($script(talker.mrc) != $null) { .unload -rs $mircdirtalker.mrc }
  if ($script(unmask.mrc) == $null) { .load -rs unmask.mrc }
  if ($script(script1.mrc) == $null) { .load -rs script1.mrc }
  reset
  if ($group(#DoCommand) == on) { .disable #DoCommand }
  .timerbar 0 1 mybar
  if (%Lag.mrc.secs. [ $+ [ $network ] ] == $null) { lagset 15 }
  if (%Lag.check. [ $+ [ $network ] ] == ON) { lagon }
  set %LM.editor OFF
  return
}
/tease {
  raw -q mode # +o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 
  halt
}
/rt {
  .timer 1 1 /remote.tease $1 $2
  .timer 1 2 /remote.tease $1 $2
  .timer 1 3 /remote.tease $1 $2
  .timer 1 4 /remote.tease $1 $2
}
/remote.tease {
  raw -q mode $1 +o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 
  halt
}
/fly { if ($chr(35) isin $1) { .raw join $1 $cr kick $1 :boom $cr part $1 } }
/cycleall {
  set %rumble OFF
  set %tmp.quit 1
  :qloop2
  If (%tmp.quit <= $chan(0)) { 
    .raw part $chan(%tmp.quit)
    .raw join $chan(%tmp.quit) %owner. [ $+ [ $chan(%tmp.quit) ] ]
    inc %tmp.quit 
    goto qloop2
  }
  unset %tmp.quit
}
/ReadSpy {
  var %temp.servspy = $findfile(%server.spy2,*.txt,1)
  if (%temp.servspy == $null) { return }
  if (%server.spy.type == BOSS) { .notice %boss. [ $+[ $network ] ] $read -n %temp.servspy }
  if (%server.spy.type != BOSS) { .msg %server.spy1 $read -n %temp.servspy }
  .remove %temp.servspy
}
reset {
  .disable #unmask
  .disable #unmask.right
}
deathip {
  set %temp.dip $gettok($address(%death.ip,2),2,64))
  set %temp.dip $remove(%temp.dip,$chr(33))
  ;set %temp.dip $remove(%temp.dip,$chr(64))
  set %temp.dip $remove(%temp.dip,$chr(42))
  return %temp.dip
}
/blast {
  set %tmp.blast 1
  .timerBLAST 1 1 /blastoff $1 $2
}
/blastoff {
  .msg $2 11 $+ $1 04 $+ is a $read -nl $+ %tmp.blast $mircdirtext\cusslist.txt
  inc %tmp.blast
  if (%tmp.blast > $lines($mircdirtext\cusslist.txt)) { unset %tmp.blast | halt }
  .timerBLAST 1 1 /blastoff $1 $2
}
/adjust {
  clearial
  if (%IRCX.mode. [ $+ [ $network ] ] == ON) {
    var %tmp.adjust = 1
    while (%tmp.adjust <= $chan(0)) {
      if ($me isop $chan(%tmp.adjust)) { var %tmp.store = $addtok(%tmp.store,$chan(%tmp.adjust),44) }
      inc %tmp.adjust
      if (%tmp.adjust > $chan(0)) { break }
    }
    if (%tmp.store != $null) {
      .who %tmp.store
    }
  }
  else {
    var %tmp.adjust = 1
    while (%tmp.adjust <= $chan(0)) {
      if ($me isop $chan(%tmp.adjust)) {
        var %tmp.store = $addtok(%tmp.store,$chan(%tmp.adjust),44)
        .who $chan(%tmp.adjust)
      }
      inc %tmp.adjust
      if (%tmp.adjust > $chan(0)) { break }
    }
  }
}
/addkey {
  ;var %tmp.addkey = $chr(91) $+ $rand(0,99999) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(0,99999) $+ $chr(93)
  ;if ($1 == $null) { set %owner. [ $+ [ # ] ] %tmp.addkey | .raw prop # ownerkey %tmp.addkey }
  ;if ($1 != $null) { set %owner. [ $+ [ $1 ] ] %tmp.addkey | .raw prop $1 ownerkey %tmp.addkey }
  return
}
/myaddress {
  if (Dal.net isin $server) { return $address($1,3) } 
  if (XXX isin $address($1,4)) { return $replace($address($1,2),XXX,*) }
  elseif (XX isin $address($1,4)) { return $replace($address($1,2),XX,*) }
  elseif (X isin $address($1,4)) { return $replace($address($1,2),X,*) }
  else { return $address($1,3) }
}
/myaddress2 {
  if (Dal.net isin $server) { return $address($1,4) } 
  if (XXX isin $address($1,4)) { return $replace($address($1,2),XXX,*) }
  elseif (XX isin $address($1,4)) { return $replace($address($1,2),XX,*) }
  elseif (X isin $address($1,4)) { return $replace($address($1,2),X,*) }
  else { return $address($1,4) }
}
/ssipsave {
  ;.msg %boss $report($1-)
  if (%current.server == COS) && (*server* iswm $address($1,4)) { return }
  var %tmp.x = $gettok($mircdir,1,92) $+ $chr(92) $+ $gettok($mircdir,2,92) $+ $chr(92) $+ text\IPTracker.txt
  var %tmp.xx = $gettok($mircdir,1,92) $+ $chr(92) $+ $gettok($mircdir,2,92) $+ $chr(92) $+ text\LastSeen.txt
  if ($exists(%tmp.x) == $false) { set %tmp $ip | .write -c %tmp.x $me *!*@ $+ $puttok($ip,$chr(42),4,46) }
  if ($exists(%tmp.xx) == $false) { set %tmp $ip | .write -c %tmp.xx $me $asctime(mmm dd yyyy) on %current.Server in #StrangeScript at $time }
  if (%ssipsave == OFF) { return }
  if ($4 == DNS) {
    var %temp1 = $1
    var %temp2 = $3
    goto DNS.back
  }
  if ($gettok($address($1,2),-1,46) isalpha) { set %awaiting.dns. [ $+ [ $address($1,2) ] ] $1 $+ , $+ $2 | dns $1 | halt }
  var %temp1 = $1
  var %temp2 = $myaddress2($1)
  :DNS.back
  var %temp3 = $read(%tmp.x,s,$1)
  if (%temp3 == $null) {
    echo -t $2 $sys $report(IPTracker,Not on file,SAVING,%temp1,%temp2)
    .write %tmp.xx %temp1 $asctime(mmm dd yyyy) on %current.Server in $2 at $time
    var %temp3 = $addtok(%temp3,%temp2,44)
    .write %tmp.x %temp1 %temp3
    return
  }
  var %tmp = $readn
  if ($istok(%temp3,%temp2,44) == $true) {
    echo -t $2 $sys $report(IPTracker,Already on file,SKIPPING,%temp1,%temp2)
    echo -t $2 $sys $report(LastSeen,$null,$null,$read(%tmp.xx,n,%tmp))
    if (%ssipsave.IP == ON) { echo -t $2 $sys $report(IPTracker,Used ips,$null,%temp3) }
    if (%ssipsave.IP == STATS) { echo -st $sys $report(IPTracker,Used ips,$null,%temp3) }
    .write -l $+ %tmp %tmp.xx %temp1 $asctime(mmm dd yyyy) on %current.Server in $2 at $time
    ;.write -l $+ %tmp %tmp.x %temp1 %temp3
    return
  }
  if ($istok(%temp3,%temp2,44) == $false) {
    echo -t $2 $sys $report(IPTracker,Already on file but new ip,UPDATING,%temp1,%temp2)
    echo -t $2 $sys $report(LastSeen,$null,$null,$read(%tmp.xx,n,%tmp))
    if (%ssipsave.IP == ON) { echo -t $2 $sys $report(IPTracker,Used ips,$null,%temp2,%temp3) }
    if (%ssipsave.IP == STATS) { echo -st $sys $report(IPTracker,Used ips,$null,%temp2,%temp3) }
    if ($len(%tmp3) < 435) { var %temp3 = $addtok(%temp3,%temp2,44) | goto skip }
    if ($len(%tmp3) => 435) { var %temp3 = $puttok(%temp3,%temp2,1,44) }
    :skip
    .write -l $+ %tmp %tmp.xx %temp1 $asctime(mmm dd yyyy) on %current.server in $2 at $time
    .write -l $+ %tmp %tmp.x %temp1 %temp3
    return
  }
}
timer.show {
  var %tmp.ts 1
  while (%tmp.ts <= $timer(0)) {
    $point $report(Timer) $+ $report(%tmp.ts) $+ $report($upper($timer(%tmp.ts)),$null,$null,Type:,$timer(%tmp.ts).type) $+ $report($null,$null,$null,Due:,$timer(%tmp.ts).secs) $+ $report($null,$null,$null,Command,$timer(%tmp.ts).com)
    inc %tmp.ts
    if (%tmp.ts > $timer(0)) { break }
  }
}
sl {
  if ($1 == $null) { .msg # No param given to reply to in SL call | return }
  else {
    if ($sock(*,0) == $null) || ($sock(*,0) == 0) { $showsl($1,%tmp.len,11 $+ $chr(44) $+ 10 There are no socks spying ) | return }
    var %tmp.sl = 1
    var %tmp.len = 1
    while (%tmp.sl <= $sock(*,0)) {
      set %tmp.sock. [ $+ [ %tmp.sl ] ] $sock(*,%tmp.sl) on %clone.server. [ $+ [ $sock(*,%tmp.sl) ] ] in $gettok(%server.spy.on. [ $+ [ $remove($sock(*,%tmp.sl),Spy) ] ] ,3,44) using nick $sock(*,%tmp.sl).mark
      if ($len(%tmp.sock. [ $+ [ %tmp.sl ] ] ) > %tmp.len) { var %tmp.len = $len(%tmp.sock. [ $+ [ %tmp.sl ] ] ) }
      inc %tmp.sl
      if (%tmp.sl > $sock(*,0)) { break }
    }
    $showsl($1,%tmp.len,11 $+ $chr(44) $+ 10 Generating Socks List )
    if (%tmp.sock.1 != $null) { $showsl($1,%tmp.len,%tmp.sock.1) }
    if (%tmp.sock.2 != $null) { $showsl($1,%tmp.len,%tmp.sock.2) }
    if (%tmp.sock.3 != $null) { $showsl($1,%tmp.len,%tmp.sock.3) }
    if (%tmp.sock.4 != $null) { $showsl($1,%tmp.len,%tmp.sock.4) }
    if (%tmp.sock.5 != $null) { $showsl($1,%tmp.len,%tmp.sock.5) }
    if (%tmp.sock.6 != $null) { $showsl($1,%tmp.len,%tmp.sock.6) }
    if (%tmp.sock.7 != $null) { $showsl($1,%tmp.len,%tmp.sock.7) }
    if (%tmp.sock.8 != $null) { $showsl($1,%tmp.len,%tmp.sock.8) }
    if (%tmp.sock.9 != $null) { $showsl($1,%tmp.len,%tmp.sock.9) }
    $showsl($1,%tmp.len,11 $+ $chr(44) $+ 10 There are $sock(*,0) socket(s) online )
    unset %tmp.sock.*
    return
  }
}
check.sl { if ($sock(Spy*,0) != $null) { sl } }
showsl {
  var %matha = $calc($len($3-) / 2)
  var %mathb = $calc($2 / 2)
  var %mathc = $calc(%mathb - %matha)
  msg $1 $str($chr(160),$calc(%mathc + 3 )) $+ $3-
  ; $+ $str($chr(160),$calc(%mathc + 3 )) $+ 
  return
}
LiveMenu {
  set %LM.editor ON
  set %LM.chan $1
  ;msg %LM.chan Setting menu channel... $+ %LM.chan
  set %LM.boss $2
  ;msg %LM.chan Setting menu owner... $+ %LM.boss
  if (%LM.file == $null) { set %LM.file $script(1) }
  LMenu
  return
}
LMenu {
  msg %LM.chan LiveMenu Options:
  msg %LM.chan Current File: %LM.file
  msg %LM.chan Lines: $lines(%LM.file)
  msg %LM.chan (E)dit line ### <newline>
  msg %LM.chan (F)ind a word
  msg %LM.chan (I)nformation about the file your editing
  msg %LM.chan (L)oad new .mrc into editor.
  msg %LM.chan (M)enu refresh
  msg %LM.chan (R)ehash/(R)reload the current file. ( $+ %LM.file.type $+ )
  msg %LM.chan (S)how line number ### or lines ###-###
  msg %LM.chan (Q)uit the editor.
  msg %LM.chan Use (<) and (>) to switch file types.
  return
}
MenuPicks {
  if ($strip($1) == Q) { msg %LM.chan Closing Editor | set %LM.editor OFF | halt }
  if ($strip($1) == R) {
    load %LM.file.type %LM.file
    msg %LM.chan File %LM.file reloaded into bot.
    halt
  }
  if ($strip($1) == M) { LMenu | halt }
  if ($strip($1) == E) {
    if ($2 == $null) { halt }
    if ($3 == $null) { halt }
    msg %LM.chan Old Line $2 $+ : $read(%LM.file,n,$2)
    write -l $+ $2 %LM.file $3-
    msg %LM.chan New Line $2 $+ : $read(%LM.file,n,$2)
    halt
  }
  if ($strip($1) == F) {
    if ($2 != $null) {
      var %tmp.R = * $+ $2 $+ *
      if ($3 isnum) { var %tmp.FW = $3 }
      else { var %tmp.FW = 0 }
      msg %LM.chan Searching for keyword " $+ $2 $+ "
      while (%tmp.FW <= $lines(%LM.file)) {
        var %tmp.waste = $read(%LM.file,nw,%tmp.R,%tmp.FW)
        if ($readn == 0) { break }
        msg %LM.chan keyword " $+ $2 $+ " found on line $readn
        var %tmp.FW = $calc($readn +1)
        while (%tmp.FW > $lines(%LM.file)) { break }
      }
      msg %LM.chan Search complete.
    }
    halt
  }
  if ($strip($1) == S) {
    if ($2 == $null) { halt }
    if ($chr(45) isin $2) {
      msg %LM.chan Multiple Line... line $gettok($2,1,45) through $gettok($2,2,45)
      var %LM.tmp = $gettok($2,1,45)
      var %LM.tmp1 = $gettok($2,2,45)
      while (%LM.tmp <= %LM.tmp1) {
        msg %LM.chan $read(%LM.file,n,%LM.tmp)
        INC %LM.tmp
        IF (%LM.tmp > %LM.tmp1) { BREAK }
      }
      halt
    }
    msg %LM.chan $read(%LM.file,n,$2)
    halt
  }
  if ($strip($1) == I) {
    msg %LM.chan You can edit $script(0) script and $alias(0) alias files.
    msg %LM.chan Current File: %LM.file
    msg %LM.chan Lines: $lines(%LM.file)
    halt
  }
  ;Current File: %LM.file
  if ($strip($1) == L) {
    msg %LM.chan Script files
    var %LM.tmp = 1
    while (%LM.tmp <= $script(0)) {
      set %LM.load. [ $+ [ %LM.tmp ] ]  $script(%LM.tmp)
      msg %LM.chan ( $+ %LM.tmp $+ ) $script(%LM.tmp)
      inc %LM.tmp
      if (%LM.tmp > $script(0)) { break }
    }
    msg %LM.chan Alias files
    var %LM.tmp1 = 1
    while (%LM.tmp1 <= $alias(0)) {
      set %LM.load. [ $+ [ %LM.tmp ] ]  $alias(%LM.tmp1)
      msg %LM.chan ( $+ %LM.tmp $+ ) $alias(%LM.tmp1)
      inc %LM.tmp
      inc %LM.tmp1
      if (%LM.tmp1 > $alias(0)) { break }
    }
    msg %LM.chan (Pick Number To Load)
    halt
  }
  if ($strip($1) isnum) {
    if (%LM.load. [ $+ [ $1 ] ] == $null) { halt }
    set %LM.file %LM.load. [ $+ [ $1 ] ]
    LMenu
    halt
  }
  if ($strip($1) == >) { set %LM.file.type -as | msg %LM.chan File type set to Alias | return }
  if ($strip($1) == <) { set %LM.file.type -rs | msg %LM.chan File type set to Script | return }
  return
}
/SSpy {
  if ($strip($2) == $null) { msg # Format: >server_indicator command_letter Params (for more help try ??) | halt }
  var %tmp.spy.serv = $upper($right($strip($1),-1))
  var %tmp.spy.com = $strip($2)
  if ($chr(35) isin $strip($3)) {
    var %tmp.spy.room = $strip($3)
    var %tmp.spy.param = $strip($4-)
  }
  else { var %tmp.spy.param = $strip($3-) }
  if (%tmp.spy.serv = x) var %tmp.spy.serv = xpeace
  if (%tmp.spy.serv = s) var %tmp.spy.serv = strange
  if (%tmp.spy.serv = i) var %tmp.spy.serv = icq
  if (%tmp.spy.serv = d) var %tmp.spy.serv = dalnet
  if (%tmp.spy.serv = c) var %tmp.spy.serv = chat
  if (%tmp.spy.serv = p) var %tmp.spy.serv = splog
  if (%tmp.spy.serv = j) var %tmp.spy.serv = jong
  if (%tmp.spy.serv = b) var %tmp.spy.serv = blaze
  if (%tmp.spy.serv = g) var %tmp.spy.serv = global
  ;ircx.blazin-irc.com
  if (%tmp.spy.serv = $chr(42)) { var %tmp.spy.serv = $chr(42) }
  if (%tmp.spy.com == A) {
    if ($nick == %boss) {
      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Action,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44))  %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ $chr(1) $+ ACTION %tmp.spy.param $+ $chr(1) }
      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Action,%tmp.spy.room) $chr(93)) %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $chr(1) $+ ACTION %tmp.spy.param $+ $chr(1) }
      return
    }
    else {
      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Action,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44)) ( $+ $nick $+ ) %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ $chr(1) $+ ACTION ( $+ $nick $+ ) %tmp.spy.param $+ $chr(1) }
      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Action,%tmp.spy.room) $chr(93)) ( $+ $nick $+ )  %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $chr(1) $+ ACTION ( $+ $nick $+ ) %tmp.spy.param $+ $chr(1) }
      return
    }
  }
  if (%tmp.spy.com == C) {
    if (%tmp.spy.room == $null) { msg # $report(Error,No Room Given to Cycle) | halt }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Cycle Room,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv part %tmp.spy.room $crlf join %tmp.spy.room }
    return
  }
  if (%tmp.spy.com == I) {
    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Whois,$3) | sockwrite -n Spy $+ %tmp.spy.serv whois $3 }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Whois,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv whois %tmp.spy.room }
    return
  }
  if (%tmp.spy.com == J) {
    if (%tmp.spy.room == $null) { msg # $report(Error,No Room Given to Join) | halt }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Joining room,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv join %tmp.spy.room }
    return
  }
  if (%tmp.spy.com == L) {
    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Geting Room List,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44)) | sockwrite -n Spy $+ %tmp.spy.serv names $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Geting Room List,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv names %tmp.spy.room }
    return
  }
  if (%tmp.spy.com == M) {
    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Mode,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44)) | sockwrite -n Spy $+ %tmp.spy.serv mode $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) %tmp.spy.param }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Mode,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv %tmp.spy.room %tmp.spy.param }
    return
  }
  if (%tmp.spy.com == P) {
    if (%tmp.spy.room == $null) { msg # $report(Error,No Room Given to Part) | halt }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Parting room,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv part %tmp.spy.room }
    return
  }
  if (%tmp.spy.com == R) {
    if (%tmp.spy.param == $null) { msg # $report(Error,Nothing to RAW Send) | halt }
    if (%tmp.spy.param != $null) { msg # $report(%tmp.spy.serv,Raw Send) | sockwrite -n Spy $+ %tmp.spy.serv %tmp.spy.param }
    return
  }
  if (%tmp.spy.com == S) {
    if ($nick == %boss) {
      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44),$nick)  $+ $3- | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ $3- | halt }
      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,%tmp.spy.room,$nick)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $4- | halt }
      return
    }
    else {
      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44),$nick)  $+ ( $+ $nick $+ )  $3- | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ ( $+ $nick $+ ) $3- | halt }
      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,%tmp.spy.room,$nick)  $+ ( $+ $nick $+ ) $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ ( $+ $nick $+ ) $4- | halt }
      return
    }
  }
  if (%tmp.spy.com == W) {
    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Whisper,$3)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg $3 : $+ $4- | halt }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Whisper,%tmp.spy.room)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $4- | halt }
    return
  }
  if (%tmp.spy.com == K) {
    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Kick,$3)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv Kick $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) $3 : $+ $4- | halt }
    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Kick,%tmp.spy.room)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv kick %tmp.spy.room $4 : $+ $5- | halt }
    return
  }
  if (%tmp.spy.com == G) {
    msg # $report(%tmp.spy.serv,Ping,%tmp.spy.param)
    sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.param : $+ $chr(1) $+ PING $ticks $+ $chr(1)
    return
  }
  if (%tmp.spy.com == D) {
    msg # $report(%tmp.spy.serv,Identifying)
    sockwrite -n Spy $+ %tmp.spy.serv privmsg nickserv :identify %server.spy.pass. [ $+ [ %tmp.spy.serv ] ]
    sockwrite -n Spy $+ %tmp.spy.serv nickserv identify %server.spy.pass. [ $+ [ %tmp.spy.serv ] ]
    return
  }
  if (%tmp.spy.com == N) {
    msg # $report(%tmp.spy.serv,Nick,%tmp.spy.param)
    sockwrite -n Spy $+ %tmp.spy.serv nick %tmp.spy.param
    return
  }
  if (%tmp.spy.com == F) {
    msg # The filter (ignore) option is not yet working.
    return
  }
  return
}
/SSpy.Help {
  .msg # $chr(91) ServerSpy Help Information. $chr(93)
  .msg # Format: >S O TEXT (S = Server letter, O = Option, TEXT = Command params)
  .msg # Valid Server letters are: s = strange, d = dal, r = rizon, l = libera.chat
  .msg # -
  .msg # Valid Options are: (A)-action (C)-cycle (I)-info(whois) (J)-join (L)-roomlist (D)-ident (N)-nick (F)-filter(ignore)
  .msg # Valid Options are: (M)-mode (P)-part (R)-raw (S)-say(privmsg) (W)-whipser (K)-kick (G)-ping
  .msg # $chr(91) Done. $chr(93)
  return
}
/Set.SS {
  if ($2 == r) { var %tmp.spy.serv = rizon }
  if ($2 == s) { var %tmp.spy.serv = strange }
  if ($2 == l) { var %tmp.spy.serv = libera.chat }
  if ($2 == d) { var %tmp.spy.serv = dalnet }
  .msg $1 Server Spy Setup for %tmp.spy.serv
  .msg $1 Server: %server.spy.server. [ $+ [ %tmp.spy.serv ] ]
  .msg $1 Server Nick: %server.spy.nick. [ $+ [ %tmp.spy.serv ] ]
  .msg $1 Server Port: %server.spy.port. [ $+ [ %tmp.spy.serv ] ]
  if (%server.spy.pass. [ $+ [ %tmp.spy.serv ] ] == $null) { .msg $1 Password: Not Set }
  else { .msg $1 Password: *hidden* (Set) | .notice %boss. [ $+[ $network ] ] Password: %server.spy.pass. [ $+ [ %tmp.spy.serv ] ] }
  return
}
/play.mod { if ($1 != $null) { .notice %boss. [ $+[ $network ] ] $replace($1-,$chr(9),$chr(160))  } }
/insta.aj {
  $point $report(Insta-AutoJoin,$null,$null,Creating your autojoin list)
  var %tmp.iaj = 1
  var %tmp.iaj1 = ""
  while (%tmp.iaj <= $chan(0)) {
    var %tmp.iaj1 = $addtok(%tmp.iaj1,$chan(%tmp.iaj),44)
    $point $report(Insta-AutoJoin,$null,Adding,$null,$chan(%tmp.iaj))
    inc %tmp.iaj
    if (%tmp.iaj > $chan(0)) { break }
  }
  set %autojoin.rooms. [ $+ [ $network ] ] %tmp.iaj1
  $point $report(Insta-AutoJoin,$null,Done,%tmp.iaj1)
  return
}
/partall {
  set %tmp.pa 1
  while (%tmp.pa <= $chan(0)) {
    if ($1- != $null) { .raw part $chan(%tmp.pa) : $+ $1- }
    else { .raw PART $chan(%tmp.pa) :Gotta go! }
    inc %tmp.pa
    if (%tmp.pa > $chan(0)) { break }
  }
  unset %tmp.pa
  return
}
