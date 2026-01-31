==================================================
; Weather script for StrangeScript
; Code by d3t0x for recess. v 0.1.4
; ==================================================
alias .wz {
  if (!$1) {
    msg $chan 10[12 Help 10][14 Format: .wz <city> 10]
    return
  }

  sockclose wttr
  set %wt.room $chan
  set %wt.city $replace($1-,$chr(32),+)

  msg %wt.room 10[12 Weather 10][14 Please wait while I retrieve the weather... 10]
  sockopen wttr wttr.in 80
}

on *:sockopen:wttr:{
  if ($sockerr) {
    msg %wt.room 10[12 Weather 10][04 Unable to connect to weather service 10]
    return
  }

  sockwrite -n wttr GET /%wt.city?format=3 HTTP/1.0
  sockwrite -n wttr Host: wttr.in
  sockwrite -n wttr User-Agent: mIRC-StrangeScript
  sockwrite -n wttr Connection: close
  sockwrite -n wttr $crlf
}

on *:sockread:wttr:{
  if ($sockerr) {
    sockclose wttr
    msg %wt.room 10[12 Weather 10][04 Error reading weather data 10]
    return
  }

  sockread %wt.line
  if (!$sockbr) return

  ; ignore headers
  if (%wt.line iswm HTTP/*) return
  if (%wt.line == $null) return

  ; THIS LINE IS THE RESULT
  msg %wt.room 10[12 Weather 10][14 %wt.line 10]
  sockclose wttr
}
