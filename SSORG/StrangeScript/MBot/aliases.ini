[aliases]
n0=ver return StrangeDrop $chr(91) v7.00.beta.11.20.2003 $chr(93) coded for 10S04trange10S04cript
n1=load.rest {
n2=  load -rs script0.ini
n3=  load -rs script1.ini
n4=  load -rs script2.ini
n5=  load -rs unmask.ini
n6=  msg %boss Reload Complete
n7=  halt
n8=}
n9=slc {
n10=  if ($1 == $null) { .msg # Format: .slc <-s|-r> | return }
n11=  if ($1 == -s) {
n12=    if (%log.query == $null) { set %log.query 1 }
n13=    if (%log.qso == $null) { set %log.query 0 }
n14=    .msg #COS SLC / ISC Bind Read.
n15=    .msg #COS Query readings $lines(c:\dns\etc\namedb\query.log) ( $+ %log.query $+ ) ( $+ %log.qso $+ )
n16=    .msg #COS Security readings $lines(c:\dns\etc\namedb\security.log) ( $+ %log.security $+ ) ( $+ %log.Sso $+ )
n17=  }
n18=  if ($1 == -r) {
n19=    set %log.query $lines(c:\dns\etc\namedb\query.log)
n20=    set %log.security $lines(c:\dns\etc\namedb\security.log)
n21=    set %log.qso 0
n22=    set %log.sso 0
n23=    .msg #COS Query readings $lines(c:\dns\etc\namedb\query.log) ( $+ %log.query $+ ) ( $+ %log.qso $+ )
n24=    .msg #COS Security readings $lines(c:\dns\etc\namedb\security.log) ( $+ %log.security $+ ) ( $+ %log.Sso $+ )
n25=  }
n26=}
n27=Check.Serv.Log {
n28=  if (%logging == 0.0.0) { return }
n29=  if ($lines(c:\IRC\services\services.log) > 0) {
n30=    %method %boss $read(c:\IRC\services\services.log, 1)
n31=    write -dl1 c:\IRC\services\services.log
n32=  }
n33=  ;
n34=  ;
n35=  if (%log.query == $null) { set %log.query 1 }
n36=  if (%log.qso == $null) { set %log.qso 0 }
n37=  if ($lines(c:\dns\etc\namedb\query.log) < %log.query) { .msg #COS ISC BIND Query file has changed, running reset. | slc -r }
n38=  if ($lines(c:\dns\etc\namedb\query.log) > %log.query) { set %log.qso 0 }
n39=  if ($lines(c:\dns\etc\namedb\query.log) >= %log.query) && (%log.qso != 1) {
n40=    if ($lines(c:\dns\etc\namedb\query.log) == %log.query) { set %log.qso 1 }
n41=    if ($lines(c:\dns\etc\namedb\query.log) > %log.query) { inc %log.query | set %log.qso 0 }
n42=    var %tmp.log = $read(c:\dns\etc\namedb\query.log, %log.query)
n43=    ;if (%log.qso != 1) && (client 68.187.32.* !iswm %tmp.log) && (*IN PTR* !iswm %tmp.log) && (client 192.168.0.* !iswm %tmp.log) { %method %boss Query ( $+ %log.query $+ ) -- %tmp.log }
n44=    if (%log.qso != 1) { %method %boss Query ( $+ %log.query $+ ) -- %tmp.log }
n45=    ;if (*IN MX* iswm %tmp.log) { .msg #COS Incoming mail (MX) from $gettok($remove($gettok(%tmp.log,2,32),:),1,35) }
n46=  }
n47=  ;
n48=  ;goto endit
n49=  ;
n50=  if (%log.security == $null) { set %log.security 1 }
n51=  if (%log.sso == $null) { set %log.sso 0 }
n52=  if ($lines(c:\dns\etc\namedb\security.log) < %log.security) { .msg #COS ISC BIND Security file has changed, running reset. | slc -r }
n53=  if ($lines(c:\dns\etc\namedb\security.log) > %log.security) { set %log.sso 0 }
n54=  if ($lines(c:\dns\etc\namedb\security.log) >= %log.security) && (%log.sso != 1) {
n55=    if ($lines(c:\dns\etc\namedb\security.log) == %log.security) { set %log.sso 1 }
n56=    if ($lines(c:\dns\etc\namedb\security.log) > %log.security) { inc %log.security | set %log.sso 0 }
n57=    var %tmp.log = $read(c:\dns\etc\namedb\security.log, %log.security)
n58=    ;if (%log.sso != 1) && (client 68.187.32.* !iswm %tmp.log) && (client 192.168.0.* !iswm %tmp.log) {
n59=    if (%log.sso != 1)  {
n60=      if ($gettok(%tmp.log,3,32) == update) || ($gettok(%tmp.log,3,32) == query) { %method %boss Security ( $+ %log.security $+ ) -- %tmp.log }
n61=    }
n62=  }
n63=  :endit 
n64=  return
n65=}
n66=/check.boss {
n67=  updatenl
n68=  if ($1 != $null) { set %boss $1 }
n69=  else { notice %boss There is an error in the Check.Boss routine. No nick is being passed on the command line. Halting | return }
n70=  .notice $1 Checking and repairing the BOSS variable
n71=  auser 5 $address(%boss,4) %boss
n72=  if ($nopath($mircini) == SSC1.ini) {
n73=    if ($address(frenchie,4) != $null) { .msg #COS Adding user frenchie | auser 4 $address(frenchie,4) frenchie }
n74=    if ($address(m0,4) != $null) { .msg #COS Adding user m0 | auser 4 $address(m0,4) m0 }
n75=    if ($address(mystro,4) != $null) { .msg #COS Adding user mystro | auser 4 $address(mystro,4) mystro }
n76=    if ($address(RDC,4) != $null) { .msg #COS Adding user RDC | auser 4 $address(RDC,4) RDC }
n77=    if ($address(wolflord,4) != $null) { .msg #COS Adding user wolflord | auser 4 $address(wolflord,4) wolflord }
n78=    if ($address(Nightdeath^,4) != $null) { .msg #COS Adding user Nightdeath^ | auser 4 $address(Nightdeath^,4) Nightdeath^ }
n79=    if ($address(Lethal_INjection,4) != $null) { .msg #COS Adding user Lethal_INjection | auser 4 $address(Lethal_INjection,4) Lethal_INjection }
n80=    if ($address(Code,4) != $null) { .msg #COS Adding user Code | auser 4 $address(Code,4) Code }
n81=  }
n82=  return
n83=}
n84=/fix.mode {
n85=  mode $me +iowghrpaAsxNWHt
n86=  mode $me +s +kcFfjvGenq
n87=  mode $me
n88=  return
n89=}
n90=/recover {
n91=  if ($me == %recover) {
n92=    .timerREC OFF
n93=    .notice %boss 04 $+ Nick Recovered
n94=    unset %recover
n95=    halt
n96=  }
n97=  if ($me != %recover) {
n98=    if (%recover != $null) { nick %recover }
n99=    .timerREC 1 10 recover
n100=  }
n101=  return
n102=}
n103=/report1 {
n104=  .msg $1 10 $+ $chr(91) $+ 00,01 $+ %report $+ 10 $+ $chr(93) $chr(91) $+ 11,01 $+ $2- $+  $+ 10 $+ $chr(93)
n105=  return
n106=}
n107=report {
n108=  if ($1- == $null) { return No Text Sent to Report | return }
n109=  else { var %tmp.rbuild = %tmp.rbuild 05 $+ $chr(124) }
n110=  if ($1 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 15 $1 10 $+ $chr(93) $+ 05 $+ $chr(124) }
n111=  if ($2 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 10 $2 10 $+ $chr(93) $+ 05 $+ $chr(124) }
n112=  if ($3 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 14 $3 10 $+ $chr(93) $+ 05 $+ $chr(124) }
n113=  if ($4 != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 04 $4 10 $+ $chr(93) $+ 05 $+ $chr(124) }
n114=  if ($5- != $null) { var %tmp.rbuild = %tmp.rbuild $+ 10 $+ $chr(91) $+ 15 $5- 10 $+ $chr(93) $+ 05 $+ $chr(124) }
n115=  if ($prop == active) { return echo -at $sys %tmp.rbuild }
n116=  if ($prop == status) { return echo -st $sys %tmp.rbuild }
n117=  if ($prop == $null) { return %tmp.rbuild }
n118=}
n119=/do.var { set %tmp % $+ $1 | return %tmp }
n120=/is.sock {
n121=  if ($read -ns $1 $remove($mircdir,mbot\) $+ text\Socket.Nick.txt != $null) { return $true }
n122=  else { return $false }
n123=}
n124=/do.aop {
n125=  if ($1 isowner $chan($2)) { return }
n126=  elseif ($1 isop $chan($2)) { return }
n127=  mode $2 +ao $1 $1
n128=  return
n129=}
n130=/do.aop {
n131=  if ($1 isowner $chan($2)) { return }
n132=  elseif ($1 isop $chan($2)) { return }
n133=  mode $2 +o $1
n134=  return
n135=}
n136=/do.hop {
n137=  if ($1 isowner $chan($2)) { return }
n138=  elseif ($1 isop $chan($2)) { return }
n139=  mode $2 +h $1
n140=  return
n141=}
n142=/take { raw access # clear $+ $cr $+ access # add host *!*@*  | /mkall # | /prop # ownerkey tester }
n143=info return StrangeServer
n144=mybar { titlebar - $chr(91) Clone $mid($nopath($mircini),4,2) ] $chr(91) nick: $me $chr(93) $chr(91) lag: %Lag.mrc $chr(93) $chr(91) IRCX: %IRCX.mode $chr(93) $chr(91) $server $chr(93) }
n145=/join { jn $1 $2 $3 $4 $5 $6- }
n146=/jn {
n147=  if ($2 != $null) { .raw join $1 $2- }
n148=  if ($2 == $null) && (%key. [ $+ [ $1 ] ] != $null) { .raw join $1 %key. [ $+ [ $1 ] ] }
n149=  else { .raw join $1 }
n150=}
n151=/jns { .raw join $replace($1-,$chr(32),$chr(160)) }
n152=/set.auto.joinN {
n153=  return
n154=  set %tmp 1
n155=  set %count 1
n156=  :loop
n157=  if (%count == 11) goto second.halfN
n158=  if (%autojoin [ $+ [ %count ] ] != $null) {
n159=    set %temp [ $+ [ %tmp ] ] %autojoin [ $+ [ %count ] ]
n160=    inc %tmp
n161=    inc %count
n162=    goto loop
n163=  }
n164=  if (%autojoin [ $+ [ %count ] ] == $null) { inc %count | goto loop }
n165=  echo -at 11 ERROR IN SET.AUTO.JOIN NORMAL
n166=  halt
n167=  :second.halfN
n168=  set %autojoin1 %temp1 
n169=  set %autojoin2 %temp2 
n170=  set %autojoin3 %temp3 
n171=  set %autojoin4 %temp4 
n172=  set %autojoin5 %temp5 
n173=  set %autojoin6 %temp6 
n174=  set %autojoin7 %temp7 
n175=  set %autojoin8 %temp8 
n176=  set %autojoin9 %temp9 
n177=  set %autojoin10 %temp10
n178=  unset %tmp %temp* %count
n179=}
n180=/pound {
n181=  if ($me ison %pound) { set %pound "" | set %pound.active OFF | .notice %boss Pound Disabled, Entered Room | halt } 
n182=  .timerPND 1 10 /pound
n183=  .raw join %pound
n184=}
n185=/hup { 
n186=  if ($1 == $null) {
n187=    echo -at 04 You need to include the nick $textcolor ( 09 /hup nick $textcolor )
n188=    halt 
n189=  } 
n190=  echo -at 04 Sending a 11 HUP 04 style ping to $1
n191=  .raw -q privmsg $1 : $+ $chr(1) $+ PING +++ATH0 $+ $chr(1)
n192=}
n193=/cycle {
n194=  if ($1 != $null) { .raw part $1 $cr join $1 %key. [ $+ [ $1 ] ] }
n195=  else { .raw part # $cr join # %key. [ $+ [ # ] ] }
n196=}
n197=/ssctcpflood {
n198=  /inc %attempt
n199=  if (%attempt > 2) {
n200=    /ignore -ntu45 *!*@*
n201=    .timerFloodOver 1 45 /set %attempt 0
n202=    if (%attempt == 3) { 
n203=      .notice %boss 00 $+ CTCP 04 $+ Flood Protection has been 11 $+ ACTIVATED 04 $+ by 11 $+ $nick
n204=      echo -st 00 $+ CTCP 04 $+ Flood Protection has been 11 $+ ACTIVATED 04 $+ by 11 $+ $nick
n205=    }
n206=    return
n207=  }
n208=  .timerFloodOver 1 15 /set %attempt 0
n209=  return
n210=}
n211=/sstalkflood {
n212=  /inc %attempt.talk
n213=  if (%attempt.talk > 3) {
n214=    /ignore -u30 *!*@*
n215=    .timerFloodTalk 1 30 /set %attempt.talk 0
n216=    return
n217=  }
n218=  .timerFloodTalk 1 10 /set %attempt.talk 0
n219=  return
n220=}
n221=/mkall {
n222=  unset %mass2
n223=  set %mass 0
n224=  :incl
n225=  if (%mass < $nick($1,0)) {
n226=    inc %mass 1
n227=    if $nick($1,%mass) != $me { set %mass2 %mass2 $+ , $+ $nick($1,%mass) }
n228=    goto incl
n229=  }
n230=  .raw kick $1 %mass2
n231=  unset %mass %mass1 %mass2
n232=}
n233=/auto.join {
n234=  .raw mode $me +i
n235=  if (%do.autojoin == OFF) { return }
n236=  if (%do.autojoin == SPEED) { return }
n237=  if (%do.autojoin == ON) {
n238=    var %tmp.oo = 1
n239=    while (%tmp.oo <= $numtok(%autojoin,44)) {
n240=      .raw join $gettok(%autojoin,%tmp.oo,44) %key. [ $+ [ $gettok(%autojoin,%tmp.oo,44) ] ]
n241=      inc %tmp.oo
n242=      if (%tmp.oo > $numtok(%autojoin,44)) { break }
n243=    }
n244=    return
n245=  }
n246=  return
n247=}
n248=/join.setup {
n249=  beep
n250=  if (%boss != $me) { .ctcp %boss REG }
n251=  .raw mode $me +i
n252=  set %IRCX.mode OFF
n253=  if ($server == strange.selfip.biz) { ircx | set %IRCX.mode ON | .msg nickserv identify %irc.nick.pass }
n254=  if ($network == Jong) { ircx | set %IRCX.mode ON }
n255=  if ($network == IRCx) { ircx | set %IRCX.mode ON }
n256=  if (%IRCX.mode == OFF) {
n257=    if ($network == dalnet) { .nickserv identify %irc.nick.pass }
n258=    else { .msg nickserv identify %irc.nick.pass }
n259=  }
n260=  if ($ial != $true) { .ial on }
n261=  set %count.note 0
n262=  set %pound.active OFF
n263=  set %spy OFF
n264=  set %spy1 ""
n265=  set %spy2 ""
n266=  ;set %server.spy ""
n267=  ;set %server.spy1 ""
n268=  ;set %server.spy2 ""
n269=  if ($script(talker.ini) != $null) { .unload -rs $mircdirtalker.ini }
n270=  if ($script(unmask.ini) == $null) { .load -rs unmask.ini }
n271=  if ($script(script1.ini) == $null) { .load -rs script1.ini }
n272=  reset
n273=  if ($group(#DoCommand) == on) { .disable #DoCommand }
n274=  .timerbar 0 1 mybar
n275=  lagset 15
n276=  lagon
n277=  set %LM.editor OFF
n278=  return
n279=}
n280=/tease {
n281=  raw -q mode # +o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 $1 
n282=  halt
n283=}
n284=/rt {
n285=  .timer 1 1 /remote.tease $1 $2
n286=  .timer 1 2 /remote.tease $1 $2
n287=  .timer 1 3 /remote.tease $1 $2
n288=  .timer 1 4 /remote.tease $1 $2
n289=}
n290=/remote.tease {
n291=  raw -q mode $1 +o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o+o-o $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 $2 
n292=  halt
n293=}
n294=/fly {
n295=  if ($1 == 1) { .raw join $2 | .raw kick $2 $3 | .raw part $2 }
n296=  if ($1 == 2) { halt }
n297=  if ($1 == 3) { halt }
n298=  if ($1 == 4) { halt }
n299=}
n300=/cycleall {
n301=  set %rumble OFF
n302=  set %tmp.quit 1
n303=  :qloop2
n304=  If (%tmp.quit <= $chan(0)) { 
n305=    .raw part $chan(%tmp.quit)
n306=    .raw join $chan(%tmp.quit) %key. [ $+ [ $chan(%tmp.quit) ] ]
n307=    inc %tmp.quit 
n308=    goto qloop2
n309=  }
n310=  unset %tmp.quit
n311=}
n312=/ReadSpy {
n313=  var %temp.servspy = $findfile(%server.spy2,*.txt,1)
n314=  if (%temp.servspy == $null) { return }
n315=  if (%server.spy.type == BOSS) { .notice %boss $read -n %temp.servspy }
n316=  if (%server.spy.type != BOSS) { .msg %server.spy1 $read -n %temp.servspy }
n317=  .remove %temp.servspy
n318=}
n319=reset {
n320=  .disable #unmask
n321=  .disable #unmask.right
n322=}
n323=deathip {
n324=  set %temp.dip $gettok($address(%death.ip,2),2,64))
n325=  set %temp.dip $remove(%temp.dip,$chr(33))
n326=  ;set %temp.dip $remove(%temp.dip,$chr(64))
n327=  set %temp.dip $remove(%temp.dip,$chr(42))
n328=  return %temp.dip
n329=}
n330=/blast {
n331=  set %tmp.blast 1
n332=  .timerBLAST 1 1 /blastoff $1 $2
n333=}
n334=/blastoff {
n335=  .msg $2 11 $+ $1 04 $+ is a $read -nl $+ %tmp.blast $mircdirtext\cusslist.txt
n336=  inc %tmp.blast
n337=  if (%tmp.blast > $lines($mircdirtext\cusslist.txt)) { unset %tmp.blast | halt }
n338=  .timerBLAST 1 1 /blastoff $1 $2
n339=}
n340=/adjust {
n341=  clearial
n342=  if (%IRCX.mode == ON) {
n343=    var %tmp.adjust = 1
n344=    while (%tmp.adjust <= $chan(0)) {
n345=      if ($me isop $chan(%tmp.adjust)) { var %tmp.store = $addtok(%tmp.store,$chan(%tmp.adjust),44) }
n346=      inc %tmp.adjust
n347=      if (%tmp.adjust > $chan(0)) { break }
n348=    }
n349=    if (%tmp.store != $null) {
n350=      .who %tmp.store
n351=    }
n352=  }
n353=  else {
n354=    var %tmp.adjust = 1
n355=    while (%tmp.adjust <= $chan(0)) {
n356=      if ($me isop $chan(%tmp.adjust)) {
n357=        var %tmp.store = $addtok(%tmp.store,$chan(%tmp.adjust),44)
n358=        .who $chan(%tmp.adjust)
n359=      }
n360=      inc %tmp.adjust
n361=      if (%tmp.adjust > $chan(0)) { break }
n362=    }
n363=  }
n364=}
n365=/addkey {
n366=  ;var %tmp.addkey = $chr(91) $+ $rand(0,99999) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(0,99999) $+ $chr(93)
n367=  ;if ($1 == $null) { set %key. [ $+ [ # ] ] %tmp.addkey | .raw prop # ownerkey %tmp.addkey }
n368=  ;if ($1 != $null) { set %key. [ $+ [ $1 ] ] %tmp.addkey | .raw prop $1 ownerkey %tmp.addkey }
n369=  return
n370=}
n371=/myaddress {
n372=  if (Dal.net isin $server) { return $address($1,3) } 
n373=  if (XXX isin $address($1,4)) { return $replace($address($1,2),XXX,*) }
n374=  elseif (XX isin $address($1,4)) { return $replace($address($1,2),XX,*) }
n375=  elseif (X isin $address($1,4)) { return $replace($address($1,2),X,*) }
n376=  else { return $address($1,3) }
n377=}
n378=/myaddress2 {
n379=  if (Dal.net isin $server) { return $address($1,4) } 
n380=  if (XXX isin $address($1,4)) { return $replace($address($1,2),XXX,*) }
n381=  elseif (XX isin $address($1,4)) { return $replace($address($1,2),XX,*) }
n382=  elseif (X isin $address($1,4)) { return $replace($address($1,2),X,*) }
n383=  else { return $address($1,4) }
n384=}
n385=/ssipsave {
n386=  ;.msg %boss $report($1-)
n387=  if (%current.server == COS) && (*server* iswm $address($1,4)) { return }
n388=  var %tmp.x = $gettok($mircdir,1,92) $+ $chr(92) $+ $gettok($mircdir,2,92) $+ $chr(92) $+ text\IPTracker.txt
n389=  var %tmp.xx = $gettok($mircdir,1,92) $+ $chr(92) $+ $gettok($mircdir,2,92) $+ $chr(92) $+ text\LastSeen.txt
n390=  if ($exists(%tmp.x) == $false) { set %tmp $ip | .write -c %tmp.x $me *!*@ $+ $puttok($ip,$chr(42),4,46) }
n391=  if ($exists(%tmp.xx) == $false) { set %tmp $ip | .write -c %tmp.xx $me $asctime(mmm dd yyyy) on %current.Server in #StrangeScript at $time }
n392=  if (%ssipsave == OFF) { return }
n393=  if ($4 == DNS) {
n394=    var %temp1 = $1
n395=    var %temp2 = $3
n396=    goto DNS.back
n397=  }
n398=  if ($gettok($address($1,2),-1,46) isalpha) { set %awaiting.dns. [ $+ [ $address($1,2) ] ] $1 $+ , $+ $2 | dns $1 | halt }
n399=  var %temp1 = $1
n400=  var %temp2 = $myaddress2($1)
n401=  :DNS.back
n402=  var %temp3 = $read(%tmp.x,s,$1)
n403=  if (%temp3 == $null) {
n404=    echo -t $2 $sys $report(IPTracker,Not on file,SAVING,%temp1,%temp2)
n405=    .write %tmp.xx %temp1 $asctime(mmm dd yyyy) on %current.Server in $2 at $time
n406=    var %temp3 = $addtok(%temp3,%temp2,44)
n407=    .write %tmp.x %temp1 %temp3
n408=    return
n409=  }
n410=  var %tmp = $readn
n411=  if ($istok(%temp3,%temp2,44) == $true) {
n412=    echo -t $2 $sys $report(IPTracker,Already on file,SKIPPING,%temp1,%temp2)
n413=    echo -t $2 $sys $report(LastSeen,$null,$null,$read(%tmp.xx,n,%tmp))
n414=    if (%ssipsave.IP == ON) { echo -t $2 $sys $report(IPTracker,Used ips,$null,%temp3) }
n415=    if (%ssipsave.IP == STATS) { echo -st $sys $report(IPTracker,Used ips,$null,%temp3) }
n416=    .write -l $+ %tmp %tmp.xx %temp1 $asctime(mmm dd yyyy) on %current.Server in $2 at $time
n417=    ;.write -l $+ %tmp %tmp.x %temp1 %temp3
n418=    return
n419=  }
n420=  if ($istok(%temp3,%temp2,44) == $false) {
n421=    echo -t $2 $sys $report(IPTracker,Already on file but new ip,UPDATING,%temp1,%temp2)
n422=    echo -t $2 $sys $report(LastSeen,$null,$null,$read(%tmp.xx,n,%tmp))
n423=    if (%ssipsave.IP == ON) { echo -t $2 $sys $report(IPTracker,Used ips,$null,%temp2,%temp3) }
n424=    if (%ssipsave.IP == STATS) { echo -st $sys $report(IPTracker,Used ips,$null,%temp2,%temp3) }
n425=    if ($len(%tmp3) < 435) { var %temp3 = $addtok(%temp3,%temp2,44) | goto skip }
n426=    if ($len(%tmp3) => 435) { var %temp3 = $puttok(%temp3,%temp2,1,44) }
n427=    :skip
n428=    .write -l $+ %tmp %tmp.xx %temp1 $asctime(mmm dd yyyy) on %current.server in $2 at $time
n429=    .write -l $+ %tmp %tmp.x %temp1 %temp3
n430=    return
n431=  }
n432=}
n433=timer.show {
n434=  var %tmp.ts 1
n435=  while (%tmp.ts <= $timer(0)) {
n436=    .msg # $chr(91) $+ %tmp.ts $+ $chr(93) Timer $+ $upper($timer(%tmp.ts)) Type: $timer(%tmp.ts).type Due: $timer(%tmp.ts).secs secs  Command: $timer(%tmp.ts).com
n437=    inc %tmp.ts
n438=    if (%tmp.ts > $timer(0)) { break }
n439=  }
n440=}
n441=sl {
n442=  if ($1 == $null) { .msg # No param given to reply to in SL call | return }
n443=  else {
n444=    if ($sock(*,0) == $null) || ($sock(*,0) == 0) { $showsl($1,%tmp.len,11 $+ $chr(44) $+ 10 There are no socks spying ) | return }
n445=    var %tmp.sl = 1
n446=    var %tmp.len = 1
n447=    while (%tmp.sl <= $sock(*,0)) {
n448=      set %tmp.sock. [ $+ [ %tmp.sl ] ] $sock(*,%tmp.sl) on %clone.server. [ $+ [ $sock(*,%tmp.sl) ] ] in $gettok(%server.spy.on. [ $+ [ $remove($sock(*,%tmp.sl),Spy) ] ] ,3,44) using nick $sock(*,%tmp.sl).mark
n449=      if ($len(%tmp.sock. [ $+ [ %tmp.sl ] ] ) > %tmp.len) { var %tmp.len = $len(%tmp.sock. [ $+ [ %tmp.sl ] ] ) }
n450=      inc %tmp.sl
n451=      if (%tmp.sl > $sock(*,0)) { break }
n452=    }
n453=    $showsl($1,%tmp.len,11 $+ $chr(44) $+ 10 Generating Socks List )
n454=    if (%tmp.sock.1 != $null) { $showsl($1,%tmp.len,%tmp.sock.1) }
n455=    if (%tmp.sock.2 != $null) { $showsl($1,%tmp.len,%tmp.sock.2) }
n456=    if (%tmp.sock.3 != $null) { $showsl($1,%tmp.len,%tmp.sock.3) }
n457=    if (%tmp.sock.4 != $null) { $showsl($1,%tmp.len,%tmp.sock.4) }
n458=    if (%tmp.sock.5 != $null) { $showsl($1,%tmp.len,%tmp.sock.5) }
n459=    if (%tmp.sock.6 != $null) { $showsl($1,%tmp.len,%tmp.sock.6) }
n460=    if (%tmp.sock.7 != $null) { $showsl($1,%tmp.len,%tmp.sock.7) }
n461=    if (%tmp.sock.8 != $null) { $showsl($1,%tmp.len,%tmp.sock.8) }
n462=    if (%tmp.sock.9 != $null) { $showsl($1,%tmp.len,%tmp.sock.9) }
n463=    $showsl($1,%tmp.len,11 $+ $chr(44) $+ 10 There are $sock(*,0) socket(s) online )
n464=    unset %tmp.sock.*
n465=    return
n466=  }
n467=}
n468=check.sl { if ($sock(Spy*,0) != $null) { sl } }
n469=showsl {
n470=  var %matha = $calc($len($3-) / 2)
n471=  var %mathb = $calc($2 / 2)
n472=  var %mathc = $calc(%mathb - %matha)
n473=  msg $1 $str($chr(160),$calc(%mathc + 3 )) $+ $3-
n474=  ; $+ $str($chr(160),$calc(%mathc + 3 )) $+ 
n475=  return
n476=}
n477=LiveMenu {
n478=  set %LM.editor ON
n479=  set %LM.chan $1
n480=  ;msg %LM.chan Setting menu channel... $+ %LM.chan
n481=  set %LM.boss $2
n482=  ;msg %LM.chan Setting menu owner... $+ %LM.boss
n483=  if (%LM.file == $null) { set %LM.file $script(1) }
n484=  LMenu
n485=  return
n486=}
n487=LMenu {
n488=  msg %LM.chan LiveMenu Options:
n489=  msg %LM.chan Current File: %LM.file
n490=  msg %LM.chan Lines: $lines(%LM.file)
n491=  msg %LM.chan (E)dit line ### <newline>
n492=  msg %LM.chan (F)ind a word
n493=  msg %LM.chan (I)nformation about the file your editing
n494=  msg %LM.chan (L)oad new .ini into editor.
n495=  msg %LM.chan (M)enu refresh
n496=  msg %LM.chan (R)ehash/(R)reload the current file. ( $+ %LM.file.type $+ )
n497=  msg %LM.chan (S)how line number ### or lines ###-###
n498=  msg %LM.chan (Q)uit the editor.
n499=  msg %LM.chan Use (<) and (>) to switch file types.
n500=  return
n501=}
n502=MenuPicks {
n503=  if ($strip($1) == Q) { msg %LM.chan Closing Editor | set %LM.editor OFF | halt }
n504=  if ($strip($1) == R) {
n505=    load %LM.file.type %LM.file
n506=    msg %LM.chan File %LM.file reloaded into bot.
n507=    halt
n508=  }
n509=  if ($strip($1) == M) { LMenu | halt }
n510=  if ($strip($1) == E) {
n511=    if ($2 == $null) { halt }
n512=    if ($3 == $null) { halt }
n513=    msg %LM.chan Old Line $2 $+ : $read(%LM.file,n,$2)
n514=    write -l $+ $2 %LM.file $3-
n515=    msg %LM.chan New Line $2 $+ : $read(%LM.file,n,$2)
n516=    halt
n517=  }
n518=  if ($strip($1) == F) {
n519=    if ($2 != $null) {
n520=      var %tmp.R = * $+ $2 $+ *
n521=      if ($3 isnum) { var %tmp.FW = $3 }
n522=      else { var %tmp.FW = 0 }
n523=      msg %LM.chan Searching for keyword " $+ $2 $+ "
n524=      while (%tmp.FW <= $lines(%LM.file)) {
n525=        var %tmp.waste = $read(%LM.file,nw,%tmp.R,%tmp.FW)
n526=        if ($readn == 0) { break }
n527=        msg %LM.chan keyword " $+ $2 $+ " found on line $readn
n528=        var %tmp.FW = $calc($readn +1)
n529=        while (%tmp.FW > $lines(%LM.file)) { break }
n530=      }
n531=      msg %LM.chan Search complete.
n532=    }
n533=    halt
n534=  }
n535=  if ($strip($1) == S) {
n536=    if ($2 == $null) { halt }
n537=    if ($chr(45) isin $2) {
n538=      msg %LM.chan Multiple Line... line $gettok($2,1,45) through $gettok($2,2,45)
n539=      var %LM.tmp = $gettok($2,1,45)
n540=      var %LM.tmp1 = $gettok($2,2,45)
n541=      while (%LM.tmp <= %LM.tmp1) {
n542=        msg %LM.chan $read(%LM.file,n,%LM.tmp)
n543=        INC %LM.tmp
n544=        IF (%LM.tmp > %LM.tmp1) { BREAK }
n545=      }
n546=      halt
n547=    }
n548=    msg %LM.chan $read(%LM.file,n,$2)
n549=    halt
n550=  }
n551=  if ($strip($1) == I) {
n552=    msg %LM.chan You can edit $script(0) script and $alias(0) alias files.
n553=    msg %LM.chan Current File: %LM.file
n554=    msg %LM.chan Lines: $lines(%LM.file)
n555=    halt
n556=  }
n557=  ;Current File: %LM.file
n558=  if ($strip($1) == L) {
n559=    msg %LM.chan Script files
n560=    var %LM.tmp = 1
n561=    while (%LM.tmp <= $script(0)) {
n562=      set %LM.load. [ $+ [ %LM.tmp ] ]  $script(%LM.tmp)
n563=      msg %LM.chan ( $+ %LM.tmp $+ ) $script(%LM.tmp)
n564=      inc %LM.tmp
n565=      if (%LM.tmp > $script(0)) { break }
n566=    }
n567=    msg %LM.chan Alias files
n568=    var %LM.tmp1 = 1
n569=    while (%LM.tmp1 <= $alias(0)) {
n570=      set %LM.load. [ $+ [ %LM.tmp ] ]  $alias(%LM.tmp1)
n571=      msg %LM.chan ( $+ %LM.tmp $+ ) $alias(%LM.tmp1)
n572=      inc %LM.tmp
n573=      inc %LM.tmp1
n574=      if (%LM.tmp1 > $alias(0)) { break }
n575=    }
n576=    msg %LM.chan (Pick Number To Load)
n577=    halt
n578=  }
n579=  if ($strip($1) isnum) {
n580=    if (%LM.load. [ $+ [ $1 ] ] == $null) { halt }
n581=    set %LM.file %LM.load. [ $+ [ $1 ] ]
n582=    LMenu
n583=    halt
n584=  }
n585=  if ($strip($1) == >) { set %LM.file.type -as | msg %LM.chan File type set to Alias | return }
n586=  if ($strip($1) == <) { set %LM.file.type -rs | msg %LM.chan File type set to Script | return }
n587=  return
n588=}
n589=/SSpy {
n590=  if ($strip($2) == $null) { msg # Format: >server_indicator command_letter Params (for more help try ??) | halt }
n591=  var %tmp.spy.serv = $upper($right($strip($1),-1))
n592=  var %tmp.spy.com = $strip($2)
n593=  if ($chr(35) isin $strip($3)) {
n594=    var %tmp.spy.room = $strip($3)
n595=    var %tmp.spy.param = $strip($4-)
n596=  }
n597=  else { var %tmp.spy.param = $strip($3-) }
n598=  if (%tmp.spy.serv = x) var %tmp.spy.serv = xpeace
n599=  if (%tmp.spy.serv = s) var %tmp.spy.serv = strange
n600=  if (%tmp.spy.serv = i) var %tmp.spy.serv = icq
n601=  if (%tmp.spy.serv = d) var %tmp.spy.serv = dalnet
n602=  if (%tmp.spy.serv = c) var %tmp.spy.serv = chat
n603=  if (%tmp.spy.serv = p) var %tmp.spy.serv = splog
n604=  if (%tmp.spy.serv = j) var %tmp.spy.serv = jong
n605=  if (%tmp.spy.serv = b) var %tmp.spy.serv = blaze
n606=  if (%tmp.spy.serv = g) var %tmp.spy.serv = global
n607=  ;ircx.blazin-irc.com
n608=  if (%tmp.spy.serv = $chr(42)) { var %tmp.spy.serv = $chr(42) }
n609=  if (%tmp.spy.com == A) {
n610=    if ($nick == %boss) {
n611=      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Action,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44))  %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ $chr(1) $+ ACTION %tmp.spy.param $+ $chr(1) }
n612=      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Action,%tmp.spy.room) $chr(93)) %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $chr(1) $+ ACTION %tmp.spy.param $+ $chr(1) }
n613=      return
n614=    }
n615=    else {
n616=      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Action,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44)) ( $+ $nick $+ ) %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ $chr(1) $+ ACTION ( $+ $nick $+ ) %tmp.spy.param $+ $chr(1) }
n617=      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Action,%tmp.spy.room) $chr(93)) ( $+ $nick $+ )  %tmp.spy.param | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $chr(1) $+ ACTION ( $+ $nick $+ ) %tmp.spy.param $+ $chr(1) }
n618=      return
n619=    }
n620=  }
n621=  if (%tmp.spy.com == C) {
n622=    if (%tmp.spy.room == $null) { msg # $report(Error,No Room Given to Cycle) | halt }
n623=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Cycle Room,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv part %tmp.spy.room $crlf join %tmp.spy.room }
n624=    return
n625=  }
n626=  if (%tmp.spy.com == I) {
n627=    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Whois,$3) | sockwrite -n Spy $+ %tmp.spy.serv whois $3 }
n628=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Whois,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv whois %tmp.spy.room }
n629=    return
n630=  }
n631=  if (%tmp.spy.com == J) {
n632=    if (%tmp.spy.room == $null) { msg # $report(Error,No Room Given to Join) | halt }
n633=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Joining room,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv join %tmp.spy.room }
n634=    return
n635=  }
n636=  if (%tmp.spy.com == L) {
n637=    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Geting Room List,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44)) | sockwrite -n Spy $+ %tmp.spy.serv names $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) }
n638=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Geting Room List,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv names %tmp.spy.room }
n639=    return
n640=  }
n641=  if (%tmp.spy.com == M) {
n642=    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Mode,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44)) | sockwrite -n Spy $+ %tmp.spy.serv mode $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) %tmp.spy.param }
n643=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Mode,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv %tmp.spy.room %tmp.spy.param }
n644=    return
n645=  }
n646=  if (%tmp.spy.com == P) {
n647=    if (%tmp.spy.room == $null) { msg # $report(Error,No Room Given to Part) | halt }
n648=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Parting room,%tmp.spy.room) | sockwrite -n Spy $+ %tmp.spy.serv part %tmp.spy.room }
n649=    return
n650=  }
n651=  if (%tmp.spy.com == R) {
n652=    if (%tmp.spy.param == $null) { msg # $report(Error,Nothing to RAW Send) | halt }
n653=    if (%tmp.spy.param != $null) { msg # $report(%tmp.spy.serv,Raw Send) | sockwrite -n Spy $+ %tmp.spy.serv %tmp.spy.param }
n654=    return
n655=  }
n656=  if (%tmp.spy.com == S) {
n657=    if ($nick == %boss) {
n658=      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44),$nick)  $+ $3- | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ $3- | halt }
n659=      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,%tmp.spy.room,$nick)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $4- | halt }
n660=      return
n661=    }
n662=    else {
n663=      if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,$gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44),$nick)  $+ ( $+ $nick $+ )  $3- | sockwrite -n Spy $+ %tmp.spy.serv privmsg $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) : $+ ( $+ $nick $+ ) $3- | halt }
n664=      if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,%tmp.spy.room,$nick)  $+ ( $+ $nick $+ ) $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ ( $+ $nick $+ ) $4- | halt }
n665=      return
n666=    }
n667=  }
n668=  if (%tmp.spy.com == W) {
n669=    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Whisper,$3)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg $3 : $+ $4- | halt }
n670=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Whisper,%tmp.spy.room)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.room : $+ $4- | halt }
n671=    return
n672=  }
n673=  if (%tmp.spy.com == K) {
n674=    if (%tmp.spy.room == $null) { msg # $report(%tmp.spy.serv,Kick,$3)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv Kick $gettok(%server.spy.on. [ $+ [ %tmp.spy.serv ] ] ,3,44) $3 : $+ $4- | halt }
n675=    if (%tmp.spy.room != $null) { msg # $report(%tmp.spy.serv,Kick,%tmp.spy.room)  $+ $4- | sockwrite -n Spy $+ %tmp.spy.serv kick %tmp.spy.room $4 : $+ $5- | halt }
n676=    return
n677=  }
n678=  if (%tmp.spy.com == G) {
n679=    msg # $report(%tmp.spy.serv,Ping,%tmp.spy.param)
n680=    sockwrite -n Spy $+ %tmp.spy.serv privmsg %tmp.spy.param : $+ $chr(1) $+ PING $ticks $+ $chr(1)
n681=    return
n682=  }
n683=  if (%tmp.spy.com == D) {
n684=    msg # $report(%tmp.spy.serv,Identifying)
n685=    sockwrite -n Spy $+ %tmp.spy.serv privmsg nickserv :identify %server.spy.pass. [ $+ [ %tmp.spy.serv ] ]
n686=    sockwrite -n Spy $+ %tmp.spy.serv nickserv identify %server.spy.pass. [ $+ [ %tmp.spy.serv ] ]
n687=    return
n688=  }
n689=  if (%tmp.spy.com == N) {
n690=    msg # $report(%tmp.spy.serv,Nick,%tmp.spy.param)
n691=    sockwrite -n Spy $+ %tmp.spy.serv nick %tmp.spy.param
n692=    return
n693=  }
n694=  if (%tmp.spy.com == F) {
n695=    msg # The filter (ignore) option is not yet working.
n696=    return
n697=  }
n698=  return
n699=}
n700=/SSpy.Help {
n701=  .msg # $chr(91) ServerSpy Help Information. $chr(93)
n702=  .msg # Format: >S O TEXT (S = Server letter, O = Option, TEXT = Command params)
n703=  .msg # Valid Server letters are: x = xpeace, s = strange, i = icq, d = dal, g = global
n704=  .msg # Valid Server letters are: c = chatnet, p = splog, j = jong, b = blaze
n705=  .msg # -
n706=  .msg # Valid Options are: (A)-action (C)-cycle (I)-info(whois) (J)-join (L)-roomlist (D)-ident (N)-nick (F)-filter(ignore)
n707=  .msg # Valid Options are: (M)-mode (P)-part (R)-raw (S)-say(privmsg) (W)-whipser (K)-kick (G)-ping
n708=  .msg # $chr(91) Done. $chr(93)
n709=  return
n710=}
n711=/Set.SS {
n712=  if ($2 == x) { var %tmp.spy.serv = xpeace }
n713=  if ($2 == s) { var %tmp.spy.serv = strange }
n714=  if ($2 == i) { var %tmp.spy.serv = icq }
n715=  if ($2 == d) { var %tmp.spy.serv = dalnet }
n716=  if ($2 == c) { var %tmp.spy.serv = chat }
n717=  if ($2 == p) { var %tmp.spy.serv = splog }
n718=  if ($2 == j) { var %tmp.spy.serv = jong }
n719=  if ($2 == b) { var %tmp.spy.serv = blaze }
n720=  if ($2 == g) { var %tmp.spy.serv = global }
n721=  ;ircx.blazin-irc.com
n722=  .msg $1 Server Spy Setup for %tmp.spy.serv
n723=  .msg $1 Server: %server.spy.server. [ $+ [ %tmp.spy.serv ] ]
n724=  .msg $1 Server Nick: %server.spy.nick. [ $+ [ %tmp.spy.serv ] ]
n725=  .msg $1 Server Port: %server.spy.port. [ $+ [ %tmp.spy.serv ] ]
n726=  if (%server.spy.pass. [ $+ [ %tmp.spy.serv ] ] == $null) { .msg $1 Password: Not Set }
n727=  else { .msg $1 Password: *hidden* (Set) | .notice %boss Password: %server.spy.pass. [ $+ [ %tmp.spy.serv ] ] }
n728=
n729=  return
n730=}
n731=/play.mod { if ($1 != $null) { .notice %boss $replace($1-,$chr(9),$chr(160))  } }
