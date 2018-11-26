[script]
n0=on *:ACTION:*:#:{
n1=  if (%easy.room != $null) && (# == %easy.room) && ($left($strip($1-),1) != >) && ($left($strip($1-),1) != .) {
n2=    if ($sock(Spy [ $+ [ %easy.server ] ] ) != $null) { .timer 1 0 sockwrite -n Spy $+ %easy.server privmsg $gettok(%server.spy.on. [ $+ [ %easy.server ] ] ,3,44) : $+ $chr(1) $+ ACTION ( $+ $nick $+ ) $1- $+ $chr(1) }
n3=  }
n4=}
n5=on *:TEXT:*:#: {
n6=  if ($nick == $chan(#)) { halt }
n7=  if ($nick == $me) { halt }
n8=  if (%boss.repeat == ON) { .msg # On # %boss said: $1- }
n9=  if (%easy.room != $null) && (# == %easy.room) && ($left($strip($1-),1) != >) && ($left($strip($1-),1) != .) {
n10=    if ($sock(Spy [ $+ [ %easy.server ] ] ) != $null) {
n11=      if ($nick == %boss) { .timer 1 0 sockwrite -n Spy $+ %easy.server privmsg $gettok(%server.spy.on. [ $+ [ %easy.server ] ] ,3,44) : $+ $1- }
n12=      else { .timer 1 0 sockwrite -n Spy $+ %easy.server privmsg $gettok(%server.spy.on. [ $+ [ %easy.server ] ] ,3,44) : $+ ( $+ $nick $+ ) $1- }
n13=    }
n14=  }
n15=  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,%spy1,$null,$nick, $+ $1-) }
n16=  if ($level($address($nick,4)) = 5) || ($level($address($nick,1)) = 5) || ($level($address($nick,4)) = 4) || ($level($address($nick,1)) = 4) {
n17=    ;if (# == #COS) && (*stats* iswm $1-) { msg # Get room and server stats at http://www.strangeout.com/~stats }
n18=    if (%LM.editor == ON) { if (%LM.chan != #) { halt } | MenuPicks $1- | halt }
n19=    if ($strip($1) == /) || ($strip($1) == .) || ($strip($1) == ..) || ($strip($1) == .cmd) { halt }
n20=    if ($strip($1-) = $me) {
n21=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n22=      .msg # yes?
n23=      .enable #DoCommand
n24=      halt
n25=    }
n26=    ;#.help Format: .help [[.]<command>] (Makes the bot show the complete command list or the specified command.)
n27=    if ($strip($1) == .help) {
n28=      write -c bothelp.txt
n29=      if ($2 == $null) {
n30=        .msg # Please wait while i extract the help, this may take a minute
n31=        var %tmp = 1
n32=        while (%tmp <= $lines(script1.ini)) {
n33=          var %tmp1 = $read(script1.ini,n,%tmp)
n34=          if (*;#.* iswm %tmp1) { var %tmp1 = $remove(%tmp1,;#) | var %tmp1 = $gettok(%tmp1,2,32) | var %tmp2 = %tmp2 $lower(%tmp1) }
n35=          inc %tmp
n36=          if ($numtok(%tmp2,32) == 15) { .msg # %tmp2 | var %tmp2 }
n37=          if (%tmp > $lines(script1.ini)) { break }
n38=        }
n39=        if (%tmp2 != $null) { .msg # %tmp2 }
n40=        .msg # For help on a specific command try .help <command>
n41=        ;.notice $nick For a complete list of commands try .help
n42=        halt
n43=      }
n44=      else {
n45=        .msg # Please wait while i extract the help, this may take a minute
n46=        var %tmp = 1
n47=        var %cleanup = $remove($2,.)
n48=        while (%tmp <= $lines(script1.ini)) {
n49=          var %tmp1 = $read(script1.ini,n,%tmp)
n50=          var %tmp2 = $chr(42) $+ ;#. $+ %cleanup $+ $chr(42)
n51=          if (%tmp2 iswm %tmp1) { .msg # $gettok(%tmp1,3-,32) | unset %tmp1 | break }
n52=          inc %tmp
n53=          if (%tmp > $lines(script1.ini)) { break }
n54=        }
n55=        if (%tmp1 != $null) { .msg # No help found for %cleanup }
n56=        .msg # For a complete list of commands try .help
n57=        halt
n58=      }
n59=    }
n60=    ;&& (%tmp != 35) && (%tmp != 49) 
n61=    ;
n62=    if ($strip($1) == $chr(63) $+ $chr(63)) { SSpy.Help | halt }
n63=    ;#.alias Format: .alias (Shows infomation on a given alias)
n64=    if ($strip($1) == .alias) {
n65=      if ($isalias($2) != $true) { .msg # The alias $2 was not found | halt  }
n66=      else { .msg # Alias  $2 is in $isalias($2).fname }
n67=      halt
n68=    }
n69=    ;#.aj Format: .aj (Joins all set autojoin rooms.)
n70=    if ($strip($1) == .AJ) { .raw join %autojoin | .msg # $report(AutoJoin All,$null,Joined,%autojoin) | halt }
n71=    ;#.sop Format: .SOP <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] (Configures the join auto owner settings.)
n72=    ;#.aop Format: .AOP <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] (Configures the join auto ops settings.)
n73=    ;#.hop Format: .HOP <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] (Configures the join half ops settings.)
n74=    if ($strip($1) == .SOP) || ($strip($1) == .AOP) || ($strip($1) == .HOP) {
n75=      if ($2 == $null) { .msg # Format: $upper($1) <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] | halt }
n76=      UP.Service # $remove($strip($1-),.)
n77=      halt
n78=    }
n79=    ;#.autojoin Format: .autojoin <ON|OFF|SPEED|ADD|DEL|SHOW> [#room] (Configures the autojoin for the bot.)
n80=    if ($strip($1) == .AUTOJOIN) {
n81=      if ($2 == $null) { .msg # Format: .autojoin <ON|OFF|SPEED|ADD|DEL|SHOW> [<#room>] | halt }
n82=      if ($2 == SHOW) { .msg # $report(Current,$null,$null,%autojoin) | halt }
n83=      if ($2 == ADD) { set %autojoin $addtok(%autojoin,$3,44) | .msg # $report(Current,$null,$null,%autojoin) | halt }
n84=      if ($2 == DEL) { set %autojoin $remtok(%autojoin,$3,1,44) | .msg # $report(Current,$null,$null,%autojoin) | halt }
n85=      if ($2 == ON) { set %do.autojoin ON | .msg # $report(Current,$null,$null,%do.autojoin) | halt }
n86=      if ($2 == OFF) { set %do.autojoin OFF | .msg # $report(Current,$null,$null,%do.autojoin) | halt }
n87=      if ($2 == SPEED) { set %do.autojoin SPEED | .msg # $report(Current,$null,$null,%do.autojoin) | halt }
n88=      halt
n89=    }
n90=    ;#.away Format: .away <reason> (Sets the bot away.)
n91=    if ($strip($1) == .AWAY) { if ($2 != $null) { .ctcp # AWAY $2- | /away $2- | /ame is away: $2- | halt } | else { .ctcp # AWAY Out | /away out | /ame is away: out | halt } }
n92=    ;#.blast Format: .blast <nick> (Insults the shit out of <nick>.)
n93=    if ($strip($1) == .blast) { if ($2 == $null) { .msg # $report(Format,$null,$null,.blast <nick>) | halt } | else { /blast $2 # | halt } }
n94=    ;#.bnc Format: .bnc <ip> (Logs into a bnc with the bot.)
n95=    if ($strip($1) == .bnc) { if ($2 == $null) { msg # Format: .bnc <ip> Example: .bnc 123.456.789.123 | halt } | server $2 $+ : $+ %BNC.port | halt }
n96=    ;#.bncsetup Format: .bncsetup <PORT|PASS[WORD]|SERVER> <value> (Sets up the user info for the BNC.)
n97=    if ($strip($1) == .bncsetup) {
n98=      if ($2 == $null) { msg # Format: .bncsetup <PORT|PASS[WORD]|SERVER> <value> | halt }
n99=      if ($2 == Port) { set %BNC.port $3 | msg # $report(BNC Setup,PORT,$null,$null,%BNC.port) | halt }
n100=      if ($2 == PASSWORD) || ($2 == PASS) { set %BNC.pass $3 | msg # $report(BNC Setup,PASSWORD,$null,$null,%BNC.pass) | halt }
n101=      if ($2 == SERVER) { set %BNC.server $3 | msg # $report(BNC Setup,SERVER,$null,$null,%BNC.server) | halt }
n102=      halt
n103=    }
n104=    ;#.back Format: .back (Sets the bot back.)
n105=    if ($strip($1) == .back) { .ctcp # AWAY | away | ame is back | halt }
n106=    ;#.boot Format: .boot <nick> [channel] (Kicks the given nick out of the active room or [channel].)
n107=    if ($strip($1) == .boot) {
n108=      if ($2 == $null) { msg # $report(Format,$null,$null,.boot <nick> or .boot <nick> <channel>) | halt }
n109=      if ($3 == $null) { .kick # $2 BAM | halt }
n110=      else { .kick $3 $2 BAM | halt }
n111=    }
n112=    ;#.boss Format: .boss (Sets yourself boss in the bot and registers it.)
n113=    if ($strip($1) == .boss) { if ($level($address($nick,4)) != 5) { halt } | set %boss $nick | .notice %boss $report(Boss,Set,%boss) | .ctcp %boss SSBOT %bot.key. [ $+ [ $network ] ] | halt }
n114=    ;#.cb Format: .cb (Runs Check.Boss)
n115=    if ($strip($1) == .cb) {
n116=      ;if ($nick != %boss) { .msg # This is a %boss only command | halt }
n117=      Check.boss Strange
n118=      halt
n119=    }
n120=    ;#.cnn Format: .cnn [<-r|-u>] [<NUM>] (Gets CNN News or URL.)
n121=    if ($strip($1) == .cnn) { cnn # $nick $2- | halt }
n122=    ;#.cycle Format: .cycle [<channel>] (Cycles the current or given channel.)
n123=    if ($strip($1) == .cycle) { if ($2 == $null) { .raw part $chan $cr join $chan %key. [ $+ [ $chan ] ] | halt } | else { .raw part $2 | .raw join $2 %key. [ $+ [ $2 ] ] | halt } }
n124=    ;#.cycleall Format: .cycleall (Cycles all channels.)
n125=    if ($strip($1) == .cycleall) { cycleall | halt }
n126=    ;#.dcc Format: .dcc (Causes the bot to dcc chat the boss.)
n127=    if ($strip($1) == .dcc) { .dcc chat %boss | halt }
n128=    ;#.deop Format: .deop <nick> [channel] (Makes the bot deop <nick> in current room or [channel].)
n129=    if ($strip($1) == .deop) { if ($2 == $null) { msg # $report(Format,$null,$null,.deop <nick> or .deop <nick> <channel>) | halt } | if ($2 == %boss) { halt } | if ($3 == $null) { .raw mode $chan -o $2 | halt } | else { .raw mode $3 -o $2 | halt } }
n130=    ;#.deq Format: .deq <nick> [channel] (Makes the bot deq <nick> in current room or [channel].)
n131=    if ($strip($1) == .deq) { if ($2 == $null) { msg # $report(Format,$null,$null,.deq <nick> or .deq <nick> <channel>) | halt } | if ($3 == $null) { .raw mode $chan +o $2 | halt } else { .raw mode $3 -o $2 | halt } }
n132=    ;#.dns Format: .dns <-s(STATS)|-i(INFO)|-d(DIG)> [<domian.name>] (Manages ISC BIND dns server.)
n133=    if ($strip($1) == .dns) {
n134=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n135=      if ($2 == $null) { msg # Format: .dns <-s(STATS)|-i(INFO)|-d(DIG)> [<domian.name>] (Manages ISC BIND dns server.) | halt }
n136=      if ($exists(c:\temp\temp.txt) == $true) { .remove c:\temp\temp.txt }
n137=      if ($2 == -s) {
n138=        %method # Generating Bind DNS statistics, one minute ...
n139=        .remove c:\dns\etc\namedb\named.stats
n140=        .run -np c:\dns\bin\rndc.exe stats
n141=        .timer 1 3 .play # c:\dns\etc\namedb\named.stats 100
n142=        halt
n143=      }
n144=      if ($2 == -i) {
n145=        %method # Gathering running server info, one minute ...
n146=        .run -n cmd.exe /c C:\dns\bin\rndc.exe status > temp.txt
n147=        ;if ($exists(temp.txt) == $false) { msg # Error playing file, the fucking thing is missing | halt }
n148=        .timerlll 1 3 .play # temp.txt 100
n149=        halt
n150=      }
n151=      if ($2 == -d) {
n152=        if ($3 == $null) { halt }
n153=        %method # Running dig $3- $+ , one minute ...
n154=        .run -n cmd.exe /c C:\dns\bin\dig.exe $3-  > temp.txt
n155=        if ($exists(temp.txt) == $false) { msg # Error playing file, the fucking thing is missing | halt }
n156=        else { .timer 1 3 play.filter # temp.txt }
n157=        ;.timerldl 1 3 .play # temp.txt 100
n158=        halt
n159=      }
n160=      halt
n161=    }
n162=    ;#.domath Format: .domath <##> <+-*/> <##> <+-*/> <##> (Does the entered math calulation.)
n163=    if ($strip($1) == .domath) { if ($2 == $null) { msg # Format: .domath <##> <+-*/> <##> <+-*/> <##> | halt } | .msg # $report(Math Calc,$null,Done,$calc($2-)) | halt }
n164=    ;#.exit Format: .exit (Makes the bot exit.)
n165=    if ($strip($1) == .exit) { .msg # $report(Exit,Done) | .timer 1 1 quit $replace($2-,$chr(32),$chr(160)) | .timer -o 1 2 exit | halt }
n166=    ;#.gen Format: .gen <#room> (Generates stats for the given room.)
n167=    if ($strip($1) == .gen) {
n168=      if ($2 == $null) { .msg # Format: .gen <#room> (Generates stats for the given room.) }
n169=      var %tmp.stat = $remove($2,$chr(35))
n170=      var %tmp.stat1 = D:\SS\MircStats\Config\ $+ %tmp.stat $+ .cfg
n171=      if ($exists(%tmp.stat1)  == $true) {
n172=        .msg # Generating Stats for $chr(35) $+ %tmp.stat $+ ....
n173=        .timerSTATS. $+ %tmp.stat 1 30 msg # Located: http://www.strangeout.com/~stats/ $+ %tmp.stat $+ /
n174=        ;.run -np %tmp.stat1
n175=        .run -np D:\SS\MircStats\mircstats.exe -c %tmp.stat $+ .cfg
n176=      }
n177=      if ($exists(%tmp.stat1)  == $false) { .msg # There is no configuration file for that room. Youll need to make one huh. }
n178=      halt
n179=    }
n180=    ;#.quit Format: .quit <reason> (Makes the bot quit.)
n181=    if ($strip($1) == .quit) { .msg # $report(Exit,Done) | .timer 1 1 quit $replace($2-,$chr(32),$chr(160)) | .timer -o 1 2 exit | halt }
n182=    ;#.heel Format: .heel (Makes the bot deop itself.)
n183=    if ($strip($1) == .heel) { .raw mode # -o $me | halt }
n184=    ;#.ident Format: .ident (Makes the bot identify to chanserv using saved password.)
n185=    ;#.identify Format: .identify (Makes the bot identify to chanserv using saved password.)
n186=    if ($strip($1) == .identify) || ($strip($1) == .ident) { if (*dal.net iswm $server) { nickserv identify %irc.nick.pass } | else { /msg nickserv identify %irc.nick.pass } | halt }
n187=    ;#.ignore Format: .ignore <nick/ip> (Makes the bot ignore given <nick or ip> for 15 minutes.)
n188=    if ($strip($1) == .ignore) { if ($2 == $null) { msg # Format: .ignore <nick/ip> | halt } | .ignore -u900 $2 | .msg # $report(Ignore,$2,Added) | halt }
n189=    ;#.ircx Format: .ircx (Makes the bot set itself to ircx mode.)
n190=    if ($strip($1) == .ircx) { .ircx | .msg # $report(IRCx Mode,$null,Set) | halt }
n191=    ;#.invite Format: .invite <nick> [channel] (Makes the bot invite <nick> to current channel or to [channel].)
n192=    if ($strip($1) == .invite) { if ($2 == $null) { msg # Format: .invite <nick> or .invite <nick> <channel> | halt } | if ($3 == $null) { .invite $2 # | .msg # $report(Invite,$2,#) | halt } | else { .invite $2 $3 | .msg # $report(Invite,$2,$3) | halt } }
n193=    ;#.join Format: .join <#room> [key] (Makes the bot join <#channel>.)
n194=    if ($strip($1) == .join) { if ($2 == $null) { msg # Format: .join <#room> or .join <#room> <key> | halt } | .join $2 $3 | .msg # $report(Joined,$2) | halt }
n195=    ;#.kick Format: .kick [<channel>] <nick> <message> (Makes the bot kick <nick> on current channel or on [channel].)
n196=    if ($strip($1) == .kick) {
n197=      if ($2 == $null) { msg # Format: .kick [<channel>] <nick> <message> | halt }
n198=      if ($2 == %boss) { halt }
n199=      if ($chr(35) isin $2) { .kick $2 $3 $4- | halt } | else { .kick # $2 $3- | halt }
n200=    }
n201=    ;#.lag Format: .lag (Shows the bots lag on the server.)
n202=    if ($strip($1) == .lag) {
n203=      if ($2 == silent) { .notice %boss $report(Lag Report,$server,%Lag.mrc) | halt }
n204=      else { msg # $report(Lag Report,$server,%Lag.mrc) | halt }
n205=    }
n206=    ;#.LiveMenu Format: .livemenu (Enters the interactive ip to ip mirc ini editor.)
n207=    if ($strip($1) == .livemenu) {
n208=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n209=      ;if ($2 == $null) { msg #.LiveMenu Format: .livemenu (Enters the interactive ip to ip mirc ini editor.) | halt }
n210=      LiveMenu # $nick
n211=      ;  if ($2 == silent) { .notice %boss $report(Lag Report,$server,%Lag.mrc) | halt }
n212=      ;  else { msg # $report(Lag Report,$server,%Lag.mrc) | halt }
n213=    }
n214=    ;#.log Format: .log <-s ON/OFF|-q ON/OFF|ON|OFF|SHOW> (Turns log reads on or off.)
n215=    if ($strip($1) == .log) {
n216=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n217=      if ($2 == $null) { .msg # Format: .log <-s ON/OFF|-q ON/OFF|ON|OFF|SHOW> (Turns log reads on or off.) | halt }
n218=      LOG.ADJUST # $2-
n219=      halt
n220=    }
n221=    ;#.login Format: .login <server> (Makes the bot login to <server address:port>.)
n222=    if ($strip($1) == .login) { if ($nick != %boss) { .msg # This is a %boss only command | halt } | server $2- }
n223=    ;#.auser Format: .auser <nick> (Adds a user to the UserList)
n224=    if ($strip($1) == .auser) {
n225=      if ($2 == $null) { msg # Format: .auser <nick> | halt }
n226=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n227=      auser 4 $address($2,4) $2
n228=      .msg # I am now stuck taking orders from $2 $+ , sucks to be me.
n229=      halt
n230=    }
n231=    ;#.ruser Format: .ruser <nick> (Removes a user from the UserList)
n232=    if ($strip($1) == .ruser) {
n233=      if ($2 == $null) { msg # Format: .ruser <nick> | halt }
n234=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n235=      ruser $2
n236=      .msg # Thanks for getting $2 the fuck off my back.
n237=      halt
n238=    }
n239=    ;#.luser Format: .luser (Lists the users in the UserList)
n240=    if ($strip($1) == .luser) {
n241=      msg # Extracting UserList
n242=      var %tmpul = 1
n243=      while (%tmpul <= $ulist(*,0)) {
n244=        .msg # ( $+ %tmpul $+ ) $ulist(*,%tmpul) $ulist(*,%tmpul).info
n245=        inc %tmpul
n246=        if (%tmpul > $ulist(*,0)) { break }
n247=      }
n248=      msg # Done.
n249=    }
n250=    ;#.mail Format: .mail <on|off|-u> [<nick>] (Checks for CNN Breaking news or if USER has mail.)
n251=    if ($strip($1) == .mail) {
n252=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n253=      if ($2 == $null) { .msg # Format: .mail <on|off|-u> [<nick>] (Checks for CNN Breaking news or if USER has mail.) | halt }
n254=      if ($2 == ON) { .timerMAIL 0 120 mail #COS | set %mail.run ON | msg # MailCheck is now %mail.run | halt }
n255=      if ($2 == OFF) { .timerMAIL OFF | set %mail.run OFF | unset %mail.user | set %mail.write OFF | msg # MailCheck is now %mail.run | halt }
n256=      if ($2 == -u) { mail #COS $3 | halt }
n257=      halt
n258=    }
n259=    ;#.menu Format: .menu (Enables the Spy Menu.)
n260=    if ($strip($1) == .menu) { if ($nick != %boss) { .msg # This is a %boss only command | halt } | .enable #Menu | msg # $report(Spy Menu,ON) | menu # | halt }
n261=    ;#.base Format: .base <NICK|CHANNEL> (Sets up the base (User/#room reported to).)
n262=    if ($strip($1) == .base) {
n263=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n264=      if ($2 != $null) { set %base $2 | goto ch1 | halt }
n265=      .msg # Format: .base <NICK|CHANNEL>  (Sets up the base (User or #room reported to).) 
n266=      :ch1
n267=      .msg # Your Current settings are: METHOD( $+ %method $+ ) BASE( $+ %base $+ )
n268=      halt
n269=    }
n270=    ;#.method Format: .method <MSG|NOTICE NICK|CHANNEL> (Sets up the bot play method.)
n271=    if ($strip($1) == .method) {
n272=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n273=      if ($2 == MSG) || ($2 == NOTICE) && ($3 != $null) { set %method . $+ $2 | set %base $3 | goto ch2 | halt }
n274=      .msg # Format: .method <MSG|NOTICE NICK|CHANNEL> (Sets up the bot play method.) 
n275=      :ch2
n276=      .msg # Your Current settings are: METHOD( $+ %method $+ ) BASE( $+ %base $+ )
n277=      halt
n278=    }
n279=    ;#.mk Format: .mk (Makes the bot mass kick current room.)
n280=    if ($strip($1) == .mk) { if ($nick != %boss) { .msg # This is a %boss only command | halt } | mkall # | .cycle | halt }
n281=    ;#.take Format: .take (Makes the bot try to take the current room.)
n282=    if ($strip($1) == .take) { 
n283=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n284=      .raw access # clear $cr access # add host *!*@*
n285=      /mkall #
n286=      halt
n287=    }
n288=    ;#.mode Format: .mode <raw command> (Makes the bot send a server raw.)
n289=    if ($strip($1) == .mode) {
n290=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n291=      .mode $2 $3 $4 $5 $6 $7 $8 $9 | set %report Mode Set $2 | /report1 # Done
n292=      halt
n293=    }
n294=    ;#.nick Format: .nick <base nick> (Changes the bots nick to <base nick>[#####].)
n295=    if ($strip($1) == .nick) { .nick $2 $+ $chr(91) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $chr(93) | halt }
n296=    ;#.bnick Format: .bnick [INC/LONG] <base nick> (Changes all the bots nick to <base nick>[#] or <base nick>[#####].)
n297=    if ($strip($1) == .bnick) { 
n298=      if ($2 == inc) { .nick $3 $+ $chr(91) $+ $right($remove($nopath($mircini),.ini),-3) $+ $chr(93) | halt }
n299=      if ($2 == long) { .nick $2 $+ $chr(91) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $chr(93) | halt }
n300=      if ($2 != inc) && ($2 != long) { .nick $3 $+ $chr(91) $+ $right($remove($nopath($mircini),.ini),-3) $+ $chr(93) | halt }  
n301=    }
n302=    ;#.o Format: .o [nick] (makes the bot op the boos or [nick] on current channel.)
n303=    if ($strip($1) == .o) { if ($2 == $null) { .raw mode $chan +o $nick | halt } | if ($2 == ?) { .raw mode $chan +o %lastjoin. [ $+ [ $chan ] ] | halt } | else { .raw mode $chan +o $2 | halt } }
n304=    ;#.oper  Format: .oper (makes the bot send /Oper to the server.)
n305=    if ($strip($1) == .oper) {
n306=      if (%irc.oper.nick == $null) { msg # No nick is saved to oper with. Use .raw set % $+ irc.oper.nick <value> | halt }
n307=      if ( %irc.oper.pass == $null) { msg # No pass is saved to oper with. Use .raw set % $+ irc.oper.pass <value> | halt }
n308=      if ($2 == $null) {
n309=        .raw oper %irc.oper.nick %irc.oper.pass
n310=        msg # Oper has been sent
n311=        halt
n312=      }
n313=    }
n314=    ;#.unoper Format: .unoper (makes the bot send /Unoper to the server. Works only if supprted.)
n315=    if ($strip($1) == .unoper) { if ($2 == $null) { .raw unoper | halt } }
n316=    ;#.part Format: .part [<channel>] (Parts current or given channel.)
n317=    if ($strip($1) == .part) {
n318=      if ($2 == $null) { part # | halt }
n319=      if ($2 != $null) {
n320=        if ($chr(35) !isin $2) { .msg # $report(Part,Cant part,Invalid room name) | halt }
n321=        else { part $2 | .msg # $report(Parted,$2) | halt }
n322=      }
n323=    }
n324=    ;#.ping Format: .ping [<nick|channel>] (Pings you,  nick or channel. )
n325=    if ($strip($1) == .ping) {
n326=      if ($2 == $null) { set %ping.chan # | set %ping.nick $nick | .raw -q privmsg $nick : $+ $chr(1) $+ PING $ticks $+ $chr(1) | halt }
n327=      if ($2 != $null) {
n328=        set %ping.chan #
n329=        if ($chr(35) isin $2) { unset %ping.nick }
n330=        else { set %ping.nick $2 }
n331=        .raw -q privmsg $2 : $+ $chr(1) $+ PING $ticks $+ $chr(1)
n332=        halt
n333=      }
n334=    }
n335=    ;#.pound Format: .pound <channel> (Make the bot(s) try to join a room hundreds of times a minute.)
n336=    if ($strip($1) == .pound) { if ($me ison $2) { halt } | else { set %pound $2 | set %pound %pound $+ $chr(44) | set %pound $str(%pound,20) | set %pound.active ON | /pound | set %report Pound on $2 | /report1 # Engaged | halt } }
n337=    ;#.prop Format: .prop [channel] (Sets the props on current channel or [channel].)
n338=    if ($strip($1) == .prop) {
n339=      if ($2 == $null) {
n340=        if (%key. [ $+ [ # ] ] != $null) { /prop # OWNERKEY %key. [ $+ [ # ] ] }
n341=        if (%key2. [ $+ [ # ] ] != $null) { .prop # HOSTKEY %key2. [ $+ [ # ] ] }
n342=        .raw mode # +ntw
n343=        halt
n344=      }
n345=      if ($2 != $null) {
n346=        if (%key. [ $+ [ $2 ] ] != $null) { /prop $2 OWNERKEY %key. [ $+ [ $2 ] ] }
n347=        if (%key2. [ $+ [ $2 ] ] != $null) { .prop $2 HOSTKEY %key2. [ $+ [ $2 ] ] }
n348=        .raw mode $2 +ntw
n349=        set %report Props in $2 | /report1 # Set
n350=        halt
n351=      }
n352=    }
n353=    ;#.put Format: .put <channel> <text> (Makes the bot say <text> on <channel>.)
n354=    if ($strip($1) == .put) { msg $2 $3- | halt }
n355=    if ($strip($1) == .unmask) { if ($2 == $null) { msg # You must include the nick | halt } | unmask $gettok($address($2,2),2,64) $2 | halt }
n356=    ;#.q Format: .q or .q <nick> or .q <nick> ALOT (Makes the bot +q the boss or <nick> or +qqqqqq <nick>.)
n357=    if ($strip($1) == .q) {
n358=      if ($2 == $null) { .raw mode # +q $nick | halt }
n359=      elseif ($2 == ?) { .raw mode $chan +q %lastjoin. [ $+ [ $chan ] ] | halt }
n360=      else { .raw mode # +q $2 | halt }
n361=    }
n362=    ;#.rand Format: .rand (Gives the bot a random lettered nick.)
n363=    if ($strip($1) == .rand) { .nick $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) | halt }
n364=    ;#.raw Format: .raw <raw command> (This is a %boss only command)
n365=    if ($strip($1) == .raw) {
n366=      if ($2 == $null) { .msg # $report(Format,$null,$null,.raw <raw command>,This is a %boss only command) | halt }
n367=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n368=      $replace($2-,$chr(160),$chr(32))
n369=      .msg # $report(Raw,$null,Sent,$2-)
n370=      halt
n371=    }
n372=    ;#.remkey Format: .remkey (Deletes the owner and host key on the current channel.)
n373=    if ($strip($1) == .remkey) { unset %key. [ $+ [ # ] ] | unset %key2. [ $+ [ # ] ] | set %report OwnerKey and Hostkey | /report1 # Deleted | halt }
n374=    ;#.recover Format: .recover <#> <nick> (The given bot number recovers given nickname.)
n375=    if ($strip($1) == .recover) { 
n376=      if ($2 == $null) { msg # Format: .recover <#> <nick> (The given bot number recovers given nickname.) | halt }
n377=      if ($2 == OFF) { .timerREC OFF | unset %recover | .msg # $report(Recover,Off) | halt }
n378=      elseif ($2 == $me) { set %recover $3 | msg # $report(Recover,Attempting to recover,%recover) | recover | halt }
n379=      elseif ($2 == $mid($nopath($mircini),4,1)) { set %recover $3 | msg # $report(Recover,Attempting to recover,%recover) | recover | halt }
n380=      else { halt }
n381=    }
n382=    ;#.reload Format: .reload (reloads the bots scripts)
n383=    if ($strip($1) == .reload) {
n384=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n385=      load.again
n386=    }
n387=    ;#.reup Format: .reup (Causes the bot to restart)
n388=    if ($strip($1) == .reup) {
n389=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n390=      server $server
n391=    }
n392=    ;#.safe Format: .safe (Goes into Safe mode ignoring everything except you)
n393=    if ($strip($1) == .safe) { .ignore -u60 *!*@* | halt }
n394=    ;#.scanlog Format: .scanlog ON/OFF/SET (Reads %boss the scanlog as it happens.)
n395=    if ($strip($1) == .scanlog) {
n396=      if ($2 == $null) { msg # Format: .scanlog ON/OFF/SET (Reads %boss the scanlog as it happens.) | halt }
n397=      if ($2 == ON) { .timerSCANLOG -m 0 100 SL.PLAY | msg # $report(ScanLog,Play,Enabled) | halt }
n398=      if ($2 == OFF) { .timerSCANLOG OFF | msg # $report(ScanLog,Play,Disabled) | halt }
n399=      if ($2 == SET) { }
n400=      halt
n401=    }
n402=    ;#.shit Format: .shit <ON|OFF|-a (ADD)|-d (DEL)|-c (CLEAR)|-l (LIST)|-s (SHOW)> <IP>  (manages the shitlist)
n403=    if ($strip($1) == .shit) {
n404=      if ($2 == $null) { .msg # $report(Format,$null,$null,.shit <ON|OFF|-a (ADD)|-d (DEL)|-c (CLEAR)|-l (LIST)|-s (SHOW)> <IP> ) | halt }
n405=      if ($2 == -s) { .msg # $report(ShitList,$null,List,%shitlist,%shitlist.Do) | halt }
n406=      if ($2 == -l) { .msg # $report(ShitList,$null,List,%shitlist,%shitlist.Do) | halt }
n407=      if ($2 == ON) { set %shitlist.Do ON | .msg # $report(ShitList,Set,%shitlist.Do,%shitlist) | halt }
n408=      if ($2 == OFF) { set %shitlist.Do OFF | .msg # $report(ShitList,Set,%shitlist.Do,%shitlist) | halt }
n409=      if ($2 == -a) {
n410=        if ($3 == $null) { .msg # $report(Format,$null,$null,.shit -add <IP>) | halt }
n411=        if ($3 != $null) {
n412=          var %tmpip = $3
n413=          if ($istok(%shitlist,%tmpip,44) == $true) { .msg # $report(ShitList,%tmpip,Error,That IP is already in the shitlist,%shitlist) | halt }
n414=          else { set %shitlist $addtok(%shitlist,%tmpip,44) | .msg # $report(ShitList,%tmpip,Add,%shitlist,%shitlist.Do) | halt }
n415=        }
n416=      }
n417=      if ($2 == DEL) {
n418=        if ($3 == $null) || ($3 !isnum) {
n419=          .msg # $report(Format,$null,$null,.shit -d <IP>)
n420=          var %tmp = 1
n421=          while (%tmp <= $numtok(%shitlist,44)) {
n422=            .msg # $report(%tmp) $report($null,$gettok(%shitlist,%tmp,44))
n423=            inc %tmp
n424=            if (%tmp > $numtok(%shitlist,44)) { break }
n425=          }
n426=          halt
n427=        }
n428=        if ($3 != $null) && ($3 isnum) { .msg # $report(ShitList,$null,Delete,$gettok(%shitlist,$3,44),%shitlist.Do) | set %shitlist $deltok(%shitlist,$3,44) | halt }
n429=      }
n430=      if ($2 == CLEAR) { set %shitlist "" | .msg # $report(ShitList,%tmpip,Clear,*,%shitlist.Do) | halt }
n431=    }
n432=    ;#.say Format: .say <text> or .say <numberoftimes> <text> or .say <numberoftimes> <channel> <text>) (Puts text to active or given channel)
n433=    if ($strip($1) == .say) {
n434=      if ($2 == $null) { msg # $report(Format,$null,$null,.say <text> or .say <numberoftimes> <text> or .say <numberoftimes> <channel> <text>) | halt }
n435=      if ($2 !isnum) {
n436=        if ($chr(35) isin $2) { /msg $2 $3- | halt }
n437=        else { .msg # $2- | halt }
n438=      }
n439=      if ($2 isnum) {
n440=        set %tmp 1
n441=        if ($chr(35) isin $3) { while (%tmp <= $2) { .msg $3 $4- | inc %tmp | if (%tmp > $2) { break } } }
n442=        if ($chr(35) !isin $3) { while (%tmp <= $2) { .msg # $3- | inc %tmp | if (%tmp > $2) { break } } }
n443=        unset %tmp
n444=        halt
n445=      }
n446=    }
n447=    ;#.slc Format: .slc <-s (SHOW)|-r (RESET)> (Configures the Security Log)
n448=    if ($strip($1) == .slc) { slc $2- | halt }
n449=    ;#.seen Format: .seen <nick> (last time a nick was seen and where)
n450=    if ($strip($1) == .seen) {
n451=      if ($2 == $null) { msg # $report(Format,$null,$null,.seen <nick>) | halt }
n452=      else { 
n453=        var %tmp.x = $gettok($mircdir,1,92) $+ $chr(92) $+ $gettok($mircdir,2,92) $+ $chr(92) $+ text\LastSeen.txt
n454=        var %tmp.xx = $read(%tmp.x,s,$2)
n455=        if (%tmp.xx == $null) { var %tmp.xx = User not in database }
n456=        msg # $report(LastSeen,$2,$null,%tmp.xx)
n457=      }
n458=    }
n459=    ;#.setss Format: .setss <server> (Setup for servers)
n460=    if ($strip($1) == .setss) {
n461=      if ($2 == $null) {
n462=        .msg # $report(Format,$null,$null,.setss <server>)
n463=        .msg # Valid Server letters are: x = xpeace, s = strange, i = icq, d = dal,  b = blaze
n464=        .msg # Valid Server letters are: c = chatnet, p = splog, j = jong, g = global
n465=        halt
n466=      }
n467=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n468=      Set.SS # $2- | halt
n469=    }
n470=    ;#.ss Format: .ss  ON/OFF/STATS/NICK DAL/ICQ <room to join/nickforsocket> (spy from current serv to another)
n471=    ;#.serverspy Format: .serverspy  ON/OFF/STATS/NICK DAL/ICQ <room to join/nickforsocket> (spy from current serv to another)
n472=    if ($strip($1) == .ss) || ($strip($1) == .serverspy) {
n473=      if ($2 == $null) { msg # $report(Format,$null,$null,.ss ON/OFF/STATS/NICK/SERVER/PASS/PORT DAL/ICQ <room to join/nickforsocket/newpass/port> (spy from current serv to another)) | halt }
n474=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n475=      SS.Command $1-
n476=      halt
n477=    }
n478=    if ($strip($1) == .spell) { .msg # Please use /desc or /describe | halt }
n479=    ;#.desc Format: .desc <word> (Searches for spelling and definition.)
n480=    ;#.describe Format: .describe <word> (Searches for spelling and definition.)
n481=    if ($strip($1) == .desc) || ($strip($1) == .describe) {
n482=      if ($2 == $null) { .msg # $report(Format:,.describe word (Searches for spelling and definition.)) | halt }
n483=      else { spell # $2 | halt }
n484=      halt
n485=    }
n486=    ;#.st Format: .st ON/OFF (allows other users to talk through the spy sockets.)
n487=    ;#.spy Format: .spy ON/OFF #room (.)
n488=    if ($strip($1) == .spy) {
n489=      if ($2 == $null) { .msg # $report(Format:,.spy ON/OFF #room) | halt }
n490=      if ($2 == ON) {
n491=        if ($me !ison $3) { .join $3 %key. [ $+ [ $3 ] ] }
n492=        set %spy ON
n493=        set %spy1 $3
n494=        set %spy2 # 
n495=        .msg # $report(Spy,%spy1,Enabled)
n496=        halt
n497=      }
n498=      if ($2 == OFF) { set %spy OFF | set %spy1 "" | set %spy2 "" | .msg # $report(Spy,Disabled) | halt }
n499=    }
n500=    ;#.spytalk Format: .spytalk ON/OFF (allows other users to talk through the spy sockets.)
n501=    if ($strip($1) == .spytalk) || ($strip($1) == .st) {
n502=      if ($2 == $null) { .msg # $report(Format,$null,$null,.spytalk ON/OFF, Current: %server.spy.talk) | .msg # $report(Format,$null,$null,.st ON/OFF, Current: %server.spy.talk) }
n503=      else {
n504=        if ($2 == ON) { set %server.spy.talk ON }
n505=        else { set %server.spy.talk OFF }
n506=        msg # $report(SpyTalk,SET,%server.spy.talk) 
n507=      }
n508=      halt 
n509=    }
n510=    ;#.stop Format: .stop (.)
n511=    if ($strip($1) == .stop) { .timerPND OFF | set %pound "" | set %pound.active == OFF | set %report Pound | /report1 # Off | halt }
n512=    ;#.talk Format: .talk (.)
n513=    if ($strip($1) == .talk) {
n514=      if ($2 == ON) { .load -rs talker.ini | if ($3 != $null) { set %talk.room $3 } | if ($3 == $null) { set %talk.room # } | .msg # $report(Speach Interaction,$null,$null,On) | .msg # $report(Active Rooms,$null,$null,%talk.room) | halt }
n515=      if ($2 == OFF) { .unload -rs talker.ini | unset %talk.room | .msg # $report(Speach interaction,$null,$null,Off) | halt }
n516=      halt
n517=    }
n518=    ;#.timer Format: .timer (Displays the currently active timers and info.)
n519=    if ($strip($1) == .timer) { timer.show # }
n520=    ;#.tease Format: .tease (.)
n521=    if ($strip($1) == .tease) {
n522=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n523=      /rt # $2
n524=      halt
n525=    }
n526=    ;#.ver Format: .ver (Returns bot version.)
n527=    if ($strip($1) == .ver) { .msg # $ver | halt }
n528=    ;#.you Format: .you <nick> (causes the both to take the given nick.)
n529=    if ($strip($1) == .you) { .nick $2 | halt }
n530=    if ($strip($1) == drop) && ($2 == dead) { set %report Exit | /report1 # Done | .exit | halt }
n531=    if ($strip($1) == go) && ($2 == away) { .msg # Fine then | .part # | halt }
n532=    if ($strip($1) == get) && ($2 == rid) && ($3 == of) { if ($4 != $me) { .raw kick # $4 Bosses $+ $chr(160) $+ Orders | halt } | if ($4 == $me) { .msg # What? do i look fucking stupid? | halt } }
n533=    ;#.sw Format: .sw (.)
n534=    if ($strip($1) == .sw) {
n535=      if ($2 == $null) { msg # $report(Format,$null,$null,.sw <raw socket command> | halt }
n536=      sockwrite -n * $2 $3 $4 $5 $6 $7 $8 $9
n537=      msg # $report(Socket Command,Sent,$2-) | halt
n538=    }
n539=    ;#.sock Format: .sock (.)
n540=    if ($strip($1) == .sock) || ($strip($1) == .socks) {
n541=      if ($2 == $null) { msg # $report(Format,$null,$null,.sock(s) FIRE/KILL/SHOW $chr(35)) | halt }
n542=      if ($nick != %boss) { .msg # This is a %boss only command | halt }
n543=      if ($2 == SHOW) { msg # $report(Format,$null,$null,.sock(s) FIRE/KILL/SHOW) | halt }
n544=      if ($2 == KILL) { sockclose * | msg # $report(Sockets Killed) | halt }
n545=      if ($2 == FIRE) {
n546=        var %tmp.SF = 1
n547=        while (%tmp.SF <= $3) {
n548=          sockopen Protect $+ $rand(A,Z) $+ $rand(A,Z) $server 6667
n549=          inc %tmp.SF
n550=          if (%tmp.SF > $3) { break }
n551=        }
n552=        msg # $report(Fired,$3,to,$server)
n553=        halt
n554=      }
n555=    }
n556=    ;#.sl Format: .sl (.)
n557=    if ($strip($1) == .sl) { sl # | halt }
n558=    ;#.info Format: .info (.)
n559=    if ($strip($1) == .info) {
n560=      .msg # The Information Utility is not yet configured.
n561=      halt
n562=    }
n563=    ;#.spawn Format: .spawn # (.)
n564=    if ($strip($1) == .spawn) {
n565=      .msg # The Information Utility is not yet configured.
n566=      halt
n567=    }
n568=    if ($left($strip($1-),1) == >) { SSPy $1- }
n569=    ;#.ez Format: .ez ON/OFF/SERVER #room/server (turns on easy-relay)
n570=    if ($strip($1) == .ez) {
n571=      if ($2 == $null) {
n572=        .msg # $report(Format:,.ez ON/OFF/SERVER #room/server,turns on easy-relay)
n573=        .msg # $report(Current Room,%easy.room) $report(Current Server,%easy.server)
n574=      }
n575=      if ($2 == ON) {
n576=        if ($3 == $null) { .set %easy.room # }
n577=        else { .set %easy.room $3 }
n578=        .msg # $report(Ez-Relay,Active,%easy.room,to,%easy.server)
n579=        halt 
n580=      }
n581=      if ($2 == OFF) { .unset %easy.room | .msg # $report(Ez-Relay,$null,OFF) | halt }
n582=      if ($2 == SERVER) { .set %easy.server $3 | .msg # $report(Ez-Relay,Server Set,%easy.server) | halt }
n583=    }
n584=    ;#.wz Format: .wz <city, state/zipcode> (returns the weather)
n585=    if ($strip($1) == .wz) {
n586=      if ($2 == $null) { msg # Format: .wz <city, state/zipcode> (returns the weather) | halt }
n587=      elseif ($2 == OFF) { sockclose weather | sockclose wt | msg # Weather sockets  closed. | return }
n588=      else { weather # $2- | return }
n589=    }
n590=    ;#.var Format: .var (Shows infomation on a given variable)
n591=    if ($strip($1) == .var) {
n592=      if ($var($2,1) = $null) { .msg # The variable $2 does not exist | halt  }
n593=      else { .msg # Variable $2 $+ = $+ $var($2,1).value }
n594=      halt
n595=    }
n596=  }
n597=}
n598=raw 421:*:{ if (*Lag-CK* !iswm $1-) { notice %boss $upper($2) $3- } }
n599=raw 473:*:{ .notice %boss Join Failed $2 Invite Only, Using ChanServ to auto invite me. | .chanserv invite $2 $me  }
n600=;Check for end of file
