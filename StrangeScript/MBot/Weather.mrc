==================================================
; TinyWeather for MasterBot and StrangeScript
; Code by d3t0x and recess. v0.1.14 2-1-2026
; ==================================================
alias wz.weather {
  set %wz.room $1
  set %wz.city $replace($2-,$chr(32),+)

  msg %wz.room $report(Weather,$null,Please wait while I retrieve the weather...)

  if ($exists(wz_weather.txt)) .remove wz_weather.txt

  ; -s = silent, -L = follow redirects, 2>&1 = merge stderr
  ;-o wz_weather.txt
  ;msg %wz.room $report(Weather,$null,curl -s -L "https://wttr.in/ $+ %wz.city $+ ?format=3")
  ;run cmd /c curl -s -L "https://wttr.in/%wz.city?format=3" > wz_weather.txt 2>&1
  run curl -s -L -o wz_weather.txt "http://wttr.in/ $+ %wz.city $+ ?format=3"

  ; poll until file has data
  set %tt 1
  timerwzpoll 1 1 wz.check
}

alias wz.check {
  inc %tt
  if (%tt == 60) { msg %wz.room $report(Weather,$null,Error,Unable to retrieve weather data) | .timerwzpoll off | return }
  if ($exists(wz_weather.txt)) {
    var %line = $read(wz_weather.txt)
    msg %wz.room Weather $replace(%line,+,$chr(32))
  }
  else { timerwzpoll 1 1 wz.check }
  ;.remove wz_weather.txt
}

wz.save {

}
