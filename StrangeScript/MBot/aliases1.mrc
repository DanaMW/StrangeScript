[aliases]
n0=/SL.PLAY {
n1=  return
n2=  ;.notice Strange 
n3=}
n4=log.value {
n5=  if (%logging == 0.0.0) { return OFF }
n6=  if (%logging == 1.1.1) { return ON all }
n7=  if (%logging == 1.1.0) { return ON Security only }
n8=  if (%logging == 1.0.1) { return On Query only }
n9=  return
n10=}
n11=LOG.ADJUST {
n12=  log.value
n13=  if ($2 == ON) { set %logging 1.1.1 | .timerLOG 0 1 Check.Serv.Log | .msg $1 Your log reads set as %logging $logging.value $+ . | return }
n14=  if ($2 == OFF) { set %logging 0.0.0 | .timerLOG OFF | .msg $1 Your log reads set as %logging $logging.value $+ . | return }
n15=  if ($2 == SHOW) { .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . | return }
n16=  if ($2 == -s) {
n17=    if ($3 == OFF) { set %logging $puttok(%logging,0,2,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
n18=    if ($3 == ON) { set %logging $puttok(%logging,1,2,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
n19=    ;set %logging OFF | .timerLOG OFF | .msg $1 Your log reads set as %logging $logging.value $+ .
n20=    return
n21=  }
n22=  if ($2 == -q) {
n23=    if ($3 == OFF) { set %logging  $puttok(%logging,0,3,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
n24=    if ($3 == ON) { set %logging  $puttok(%logging,1,3,46) | .msg $1 Your log reads are set as %logging ( $+ $logging.value $+ ) $+ . }
n25=    ; set %logging OFF | .timerLOG OFF | .msg $1 Your log reads set as %logging $logging.value $+ .
n26=    return
n27=  }
n28=  return
n29=}
n30=SS.Command {
n31=  if ($2 == OFF) {
n32=    if ($3 == all) || ($3 == $chr(42)) { sockclose Spy* | unset %server.spy.on.* | msg # $report(ServerSpy,OFF,ALL) }
n33=    if ($3 == icq) || ($3 == i) { sockclose SpyICQ | unset %server.spy.on.icq | msg # $report(ServerSpy,OFF,Icq) }
n34=    if ($3 == dalnet) || ($3 == d) { sockclose SpyDALNET | unset %server.spy.on.dalnet | msg # $report(ServerSpy,OFF,Dalnet) }
n35=    if ($3 == strange) || ($3 == s) { sockclose SpySTRANGE | unset %server.spy.on.strange | msg # $report(ServerSpy,OFF,Strange) }
n36=    if ($3 == xpeace) || ($3 == x) { sockclose SpyXPEACE | unset %server.spy.on.xpeace | msg # $report(ServerSpy,OFF,Xpeace) }
n37=    if ($3 == chat) || ($3 == c) { sockclose SpyCHAT | unset %server.spy.on.chat | msg # $report(ServerSpy,OFF,Chat) }
n38=    if ($3 == splog) || ($3 == p) { sockclose SpySPLOG | unset %server.spy.on.splog | msg # $report(ServerSpy,OFF,sPlog) }
n39=    if ($3 == jong) || ($3 == j) { sockclose SpyJONG | unset %server.spy.on.jong | msg # $report(ServerSpy,OFF,Jong) }
n40=    if ($3 == blaze) || ($3 == b) { sockclose SpyBLAZE | unset %server.spy.on.blaze | msg # $report(ServerSpy,OFF,Blaze) }
n41=    if ($3 == global) || ($3 == g) { sockclose SpyGLOBAL | unset %server.spy.on.global | msg # $report(ServerSpy,OFF,Global) }
n42=    return
n43=  }
n44=  if ($2 == ON) {
n45=    if ($3 == icq) || ($3 == i) { if (%server.spy.port.icq == $null) { set %server.spy.port.icq 6667 } | sockopen SpyICQ %server.spy.server.icq %server.spy.port.icq | set %server.spy.on.icq icq $+ , $+ $chan $+ , $+ %server.spy.chan.icq | msg # $report(ServerSpy,ON,Icq) }
n46=    if ($3 == dalnet) || ($3 == d) { if (%server.spy.port.dalnet == $null) { set %server.spy.port.dalnet 6667 } | sockopen SpyDALNET %server.spy.server.dalnet %server.spy.port.dalnet | set %server.spy.on.dalnet dalnet $+ , $+ $chan $+ , $+ %server.spy.chan.dalnet | msg # $report(ServerSpy,ON,Dalnet) }
n47=    if ($3 == strange) || ($3 == s) { if (%server.spy.port.strange == $null) { set %server.spy.port.strange 6667 } | sockopen SpySTRANGE %server.spy.server.strange %server.spy.port.strange | set %server.spy.on.strange strange $+ , $+ $chan $+ , $+ %server.spy.chan.strange | msg # $report(ServerSpy,ON,Strange) }
n48=    if ($3 == xpeace) || ($3 == x) { if (%server.spy.port.xpeace == $null) { set %server.spy.port.xpeace 6667 } | sockopen SpyXPEACE %server.spy.server.xpeace %server.spy.port.xpeace | set %server.spy.on.xpeace xpeace $+ , $+ $chan $+ , $+ %server.spy.chan.xpeace | msg # $report(ServerSpy,ON,Xpeace) }
n49=    if ($3 == chat) || ($3 == c) { if (%server.spy.port.chat == $null) { set %server.spy.port.chat 6667 } | sockopen SpyCHAT %server.spy.server.chat %server.spy.port.chat | set %server.spy.on.chat chat $+ , $+ $chan $+ , $+ %server.spy.chan.chat | msg # $report(ServerSpy,ON,Chat) }
n50=    if ($3 == splog) || ($3 == p) { if (%server.spy.port.splog == $null) { set %server.spy.port.splog 6667 } | sockopen SpySPLOG %server.spy.server.splog %server.spy.port.splog | set %server.spy.on.splog splog $+ , $+ $chan $+ , $+ %server.spy.chan.splog | msg # $report(ServerSpy,ON,sPlog) }
n51=    if ($3 == jong) || ($3 == j) { if (%server.spy.port.jong == $null) { set %server.spy.port.jong 6667 } | sockopen SpyJONG %server.spy.server.jong %server.spy.port.jong | set %server.spy.on.jong jong $+ , $+ $chan $+ , $+ %server.spy.chan.jong | msg # $report(ServerSpy,ON,Jong) }
n52=    if ($3 == blaze) || ($3 == b) { if (%server.spy.port.blaze == $null) { set %server.spy.port.blaze 6667 } | sockopen SpyBLAZE %server.spy.server.blaze %server.spy.port.blaze | set %server.spy.on.blaze blaze $+ , $+ $chan $+ , $+ %server.spy.chan.blaze | msg # $report(ServerSpy,ON,Blaze) }
n53=    if ($3 == global) || ($3 == g) { if (%server.spy.port.global == $null) { set %server.spy.port.global 6667 } | sockopen SpyGLOBAL %server.spy.server.global %server.spy.port.global | set %server.spy.on.global global $+ , $+ $chan $+ , $+ %server.spy.chan.global | msg # $report(ServerSpy,ON,Global) }
n54=    return
n55=  }
n56=  if ($2 == STATS) { sl $3- }
n57=  if ($2 == NICK) {
n58=    if ($3 == icq) || ($3 == i) { set %server.spy.nick.icq $4 | msg # $report(ServerSpy,Nick,Icq,$4) }
n59=    if ($3 == dalnet) || ($3 == d) { set %server.spy.nick.dalnet $4 | msg # $report(ServerSpy,Nick,Dalnet,$4) }
n60=    if ($3 == strange) || ($3 == s) { set %server.spy.nick.strange $4 | msg # $report(ServerSpy,Nick,Strange,$4) }
n61=    if ($3 == xpeace) || ($3 == x) { set %server.spy.nick.xpeace $4 | msg # $report(ServerSpy,Nick,Xpeace,$4) }
n62=    if ($3 == chat) || ($3 == c) { set %server.spy.nick.chat $4 | msg # $report(ServerSpy,Nick,Chat,$4) }
n63=    if ($3 == splog) || ($3 == p) { set %server.spy.nick.splog $4 | msg # $report(ServerSpy,Nick,sPlog,$4) }
n64=    if ($3 == jong) || ($3 == j) { set %server.spy.nick.jong $4 | msg # $report(ServerSpy,Nick,Jong,$4) }
n65=    if ($3 == blaze) || ($3 == b) { set %server.spy.nick.blaze $4 | msg # $report(ServerSpy,Nick,Blaze,$4) }
n66=    if ($3 == global) || ($3 == g) { set %server.spy.nick.global $4 | msg # $report(ServerSpy,Nick,Global,$4) }
n67=    return
n68=  }
n69=  if ($2 == SERVER) {
n70=    if ($3 == icq) || ($3 == i) { set %server.spy.server.icq $4 | msg # $report(ServerSpy,Server,Icq,$4) }
n71=    if ($3 == dalnet) || ($3 == d) { set %server.spy.server.dalnet $4 | msg # $report(ServerSpy,Server,Dalnet,$4) }
n72=    if ($3 == strange) || ($3 == s) { set %server.spy.server.strange $4 | msg # $report(ServerSpy,Server,Strange,$4) }
n73=    if ($3 == xpeace) || ($3 == x) { set %server.spy.server.xpeace $4 | msg # $report(ServerSpy,Server,Xpeace,$4) }
n74=    if ($3 == chat) || ($3 == c) { set %server.spy.server.chat $4 | msg # $report(ServerSpy,Server,Chat,$4) }
n75=    if ($3 == splog) || ($3 == p) { set %server.spy.server.splog $4 | msg # $report(ServerSpy,Server,sPlog,$4) }
n76=    if ($3 == jong) || ($3 == j) { set %server.spy.server.jong $4 | msg # $report(ServerSpy,Server,Jong,$4) }
n77=    if ($3 == blaze) || ($3 == b) { set %server.spy.server.blaze $4 | msg # $report(ServerSpy,Server,Blaze,$4) }
n78=    if ($3 == global) || ($3 == g) { set %server.spy.server.global $4 | msg # $report(ServerSpy,Server,Global,$4) }
n79=    return
n80=  }
n81=  if ($2 == PASS) {
n82=    if ($3 == icq) || ($3 == i) { set %server.spy.pass.icq $4 | msg # $report(ServerSpy,Pass,Icq,$4) }
n83=    if ($3 == dalnet) || ($3 == d) { set %server.spy.pass.dalnet $4 | msg # $report(ServerSpy,Pass,Dalnet,$4) }
n84=    if ($3 == strange) || ($3 == s) { set %server.spy.pass.strange $4 | msg # $report(ServerSpy,Pass,Strange,$4) }
n85=    if ($3 == xpeace) || ($3 == x) { set %server.spy.pass.xpeace $4 | msg # $report(ServerSpy,Pass,Xpeace,$4) }
n86=    if ($3 == chat) || ($3 == c) { set %server.spy.pass.chat $4 | msg # $report(ServerSpy,Pass,Chat,$4) }
n87=    if ($3 == splog) || ($3 == p) { set %server.spy.pass.splog $4 | msg # $report(ServerSpy,Pass,sPlog,$4) }
n88=    if ($3 == jong) || ($3 == j) { set %server.spy.pass.jong $4 | msg # $report(ServerSpy,Pass,Jong,$4) }
n89=    if ($3 == blaze) || ($3 == b) { set %server.spy.pass.blaze $4 | msg # $report(ServerSpy,Pass,Blaze,$4) }
n90=    if ($3 == global) || ($3 == g) { set %server.spy.pass.global $4 | msg # $report(ServerSpy,Pass,Global,$4) }
n91=    return
n92=  }
n93=  if ($2 == PORT) {
n94=    if ($3 == icq) || ($3 == i) { set %server.spy.port.icq $4 | msg # $report(ServerSpy,Port,Icq,$4) }
n95=    if ($3 == dalnet) || ($3 == d) { set %server.spy.port.dalnet $4 | msg # $report(ServerSpy,Port,Dalnet,$4) }
n96=    if ($3 == strange) || ($3 == s) { set %server.spy.port.strange $4 | msg # $report(ServerSpy,Port,Strange,$4) }
n97=    if ($3 == xpeace) || ($3 == x) { set %server.spy.port.xpeace $4 | msg # $report(ServerSpy,Port,Xpeace,$4) }
n98=    if ($3 == chat) || ($3 == c) { set %server.spy.port.chat $4 | msg # $report(ServerSpy,Port,Chat,$4) }
n99=    if ($3 == splog) || ($3 == p) { set %server.spy.port.splog $4 | msg # $report(ServerSpy,Port,sPlog,$4) }
n100=    if ($3 == jong) || ($3 == j) { set %server.spy.port.jong $4 | msg # $report(ServerSpy,Port,Jong,$4) }
n101=    if ($3 == blaze) || ($3 == b) { set %server.spy.port.blaze $4 | msg # $report(ServerSpy,Port,Blaze,$4) }
n102=    if ($3 == global) || ($3 == g) { set %server.spy.port.global $4 | msg # $report(ServerSpy,Port,Global,$4) }
n103=    return
n104=  }
n105=  if ($2 == CHANNEL) || ($2 == CHAN) {
n106=    if ($3 == icq) || ($3 == i) { set %server.spy.chan.icq $4 | msg # $report(ServerSpy,Channel,Icq,$4) }
n107=    if ($3 == dalnet) || ($3 == d) { set %server.spy.chan.dalnet $4 | msg # $report(ServerSpy,Channel,Dalnet,$4) }
n108=    if ($3 == strange) || ($3 == s) { set %server.spy.chan.strange $4 | msg # $report(ServerSpy,Channel,Strange,$4) }
n109=    if ($3 == xpeace) || ($3 == x) { set %server.spy.chan.xpeace $4 | msg # $report(ServerSpy,Channel,Xpeace,$4) }
n110=    if ($3 == chat) || ($3 == c) { set %server.spy.chan.chat $4 | msg # $report(ServerSpy,Channel,Chat,$4) }
n111=    if ($3 == splog) || ($3 == p) { set %server.spy.chan.splog $4 | msg # $report(ServerSpy,Channel,sPlog,$4) }
n112=    if ($3 == jong) || ($3 == j) { set %server.spy.chan.jong $4 | msg # $report(ServerSpy,Channel,Jong,$4) }
n113=    if ($3 == blaze) || ($3 == b) { set %server.spy.chan.blaze $4 | msg # $report(ServerSpy,Channel,Blaze,$4) }
n114=    if ($3 == global) || ($3 == g) { set %server.spy.chan.global $4 | msg # $report(ServerSpy,Channel,global,$4) }
n115=    return
n116=  }
n117=  return
n118=}
n119=UP.Service {
n120=  ;$1 is message room
n121=  ;$2 is hop,aop,sop
n122=  ;$3 is #room
n123=  ;$4 is ADD|DEL|LIST|WIPE
n124=  ;$5 is nick
n125=  if ($exists(up_service.ini) == $false) { write -c up_service.ini }
n126=  if ($1 == $null) { msg $2 Error in commadn UP.Service | return }
n127=  if ($2 == $null) || ($3 == $null) || ($4 == $null) { msg $1 Format: . $+ $UPPER($2) <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> <nick> | return }
n128=  if ($4 != -a) && ($4 != -d) && ($4 != -l) && ($4 != -w) { msg $1 Format: . $+ $UPPER($2) <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> <nick> | return }
n129=  if ($4 == -a) {
n130=    if ($5 == $null) { msg $1 Format: . $+ $UPPER($2) <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> <nick> | return }
n131=    var %t.us = $readini(up_service.ini, n,$3,$5)
n132=    if (%t.us == $null) { .writeini -n up_service.ini $3 $5 $upper($2) | msg $1 Added $5 to $3 as an $upper($2) | return }
n133=    else { msg $1 $5 is already listed as an $upper(%t.us) in $3 | return }
n134=    ;.timer -m 1 500 HOP.Service $1 LIST
n135=    return
n136=  }
n137=  if ($4 == -d) {
n138=    if ($5 == $null) { msg $1 Format: . $+ $UPPER($2) <#room> ADD|DEL|LIST|WIPE <nick> | return }
n139=    var %t.us = $readini(up_service.ini, n,$3,$5)
n140=    if (%t.us == $null) || ($readini(up_service.ini, n,$3,$5) != $upper($2)) { msg $1 $5 is not listed as an $upper($2) in $3 | return }
n141=    else { .remini up_service.ini $3 $5 | msg $1 Removed $5 from $3 ( was $upper(%t.us) ) | return }
n142=    ;.timer -m 1 500 HOP.Service $1 LIST
n143=    return
n144=  }
n145=  if ($4 == -l) {
n146=    var  %t.us = $ini(up_service.ini,$3,0)
n147=    if (%t.us < 1) { msg $1 There are no HOP|AOP|SOP's listed for $3 | return }
n148=    else {
n149=      msg $1 HOP AOP SOP list for $3
n150=      var %lcount = 1
n151=      while (%lcount <= %t.us) {
n152=        if ($readini(up_service.ini, n,$3,$ini(up_service.ini,$3,%lcount)) == SOP) { var %t.1 = +o }
n153=        if ($readini(up_service.ini, n,$3,$ini(up_service.ini,$3,%lcount)) == AOP) { var %t.1 = +v }
n154=        if ($readini(up_service.ini, n,$3,$ini(up_service.ini,$3,%lcount)) == HOP) { var %t.1 = +h }
n155=        msg $1 $chr(91) %lcount $chr(93) $ini(up_service.ini,$3,%lcount) $+ $str(.,$calc(30 - $len($ini(up_service.ini,$3,%lcount)))) $+  ( %t.1 )
n156=        inc %lcount
n157=        if (%lcount > %t.us) { break }
n158=      }
n159=    }
n160=    return
n161=  }
n162=  if ($4 == -w) { .remini up_service.ini $3 | msg $1 Wiped the room $3 | return }
n163=}
n164=play.filter {
n165=  ;$1 = room to play to
n166=  ;$2 = file to play
n167=  if ($1 == $null) { .msg # Error in play.filter, no params specified (Format: /play.filter <#room to play to> <file  to filter and play>) | halt }
n168=  if ($exists($2) == $false) { msg # Error playing file, the fucking thing is missing ($2) | halt }
n169=  var %xz = 1
n170=  while (%xz <= $lines($2)) {
n171=    if ($read($2, n,%xz) == $null) { .timer 1 $calc(2 + %xz) .msg $1 $chr(160) }
n172=    else { .timer 1 $calc(2 + %xz) .msg $1 $replace($read($2, n,%xz),$chr(9),$chr(160)) }
n173=    inc %xz
n174=    if  (%xz > $lines($2)) { break }
n175=  }
n176=}
