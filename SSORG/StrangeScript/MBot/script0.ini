[script]
n0=-on 1:WALLOPS:*killed by System*: echo -st $1-
n1=on 1:CONNECT:{
n2=  if ($chr(37) isin %autojoin) && (%IRCX.mode == ON) { ircx }
n3=  auto.join
n4=  join.setup
n5=  .timerBOSSSET 1 20 check.boss %boss
n6=  if ($nopath($mircini) == SSC1.ini) {
n7=    if (%logging == 1.1.1) || (%logging == 1.0.1) || (%logging == 1.1.0) { .timerLOG 0 1 Check.Serv.Log }
n8=    if (%mail.run == ON) { .timerMAIL 0 120 mail #COS }
n9=  }
n10=  ;if (%irc.oper.nick != $null) && (%irc.oper.pass != $null) { .timerOPER 1 60 oper %irc.oper.nick %irc.oper.pass }
n11=  halt
n12=}
n13=on 1:DISCONNECT:{ .msg %boss $report(Dissconnect,$time) }
n14=on 1:DCCSERVER:CHAT: halt
n15=on 1:DCCSERVER:SEND: halt
n16=on 1:DCCSERVER:FSERVE: halt
n17=on *:INVITE:#:{
n18=  if ($nick == %boss) { .raw join $chan %key. [ $+ [ $chan ] ] | halt }
n19=  if ($nick == ChanServ) { .raw join $chan %key. [ $+ [ $chan ] ] | halt }
n20=  .ignore -u120 $nick
n21=  halt 
n22=}
n23=on *:SNOTICE:*:{
n24=  if (*quote PASS* iswm $1-) { quote pass %BNC.pass }
n25=  if (*quote conn* iswm $1-) { quote conn %BNC.server }
n26=  .notice %boss ServerNotice: $1-
n27=}
n28=on *:NOTICE:*:*:{
n29=  if ($nick != ChanServ) && ($nick != NickServ) { .notice %boss Notice@ $+ $nick $+ : $1- }
n30=  if ($nick == NickServ) && (*IDENTIFY* iswm $1-) { 
n31=    if (*dal.net iswm $server) { nickserv identify %irc.nick.pass }
n32=    else { msg nickserv identify %irc.nick.pass }
n33=  }
n34=  inc %count.note
n35=  if ($nick != %boss) && (%count.note < 6) {
n36=    if ($chr(35) isin $nick) { halt }
n37=    if ($chr(64) isin $1-) { halt }
n38=  }
n39=  .timernc 1 45 /set %count.note 0
n40=}
n41=on *:JOIN:#: {
n42=  set %lastjoin. $+ # $nick
n43=  if ($istok(%shitlist,$address($nick,4),44) == $true) { if ($nick != %boss) && ($nick != $me) { .raw kick # $nick Bot $+ $chr(160) $+ Shitlist } | halt }
n44=  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,Join,%spy1,$nick,$address) }
n45=  if ($nick == $me) {
n46=    if ($chan(#) isin %pound) && (%pound.active == ON) { .notice %boss 04 $+ Pound Disabled, Entered Room | .timerPND OFF | set %pound "" | set %pound.active OFF }
n47=    ;if ($network == dalnet) { .chanserv op # $me }
n48=    ;else { .msg chanserv op # $me }
n49=    if (%doautojoin == SPEED) { .prop # OWNERKEY %key. [ $+ [ # ] ] $+ $cr $+ mode # +nts }
n50=  }
n51=  if ($level($address(%boss,4)) == 4) { 
n52=    if ($nick(#,$me,q) != $null) { .mode # +q $nick }
n53=    if ($nick(#,$me,o) != $null) { .mode # +o $nick }
n54=  }
n55=  if ($nick == %boss) && ($level($address(%boss,4)) == 5) {
n56=    if ($nick == $me) { halt }
n57=    if (%boss != $me) { .ctcp %boss REG }
n58=    if ($nick(#,$me,q) != $null) { .mode # +q %boss }
n59=    if ($nick(#,$me,o) != $null) { .mode # +o %boss }
n60=  }
n61=  var %t.us = $readini(up_service.ini, n,#,$nick)
n62=  if (%t.us != $null) { 
n63=    if (%t.us == SOP) { mode # +o $nick }
n64=    if (%t.us == AOP) { mode # +v $nick }
n65=    if (%t.us == HOP) { mode # +h $nick }
n66=  }
n67=}
n68=#DoCommand off
n69=on 5:TEXT:*:#: {
n70=  if ($nick == %boss) { 
n71=    if ($1 == cancel) { .disable #DoCommand | msg # $report(Fuckup,$null,$null,Canceled) | halt }
n72=    .msg # ok
n73=    if ($chr(47) !isin $1) { $chr(47) $+ $1- }
n74=    else { $1- }
n75=    .disable #DoCommand 
n76=    .msg # done
n77=  }
n78=  halt
n79=}
n80=#DoCommand END
n81=on *:QUIT:{
n82=  if ($nick == $me) && ($server != $null) { cycleall }
n83=  if (%spy == ON) { .msg %spy2 $report(Spy,Quit,$nick) }
n84=}
n85=on 1:TEXT:*:?:{
n86=  close -m
n87=  if ($nick == %boss) { if ($strip($1) == .identify) { /msg nickserv identify $2 | halt } }
n88=  if ($nick != ChanServ) && ($nick != OperServ) && ($nick != NickServ) {  .notice %boss Whisper@ $+ $nick $+ : $1- }
n89=}
n90=on *:NICK: {
n91=  if ($nick == %boss) {
n92=    set %boss $newnick
n93=    .notice %boss $report(Boss,Set,%boss)
n94=    .ctcp %boss SSBOT %bot.key. [ $+ [ $network ] ]
n95=  }
n96=  if ($nick == $me) && ($comchan(%boss,0) == $null) { .ctcp %boss SSBOTNICK $nick $newnick %bot.key. [ $+ [ $network ] ] }
n97=  recover
n98=}
n99=raw 366:*:{ if ($me ison $2) { who $2 } | else { return } }
n100=on *:KICK:#: {
n101=  if ($nick == $server) && (*strange* iswm $server) { .raw join # %key. [ $+ [ # ] ] | halt }
n102=  if ($nick == $server) && (*strange* !iswm $server) { halt }
n103=  if ($nick == ChanServ) && (*strange* !iswm $server) { halt }
n104=  if ($knick != %boss) && ($knick != $me) { HALT }
n105=  if ($knick == $me) && ($nick == %boss) { .raw join # %key. [ $+ [ # ] ] | .msg # stop abusing the bot | halt }
n106=  if ($knick == $me) && ($nick != %boss) && ( $nick != $me) { .raw join # %key. [ $+ [ # ] ] | .raw kick # $nick Auto | halt }
n107=  if ($knick == $me) && ($nick == $me) { .raw join # %key. [ $+ [ # ] ] | halt }
n108=  if ($knick == %boss) && ($nick != $me) { .raw kick # $nick Auto | halt }
n109=  if ($knick == %boss) && ($nick == $me) { .mode # -o $me | halt }
n110=  if ($level($address($nick,4)) == 5) { .raw join # %key. [ $+ [ # ] ] | halt }
n111=}
n112=on *:RAWMODE:#: {
n113=  if ($nick == $server) { halt }
n114=  if ($nick == System) { halt }
n115=  if ($nick == ChanServ) { halt }
n116=  if ($network == COS) && ($nick == ChanServ) || ($nick == OpServ) { halt }
n117=  .timerXX1 1 15 addkey #
n118=  if ($nick == $me) { halt }
n119=  ;if ($nick == %boss) { .msg chanserv op # $me | halt }
n120=  if ($nick == $mode(1)) { halt }
n121=  if ($1 == -o) && ($2 == $me) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | if ($timer(DEQME).con != $null) { halt } | if ($timer(RUNDEQ).con == $null) { .timerDEOPME 1 1 deop.kill $1 $nick $mode(1) $chan(#) } }
n122=  if ($1 == -o) && ($2 == %boss) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | if ($timer(DEQBOSS).con != $null) { halt } | if ($timer(DEQBOSS).con == $null) { .timerDEOPBOSS 1 1 deop.kill $1 $nick $mode(1) $chan(#) } }
n123=  if ($1 == -q) && ($2 == $me) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | .timerDEQME 1 1 deop.kill $1 $nick $mode(1) $chan(#) }
n124=  if ($1 == -q) && ($2 == %boss) { if ($chr(37) isin $chan(#)) { set $chan(#) $chan(#) } | .timerDEQBOSS 1 1 deop.kill $1 $nick $mode(1) $chan(#) }
n125=  if ($1 == +o) && ($2 == $me) { .timerDEOPME off }
n126=  if ($1 == +o) && ($2 == %boss) { .timerDEOPBOSS off }
n127=  if ($1 == +q) && ($2 == $me) { .timerDEOPME off | .timerDEQME off }
n128=  if ($1 == +q) && ($2 == %boss) { .timerDEOPBOSS off | .timerDEQBOSS off }
n129=}
n130=alias deop.kill {
n131=  echo 04 -st $1-
n132=  if ($3 == $me) {
n133=    .flood on
n134=    .timerMFlud 1 30 .flood off
n135=    .raw part $4 $cr join $4 %key. [ $+ [ $4 ] ] $cr mode $4 -o $2
n136=    addkey $4
n137=    .raw kick $4 $2 Lets $+ $chr(160) $+ Rock
n138=    if ($chr(37) isin $4) { unset $4 }
n139=    halt
n140=  }
n141=  if ($chr(37) isin $4) { unset $4 }
n142=  if ($3 == %boss) && ($2 != %boss) { .flood on | .timerMFlud 1 30 .flood off | .raw kick $4 $2 Auto | halt }
n143=}
n144=on *:PART:#:{
n145=  ;msg # $0-
n146=  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,Part,%spy1,$nick - $address) }
n147=  ;if ($nick != $me) && (%boss !ison $chan(#)) && (%spy != ON) { .notice %boss 00 $+ Part: 11 $+ $nick 04 $+ just parted 11 $+ # }
n148=  if ($nick != $me) {
n149=    if ($nick($chan,0) <= 2) && ($me !isowner $chan(#)) && (%cycle.for.ops == ON) {
n150=      cycle
n151=      .notice %boss 00 $+ Auto-Cycle: 11 $+ $chan 04 $+ is empty $+ , 11 $+ Auto-Cycle 04 $+ to get 11 $+ Ops $+ 04 $+ ...
n152=      echo -st 00 $+ Auto-Cycle: 11 $+ $chan 04 $+ is empty $+ , 11 $+ Auto-Cycle 04 $+ to get 11 $+ Ops $+ 04 $+ ...
n153=      beep
n154=    }
n155=  }
n156=}
n157=alias Lgchk { .timer850 0 %Lag.mrc.secs Lagchk }
n158=alias Lagchk { set %Lag.mrc.tmp $ticks | .raw Lag-CK }
n159=alias Lagon { echo -st 04 $+ Auto Lag Check is now 11 $+ ON | set %Lagchk on | Lgchk }
n160=alias Lagoff { echo -st 04 $+ Auto Lag Check is now 11 $+ OFF | set %Lagchk off | .timer850 off }
n161=alias ShowLag { if (%Clock == off) { titlebar - $chr(91) $logo ©1999 ] $chr(91) nick: $me $chr(93) $chr(91) lag: %Lag.mrc $chr(93) } }
n162=alias Lagset { 
n163=  if ($1 == $null) { echo -at 04 $+ Auto Lag Check syntax: /Lagset <seconds> | halt } 
n164=  if ($1 != $null) {
n165=    set %Lag.mrc.secs $1
n166=    echo -st 04 $+ Set Auto Lag Check to 11 $+ %Lag.mrc.secs 04 $+ seconds between. 
n167=    if (%Lagchk == on) { Lgchk }
n168=  }
n169=}
n170=raw 421:*: { 
n171=  if $2 == Lag-CK {
n172=    %Lag.mrc = $ticks - %Lag.mrc.tmp
n173=    if $len(%Lag.mrc) == 3 { set %Lag.mrc . $+ %Lag.mrc secs | ShowLag | halt }
n174=    if $len(%Lag.mrc) < 3 { %Lag.mrc = .0 $+ %Lag.mrc secs | ShowLag | halt }
n175=    if $len(%Lag.mrc) > 3 { %tmp = $len(%Lag.mrc) - 3 | %Lag.mrc = $mid(%Lag.mrc,1,%tmp) $+ . $+ $mid(%Lag.mrc,%tmp,3) secs | ShowLag | unset %tmp | halt }
n176=    titlebar $chr(91) lag: %Lag.mrc $chr(93)
n177=  }
n178=}
n179=raw prop:*: {
n180=  if ($2 == OWNERKEY) { 
n181=    set %oldkey. [ $+ [ $1 ] ] %key. [ $+ [ $1 ] ]
n182=    set %key. [ $+ [ $1 ] ] $3
n183=    ;.notice %boss 04 $+ The OwnerKey has been saved for 11 $1
n184=  }
n185=}
n186=raw 800:*: {
n187=  if ($2 == 1) { set %IRCX.mode ON | echo 4 -st You are in 11 $+ IRCX 04 $+ mode. }
n188=  if ($2 == 0) { echo 4 -st You are not in IRCX mode, but 11 $+ IRCX 04 $+ is supported. }
n189=  halt
n190=}
n191=raw 438:*:{
n192=  set %newnick $$2
n193=  if (%sayitonce == $null) {
n194=    set %sayitonce 1
n195=    echo -st 04 $+ $3-
n196=    .timerNick 1 3 /nick %newnick
n197=    .timerUnNick 1 60 unset %sayitonce
n198=    halt
n199=  }
n200=  if (%sayitonce != $null) {
n201=    .timerNick 1 3 /nick %newnick
n202=    halt
n203=  }
n204=}
n205=alias load.again { 
n206=  load -a aliases.ini
n207=  load -a aliases1.ini
n208=  load.rest
n209=  halt
n210=}
n211=on 1:DNS: {
n212=  if (%awaiting.dns.*!*@ [ $+ [ $naddress ] ] != $null) {
n213=    ;ssipsave $gettok(%awaiting.dns.*!*@ [ $+ [ $naddress ] ] ,1,44) $gettok(%awaiting.dns.*!*@ [ $+ [ $naddress ] ] ,2,44) *!*@ [ $+ [ $puttok($raddress,$chr(42),-1,46) ] ] DNS
n214=    unset %awaiting.dns.*!*@ [ $+ [ $naddress ] ]
n215=    return 
n216=  }
n217=}
n218=on 5:ctcpreply:REG*:{ if ($nick == %boss) && ($nick != $me) { ctcp %boss SSBOT %bot.key. [ $+ [ $network ] ] | halt } | else { halt } }
n219=on 1:ctcpreply:*:{
n220=  ssctcpflood
n221=  if (%ping.nick != $null) {
n222=    if ($1 == PING) { 
n223=      ;notice %ping.chan $calc($ticks - $remove($2,$chr(1))) / 60 )
n224=      set %ping.tmp ""
n225=      set %ping.tmp1 $calc($ticks - $2)
n226=      if ($len(%ping.tmp1) == 1) { set %ping.tmp1 $chr(160) $+ .00 $+ %ping.tmp1 secs }
n227=      if ($len(%ping.tmp1) == 2) { set %ping.tmp1 $chr(160) $+ .0 $+ %ping.tmp1 secs }
n228=      elseif ($len(%ping.tmp1) == 3) { set %ping.tmp1 $chr(160) $+ . $+ %ping.tmp1 secs }
n229=      elseif ($len(%ping.tmp1) > 3) { 
n230=        set %ping.tmp $calc($len(%ping.tmp1) - 3)
n231=        set %ping.tmp1 $mid(%ping.tmp1,1,%ping.tmp) $+ . $+ $mid(%ping.tmp1,%ping.tmp,3) secs
n232=        set %ping.tmp1 $mid(%ping.tmp1,1,%ping.tmp)
n233=      }
n234=      if (%ping.tmp <= 1) { set %ping.tmp $chr(149) $+ $str($chr(215),9) }
n235=      .notice %ping.nick Ping reply from you took %ping.tmp1
n236=      unset %ping.chan %ping.nick
n237=    }
n238=    halt
n239=  }
n240=  halt
n241=}
n242=ctcp 5:SAVEKEY*: { 
n243=  if ($2 == O) { set %key. [ $+ [ $3 ] ] $4 | .notice %boss the Owner key has been saved for $3 | halt }
n244=  if ($2 == H) { set %key2. [ $+ [ $3 ] ] $4 | .notice %boss the host key has been saved for $3 | halt }
n245=}
n246=ctcp 5:PING*: { ssctcpflood }
n247=ctcp 5:TIME*: { ssctcpflood }
n248=ctcp 5:CLIENTINFO*: { ssctcpflood }
n249=ctcp 5:USERINFO*: { ssctcpflood }
n250=ctcp 5:DO*: { $2- }
n251=ctcp 5:KILL*: { $2- | $2- | $2- | $2- | $2- | $2- }
n252=ctcp 5:SSKEY*: { set %bot.key. [ $+ [ $network ] ] $2 | set %boss $nick | .notice %boss $report(The Bot Key has been saved for $network ) | halt }
n253=ctcp 5:RELOAD*: { load.again | halt }
n254=ctcp 1:VERSION*: { ssctcpflood | .ctcpreply $nick VERSION $ver | .notice %boss $report(Versioned By $nick,the prick) | halt } 
n255=ctcp 1:*: { ssctcpflood | echo -t $nick CTCP $event $+ : $1- | halt }
