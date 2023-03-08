:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;:::;::::::::
;;;;;;;;;;;;(c) 2001-2023 Dana L. Meli-Wischman for StrangeScript and TranSend with mIRC and AdiIrc;;;;;;;;;;;;;;;
;If you use this code I want my name in it or you're a cock sucking worthless fuck that shouldn't live past today.;
:::::::::::::::::::::::::::::::::::::::::::::::::::Have a nice day.::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
alias showoff {
  msg # I get to pick one of $findfile($songdir,*.*,0) Songs
}
alias mp3.prep {
  set %Transend.version Transend Player
  set %Transend.build 6.00
  set %Transend.title %Transend.version %Transend.build by Dana M-W
  if (%Transend.crossfade == $null) { set %Transend.crossfade 0 }
  return
}
alias mp3 {
  mp3.prep
  if (%Transend.showinfo == $null) { set %Transend.showinfo ON }
  if ($1 == /?) || ($1 == /help) || ($1 == -h) || ($1 == -HELP) { echo -at $report(%Transend.title,$null,$null,Available commands are) $report($null,$null,$null,$null,/MP3) $report($null,$null,$null,$null,/MP3 INFO) $report($null,$null,$null,$null,/MP3 STOP) $report($null,$null,$null,$null,/MP3 RAND) $report($null,$null,$null,$null,/MP3 HELP) | halt }
  if ($1 == INFO) { InfoX.MP3 | halt }
  if ($1 == STOP) {
    splay -p stop
    .timerSMPsh off
    set %Transend.mode Spool
    set %mybar.temp ""
    set %Transend.lastdir ""
    if ($dialog(mp3p).x != $null) {
      did -o mp3p 5 1 Current Play: None
      did -o mp3p 4 1 Click here to pick one of $findfile($songdir,*.*,0) Songs
    }
    .timerCKEDIT 1 0 check.edit
    $report(%Transend.version %Transend.build,$null,%Transend.mode,Stopped).active
    halt
  }
  if ($1 == RAND) || ($1 == RANDOM) { mp3.random | splay seek $calc($inmp3.length - 50) | CurPlay | return }
  if ($dialog(mp3p).x != $null) { .dialog -erv mp3p mp3play }
  else { .dialog -mderv mp3p mp3play }
}
dialog mp3play {
  title " $+ %Transend.title $+ "
  icon StrangeScript.ani
  size -1 -1 210 100
  option dbu
  button "Exit", 1, 180 76 20 10, ok
  edit "", 3, 10 15 160 10, multi, vsbar
  ;list 3, 10 15 160 10, size, vsbar
  button "Click here to pick one of 0 Songs", 4, 10 25 190 10,
  text "Current Play: None", 5, 10 5 190 10
  button "Play", 6, 10 40 20 10,
  button "Stop", 9, 30 40 20 10,
  button "Pause", 7, 50 40 20 10,
  button "Resume", 8, 70 40 30 10,
  button "|<", 24, 110 40 10 10,
  button "<<<<", 21, 120 40 20 10,
  button ">>>>", 22, 140 40 20 10,
  button ">|", 25, 160 40 10 10,
  text "", 10, 10 53 165 9
  button "Up", 11, 43 62 33 10,
  button "Down", 12, 10 62 33 10,
  button "Mute", 13, 76 62 33 10,
  text "", 14, 10 75 165 9
  button "Up", 15, 43 84 33 10,
  button "Down", 16, 10 84 33 10,
  button "Mute", 23, 76 84 33 10,
  button "Rand", 17, 180 40 20 10,
  button "Bump", 18, 180 52 20 10,
  button "All", 19, 180 64 20 10,
  button "Rename", 20, 170 15 30 10
}
on *:dialog:mp3p:init:0: {
  var %rtmp = 1
  while (%rtmp <= $var(%Transend.play*,0)) {
    did -o mp3p 3 %rtmp $nopath(%Transend.play [ $+ [ %rtmp ] ] )
    inc %rtmp
    if (%rtmp > $var(%Transend.play*,0)) { break }
  }
  did -o mp3p 3 1 $nopath(%Transend.play1)
  check.edit
  did -f mp3p 3 1
  did -b mp3p 19
  did -b mp3p 8
  did -o mp3p 5 1 Current Play: None
  did -o mp3p 10 1 $str($chr(146),$round($calc($vol(master) / 65535 * 100),0))
  did -o mp3p 4 1 Click here to pick one of $findfile($songdir,*.mp3,0) Songs
  if ($vol(master).mute == $true) { vol -vu1 | did -o mp3p 10 1 Muted }
  if ($vol(master).mute == $false) { vol -vu2 | did -o mp3p 10 1 $str($chr(146),$round($calc($vol(master) / 65535 * 100),0)) $round($calc($vol(master) / 65535 * 100),0) $+ % }
  if ($vol(wave).mute == $true) { vol -wu1 | did -o mp3p 14 1 Muted }
  if ($vol(wave).mute == $false) { vol -wu2 | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wave) / 65535 * 100),0) $+ % }
  .timerCKEDIT 1 0 check.edit
  MP3Title
}
;on *:dialog:mp3p:*:*: {
;echo -st $dname $devent $did
;if ($did == 14) { vol -w $calc($vol(wave) +3000) | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wav) / 65535 * 100),0) $+ % }
;f ($did == 16) { vol -w $calc($vol(wave) -3000) | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wav) / 65535 * 100),0) $+ % }
;}
;on *:dialog:mp3p:*:*: {
;
;  if ($devent != mouse) { echo -at Event triggered $dname $devent $did }
;
;}
on *:dialog:mp3p:sclick:*: {
  if ($did == 4) { .timer 1 0 Pick.MP3 }
  if ($did == 6) { Send.MP3 }
  if ($did == 7) { splay pause | did -b mp3p 7 | did -e mp3p 8 }
  if ($did == 8) { splay resume | did -b mp3p 8 | did -e mp3p 7 }
  if ($did == 9) {
    splay -p stop
    .timerSMPsh off
    set %Transend.mode Spool
    set %mybar.temp ""
    set %Transend.lastdir ""
    did -o mp3p 5 1 Current Play: None
    did -ot mp3p 4 1 Click here to pick one of $findfile($songdir,*.mp3,0) Songs
    .timerCKEDIT 1 0 check.edit
  }
  if ($did == 11) { vol -v $calc($vol(master) +1000) | did -o mp3p 10 1 $str($chr(146),$round($calc($vol(master) / 65535 * 100),0)) $round($calc($vol(master) / 65535 * 100),0) $+ % }
  if ($did == 12) { vol -v $calc($vol(master) -1000) | did -o mp3p 10 1 $str($chr(146),$round($calc($vol(master) / 65535 * 100),0)) $round($calc($vol(master) / 65535 * 100),0) $+ % }
  if ($did == 13) {
    if ($vol(master).mute == $true) { did -o mp3p 13 1 Mute | vol -vu2 | did -o mp3p 10 1 $str($chr(146),$round($calc($vol(master) / 65535 * 100),0)) $round($calc($vol(master) / 65535 * 100),0) $+ % }
    else { vol -vu1 | did -o mp3p 10 1 Muted | did -o mp3p 13 1 UnMute }
  }
  if ($did == 15) { vol -w $calc($vol(wave) +1000) | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wav) / 65535 * 100),0) $+ % }
  if ($did == 16) { vol -w $calc($vol(wave) -1000) | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wav) / 65535 * 100),0) $+ % }
  if ($did == 23) {
    if ($vol(wave).mute == $true) { did -o mp3p 23 1 Mute | vol -wu2 | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wav) / 65535 * 100),0) $+ % }
    else { vol -wu1 | did -o mp3p 14 1 Muted | did -o mp3p 23 1 UnMute }
  }
  if ($did == 17) { mp3.random }
  if ($did == 18) { mp3.bump }
  if ($did == 20) { Rename.MP3 }
  if ($did == 21) { if ($inmp3 == $true) { splay seek $calc($inmp3.pos - 2000) | CurPlay | return } }
  if ($did == 22) { if ($inmp3 == $true) { splay seek $calc($inmp3.pos + 2000) | CurPlay | return } }
  if ($did == 24) { if ($inmp3 == $true) { splay seek 0 | CurPlay | return } }
  if ($did == 25) { if ($inmp3 == $true) { splay seek $calc($inmp3.length - 50) | CurPlay | return } }
}
alias MP3Title {
  ;
  MP3Title.send %Transend.title
  return
  ;
  if ($dialog(mp3p).x == $null) { return }
  set %Transend.tmp 1
  set %Transend.tmp1 35
  while (%Transend.tmp1 > 0) {
    .timerb $+ %Transend.tmp -m 1 $calc(50 * %Transend.tmp)  MP3Title.send $left(%Transend.title,%Transend.tmp1)
    dec %Transend.tmp1
    inc %Transend.tmp
    if (%Transend.tmp1 <= 0) { break }
  }
  set %Transend.tmp1 1
  while (%Transend.tmp1 <= $len(%Transend.title)) {
    .timera $+ %Transend.tmp -m 1 $calc(50 * %Transend.tmp) MP3Title.send $left(%Transend.title,%Transend.tmp1)
    inc %Transend.tmp
    inc %Transend.tmp1
    if (%Transend.tmp1 > $len(%Transend.title)) { break }
  }
  .timera $+ $calc(%Transend.tmp +1) -m 1 $calc(50 * %Transend.tmp) MP3Title.send %Transend.title
  unset %Transend.tmp*
  return
}
alias MP3Title.send { if ($dialog(mp3p).x != $null) { dialog -t mp3p $1- } }
alias CurPlay {
  if ($dialog(mp3p) != $null) {
    if ( $inmp3 == $false) { did -o mp3p 5 1 Current Play: None }
    if ( $len($inmp3.pos) == 4 ) { did -o mp3p 5 1 Current Play: $nopath(%Transend.current) $chr(91) $+ $round($calc($left($inmp3.pos,1) / 60),2) of $round($calc($left($inmp3.length,3) / 60),2) $+ $chr(93) }
    if ( $len($inmp3.pos) == 5 ) { did -o mp3p 5 1 Current Play: $nopath(%Transend.current) $chr(91) $+ $round($calc($left($inmp3.pos,2) / 60),2) of $round($calc($left($inmp3.length,3) / 60),2) $+ $chr(93) }
    if ( $len($inmp3.pos) >= 6 ) { did -o mp3p 5 1 Current Play: $nopath(%Transend.current) $chr(91) $+ $round($calc($left($inmp3.pos,3) / 60),2) of $round($calc($left($inmp3.length,3) / 60),2) $+ $chr(93) }
    ;added
    if ($vol(master).mute == $true) { vol -vu1 | did -o mp3p 10 1 Muted }
    if ($vol(master).mute == $false) { vol -vu2 | did -o mp3p 10 1 $str($chr(146),$round($calc($vol(master) / 65535 * 100),0)) $round($calc($vol(master) / 65535 * 100),0) $+ % }
    if ($vol(wave).mute == $true) { vol -wu1 | did -o mp3p 14 1 Muted }
    if ($vol(wave).mute == $false) { vol -wu2 | did -o mp3p 14 1 $str($chr(146),$round($calc($vol(wave) / 65535 * 100),0)) $round($calc($vol(wave) / 65535 * 100),0) $+ % }
    ;
  }
  feed.line
  return
}
alias Rename.MP3 {
  if ($inmp3.fname == %Transend.play1) { halt }
  if (%Transend.play1 == $null) { halt }
  if (%Transend.play1 !=== %Transend.edit) {
    .rename " $+ %Transend.play1 $+ " " $+ %Transend.edit $+ "
    set %Transend.play1 %Transend.edit
    if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%Transend.play1) }
  }
}
alias Pick.MP3 {
  ;dialog -x mp3p
  set %Transend.mode Spool
  set %Transend.XXX.ptmp %Transend.play1
  unset %Transend.play*
  did -r mp3p 3 1
  if (%Transend.lastdir != $null) { set %Transend.pick $msfile(%Transend.lastdir $+ *.*,You may choose multiple media files by holding control,Spool) }
  else { set %Transend.pick $msfile($songdir $+ \*.*,You may choose multiple media files by holding control,Spool) }
  if (%Transend.pick == -1) { set %Transend.play1 Error to many songs selected | .timer 1 6 repair.mp3 %Transend.XXX.ptmp | mp3 }
  if (%Transend.pick == 0) {
    set %Transend.pick 1
    set %Transend.play1 %Transend.XXX.ptmp
    set %Transend.edit %Transend.play1
    if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%Transend.play1) }
    mp3
    halt
  }
  if (%Transend.pick > 0) {
    var %stmp = 1
    while (%stmp <= %Transend.pick) {
      if ($msfile(%stmp) != $null) { set %Transend.play [ $+ [ %stmp ] ] $msfile(%stmp) }
      if ($dialog(mp3p).x != $null) { did -o mp3p 3 %stmp $nopath(%Transend.play [ $+ [ %stmp ] ] ) }
      inc %stmp
      if (%stmp > %Transend.pick) { break }
    }
    did -o mp3p 3 1 $nopath(%Transend.play1)
    set %Transend.edit %Transend.play1
    set %Transend.lastdir $nofile(%Transend.play1)
    mp3
  }
}
alias repair.mp3 {
  set %Transend.pick 1
  set %Transend.play1 $1-
  if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%Transend.play1) }
}
alias Info.MP3 {
  if ($server != $null) {
    if (%Transend.mode == Random) {
      if (%Transend.showinfo == ON) { scid -a amsg $report(%Transend.version %Transend.build,%Transend.mode,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4))) }
      if (%Transend.showinfo == EXTRA) { scid -a amsg $report(%Transend.version %Transend.build,%Transend.mode,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4)),$null,$bytes($calc($file(%Transend.play1).size / 1024),m3) meg,-,$mp3(%Transend.play1).bitrate bit,-,$mp3(%Transend.play1).mode,-,$duration($left($mp3(%Transend.play1).length,3))) }
      if (%Transend.showinfo == LOCAL) { $report(%Transend.version %Transend.build,%Transend.mode,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4)),$null,$bytes($calc($file(%Transend.play1).size / 1024),m3) meg,-,$mp3(%Transend.play1).bitrate bit,-,$mp3(%Transend.play1).mode,-,$duration($left($mp3(%Transend.play1).length,3))).active }
      if (%Transend.showinfo == OFF) || (%Transend.showinfo == $null) { return }
    }
    else {
      if ($var(%Transend.play*,0) == 1) { var %MP.tmp = %Transend.mode }
      if ($var(%Transend.play*,0) > 1) { var %MP.tmp = %Transend.mode 1 of $var(%Transend.play*,0) }
      if (%Transend.showinfo == ON) { scid -a amsg $report(%Transend.version %Transend.build,%MP.tmp,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4))) }
      if (%Transend.showinfo == EXTRA) { scid -a amsg $report(%Transend.version %Transend.build,%MP.tmp,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4)),$null,$bytes($calc($file(%Transend.play1).size / 1024),m3) meg,-,$mp3(%Transend.play1).bitrate bit,-,$mp3(%Transend.play1).mode,-,$duration($left($mp3(%Transend.play1).length,3))) }
      if (%Transend.showinfo == LOCAL) { $report(%Transend.version %Transend.build,%MP.tmp,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4)),$null,$bytes($calc($file(%Transend.play1).size / 1024),m3) meg,-,$mp3(%Transend.play1).bitrate bit,-,$mp3(%Transend.play1).mode,-,$duration($left($mp3(%Transend.play1).length,3))).active }
      if (/mp == OFF) || (%Transend.showinfo == $null) { return }
    }
  }
  return
}
alias InfoX.MP3 {
  if ($server != $null) { amsg $report(%Transend.version %Transend.build,%Transend.mode,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4)),$null,$bytes($calc($file(%Transend.play1).size / 1024),m3) meg,-,$mp3(%Transend.play1).bitrate bit,-,$mp3(%Transend.play1).mode,-,$duration($left($mp3(%Transend.play1).length,3))) | return }
  else { $report(%Transend.version %Transend.build,%Transend.mode,$lower($right(%Transend.play1,3)),$nopath($left(%Transend.play1,-4)),$null,$bytes($calc($file(%Transend.play1).size / 1024),m3) meg,-,$mp3(%Transend.play1).bitrate bit,-,$mp3(%Transend.play1).mode,-,$duration($left($mp3(%Transend.play1).length,3))).active | return }
}
alias Send.MP3 {
  mp3.prep
  if ($chr(32) $+ $chr(32) isin %Transend.play1) || ($chr(160) $+ $chr(160) isin %Transend.play1) { $report(SMP,Error,$null,The file your trying to play has a double space in its name somewhere.).active | $report(SMP,Error,$null,mIRC can not play files in that shape as mirc strips the extra spaces.).active | $report(SMP,Error,$null,Try manually renaming by taking out all spaces,).active | $report(SMP,Error,$null,then putting 1 back in each place so the file will work in the player.).active | .timer 1 0 MP3 STOP | halt }
  set %tmp %Transend.play1
  set %Transend.current %Transend.play1
  if (*.mp3 iswm %Transend.play1) { splay -p " $+ %Transend.play1 $+ " }
  else { run " $+ %Transend.play1 $+ " | .timer 1 0 MP3 STOP }
  ;
  if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%Transend.play1) }
  ;
  Info.MP3
  .timerSMPsh -mo 0 400 curPlay
  check.edit
  MP3Title
  halt
}
on *:dialog:mp3p:edit:*: { if ($did == 3) { set %Transend.edit $remove(%Transend.play1,$nopath(%Transend.play1)) $+ $did(3).text } }
on *:MP3END:{
  .timerSMPsh off
  mp3.prep
  if ($dialog(mp3p) != $null) { did -o mp3p 4 1 Click here to pick one of $findfile($songdir,*.mp3,0) Songs }
  if ($dialog(mp3p) != $null) { did -o mp3p 5 1 Current Play: None }
  set %mybar.temp ""
  if (%Transend.play1 != $null) && (%Transend.play1 == %Transend.current) {
    if ($var(%Transend.play*,0) > 1) {
      var %ptmp = 1
      while (%ptmp <= $var(%Transend.play*,0)) {
        set %Transend.play [ $+ [ %ptmp ] ] %Transend.play [ $+ [ $calc(%ptmp +1) ] ]
        unset %Transend.play [ $+ [ $calc(%ptmp +1) ] ]
        if ($dialog(mp3p).x != $null) {
          ;if (%Transend.play [ $+ [ %ptmp ] ] == 1) { did -o mp3p 3 }
          did -o mp3p 3 %ptmp $nopath(%Transend.play [ $+ [ %ptmp ] ] )
          did -d mp3p 3 $calc(%ptmp +1)
        }
        inc %ptmp
        if (%ptmp > $var(%Transend.play*,0)) { break }
      }
    }
  }
  if (%Transend.play1 != $null) && (%Transend.play1 != %Transend.current) { check.edit | Send.MP3 }
  check.edit
  if (%Transend.mode == Random) { mp3.random }
}
alias check.edit {
  if ($insong.fname == %Transend.play1) { if ($dialog(mp3p) != $null) { did -b mp3p 20 | did -b mp3p 18 } }
  else { if ($dialog(mp3p) != $null) { did -e mp3p 20 | did -e mp3p 18 } }
  return
}
alias mp3.random {
  if ($dialog(mp3p) != $null) { did -r mp3p 3 1 }
  set %Transend.mode Random
  set %Transend.play1 $findfile($songdir,*.mp3,$rand(1,$findfile($songdir,*.mp3,0,1)),1)
  set %Transend.edit %Transend.play1
  if ($dialog(mp3p) != $null) { did -o mp3p 3 1 $nopath(%Transend.play1) }
  check.edit
  if ($inmp3 == $true) { return }
  if ($inmp3 == $false) { Send.MP3 }
}
alias feed.line {
  set %Transend.feed.num $calc($round($inmp3.length,0) / 100)
  if ($dialog(mp3p) != $null) { did -o mp3p 4 1 $chr(91) $+ $str($chr(160),$calc(50 - $calc($round($inmp3.pos,0) / %Transend.feed.num / 2))) $+ $str($chr(145),$calc($round($inmp3.pos,0) / %Transend.feed.num / 2)) $+ ] $round($calc($round($inmp3.pos,0) / %Transend.feed.num),0) $+ % [ $+ $str($chr(145),$calc($round($inmp3.pos,0) / %Transend.feed.num / 2)) $+ $str($chr(160),$calc(50 - $calc($round($inmp3.pos,0) / %Transend.feed.num / 2))) $+ $chr(93) }
  set %mybar.temp $round($calc($round($inmp3.pos,0) / %Transend.feed.num),0) $+ %
  return
}
alias mp3.bump {
  if ($insong.fname == %Transend.play1) { return }
  did -r mp3p 3 1
  var %ptmp = 1
  while (%ptmp < $var(%Transend.play*,0)) {
    set %Transend.play [ $+ [ %ptmp ] ] %Transend.play [ $+ [ $calc(%ptmp +1) ] ]
    unset %Transend.play [ $+ [ $calc(%ptmp +1) ] ]
    if ($dialog(mp3p).x != $null) {
      did -o mp3p 3 %ptmp $nopath(%Transend.play [ $+ [ %ptmp ] ] )
      did -d mp3p 3 $calc(%ptmp +1)
    }
    inc %ptmp
    if (%ptmp == $var(%Transend.play*,0)) { break }
  }
  did -o mp3p 3 1 $nopath(%Transend.play1)
  set %Transend.edit %Transend.play1
}
