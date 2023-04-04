alias net return $sep $+ $chr(186) $+ ( $+ 4 $network $sep $+ )
alias mybar {
  set %mybar. $+ $cid $chr(124) $+ $chr(91) Servers: $scid(0) $chr(93) $+ $chr(124) $+ $chr(91) $server $chr(93) $+ $chr(124) $+ $chr(91) Nick: $me $chr(93) $+ $chr(124) $+ $chr(91) Network: $network $chr(93) $+ $chr(124) $+ $chr(91) Empty $chr(93) $+ $chr(124) $+ $chr(91) Lag: $key($network,lagmrc) $chr(93) $+ $chr(124) $+ $chr(91) IRCMode: $key($network,ircmode) $chr(93) $+ $chr(124) $+ $chr(91) StrangeScript $chr(93) $+ $chr(124)
  if (%mybar.temp == $null) { titlebar %mybar. [ $+ [ $activecid ] ] }
  if (%mybar.temp != $null) { titlebar %mybar. [ $+ [ $activecid ] ] }
  return
}
alias script.play {
  if ($key(StrangeScript,script.sounds) == OFF) { return }
  if ($right($1-,3) == wav) {
    if ($inwave != $true) { splay -w $sounddir $+ $1- }
  }
  if ($right($1-,3) == mp3) || ($right($1-,3) == wma) {
    if ($insong != $true) { splay -p $sounddir $+ $1- }
  }
  $report(StrangeScript,Sound Play,$null,Playing a *. $+ $upper($right($1,3)) sound file).status
  return
}
alias say {
  if ($1 == $null) {
    $report(StrangeScript,Error,Say,$null,No text to send).active
    halt
  }
  msg $active $1-
  return
}
alias Lagon { keywrite $network Lagchk ON | $report(StrangeScript,Auto Lag Check,$null,Set to,$key($network,lagchk)).status | Lgchk | return }
alias Lagoff { keywrite $network Lagchk OFF | $report(StrangeScript,Auto Lag Check,$null,Set to,$key($network,lagchk)).status |  .timer850. $+ $network off | keywrite $network Lagmrc OFF | return }
alias LagSet.Secs {
  set %tmp.lss $$?="How many second between check pings?"
  if (%tmp.lss == $null) { return  }
  keywrite $network Lagmrcsecs %tmp.lss
  $report(StrangeScript,$null,Lag Set Seconds,Set to,$key($network,Lagmrcsecs)).active
  unset %tmp.lss
  if ($key($network,lagchk) == ON) { lagoff | lagon }
  else { lagoff }
  return
}
/Lgchk { .timer850. $+ $network 0 $key($network,Lagmrcsecs) Lagchk }
/Lagchk { .raw Lag-CK $+ $chr(160) $+ $ticks }
/showLag { /mybar | return }
alias Lagset {
  if ($1 == $null) {
    $report(StrangeScript,$null,Lag Set Seconds,Try this,syntax: /Lagset <seconds>).active
    return
  }
  else {
    keywrite $network Lagmrcsecs $1
    $report(StrangeScript,$null,Lag Set Seconds,Set to,$key($network,Lagmrcsecs)).active
    if ($key($network,lagchk) == ON) { lagoff | lagon }
  }
  return
}
/sound.play {
  if ($1 == IN) { goto soundin }
  if ($1 == OUT) { goto soundout }
  if ($1 == REQUEST) { goto soundreg }
  :soundin
  return
  :soundout
}
;list { .raw list $1-  }
alias out { saveini | clearall | partall | if ($server != $null) { exit } }
alias join.servers {
  set %tmp.js 1
  while (%tmp.js <= $server(0)) {
    if (%tmp.js == 1) { /server $server(%tmp.js) $server(%tmp.js).port }
    else { /server -m $server(%tmp.js) $server(%tmp.js).port }
    inc %tmp.js
    if (%tmp.js > $server(0)) { break }
  }
  return
}
alias quitall { 
  if ($1 != $null) { aquit $1- }
  else { aquit $unhex.ini($key(StrangeScript,quit.message)) }
  return
}
alias deop.protect {
  if ($key($network,deop.protect) == OFF) { halt }
  ;
  ;
  halt
  ;
  ;
  if ($ulist($address($3,3)) != $null) {
    var %tmp = $readini($AutoOwner,n,$4,$myaddress($3))
    if (%tmp != $null) { .raw mode $4 +q $3 | unset %tmp | if ($chr(37) isin $4) { unset $4 } | halt }
    set %tmp $readini($AutoOp,n,$4,$myaddress($3))
    if (%tmp != $null) { .raw mode $4 +o $3 | unset %tmp | if ($chr(37) isin $4) { unset $4 } | halt }
    if ($chr(37) isin $4) { unset $4 }
    halt
  }
  var %tp = 1
  while (%tp <= $sock(@boom*,0).mark) {
    if ($3 == $sock(@boom*,%tp).mark) { var %oomm = $sock(@boom*,%tp).mark | var %oomn = $right($sock(@boom*,%tp),-5) | break }
    inc %tp
    if (%tp > $sock(@boom*,0).mark) { break }
  }
  if ($3 == %oomm) {
    if ($2 == $me) { 
      sw %oomn part $4 $crlf join $4 $key($4,ownerkey)
      sw %oomn privmsg $4 : $+ $master(settings,socksay)
      halt
    }
    if ($2 != $me) {
      sw %oomn part $4 $crlf join $4 $key($4,ownerkey)
      if ($istok($key(settings,botnick),$2,44) == $true) { sw %oomn privmsg $4 :Fucking Bot |  halt }
      else { if ($address($2,4) != $address($me,4)) { sw all access $4 add host $2 $+ !*@* | sw %oomn mode $4 -o $2 | halt } }
    }
  }
  if ($key($4,kicklock) == ON) {
    if ($2 isowner $chan($4)) { halt }
    if ($1 == -o) { .raw mode $4 -o+o $2 $3 | $report($2 just deoped $3 in $4 and was punished).active  }
    if ($1 == -q) { .raw mode $4 -o+q $2 $3 | $report($2 just deQ'd $3 in $4 and was punished).active  }
    .msg $4 10 $+ $chr(91) $+ $bright $+ System  Warning $+ 10 $+ $chr(93) $+ : $lowcol $+ If you deop or Deq YOU will be de-op'd
    if ($chr(37) isin $4) { unset $4 }
    halt
  }
  if ($chr(37) isin $4) { unset $4 }
}
#sswho off
raw 352:*: {
  inc %tempa
  set %user $+ %tempa $strip($3)
  set %host $+ %tempa $strip($4)
  set %server $+ %tempa $strip($5)
  set %handle $+ %tempa $strip($6-)
  halt
}
raw 315:*: {
  updatenl
  if ($key(StrangeScript,which.window) == ACTIVE) { $report(StrangeWho,$null,$null,The room is Empty  or set Secret).active | $report(StrangeWho,$null,$null,Or the User is Hidden or Not Online).active | $report($chain).active |  unset %handle* %user* %server* %host* %temp* | .disable #sswho | halt }
  if ($key(StrangeScript,which.window) == STATUS) { $report(StrangeWho,$null,$null,The room is Empty  or set Secret).status | $report(StrangeWho,$null,$null,Or the User is Hidden or Not Online).status | $report($chain).status |  unset %handle* %user* %server* %host* %temp* | .disable #sswho | halt }
  if ($key(StrangeScript,which.window) == ON) { aline @UserInfo $sys $white $+ StrangeWho: $lowcol $+ The room is $bright $+ Empty $lowcol $+ or set $bright $+ Secret  | aline @UserInfo $sys $white $+ StrangeWho: $lowcol $+ Or the User is $bright $+ Hidden $lowcol $+ or $bright $+ Not Online | aline @UserInfo $sys $+ $chain |  unset %handle* %user* %server* %host* %temp* | .disable #sswho | halt }
  :sswholoop
  if ($key(StrangeScript,which.window) == ACTIVE) {
    $report(Info $+ %tempb,$null,$null,%handle [ $+ [ %tempb ] ] %user [ $+ [ %tempb ] ]  $+ @ $+ %host [ $+ [ %tempb ] ]).active
    $report(Server,$null,$null,%server [ $+ [ %tempb ] ]).active
    if (%tempb >= %tempa) {
      $report($null,$null,Done).active
      $report($chain).active
      unset %handle* %user* %server* %host* %temp*
      .disable #sswho
      halt
    }
    else {  inc %tempb | goto sswholoop }
  }
  if ($key(StrangeScript,which.window) == ON) {
    aline @UserInfo $sys $highcol $+ Who Reply number $white $+ %tempb 
    aline @UserInfo $sys $lowcol $+ Info: $highcol $+ %handle [ $+ [ %tempb ] ] %user [ $+ [ %tempb ] ]  $+ @ $+ %host [ $+ [ %tempb ] ]
    aline @UserInfo $sys $lowcol $+ Server: $highcol $+ %server [ $+ [ %tempb ] ]
    if (%tempb >= %tempa) {
      aline @UserInfo $sys $bright $+ Done
      aline @UserInfo $sys $+ $chain
      unset %handle* %user* %server* %host* %temp*
      .disable #sswho
      halt
    }
    else {  inc %tempb | goto sswholoop }
  }
  else {
    $report(Who Reply,$null,number,%tempb).status
    $report(Handle,$null,$null,%handle [ $+ [ %tempb ] ] %user [ $+ [ %tempb ] ]  $+ @ $+ %host [ $+ [ %tempb ] ] ).status
    $report(Serve,$null,$null,%server [ $+ [ %tempb ] ] ).status
    if (%tempb >= %tempa) {
      $report(Done).status
      $report($chain).status
      unset %handle* %user* %server* %host* %temp*
      .disable #sswho
      halt
    }
    else {  inc %tempb | goto sswholoop }
  }
}
#sswho end
alias center.server {
  $report(Center Server,Empty Function,$null,$null,$null).active
}
