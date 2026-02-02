==================================================
; TinyWeather for MasterBot and StrangeScript
; Code by d3t0x and recess. v0.1.16 2-1-2026
; ==================================================
alias wz.weather {
  set %wz.room $1
  set %wz.nick $2
  set %wz.city $replace($3-,$chr(32),+)
  msg %wz.room $report(Weather,$null,Please wait while I retrieve the weather...)
  if ($exists(wz_weather.txt)) .remove wz_weather.txt
  ; -s = silent, -L = follow redirects, 2>&1 = merge stderr
  ;msg %wz.room $report(Weather,$null,curl -s -L "https://wttr.in/ $+ %wz.city $+ ?format=3")
  ;run cmd /c curl -s -L "https://wttr.in/%wz.city?format=3" > wz_weather.txt 2>&1
  run curl -s -L -o wz_weather.txt "http://wttr.in/ $+ %wz.city $+ ?format=3"
  ; poll until file has data or time expires
  set %tt 1
  .timerwzpoll 1 1 wz.check
}

alias wz.check {
  ; increment the count
  inc %tt
  ; if we don't find the file in 60 seconds it's time to give up
  if (%tt == 60) { msg %wz.room $report(Weather,$null,Error,Unable to retrieve weather data) | .timerwzpoll off | ;.remove wz_weather.txt | return }
  ; look for the created file if it's there read it to the user
  if ($exists(wz_weather.txt)) {
    var %line = $read(wz_weather.txt)
    msg %wz.room $report(Weather:) $report($replace(%line,+,$chr(32)))
    if ($read($mircdirtext\wz_save.txt,w,* $+ %wz.nick $+ *) == $null) {
      write $mircdirtext\wz_save.txt %wz.nick $+ .OFF. $+ %wz.city
    }
    .timergoask 1 5 wz.question 
  }
  else { .timerwzpoll 1 1 wz.check }
}

; where the user file is
;$mircdirtext\wz_save.txt

alias wz.save {
  if ($2 == AUTO) {}
  if ($2 == CITY) {}
}

alias wz.question {
  return
  msg %wz.room Would you like to save $replace(%wz.city,+,$chr(32)) as your default city, %wz.nick $+ ?

}
