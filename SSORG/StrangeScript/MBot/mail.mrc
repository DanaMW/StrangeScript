alias mail {
  sockclose mail
  set %mail.room $1
  if ($2) { set %mail.user $2 }
  sockopen mail cos.selfip.biz 110
}
on 1:SOCKOPEN:mail:{
  if ($sockerr > 0) { msg %cnn.room Sockread Error for $sockname | sockclose $sockname | return }
  if ($exists(mail.txt) == $true) { .remove mail.txt }
  ;sockwrite -nt $sockname news
  ;sockwrite -nt $sockname echo1
  ;sockwrite -nt $sockname LIST
}
on 1:SOCKREAD:mail:{
  if ($sockerr > 0) { msg %mail.room Sockread Error for $sockname | sockclose $sockname | return }
  :read1
  sockread %mail
  if ($sockbr == 0) { return }
  ;notice %boss %mail
  if (*ready* iswm %mail) {
    if (%mail.user != $null) {
      sockwrite -nt $sockname USER %mail.user
      sockwrite -nt $sockname PASS %mail.user.pass. [ $+ [ %mail.user ] ]
      sockwrite -nt $sockname STAT
    }
    else {
      sockwrite -nt $sockname USER %mail.acct
      sockwrite -nt $sockname PASS %mail.acct.pass
      sockwrite -nt $sockname STAT
      ;sockclose $sockname
    }
  }
  if (*Authentication failed* iswm %mail) {
    msg %mail.room Error: Authentication failed for %mail.user
    unset %mail.user
    sockwrite -nt $sockname QUIT 
  }
  if ($gettok(%mail,2,32) == 0) && ($gettok(%mail,3,32) == messages) {
    if (%mail.user != $null) { msg %mail.room No waiting mail for %mail.user | unset %mail.user | sockwrite -nt $sockname QUIT  }
    sockwrite -nt $sockname QUIT
    if ($exists(mail.txt) == $true) { .remove mail.txt }
  }
  if ($gettok(%mail,2,32) > 0) && ($gettok(%mail,3,32) == messages) {
    if (%mail.user != $null) {
      if ($gettok(%mail,2,32) == 1) { msg %mail.room $gettok(%mail,2,32) Mail waiting for %mail.user }
      else { msg %mail.room $gettok(%mail,2,32) Mails waiting for %mail.user }
      unset %mail.user
      sockwrite -nt $sockname QUIT 
    }
    ;set %mail.count 1
    sockwrite -nt $sockname RETR %mail.count
  }
  if (%mail.user == $null) { 
    ;
    ;if (MSNBC Breaking News isin %mail) { set %mail.write MSN }
    ;write mail.txt %mail
    ;goto read1
    ;
    if ($left(%mail,2) == --) && ($left(%mail,4) != ----) { set %mail.write ON | set %mail.who CNN }
    ;if (-- isin %mail) { set %mail.write ON }
    if ($chr(61) $+ $chr(61) $+ $chr(61) isin %mail) { set %mail.write OFF }
    if ($chr(42) $+ $chr(42) $+ $chr(42) isin %mail) { set %mail.write OFF }
    if (=3D=3D=3D isin %mail) { set %mail.write OFF }
    if (%mail.write == ON) {  write mail.txt %mail }
    if (----------------- isin %mail) { set %mail.write ON | set %mail.who MSN }
    if ($left(%mail,1) == $chr(46)) { sockwrite -nt $sockname DELE %mail.count | sockwrite -nt $sockname QUIT }
  }
  goto read1
}
on 1:sockclose:mail:{  if ($exists(mail.txt) == $true) { play.mail } }
alias play.mail {
  if (%mail.who == CNN) {
    msg %mail.room CNN Breaking News ....
    var %tmp = 1
    while (%tmp <= $lines(mail.txt)) {
      var %tmp1 = $read(mail.txt,%tmp)
      if (*CNN.com* !iswm %tmp1) { var %tmp.mail = %tmp.mail $+ %tmp1 $+ $chr(160) }
      inc %tmp
      if (*CNN.com* iswm %tmp1) { break }

    }
    msg %mail.room %tmp.mail
    msg %mail.room For more details: http://www.cnn.com
    sockclose mail
  }
  if (%mail.who == MSN) {
    msg %mail.room MSNBC Breaking News ....
    var %tmp 3
    var %tmp.mail -- $+ $chr(160)
    while (%tmp <= $lines(mail.txt)) {
      var %tmp1 = $read(mail.txt,%tmp)
      ;var %tmp.mail = %tmp.mail $+ %tmp1 $+ $chr(160)
      msg %mail.room %tmp.mail $+ $remove(%tmp1,$chr(61))
      inc %tmp
      if (%tmp > $lines(mail.txt)) { break }
    }
    ;msg %mail.room %tmp.mail
    msg %mail.room For more details: http://www.msnbc.com
    sockclose mail
  }
  unset %mail.who
}
