;usage: /unmask xxxx.somewhere.com nick
;usage: /unmask 123.456.xxx nick
;--------------------------------------------------------
alias unmask.mask {
  unset %unmask*
  if ($1 == $null) { echo 04 -a ( no mask given ) | halt }
  if ($2 == $null) { echo 04 -a ( no nick given ) | halt }
  set %unmask.count 45
  set %unmask.masked $1
  set %unmask.nick $2
  set %unmask.len $count($gettok(%unmask.masked,1,46),x)
  set %unmask.cur $calc(%unmask.len - 1)
  set %unmask.last . $+ $deltok(%unmask.masked,1,46)
  .enable #unmask
  .raw who $chr(45) $+ $str(?,%unmask.cur) $+ %unmask.last
}
#unmask off
alias who { echo 04 -a the who command is disabled during unmask scan }
on 1:NICK:{ if ($nick == %unmask.nick) { set %unmask.nick $newnick } }
raw 352:*:{ 
  if ($6 == %unmask.nick) {
    set %unmask.result %unmask.result $+ $chr(%unmask.count)
    dec %unmask.cur
    set %unmask.count 44
    echo 04 -a ( unmasking status: $calc(100 / %unmask.len * (%unmask.len - %unmask.cur - 1)) $+ $chr(37) )
  }
  halt
}
raw 315:*:{ 
  if (%unmask.count == 45) inc %unmask.count 2
  if (%unmask.count == 57) set %unmask.count 96
  if (%unmask.count == 62) inc %unmask.count
  if (%unmask.count == 122) { echo 04 -a ( unable to unmask ) | .disable #unmask | halt }
  if (%unmask.cur == -1) { echo 04 -a ( 
    hack resolved $str(x,%unmask.len) $+ %unmask.last to: $lower(%unmask.result) $+ %unmask.last )
    .notice %boss. [ $+ [ $network ] ] 11 $+ hack resolved $str(x,%unmask.len) $+ %unmask.last to: $lower(%unmask.result) $+ %unmask.last )
    .disable #unmask
    halt
  }
  inc %unmask.count
  .raw who %unmask.result $+ $chr(%unmask.count) $+ $str(?,%unmask.cur) $+ %unmask.last
  halt
}
#unmask end
;<----------unmask ipz---------->
alias unmask { 
  unset %unmask*
  if ($1 == $null) { echo 04 -a ( no mask given ) | .notice %boss. [ $+ [ $network ] ] 04 $+ no mask given | halt }
  if ($2 == $null) { echo 04 -a ( no nick given ) | .notice %boss. [ $+ [ $network ] ] 04 $+ no nick given | halt }
  echo 04 -a Unmasking $2 at ip $1
  notice %boss. [ $+ [ $network ] ] 04 $+ Unmasking $2 at ip $1
  set %unmask.count 48
  set %unmask.len $len($gettok($1,4,46))
  set %unmask.masked $deltok($replace($1,.,*),4,42) $+ $chr(42)
  set %unmask.nick $2
  set %unmask.cur $calc(%unmask.len - 1)
  .enable #unmask.right
  .raw who %unmask.masked $+ 0
}
#unmask.right off
alias who { echo 04 -a the who command is disabled during unmask scan ) }
on 1:NICK:{ if ($nick == %unmask.nick) { set %unmask.nick $newnick } }
raw 352:*:{ 
  if ($6 == %unmask.nick) {
    set %unmask.result $chr(%unmask.count) $+ %unmask.result
    dec %unmask.cur
    set %unmask.count 47
    echo 04 -a unmasking status: $calc(100 / %unmask.len * (%unmask.len - %unmask.cur - 1)) $+ $chr(37) 
  }
  halt
}
raw 315:*:{ 
  if (%unmask.count == 58) { echo 04 -a ( unable to unmask ) | .disable #unmask.right | halt }
  if (%unmask.cur == -1) { 
    echo 04 -a hack resolved $replace(%unmask.masked,*,.) $+ $str(X,%unmask.len) to: $replace(%unmask.masked,*,.) $+ %unmask.result
    .notice %boss. [ $+ [ $network ] ] 11 $+ hack resolved $replace(%unmask.masked,*,.) $+ $str(X,%unmask.len) to: $replace(%unmask.masked,*,.) $+ %unmask.result
    .disable #unmask.right
    halt
  }
  inc %unmask.count
  .raw who %unmask.masked $+ $chr(%unmask.count) $+ %unmask.result
  halt
}
#unmask.right end
