;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;(c) 2001-2023 Dana L. Meli-Wischman for StrangeScript and mIRC and AdiIrc;;;;;;;;;;;;;;;;;;;;;;;;;
;If you use this code I want my name in it or you're a cock sucking worthless fuck that shouldn't live past today.;
;
alias showoff {
  msg # I get to pick one of $findfile($songdir,*.*,0) Songs
}
alias mp3.prep {
  set %SMP.version SMP
  set %SMP.build 5.90
  set %SMP.title %SMP.version %SMP.build by Strange
  if (%SMP.crossfade == $null) { set %SMP.crossfade 0 }
  return
}
alias mp3 {
  mp3.prep
  if (%SMP.showinfo == $null) { set %SMP.showinfo ON }
  if ($1 == /?) || ($1 == /help) || ($1 == -h) || ($1 == -HELP) { echo -at $report(%SMP.title,$null,$null,Available commands are) $report($null,$null,$null,$null,/MP3) $report($null,$null,$null,$null,/MP3 INFO) $report($null,$null,$null,$null,/MP3 STOP) $report($null,$null,$null,$null,/MP3 RAND) $report($null,$null,$null,$null,/MP3 HELP) | halt }
  if ($1 == INFO) { InfoX.MP3 | halt }
  if ($1 == STOP) {
    splay -p stop
    .timerSMPsh off
    set %SMP.mode Spool
    set %mybar.temp ""
    set %SMP.lastdir ""
    if ($dialog(mp3p).x != $null) {
      did -o mp3p 5 1 Current Play: None
      did -o mp3p 4 1 Click here to pick one of $findfile($songdir,*.*,0) Songs
    }
    .timerCKEDIT 1 0 check.edit
    $report(%SMP.version %SMP.build,$null,%SMP.mode,Stopped).active
    halt
  }
  if ($1 == RAND) || ($1 == RANDOM) { mp3.random | splay seek $calc($inmp3.length - 50) | CurPlay | return }
  if ($dialog(mp3p).x != $null) { .dialog -erv mp3p mp3play }
  else { .dialog -mderv mp3p mp3play }
}
dialog mp3play {
  title " $+ %SMP.title $+ "
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
  while (%rtmp <= $var(%SMP.play*,0)) {
    did -o mp3p 3 %rtmp $nopath(%SMP.play [ $+ [ %rtmp ] ] )
    inc %rtmp
    if (%rtmp > $var(%SMP.play*,0)) { break }
  }
  did -o mp3p 3 1 $nopath(%SMP.play1)
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
    set %SMP.mode Spool
    set %mybar.temp ""
    set %SMP.lastdir ""
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
  MP3Title.send %SMP.title
  return
  ;
  if ($dialog(mp3p).x == $null) { return }
  set %SMP.tmp 1
  set %SMP.tmp1 35
  while (%SMP.tmp1 > 0) {
    .timerb $+ %SMP.tmp -m 1 $calc(50 * %SMP.tmp)  MP3Title.send $left(%SMP.title,%SMP.tmp1)
    dec %SMP.tmp1
    inc %SMP.tmp
    if (%SMP.tmp1 <= 0) { break }
  }
  set %SMP.tmp1 1
  while (%SMP.tmp1 <= $len(%SMP.title)) {
    .timera $+ %SMP.tmp -m 1 $calc(50 * %SMP.tmp) MP3Title.send $left(%SMP.title,%SMP.tmp1)
    inc %SMP.tmp
    inc %SMP.tmp1
    if (%SMP.tmp1 > $len(%SMP.title)) { break }
  }
  .timera $+ $calc(%SMP.tmp +1) -m 1 $calc(50 * %SMP.tmp) MP3Title.send %SMP.title
  unset %SMP.tmp*
  return
}
alias MP3Title.send { if ($dialog(mp3p).x != $null) { dialog -t mp3p $1- } }
alias CurPlay {
  if ($dialog(mp3p) != $null) {
    if ($inmp3 == $false) { did -o mp3p 5 1 Current Play: None }
    if ($len($inmp3.pos) == 4) { did -o mp3p 5 1 Current Play: $nopath(%SMP.current) $chr(91) $+ $round($calc($left($inmp3.pos,1) / 60),2) of $round($calc($left($inmp3.length,3) / 60),2) $+ $chr(93) }
    if ($len($inmp3.pos) == 5) { did -o mp3p 5 1 Current Play: $nopath(%SMP.current) $chr(91) $+ $round($calc($left($inmp3.pos,2) / 60),2) of $round($calc($left($inmp3.length,3) / 60),2) $+ $chr(93) }
    if ($len($inmp3.pos) => 6) { did -o mp3p 5 1 Current Play: $nopath(%SMP.current) $chr(91) $+ $round($calc($left($inmp3.pos,3) / 60),2) of $round($calc($left($inmp3.length,3) / 60),2) $+ $chr(93) }
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
  if ($inmp3.fname == %SMP.play1) { halt }
  if (%SMP.play1 == $null) { halt }
  if (%SMP.play1 !=== %SMP.edit) {
    .rename " $+ %SMP.play1 $+ " " $+ %SMP.edit $+ "
    set %SMP.play1 %SMP.edit
    if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%SMP.play1) }
  }
}
alias Pick.MP3 {
  ;dialog -x mp3p
  set %SMP.mode Spool
  set %SMP.XXX.ptmp %SMP.play1
  unset %SMP.play*
  did -r mp3p 3 1
  if (%SMP.lastdir != $null) { set %SMP.pick $msfile(%SMP.lastdir $+ *.*,You may choose multiple media files by holding control,Spool) }
  else { set %SMP.pick $msfile($songdir\*.*,You may choose multiple media files by holding control,Spool) }
  if (%SMP.pick == -1) { set %SMP.play1 Error to many songs selected | .timer 1 6 repair.mp3 %SMP.XXX.ptmp | mp3 }
  if (%SMP.pick == 0) {
    set %SMP.pick 1
    set %SMP.play1 %SMP.XXX.ptmp
    set %SMP.edit %SMP.play1
    if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%SMP.play1) }
    mp3
    halt
  }
  if (%SMP.pick > 0) {
    var %stmp = 1
    while (%stmp <= %SMP.pick) {
      if ($msfile(%stmp) != $null) { set %SMP.play [ $+ [ %stmp ] ] $msfile(%stmp) }
      if ($dialog(mp3p).x != $null) { did -o mp3p 3 %stmp $nopath(%SMP.play [ $+ [ %stmp ] ] ) }
      inc %stmp
      if (%stmp > %SMP.pick) { break }
    }
    did -o mp3p 3 1 $nopath(%SMP.play1)
    set %SMP.edit %SMP.play1
    set %SMP.lastdir $nofile(%SMP.play1)
    mp3
  }
}
alias repair.mp3 {
  set %SMP.pick 1
  set %SMP.play1 $1-
  if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%SMP.play1) }
}
alias Info.MP3 {
  if ($server != $null) {
    if (%SMP.mode == Random) {
      if (%SMP.showinfo == ON) { scid -a amsg $report(%SMP.version %SMP.build,%SMP.mode,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4))) }
      if (%SMP.showinfo == EXTRA) { scid -a amsg $report(%SMP.version %SMP.build,%SMP.mode,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4)),$null,$bytes($calc($file(%SMP.play1).size / 1024),m3) meg,-,$mp3(%SMP.play1).bitrate bit,-,$mp3(%SMP.play1).mode,-,$duration($left($mp3(%SMP.play1).length,3))) }
      if (%SMP.showinfo == LOCAL) { $report(%SMP.version %SMP.build,%SMP.mode,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4)),$null,$bytes($calc($file(%SMP.play1).size / 1024),m3) meg,-,$mp3(%SMP.play1).bitrate bit,-,$mp3(%SMP.play1).mode,-,$duration($left($mp3(%SMP.play1).length,3))).active }
      if (%SMP.showinfo == OFF) || (%SMP.showinfo == $null) { return }
    }
    else {
      if ($var(%SMP.play*,0) == 1) { var %MP.tmp = %SMP.mode }
      if ($var(%SMP.play*,0) > 1) { var %MP.tmp = %SMP.mode 1 of $var(%SMP.play*,0) }
      if (%SMP.showinfo == ON) { scid -a amsg $report(%SMP.version %SMP.build,%MP.tmp,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4))) }
      if (%SMP.showinfo == EXTRA) { scid -a amsg $report(%SMP.version %SMP.build,%MP.tmp,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4)),$null,$bytes($calc($file(%SMP.play1).size / 1024),m3) meg,-,$mp3(%SMP.play1).bitrate bit,-,$mp3(%SMP.play1).mode,-,$duration($left($mp3(%SMP.play1).length,3))) }
      if (%SMP.showinfo == LOCAL) { $report(%SMP.version %SMP.build,%MP.tmp,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4)),$null,$bytes($calc($file(%SMP.play1).size / 1024),m3) meg,-,$mp3(%SMP.play1).bitrate bit,-,$mp3(%SMP.play1).mode,-,$duration($left($mp3(%SMP.play1).length,3))).active }
      if (%SMP.showinfo == OFF) || (%SMP.showinfo == $null) { return }
    }
  }
  return
}
alias InfoX.MP3 {
  if ($server != $null) { amsg $report(%SMP.version %SMP.build,%SMP.mode,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4)),$null,$bytes($calc($file(%SMP.play1).size / 1024),m3) meg,-,$mp3(%SMP.play1).bitrate bit,-,$mp3(%SMP.play1).mode,-,$duration($left($mp3(%SMP.play1).length,3))) | return }
  else { $report(%SMP.version %SMP.build,%SMP.mode,$lower($right(%SMP.play1,3)),$nopath($left(%SMP.play1,-4)),$null,$bytes($calc($file(%SMP.play1).size / 1024),m3) meg,-,$mp3(%SMP.play1).bitrate bit,-,$mp3(%SMP.play1).mode,-,$duration($left($mp3(%SMP.play1).length,3))).active | return }
}
alias Send.MP3 {
  mp3.prep
  if ($chr(32) $+ $chr(32) isin %SMP.play1) || ($chr(160) $+ $chr(160) isin %SMP.play1) { $report(SMP,Error,$null,The file your trying to play has a double space in its name somewhere.).active | $report(SMP,Error,$null,mIRC can not play files in that shape as mirc strips the extra spaces.).active | $report(SMP,Error,$null,Try manually renaming by taking out all spaces,).active | $report(SMP,Error,$null,then putting 1 back in each place so the file will work in the player.).active | .timer 1 0 MP3 STOP | halt }
  set %tmp %SMP.play1
  set %SMP.current %SMP.play1
  if (*.mp3 iswm %SMP.play1) { splay -p " $+ %SMP.play1 $+ " }
  else { run " $+ %SMP.play1 $+ " | .timer 1 0 MP3 STOP }
  ;
  if ($dialog(mp3p).x != $null) { did -o mp3p 3 1 $nopath(%SMP.play1) }
  ;
  Info.MP3
  .timerSMPsh -mo 0 400 curPlay
  check.edit
  MP3Title
  halt
}
on *:dialog:mp3p:edit:*: { if ($did == 3) { set %SMP.edit $remove(%SMP.play1,$nopath(%SMP.play1)) $+ $did(3).text } }
on *:MP3END:{
  .timerSMPsh off
  mp3.prep
  if ($dialog(mp3p) != $null) { did -o mp3p 4 1 Click here to pick one of $findfile($songdir,*.mp3,0) Songs }
  if ($dialog(mp3p) != $null) { did -o mp3p 5 1 Current Play: None }
  set %mybar.temp ""
  if (%SMP.play1 != $null) && (%SMP.play1 == %SMP.current) {
    if ($var(%SMP.play*,0) > 1) {
      var %ptmp = 1
      while (%ptmp <= $var(%SMP.play*,0)) {
        set %SMP.play [ $+ [ %ptmp ] ] %SMP.play [ $+ [ $calc(%ptmp +1) ] ]
        unset %SMP.play [ $+ [ $calc(%ptmp +1) ] ]
        if ($dialog(mp3p).x != $null) {
          ;if (%SMP.play [ $+ [ %ptmp ] ] == 1) { did -o mp3p 3 }
          did -o mp3p 3 %ptmp $nopath(%SMP.play [ $+ [ %ptmp ] ] )
          did -d mp3p 3 $calc(%ptmp +1)
        }
        inc %ptmp
        if (%ptmp > $var(%SMP.play*,0)) { break }
      }
    }
  }
  if (%SMP.play1 != $null) && (%SMP.play1 != %SMP.current) { check.edit | Send.MP3 }
  check.edit
  if (%SMP.mode == Random) { mp3.random }
}
alias check.edit {
  if ($insong.fname == %SMP.play1) { if ($dialog(mp3p) != $null) { did -b mp3p 20 | did -b mp3p 18 } }
  else { if ($dialog(mp3p) != $null) { did -e mp3p 20 | did -e mp3p 18 } }
  return
}
alias mp3.random {
  if ($dialog(mp3p) != $null) { did -r mp3p 3 1 }
  set %SMP.mode Random
  set %SMP.play1 $findfile($songdir,*.mp3,$rand(1,$findfile($songdir,*.mp3,0,1)),1)
  set %SMP.edit %SMP.play1
  if ($dialog(mp3p) != $null) { did -o mp3p 3 1 $nopath(%SMP.play1) }
  check.edit
  if ($inmp3 == $true) { return }
  if ($inmp3 == $false) { Send.MP3 }
}
alias feed.line {
  set %SMP.feed.num $calc($round($inmp3.length,0) / 100)
  if ($dialog(mp3p) != $null) { did -o mp3p 4 1 $chr(91) $+ $str($chr(160),$calc(50 - $calc($round($inmp3.pos,0) / %SMP.feed.num / 2))) $+ $str($chr(145),$calc($round($inmp3.pos,0) / %SMP.feed.num / 2)) $+ ] $round($calc($round($inmp3.pos,0) / %SMP.feed.num),0) $+ % [ $+ $str($chr(145),$calc($round($inmp3.pos,0) / %SMP.feed.num / 2)) $+ $str($chr(160),$calc(50 - $calc($round($inmp3.pos,0) / %SMP.feed.num / 2))) $+ $chr(93) }
  set %mybar.temp $round($calc($round($inmp3.pos,0) / %SMP.feed.num),0) $+ %
  return
}
alias mp3.bump {
  if ($insong.fname == %SMP.play1) { return }
  did -r mp3p 3 1
  var %ptmp = 1
  while (%ptmp < $var(%SMP.play*,0)) {
    set %SMP.play [ $+ [ %ptmp ] ] %SMP.play [ $+ [ $calc(%ptmp +1) ] ]
    unset %SMP.play [ $+ [ $calc(%ptmp +1) ] ]
    if ($dialog(mp3p).x != $null) {
      did -o mp3p 3 %ptmp $nopath(%SMP.play [ $+ [ %ptmp ] ] )
      did -d mp3p 3 $calc(%ptmp +1)
    }
    inc %ptmp
    if (%ptmp == $var(%SMP.play*,0)) { break }
  }
  did -o mp3p 3 1 $nopath(%SMP.play1)
  set %SMP.edit %SMP.play1
}
