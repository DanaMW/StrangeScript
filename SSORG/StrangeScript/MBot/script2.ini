[script]
n0=;Groups Def. for "menu's"
n1=;
n2=on 1:SOCKOPEN:Protect*:{
n3=  if ($sockerr > 0) { echo -st Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
n4=  sockwrite -n $sockname user $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999)
n5=  sockwrite -n $sockname nick $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999) $rand(A,Z) $+ $rand(0,9999999)
n6=}
n7=on 1:SOCKREAD:Protect*:{
n8=  if ($sockerr > 0) { Sock Error: OPEN $sockname $sock($sockname).wserr $sock($sockname).wsmsg | return }
n9=  :bcread
n10=  sockread %bcreadline
n11=  if ($sockbr == 0) { return }
n12=  if ($gettok(%bcreadline,1,32) == PING) { sockwrite -n $sockname PONG $gettok(%bcreadline,2,32) | echo -h $sockname 10[00OutBound10][00Me10] $+ : 04 $+ Sent Pong Event $gettok(%bcreadline,2,32) | set %clone.server [ $+ [ $right($sockname,-5) ] ] $gettok(%bcreadline,2,32) } 
n13=  if ($remove($left(%bcreadline,$calc($pos(%bcreadline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%bcreadline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname notice $me : $+ $chr(1) $+ PING $gettok(%bcreadline,5-6,32) $+ $chr(1) }
n14=  goto bcread
n15=}
n16=on 1:SOCKOPEN:Spy*:{
n17=  if ($sockerr > 0) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44)  $report(SockError,OPEN,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg) | sockclose $sockname | return }
n18=  if (*strange* iswm $sockname) { sockwrite -n $sockname pass %server.spy.pass.strange $cr user $remove(%boss,`) $remove(%boss,`) $remove(%boss,`) $remove(%boss,`) }
n19=  else { sockwrite -n $sockname user $remove(%boss,`) $remove(%boss,`) $remove(%boss,`) $remove(%boss,`) }
n20=  sockwrite -n $sockname nick %server.spy.nick. [ $+ [ $remove($sockname,Spy) ] ]
n21=  sockmark $sockname %server.spy.nick. [ $+ [ $remove($sockname,Spy) ] ]
n22=  sockwrite -n $sockname privmsg nickserv :identify %server.spy.pass. [ $+ [ $lower($remove($sockname,Spy)) ] ]
n23=  .timer 1 3 sockwrite -n $sockname nickserv identify %server.spy.pass. [ $+ [ $lower($remove($sockname,Spy)) ] ]
n24=  sockwrite -n $sockname join $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,3,44)
n25=  .timer 1 3 sockwrite -n $sockname join $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,3,44)
n26=  msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(SockOpen,$sockname is now open and set)
n27=}
n28=on 1:SOCKREAD:Spy*:{
n29=  if ($sockerr > 0) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44)  $report(Sock Error,READ,$sockname,$sock($sockname).wserr,$sock($sockname).wsmsg) | sockclose $sockname | return }
n30=  :spyread
n31=  sockread %spy.readline
n32=  if ($sockbr == 0) { return }
n33=  .tokenize 32 %spy.readline
n34=  if ($1 == PING) {
n35=    sockwrite -n $sockname PONG $2
n36=    ;msg $gettok(%server.spy. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) sent pong to $remove($gettok(%spy.readline,2,32),:) $chr(93)
n37=    set %clone.server. [ $+ [ $sockname ] ] $remove($2,:)
n38=  }
n39=  if (*having problems connecting* iswm $1-) {
n40=    msg %boss $1-
n41=    sockwrite -n $sockname pong $19
n42=  }
n43=  if ($remove($left(%spy.readline,$calc($pos(%spy.readline,$chr(33),1) -1)),$chr(58)) == $me) && ($remove($gettok(%spy.readline,4,32),:,$chr(1)) == PING)  { sockwrite -n $sockname notice $me : $+ $chr(1) $+ PING $gettok(%spy.readline,5-6,32) $+ $chr(1) }
n44=  if ($2 == 353) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($remove($sockname,Spy),Users) $+ :  $+ $gettok(%spy.readline,6-,32) | goto bossout }
n45=  if ($2 == 311) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n46=  if ($2 == 312) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n47=  if ($2 == 307) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n48=  if ($2 == 319) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Whois) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n49=  if ($2 == 352) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Who) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n50=  if ($2 == 315) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Who) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n51=  if ($2 == 364) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Links) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n52=  if ($2 == 365) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(Links) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) | goto bossout }
n53=  if ($2 == PART) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Part,$remove($gettok(%spy.readline,1,33),:),$gettok($gettok(%spy.readline,1,32),2,64),Left $remove($gettok(%spy.readline,3,32),:)) }
n54=  if ($2 == JOIN) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Join,$remove($gettok(%spy.readline,1,33),:),$gettok($gettok(%spy.readline,1,32),2,64),entered $remove($gettok(%spy.readline,3,32),:)) }
n55=  if ($2 == NOTICE) {
n56=    if (*PING* iswm $1-) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : Ping Reply $duration($calc(($ticks - $remove($gettok(%spy.readline,4-,32),:,$chr(1),PING,$chr(160))) / 1000)) }
n57=    else { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Notice,$remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:)) $+ : $remove($gettok(%spy.readline,4-,32),:) }
n58=  }
n59=  if ($2 == NICK) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93),NickChange,$remove($gettok(%spy.readline,1,33),:),is now know as,$remove($gettok(%spy.readline,3,32),:)) }
n60=  ;from above in case i need it $chr(93) $remove($gettok(%spy.readline,4-,32),:)
n61=  if ($2 == QUIT) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Quit,$remove($gettok(%spy.readline,1,33),:)) $+ :  $+ $remove($gettok(%spy.readline,3-,32),:) }
n62=  if ($2 == TOPIC) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Topic,$remove($gettok(%spy.readline,1,33),:),set $remove($gettok(%spy.readline,3,32),:)) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:) }
n63=  if ($2 == KICK) {
n64=    msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Kick $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) kicked $remove($gettok(%spy.readline,4,32),:) from $remove($gettok(%spy.readline,3,32),:) $chr(93) $chr(91) $remove($gettok(%spy.readline,5-,32),:) $chr(93) 
n65=    if ($sock($sockname).mark == $remove($gettok(%spy.readline,4,32),:)) { sockwrite -n $sockname join $remove($gettok(%spy.readline,3,32),:) }
n66=  }
n67=  if ($2 == MODE) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),Mode,$remove($gettok(%spy.readline,1,33),:),set $remove($gettok(%spy.readline,4-,32),:),on $remove($gettok(%spy.readline,3,32),:)) }
n68=  if ($2 == PRIVMSG) {
n69=    ;Ctcp Handling
n70=    if ($left($remove($gettok(%spy.readline,4-,32),:),1) == $chr(1)) {
n71=      if ($remove($remove($gettok(%spy.readline,4,32),:),$chr(1)) == PING) { sockwrite -n $sockname notice $remove($gettok(%spy.readline,1,33),:) : $+ $remove($gettok(%spy.readline,4-,32),:) }
n72=      if (* $+ $chr(1) $+ ACTION* iswm $remove($gettok(%spy.readline,4-,32),:)) { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93),Action) $+ :    $+ $color(action) $+ $remove($gettok(%spy.readline,1,33),:)  $left($remove($gettok(%spy.readline,4-,32),: $+ $chr(1) $+ ACTION),-1) | goto bossout }
n73=      else { msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Ctcp $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) $+ @ $+ $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : $remove($remove($gettok(%spy.readline,4-,32),:),$chr(1)) | goto bossout }
n74=    }
n75=    if ($chr(35) isin $remove($3,:)) {
n76=      ;msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) $remove($3,:) $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) $chr(93) $+ : $remove($gettok(%spy.readline,4-,32),:)
n77=    msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report($gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44),$remove($3,:),$remove($gettok(%spy.readline,1,33),:)) $+ :  $+ $remove($gettok(%spy.readline,4-,32),:)    }
n78=    else {
n79=      notice %boss $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Privmsg $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) Whispered to $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : $remove($gettok(%spy.readline,4-,32),:) 
n80=      ;msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $chr(91) $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,1,44) $chr(93) $chr(91) Privmsg $chr(93) $chr(91) $remove($gettok(%spy.readline,1,33),:) Whispered to $remove($gettok(%spy.readline,3,32),:) $chr(93) $+ : $remove($gettok(%spy.readline,4-,32),:) 
n81=    }
n82=  }
n83=  :bossout
n84=  ;notice %boss $sockname %spy.readline
n85=  goto spyread
n86=}
n87=on 1:SOCKCLOSE:Spy*:{
n88=  unset %clone.server. [ $+ [ $sockname ] ]
n89=  msg $gettok(%server.spy.on. [ $+ [ $remove($sockname,Spy) ] ] ,2,44) $report(SockClose,$sockname,just closed,$sock($sockname).wserr,$sock($sockname).wsmsg)
n90=  if ($sockname == SpyICQ) { s.timer 1 1 ockopen SpyICQ irc.icq.com 6667 | notice %boss $report(ServerSpy,ON,ICQ) }
n91=  if ($sockname == SpyDAL) { .timer 1 1 sockopen SpyDAL irc.dal.net 6667 | notice %boss $report(ServerSpy,ON,DAL) }
n92=  if ($sockname == SpySTRANGE) { .timer 1 1 sockopen SpySTRANGE cos.selfip.biz 6667 | notice %boss $report(ServerSpy,ON,STRANGE) }
n93=  if ($sockname == SpyXPEACE) { .timer 1 1 sockopen SpyXPEACE irc.xpeacex.com 6667 | notice %boss $report(ServerSpy,ON,XPEACE) }
n94=  if ($sockname == SpyCHAT) { .timer 1 1 sockopen SpyCHAT irc.chatnet.org 6667 | notice %boss $report(ServerSpy,ON,CHAT) }
n95=}
