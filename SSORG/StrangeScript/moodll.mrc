; moo.dll
; Procedures which make use of the dll follow, defined as aliases
; 
; [aliases]
; System Statistics
; 
; ::NOTE: should you wish, you can easily prevent the rambar from appearing by changing the line 
; "set %rb_size 10" to "set %rb_size 0"
;

;on 1:TEXT:*!nitrans*:#:/msg $chan 2Network Interfaces[ $+ $dll(moo.dll,interfaceinfo,_) $+ ]

alias moodll.error {
  echo 2moo.dll error[ $+ $1- $+ ]
}

alias moodll.getcmd {
  set %moodll.cmd $1-
  if (%moodll.cmd == $null) { set %moodll.cmd say }
}

alias gfx {
  moodll.getcmd $1-
  if ($dll(moo.dll,gfxinfo,_) == -1) {
    moodll.error Could not find GFX card info in registry
  }
  else {
    %moodll.cmd 2gfx[ $+ $dll(moo.dll,gfxinfo,_) $+ ]
  }
}

alias mbm {
  moodll.getcmd $1-
  if ($gettok($dll(moo.dll,mbm5info,1),1,44) == error) {
    moodll.error $gettok($dll(moo.dll,mbm5info,1),2,44)
  }
  else {
    getmbm5info
    %moodll.cmd 2mbm5info[ $+ $result $+ ]
  }
}

alias ni {
  moodll.getcmd $1-
  %moodll.cmd 2Network Interfaces[ $+ $dll(moo.dll,interfaceinfo,_) $+ ]
}

alias stat {
  moodll.getcmd $1-
  set %rb_size 10
  rambar
  %moodll.cmd 2os[ $+ $dll(moo.dll,osinfo,_) $+ ] 2uptime[ $+ $dll(moo.dll,uptime,_) $+ ] 2cpu[ $+ $dll(moo.dll,cpuinfo,_) $+ ] 2mem[ $+ $dll(moo.dll,meminfo,_) $+ $result $+ ]
}
; To use OLD CPU Speed calculation for previous alias, change "$dll(moo.dll,cpuinfo,_)" to "$dll(moo.dll,cpuinfo,old)"

alias connstat {
  moodll.getcmd $1-
  if ($dll(moo.dll,connection,_) == -1) {
    moodll.error Could not get RAS info on this OS
  }
  else {
    %moodll.cmd 2dialup[ $+ $dll(moo.dll,connection,_) $+ ]
  }
}

alias screenstat {
  moodll.getcmd $1-
  %moodll.cmd 2screen[ $+ $dll(moo.dll,screeninfo,_) $+ ] 
}

alias uptime {
  moodll.getcmd $1-
  %moodll.cmd 2uptime[ $+ $dll(moo.dll,osinfo,_) uptime - $dll(moo.dll,uptime,_) $+ ] 
}

alias rambar {
  if ( %rb_size == 0 ) { return }
  set %rb_used $round($calc($dll(moo.dll,rambar,_) / 100 * %rb_size),0)
  set %rb_unused $round($calc(%rb_size - %rb_used),0)
  set %rb_usedstr $str(|,%rb_used)
  set %rb_unusedstr $str(-,%rb_unused)
  return  [ $+ %rb_usedstr $+ %rb_unusedstr $+ ]
}

alias getmbm5info {

  set %mbm5_info_temps $dll(moo.dll,mbm5info,1)
  set %mbm5_info_voltages $dll(moo.dll,mbm5info,2)
  set %mbm5_info_fans $dll(moo.dll,mbm5info,3)
  set %mbm5_info_cpuspeed $dll(moo.dll,mbm5info,4)
  set %mbm5_info_cpuusage $dll(moo.dll,mbm5info,5)
  
  set %mbm5_cpus $calc($numtok(%mbm5_info_cpuspeed,44) / 2)
  set %mbm5_cpuspeed $gettok(%mbm5_info_cpuspeed,2,44)

  ; cpu
  if ( %mbm5_cpus == 1 ) {
    set %mbm5_output %mbm5_cpuspeed $+ MHz CPU
  }
  else {
    set %mbm5_output %mbm5_cpus CPUs @ %mbm5_cpuspeed $+ MHz
  }

  ; temps  
  set %reps 1
  while (%reps <= $calc($numtok(%mbm5_info_temps,44)/2)) {
    if ( $gettok(%mbm5_info_temps,$calc((%reps * 2)),44) == 0 || $gettok(%mbm5_info_temps,$calc((%reps * 2)),44) == 255 ) {
      ; do nothing
    }
    else {
      set %mbm5_output %mbm5_output $+ , $gettok(%mbm5_info_temps,$calc((%reps * 2) - 1),44) $gettok(%mbm5_info_temps,$calc((%reps * 2)),44) $+ °C
    }
    inc %reps
  }
  
  ; fans  
  set %reps 1
  while (%reps <= $calc($numtok(%mbm5_info_fans,44)/2)) {
    if ( $gettok(%mbm5_info_fans,$calc((%reps * 2)),44) == 0 || $gettok(%mbm5_info_fans,$calc((%reps * 2)),44) == 255 ) {
      ; do nothing
    }
    else {
      set %mbm5_output %mbm5_output $+ , $gettok(%mbm5_info_fans,$calc((%reps * 2) - 1),44) $gettok(%mbm5_info_fans,$calc((%reps * 2)),44) $+ RPM
    }
    inc %reps
  }  
  
  ; voltages
  set %reps 1
  while (%reps <= $calc($numtok(%mbm5_info_voltages,44)/2)) {
    if ( $gettok(%mbm5_info_voltages,$calc((%reps * 2)),44) == 0 || $gettok(%mbm5_info_voltages,$calc((%reps * 2)),44) == 255 ) {
      ; do nothing
    }
    else {
      set %mbm5_output %mbm5_output $+ , $gettok(%mbm5_info_voltages,$calc((%reps * 2) - 1),44) $gettok(%mbm5_info_voltages,$calc((%reps * 2)),44) $+ v
    }
    inc %reps
  }  

  return %mbm5_output

}
