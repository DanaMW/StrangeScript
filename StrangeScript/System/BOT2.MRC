on 1:input:#:{
  if ($1 == bot) {
    if ($2 == cycle) {
      if ($3 == $null) { sockwrite -n Bot [ $+ [ $network ] ] part # $cr join # }
      else { sockwrite -n Bot [ $+ [ $network ] ] part $3 :Cycling $cr join $3 }
    }
    else { .timer 1 3 sockwrite -n Bot [ $+ [ $network ] ] privmsg # :What? }
  }
}
