on *:ACTION:*:#:{
  if (%easy.room != $null) && (# == %easy.room) && ($left($strip($1-),1) != >) && ($left($strip($1-),1) != .) {
    if ($sock(Spy [ $+ [ %easy.server ] ] ) != $null) { .timer 1 0 sockwrite -n Spy $+ %easy.server privmsg $gettok(%server.spy.on. [ $+ [ %easy.server ] ] ,3,44) : $+ $chr(1) $+ ACTION ( $+ $nick $+ ) $1- $+ $chr(1) }
  }
}
on *:TEXT:*:#: {
  if ($nick == $chan(#)) { halt }
  if ($nick == $me) { halt }
  if (%boss.repeat == ON) { .msg # On # %boss said: $1- }
  if (%easy.room != $null) && (# == %easy.room) && ($left($strip($1-),1) != >) && ($left($strip($1-),1) != .) {
    if ($sock(Spy [ $+ [ %easy.server ] ] ) != $null) {
      if ($nick == %boss) { .timer 1 0 sockwrite -n Spy $+ %easy.server privmsg $gettok(%server.spy.on. [ $+ [ %easy.server ] ] ,3,44) : $+ $1- }
      else { .timer 1 0 sockwrite -n Spy $+ %easy.server privmsg $gettok(%server.spy.on. [ $+ [ %easy.server ] ] ,3,44) : $+ ( $+ $nick $+ ) $1- }
    }
  }
  if (%spy == ON) && ($chan == %spy1) { .msg %spy2 $report(Spy,%spy1,$null,$nick, $+ $1-) }
  if ($level($address($nick,4)) = 5) || ($level($address($nick,1)) = 5) || ($level($address($nick,4)) = 4) || ($level($address($nick,1)) = 4) {
    if (%LM.editor == ON) { if (%LM.chan != #) { halt } | MenuPicks $1- | halt }
    if ($strip($1) == /) || ($strip($1) == .) || ($strip($1) == ..) || ($strip($1) == .cmd) { halt }
    if ($strip($1-) = $me) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      .msg # yes?
      .enable #DoCommand
      halt
    }
    ;#.help Format: .help [[.]<command>] (Makes the bot show the complete command list or the specified command.)
    if ($strip($1) == .help) {
      write -c bothelp.txt
      if ($2 == $null) {
        .msg # Please wait while i extract the help, this may take a minute
        var %tmp = 1
        while (%tmp <= $lines(script1.mrc)) {
          var %tmp1 = $read(script1.mrc,n,%tmp)
          if (*;#.* iswm %tmp1) && (*iswm* !iswm %tmp1) && (*=* !iswm %tmp1) { var %tmp1 = $remove(%tmp1,;#) | var %tmp1 = $gettok(%tmp1,3,32) | var %tmp2 = %tmp2 $lower(%tmp1) }
          inc %tmp
          if ($numtok(%tmp2,32) == 15) { .msg # %tmp2 | var %tmp2 }
          if (%tmp > $lines(script1.mrc)) { break }
        }
        if (%tmp2 != $null) { .msg # %tmp2 }
        .msg # For help on a specific command try .help <command>
        ;.notice $nick For a complete list of commands try .help
        halt
      }
      else {
        .msg # Please wait while i extract the help, this may take a minute
        var %tmp = 1
        var %cleanup = $remove($2,.)
        while (%tmp <= $lines(script1.mrc)) {
          var %tmp1 = $read(script1.mrc,n,%tmp)
          var %tmp2 = $chr(42) $+ ;#. $+ %cleanup $+ $chr(42)
          if (%tmp2 iswm %tmp1) { .msg # $gettok(%tmp1,3-,32) | unset %tmp1 | break }
          inc %tmp
          if (%tmp > $lines(script1.mrc)) { break }
        }
        if (%tmp1 != $null) { .msg # No help found for %cleanup }
        .msg # For a complete list of commands try .help
        halt
      }
    }
    ;&& (%tmp != 35) && (%tmp != 49) 
    ;
    if ($strip($1) == $chr(63) $+ $chr(63)) { SSpy.Help | halt }
    ;#.alias Format: .alias (Shows infomation on a given alias)
    if ($strip($1) == .alias) {
      if ($isalias($2) != $true) { .msg # The alias $2 was not found | halt  }
      else { .msg # Alias  $2 is in $isalias($2).fname }
      halt
    }
    ;#.aj Format: .aj (Joins all set autojoin rooms.)
    if ($strip($1) == .AJ) { .raw join %autojoin | .msg # $report(AutoJoin All,$null,Joined,%autojoin) | halt }
    ;#.sop Format: .SOP <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] (Configures the join auto owner settings.)
    ;#.aop Format: .AOP <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] (Configures the join auto ops settings.)
    ;#.hop Format: .HOP <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] (Configures the join half ops settings.)
    if ($strip($1) == .SOP) || ($strip($1) == .AOP) || ($strip($1) == .HOP) {
      if ($2 == $null) { .msg # Format: $upper($1) <#room> <-a (ADD)|-d (DEL)|-l (LIST)|-w (WIPE)> [<nick>] | halt }
      UP.Service # $remove($strip($1-),.)
      halt
    }
    ;#.autojoin Format: .autojoin <ON|OFF|ADD|DEL|SHOW> [#room] (Configures the autojoin for the bot.)
    if ($strip($1) == .AUTOJOIN) {
      if ($2 == $null) { .msg # Format: .autojoin <ON|OFF|ADD|DEL|SHOW> [<#room>] | halt }
      if ($2 == SHOW) { .msg # $report(Current,$null,$null,%autojoin) | halt }
      if ($2 == ADD) { set %autojoin $addtok(%autojoin,$3,44) | .msg # $report(Current,$null,$null,%autojoin) | halt }
      if ($2 == DEL) { set %autojoin $remtok(%autojoin,$3,1,44) | .msg # $report(Current,$null,$null,%autojoin) | halt }
      if ($2 == ON) { set %do.autojoin ON | .msg # $report(Current,$null,$null,%do.autojoin) | halt }
      if ($2 == OFF) { set %do.autojoin OFF | .msg # $report(Current,$null,$null,%do.autojoin) | halt }
      halt
    }
    ;#.away Format: .away <reason> (Sets the bot away.)
    if ($strip($1) == .AWAY) { if ($2 != $null) { .ctcp # AWAY $2- | /away $2- | /ame is away: $2- | halt } | else { .ctcp # AWAY Out | /away out | /ame is away: out | halt } }
    ;#.blast Format: .blast <nick> (Insults the shit out of <nick>.)
    if ($strip($1) == .blast) { if ($2 == $null) { .msg # $report(Format,$null,$null,.blast <nick>) | halt } | else { /blast $2 # | halt } }
    ;#.bnc Format: .bnc <ip> (Logs into a bnc with the bot.)
    if ($strip($1) == .bnc) { if ($2 == $null) { msg # Format: .bnc <ip> Example: .bnc 123.456.789.123 | halt } | server $2 $+ : $+ %BNC.port | halt }
    ;#.bncsetup Format: .bncsetup <PORT|PASS[WORD]|SERVER> <value> (Sets up the user info for the BNC.)
    if ($strip($1) == .bncsetup) {
      if ($2 == $null) { msg # Format: .bncsetup <PORT|PASS[WORD]|SERVER> <value> | halt }
      if ($2 == Port) { set %BNC.port $3 | msg # $report(BNC Setup,PORT,$null,$null,%BNC.port) | halt }
      if ($2 == PASSWORD) || ($2 == PASS) { set %BNC.pass $3 | msg # $report(BNC Setup,PASSWORD,$null,$null,%BNC.pass) | halt }
      if ($2 == SERVER) { set %BNC.server $3 | msg # $report(BNC Setup,SERVER,$null,$null,%BNC.server) | halt }
      halt
    }
    ;#.back Format: .back (Sets the bot back.)
    if ($strip($1) == .back) { .ctcp # AWAY | away | ame is back | halt }
    ;#.boot Format: .boot <nick> [channel] (Kicks the given nick out of the active room or [channel].)
    if ($strip($1) == .boot) {
      if ($2 == $null) { msg # $report(Format,$null,$null,.boot <nick> or .boot <nick> <channel>) | halt }
      if ($3 == $null) { .kick # $2 BAM | halt }
      else { .kick $3 $2 BAM | halt }
    }
    ;#.boss Format: .boss (Sets yourself boss in the bot and registers it.)
    if ($strip($1) == .boss) { if ($level($address($nick,4)) != 5) { halt } | set %boss $nick | .notice %boss $report(Boss,Set,%boss) | .ctcp %boss SSBOT %bot.key. [ $+ [ $network ] ] | halt }
    ;#.cb Format: .cb (Runs Check.Boss)
    if ($strip($1) == .cb) {
      ;if ($nick != %boss) { .msg # This is a %boss only command | halt }
      Check.boss recess
      halt
    }
    ;#.cnn Format: .cnn [<-r|-u>] [<NUM>] (Gets CNN News or URL.)
    if ($strip($1) == .cnn) { cnn # $nick $2- | halt }
    ;#.cycle Format: .cycle [<channel>] (Cycles the current or given channel.)
    if ($strip($1) == .cycle) { if ($2 == $null) { .raw part $chan $cr join $chan %key. [ $+ [ $chan ] ] | halt } | else { .raw part $2 | .raw join $2 %key. [ $+ [ $2 ] ] | halt } }
    ;#.cycleall Format: .cycleall (Cycles all channels.)
    if ($strip($1) == .cycleall) { cycleall | halt }
    ;#.dcc Format: .dcc (Causes the bot to dcc chat the boss.)
    if ($strip($1) == .dcc) { .dcc chat %boss | halt }
    ;#.deop Format: .deop <nick> [channel] (Makes the bot deop <nick> in current room or [channel].)
    if ($strip($1) == .deop) { if ($2 == $null) { msg # $report(Format,$null,$null,.deop <nick> or .deop <nick> <channel>) | halt } | if ($2 == %boss) { halt } | if ($3 == $null) { .raw mode $chan -o $2 | halt } | else { .raw mode $3 -o $2 | halt } }
    ;#.deq Format: .deq <nick> [channel] (Makes the bot deq <nick> in current room or [channel].)
    if ($strip($1) == .deq) { if ($2 == $null) { msg # $report(Format,$null,$null,.deq <nick> or .deq <nick> <channel>) | halt } | if ($3 == $null) { .raw mode $chan +o $2 | halt } else { .raw mode $3 -o $2 | halt } }
    ;#.dns Format: .dns <-s(STATS)|-i(INFO)|-d(DIG)> [<domian.name>] (Manages ISC BIND dns server.)
    if ($strip($1) == .dns) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      if ($2 == $null) { msg # Format: .dns <-s(STATS)|-i(INFO)|-d(DIG)> [<domian.name>] (Manages ISC BIND dns server.) | halt }
      if ($exists(c:\temp\temp.txt) == $true) { .remove c:\temp\temp.txt }
      if ($2 == -s) {
        %method # Generating Bind DNS statistics, one minute ...
        .remove c:\dns\etc\namedb\named.stats
        .run -np c:\dns\bin\rndc.exe stats
        .timer 1 3 .play # c:\dns\etc\namedb\named.stats 100
        halt
      }
      if ($2 == -i) {
        %method # Gathering running server info, one minute ...
        .run -n cmd.exe /c C:\dns\bin\rndc.exe status > temp.txt
        ;if ($exists(temp.txt) == $false) { msg # Error playing file, the fucking thing is missing | halt }
        .timerlll 1 3 .play # temp.txt 100
        halt
      }
      if ($2 == -d) {
        if ($3 == $null) { halt }
        %method # Running dig $3- $+ , one minute ...
        .run -n cmd.exe /c C:\dns\bin\dig.exe $3-  > temp.txt
        if ($exists(temp.txt) == $false) { msg # Error playing file, the fucking thing is missing | halt }
        else { .timer 1 3 play.filter # temp.txt }
        ;.timerldl 1 3 .play # temp.txt 100
        halt
      }
      halt
    }
    ;#.domath Format: .domath <##> <+-*/> <##> <+-*/> <##> (Does the entered math calulation.)
    if ($strip($1) == .domath) { if ($2 == $null) { msg # Format: .domath <##> <+-*/> <##> <+-*/> <##> | halt } | .msg # $report(Math Calc,$null,Done,$calc($2-)) | halt }
    ;#.exit Format: .exit (Makes the bot exit.)
    if ($strip($1) == .exit) { .msg # $report(Exit,Done) | .timer 1 1 quit $replace($2-,$chr(32),$chr(160)) | .timer -o 1 2 exit | halt }
    ;#.gen Format: .gen <#room> (Generates stats for the given room.)
    if ($strip($1) == .gen) {
      if ($2 == $null) { .msg # Format: .gen <#room> (Generates stats for the given room.) }
      var %tmp.stat = $remove($2,$chr(35))
      var %tmp.stat1 = D:\SS\MircStats\Config\ $+ %tmp.stat $+ .cfg
      if ($exists(%tmp.stat1)  == $true) {
        .msg # Generating Stats for $chr(35) $+ %tmp.stat $+ ....
        ;.timerSTATS. $+ %tmp.stat 1 30 msg # Located: http://www.strangeout.com/~stats/ $+ %tmp.stat $+ /
        ;.run -np %tmp.stat1
        .run -np D:\SS\MircStats\mircstats.exe -c %tmp.stat $+ .cfg
      }
      if ($exists(%tmp.stat1) == $false) { .msg # There is no configuration file for that room. You'll need to make one huh. }
      halt
    }
    ;#.quit Format: .quit <reason> (Makes the bot quit.)
    if ($strip($1) == .quit) { .msg # $report(Exit,Done) | .timer 1 1 quit $replace($2-,$chr(32),$chr(160)) | .timer -o 1 2 exit | halt }
    ;#.heel Format: .heel (Makes the bot deop itself.)
    if ($strip($1) == .heel) { .raw mode # -o $me | halt }
    ;#.ident Format: .ident (Makes the bot identify to chanserv using saved password.)
    ;#.identify Format: .identify (Makes the bot identify to chanserv using saved password.)
    if ($strip($1) == .identify) || ($strip($1) == .ident) { if (*dal.net iswm $server) { nickserv identify %irc.nick.pass } | else { /msg nickserv identify %irc.nick.pass } | halt }
    ;#.ignore Format: .ignore <nick/ip> (Makes the bot ignore given <nick or ip> for 15 minutes.)
    if ($strip($1) == .ignore) { if ($2 == $null) { msg # Format: .ignore <nick/ip> | halt } | .ignore -u900 $2 | .msg # $report(Ignore,$2,Added) | halt }
    ;#.ircx Format: .ircx (Makes the bot set itself to ircx mode.)
    if ($strip($1) == .ircx) { .ircx | .msg # $report(IRCx Mode,$null,Set) | halt }
    ;#.invite Format: .invite <nick> [channel] (Makes the bot invite <nick> to current channel or to [channel].)
    if ($strip($1) == .invite) { if ($2 == $null) { msg # Format: .invite <nick> or .invite <nick> <channel> | halt } | if ($3 == $null) { .invite $2 # | .msg # $report(Invite,$2,#) | halt } | else { .invite $2 $3 | .msg # $report(Invite,$2,$3) | halt } }
    ;#.join Format: .join <#room> [key] (Makes the bot join <#channel>.)
    if ($strip($1) == .join) { if ($2 == $null) { msg # Format: .join <#room> or .join <#room> <key> | halt } | .join $2 $3 | .msg # $report(Joined,$2) | halt }
    ;#.kick Format: .kick [<channel>] <nick> <message> (Makes the bot kick <nick> on current channel or on [channel].)
    if ($strip($1) == .kick) {
      if ($2 == $null) { msg # Format: .kick [<channel>] <nick> <message> | halt }
      if ($2 == %boss) { halt }
      if ($chr(35) isin $2) { .kick $2 $3 $4- | halt } | else { .kick # $2 $3- | halt }
    }
    ;#.lag Format: .lag (Shows the bots lag on the server.)
    if ($strip($1) == .lag) {
      if ($2 == silent) { .notice %boss $report(Lag Report,$server,%Lag.mrc) | halt }
      else { msg # $report(Lag Report,$server,%Lag.mrc) | halt }
    }
    ;#.LiveMenu Format: .livemenu (Enters the interactive ip to ip mirc ini editor.)
    if ($strip($1) == .livemenu) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      ;if ($2 == $null) { msg #.LiveMenu Format: .livemenu (Enters the interactive ip to ip mirc ini editor.) | halt }
      LiveMenu # $nick
      ;  if ($2 == silent) { .notice %boss $report(Lag Report,$server,%Lag.mrc) | halt }
      ;  else { msg # $report(Lag Report,$server,%Lag.mrc) | halt }
    }
    ;#.log Format: .log <-s ON/OFF|-q ON/OFF|ON|OFF|SHOW> (Turns log reads on or off.)
    if ($strip($1) == .log) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      if ($2 == $null) { .msg # Format: .log <-s ON/OFF|-q ON/OFF|ON|OFF|SHOW> (Turns log reads on or off.) | halt }
      LOG.ADJUST # $2-
      halt
    }
    ;#.login Format: .login <server> (Makes the bot login to <server address:port>.)
    if ($strip($1) == .login) { if ($nick != %boss) { .msg # This is a %boss only command | halt } | server $2- }
    ;#.auser Format: .auser <nick> (Adds a user to the UserList)
    if ($strip($1) == .auser) {
      if ($2 == $null) { msg # Format: .auser <nick> | halt }
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      auser 4 $address($2,4) $2
      .msg # I am now stuck taking orders from $2 $+ , sucks to be me.
      halt
    }
    ;#.ruser Format: .ruser <nick> (Removes a user from the UserList)
    if ($strip($1) == .ruser) {
      if ($2 == $null) { msg # Format: .ruser <nick> | halt }
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      ruser $2
      .msg # Thanks for getting $2 the fuck off my back.
      halt
    }
    ;#.luser Format: .luser (Lists the users in the UserList)
    if ($strip($1) == .luser) {
      msg # Extracting UserList
      var %tmpul = 1
      while (%tmpul <= $ulist(*,0)) {
        .msg # ( $+ %tmpul $+ ) $ulist(*,%tmpul) $ulist(*,%tmpul).info
        inc %tmpul
        if (%tmpul > $ulist(*,0)) { break }
      }
      msg # Done.
    }
    ;#.mail Format: .mail <on|off|-u> [<nick>] (Checks for CNN Breaking news or if USER has mail.)
    if ($strip($1) == .mail) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      if ($2 == $null) { .msg # Format: .mail <on|off|-u> [<nick>] (Checks for CNN Breaking news or if USER has mail.) | halt }
      if ($2 == ON) { .timerMAIL 0 120 mail #COS | set %mail.run ON | msg # MailCheck is now %mail.run | halt }
      if ($2 == OFF) { .timerMAIL OFF | set %mail.run OFF | unset %mail.user | set %mail.write OFF | msg # MailCheck is now %mail.run | halt }
      if ($2 == -u) { mail #COS $3 | halt }
      halt
    }
    ;#.menu Format: .menu (Enables the Spy Menu.)
    if ($strip($1) == .menu) { if ($nick != %boss) { .msg # This is a %boss only command | halt } | .enable #Menu | msg # $report(Spy Menu,ON) | menu # | halt }
    ;#.base Format: .base <NICK|CHANNEL> (Sets up the base (User/#room reported to).)
    if ($strip($1) == .base) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      if ($2 != $null) { set %base $2 | goto ch1 | halt }
      .msg # Format: .base <NICK|CHANNEL>  (Sets up the base (User or #room reported to).) 
      :ch1
      .msg # Your Current settings are: METHOD( $+ %method $+ ) BASE( $+ %base $+ )
      halt
    }
    ;#.method Format: .method <MSG|NOTICE NICK|CHANNEL> (Sets up the bot play method.)
    if ($strip($1) == .method) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      if ($2 == MSG) || ($2 == NOTICE) && ($3 != $null) { set %method . $+ $2 | set %base $3 | goto ch2 | halt }
      .msg # Format: .method <MSG|NOTICE NICK|CHANNEL> (Sets up the bot play method.) 
      :ch2
      .msg # Your Current settings are: METHOD( $+ %method $+ ) BASE( $+ %base $+ )
      halt
    }
    ;#.mk Format: .mk (Makes the bot mass kick current room.)
    if ($strip($1) == .mk) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      mkall #
      .cycle
      halt
    }
    ;#.take Format: .take (Makes the bot try to take the current room.)
    if ($strip($1) == .take) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      mkall #
      halt
    }
    ;#.mode Format: .mode <raw command> (Makes the bot send a server raw.)
    if ($strip($1) == .mode) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      .mode $2 $3 $4 $5 $6 $7 $8 $9 | set %report Mode Set $2 | /report1 # Done
      halt
    }
    ;#.nick Format: .nick <base nick> (Changes the bots nick to <base nick>[#####].)
    if ($strip($1) == .nick) { .nick $2 $+ $chr(91) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $chr(93) | halt }
    ;#.bnick Format: .bnick [INC/LONG] <base nick> (Changes all the bots nick to <base nick>[#] or <base nick>[#####].)
    if ($strip($1) == .bnick) { 
      if ($2 == inc) { .nick $3 $+ $chr(91) $+ $right($remove($nopath($mircini),.ini),-3) $+ $chr(93) | halt }
      if ($2 == long) { .nick $2 $+ $chr(91) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $chr(93) | halt }
      if ($2 != inc) && ($2 != long) { .nick $3 $+ $chr(91) $+ $right($remove($nopath($mircini),.ini),-3) $+ $chr(93) | halt }  
    }
    ;#.o Format: .o [nick] (makes the bot op the boos or [nick] on current channel.)
    if ($strip($1) == .o) { if ($2 == $null) { .raw mode $chan +o $nick | halt } | if ($2 == ?) { .raw mode $chan +o %lastjoin. [ $+ [ $chan ] ] | halt } | else { .raw mode $chan +o $2 | halt } }
    ;#.oper  Format: .oper (makes the bot send /Oper to the server.)
    if ($strip($1) == .oper) {
      if (%irc.oper.nick == $null) { msg # No nick is saved to oper with. Use .raw set % $+ irc.oper.nick <value> | halt }
      if ( %irc.oper.pass == $null) { msg # No pass is saved to oper with. Use .raw set % $+ irc.oper.pass <value> | halt }
      if ($2 == $null) {
        .raw oper %irc.oper.nick %irc.oper.pass
        msg # Oper has been sent
        halt
      }
    }
    ;#.unoper Format: .unoper (makes the bot send /Unoper to the server. Works only if supprted.)
    if ($strip($1) == .unoper) { if ($2 == $null) { .raw unoper | halt } }
    ;#.part Format: .part [<channel>] (Parts current or given channel.)
    if ($strip($1) == .part) {
      if ($2 == $null) { part # | halt }
      if ($2 != $null) {
        if ($chr(35) !isin $2) { .msg # $report(Part,Cant part,Invalid room name) | halt }
        else { part $2 | .msg # $report(Parted,$2) | halt }
      }
    }
    ;#.ping Format: .ping [<nick|channel>] (Pings you,  nick or channel. )
    if ($strip($1) == .ping) {
      if ($2 == $null) { set %ping.chan # | set %ping.nick $nick | .raw -q privmsg $nick : $+ $chr(1) $+ PING $ticks $+ $chr(1) | halt }
      if ($2 != $null) {
        set %ping.chan #
        if ($chr(35) isin $2) { unset %ping.nick }
        else { set %ping.nick $2 }
        .raw -q privmsg $2 : $+ $chr(1) $+ PING $ticks $+ $chr(1)
        halt
      }
    }
    ;#.pound Format: .pound <channel> (Make the bot(s) try to join a room hundreds of times a minute.)
    if ($strip($1) == .pound) { if ($me ison $2) { halt } | else { set %pound $2 | set %pound %pound $+ $chr(44) | set %pound $str(%pound,20) | set %pound.active ON | /pound | set %report Pound on $2 | /report1 # Engaged | halt } }
    ;#.prop Format: .prop [channel] (Sets the props on current channel or [channel].)
    if ($strip($1) == .prop) {
      if ($2 == $null) {
        if (%key. [ $+ [ # ] ] != $null) { /prop # OWNERKEY %key. [ $+ [ # ] ] }
        if (%key2. [ $+ [ # ] ] != $null) { .prop # HOSTKEY %key2. [ $+ [ # ] ] }
        .raw mode # +ntw
        halt
      }
      if ($2 != $null) {
        if (%key. [ $+ [ $2 ] ] != $null) { /prop $2 OWNERKEY %key. [ $+ [ $2 ] ] }
        if (%key2. [ $+ [ $2 ] ] != $null) { .prop $2 HOSTKEY %key2. [ $+ [ $2 ] ] }
        .raw mode $2 +ntw
        set %report Props in $2 | /report1 # Set
        halt
      }
    }
    ;#.put Format: .put <channel> <text> (Makes the bot say <text> on <channel>.)
    if ($strip($1) == .put) { msg $2 $3- | halt }
    if ($strip($1) == .unmask) { if ($2 == $null) { msg # You must include the nick | halt } | unmask $gettok($address($2,2),2,64) $2 | halt }
    ;#.q Format: .q or .q <nick> or .q <nick> ALOT (Makes the bot +q the boss or <nick> or +qqqqqq <nick>.)
    if ($strip($1) == .q) {
      if ($2 == $null) { .raw mode # +q $nick | halt }
      elseif ($2 == ?) { .raw mode $chan +q %lastjoin. [ $+ [ $chan ] ] | halt }
      else { .raw mode # +q $2 | halt }
    }
    ;#.rand Format: .rand (Gives the bot a random lettered nick.)
    if ($strip($1) == .rand) { .nick $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) $+ $rand(A,Z) | halt }
    ;#.raw Format: .raw <raw command> (This is a %boss only command)
    if ($strip($1) == .raw) {
      if ($2 == $null) { .msg # $report(Format,$null,$null,.raw <raw command>,This is a %boss only command) | halt }
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      $replace($2-,$chr(160),$chr(32))
      .msg # $report(Raw,$null,Sent,$2-)
      halt
    }
    ;#.remkey Format: .remkey (Deletes the owner and host key on the current channel.)
    if ($strip($1) == .remkey) { unset %key. [ $+ [ # ] ] | unset %key2. [ $+ [ # ] ] | set %report OwnerKey and Hostkey | /report1 # Deleted | halt }
    ;#.recover Format: .recover <#> <nick> (The given bot number recovers given nickname.)
    if ($strip($1) == .recover) { 
      if ($2 == $null) { msg # Format: .recover <#> <nick> (The given bot number recovers given nickname.) | halt }
      if ($2 == OFF) { .timerREC OFF | unset %recover | .msg # $report(Recover,Off) | halt }
      elseif ($2 == $me) { set %recover $3 | msg # $report(Recover,Attempting to recover,%recover) | recover | halt }
      elseif ($2 == $mid($nopath($mircini),4,1)) { set %recover $3 | msg # $report(Recover,Attempting to recover,%recover) | recover | halt }
      else { halt }
    }
    ;#.reload Format: .reload (reloads the bots scripts)
    if ($strip($1) == .reload) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      load.again
    }
    ;#.reup Format: .reup (Causes the bot to restart)
    if ($strip($1) == .reup) {
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      server $server
    }
    ;#.safe Format: .safe (Goes into Safe mode ignoring everything except you)
    if ($strip($1) == .safe) { .ignore -u60 *!*@* | halt }
    ;#.scanlog Format: .scanlog ON/OFF/SET (Reads %boss the scanlog as it happens.)
    if ($strip($1) == .scanlog) {
      if ($2 == $null) { msg # Format: .scanlog ON/OFF/SET (Reads %boss the scanlog as it happens.) | halt }
      if ($2 == ON) { .timerSCANLOG -m 0 100 SL.PLAY | msg # $report(ScanLog,Play,Enabled) | halt }
      if ($2 == OFF) { .timerSCANLOG OFF | msg # $report(ScanLog,Play,Disabled) | halt }
      if ($2 == SET) { }
      halt
    }
    ;#.shit Format: .shit <ON|OFF|-a (ADD)|-d (DEL)|-c (CLEAR)|-l (LIST)|-s (SHOW)> <IP>  (manages the shitlist)
    if ($strip($1) == .shit) {
      if ($2 == $null) { .msg # $report(Format,$null,$null,.shit <ON|OFF|-a (ADD)|-d (DEL)|-c (CLEAR)|-l (LIST)|-s (SHOW)> <IP> ) | halt }
      if ($2 == -s) { .msg # $report(ShitList,$null,List,%shitlist,%shitlist.Do) | halt }
      if ($2 == -l) { .msg # $report(ShitList,$null,List,%shitlist,%shitlist.Do) | halt }
      if ($2 == ON) { set %shitlist.Do ON | .msg # $report(ShitList,Set,%shitlist.Do,%shitlist) | halt }
      if ($2 == OFF) { set %shitlist.Do OFF | .msg # $report(ShitList,Set,%shitlist.Do,%shitlist) | halt }
      if ($2 == ADD) || ($2 == -a) {
        if ($3 == $null) { .msg # $report(Format,$null,$null,.shit -add <IP>) | halt }
        if ($3 != $null) {
          var %tmpip = $3
          if ($istok(%shitlist,%tmpip,44) == $true) { .msg # $report(ShitList,%tmpip,Error,That IP is already in the shitlist,%shitlist) | halt }
          else { set %shitlist $addtok(%shitlist,%tmpip,44) | .msg # $report(ShitList,%tmpip,Add,%shitlist,%shitlist.Do) | halt }
        }
      }
      if ($2 == DEL) || ($2 == -d) {
        if ($3 == $null) || ($3 !isnum) {
          .msg # $report(Format,$null,$null,.shit -d <IP>)
          var %tmp = 1
          while (%tmp <= $numtok(%shitlist,44)) {
            .msg # $report(%tmp) $report($null,$gettok(%shitlist,%tmp,44))
            inc %tmp
            if (%tmp > $numtok(%shitlist,44)) { break }
          }
          halt
        }
        if ($3 != $null) && ($3 isnum) { .msg # $report(ShitList,$null,Delete,$gettok(%shitlist,$3,44),%shitlist.Do) | set %shitlist $deltok(%shitlist,$3,44) | halt }
      }
      if ($2 == CLEAR) || ($2 == -c) { set %shitlist "" | .msg # $report(ShitList,%tmpip,Clear,*,%shitlist.Do) | halt }
    }
    ;#.say Format: .say <text> or .say <numberoftimes> <text> or .say <numberoftimes> <channel> <text>) (Puts text to active or given channel)
    if ($strip($1) == .say) {
      if ($2 == $null) { msg # $report(Format,$null,$null,.say <text> or .say <numberoftimes> <text> or .say <numberoftimes> <channel> <text>) | halt }
      if ($2 !isnum) {
        if ($chr(35) isin $2) { /msg $2 $3- | halt }
        else { .msg # $2- | halt }
      }
    }
    if ($2 isnum) {
      set %tmp 1
      if ($chr(35) isin $3) { while (%tmp <= $2) { .msg $3 $4- | inc %tmp | if (%tmp > $2) { break } } }
      if ($chr(35) !isin $3) { while (%tmp <= $2) { .msg # $3- | inc %tmp | if (%tmp > $2) { break } } }
      unset %tmp
      halt

    }
    ;#.slc Format: .slc <-s (SHOW)|-r (RESET)> (Configures the Security Log)
    if ($strip($1) == .slc) { slc $2- | halt }
    ;#.seen Format: .seen <nick> (last time a nick was seen and where)
    if ($strip($1) == .seen) {
      if ($2 == $null) { msg # $report(Format,$null,$null,.seen <nick>) | halt }
      else { 
        var %tmp.x = $gettok($mircdir,1,92) $+ $chr(92) $+ $gettok($mircdir,2,92) $+ $chr(92) $+ text\LastSeen.txt
        var %tmp.xx = $read(%tmp.x,s,$2)
        if (%tmp.xx == $null) { var %tmp.xx = User not in database }
        msg # $report(LastSeen,$2,$null,%tmp.xx)
      }
    }
    ;#.setss Format: .setss <server> (Setup for servers)
    if ($strip($1) == .setss) {
      if ($2 == $null) {
        .msg # $report(Format,$null,$null,.setss <server>)
        .msg # Valid Server letters are: x = xpeace, s = strange, i = icq, d = dal,  b = blaze
        .msg # Valid Server letters are: c = chatnet, p = splog, j = jong, g = global
        halt
      }
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      Set.SS # $2- | halt
    }
    ;#.ss Format: .ss  ON/OFF/STATS/NICK DAL/ICQ <room to join/nickforsocket> (spy from current serv to another)
    ;#.serverspy Format: .serverspy  ON/OFF/STATS/NICK DAL/ICQ <room to join/nickforsocket> (spy from current serv to another)
    if ($strip($1) == .ss) || ($strip($1) == .serverspy) {
      if ($2 == $null) { msg # $report(Format,$null,$null,.ss ON/OFF/STATS/NICK/SERVER/PASS/PORT DAL/ICQ <room to join/nickforsocket/newpass/port> (spy from current serv to another)) | halt }
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      SS.Command $1-
      halt
    }
    if ($strip($1) == .spell) { .msg # Please use /desc or /describe | halt }
    ;#.desc Format: .desc <word> (Searches for spelling and definition.)
    ;#.describe Format: .describe <word> (Searches for spelling and definition.)
    if ($strip($1) == .desc) || ($strip($1) == .describe) {
      if ($2 == $null) { .msg # $report(Format:,.describe word (Searches for spelling and definition.)) | halt }
      else { spell # $2 | halt }
      halt
    }
    ;#.st Format: .st ON/OFF (allows other users to talk through the spy sockets.)
    ;#.spy Format: .spy ON/OFF #room (.)
    if ($strip($1) == .spy) {
      if ($2 == $null) { .msg # $report(Format:,.spy ON/OFF #room) | halt }
      if ($2 == ON) {
        if ($me !ison $3) { .join $3 %key. [ $+ [ $3 ] ] }
        set %spy ON
        set %spy1 $3
        set %spy2 # 
        .msg # $report(Spy,%spy1,Enabled)
        halt
      }
      if ($2 == OFF) { set %spy OFF | set %spy1 "" | set %spy2 "" | .msg # $report(Spy,Disabled) | halt }
    }
    ;#.spytalk Format: .spytalk ON/OFF (allows other users to talk through the spy sockets.)
    if ($strip($1) == .spytalk) || ($strip($1) == .st) {
      if ($2 == $null) { .msg # $report(Format,$null,$null,.spytalk ON/OFF, Current: %server.spy.talk) | .msg # $report(Format,$null,$null,.st ON/OFF, Current: %server.spy.talk) }
      else {
        if ($2 == ON) { set %server.spy.talk ON }
        else { set %server.spy.talk OFF }
        msg # $report(SpyTalk,SET,%server.spy.talk) 
      }
      halt 
    }
    ;#.stop Format: .stop (.)
    if ($strip($1) == .stop) { .timerPND OFF | set %pound "" | set %pound.active == OFF | set %report Pound | /report1 # Off | halt }
    ;#.talk Format: .talk (.)
    if ($strip($1) == .talk) {
      if ($2 == ON) { .load -rs talker.mrc | if ($3 != $null) { set %talk.room $3 } | if ($3 == $null) { set %talk.room # } | .msg # $report(Speach Interaction,$null,$null,On) | .msg # $report(Active Rooms,$null,$null,%talk.room) | halt }
      if ($2 == OFF) { .unload -rs talker.mrc | unset %talk.room | .msg # $report(Speach interaction,$null,$null,Off) | halt }
      halt
    }
    ;#.timer Format: .timer (Displays the currently active timers and info.)
    if ($strip($1) == .timer) { timer.show # }
    ;#.tease Format: .tease (.)
    if ($strip($1) == .tease) {
      if ($nick != %boss) { .msg # $report(Nice Try,This is a %boss only command) | halt }
      /rt # $2
      halt
    }
    ;#.ver Format: .ver (Returns bot version.)
    if ($strip($1) == .ver) { .msg # $ver | halt }
    ;#.you Format: .you <nick> (causes the bot to take the given nick.)
    if ($strip($1) == .you) { .nick $2 | halt }
    if ($strip($1) == drop) && ($2 == dead) { set %report Exit | /report1 # Done | .exit | halt }
    if ($strip($1) == go) && ($2 == away) { .msg # Fine then | .part # | halt }
    if ($strip($1) == get) && ($2 == rid) && ($3 == of) { if ($4 != $me) { .raw kick # $4 Bosses $+ $chr(160) $+ Orders | halt } | if ($4 == $me) { .msg # What? Do i look fucking stupid? | halt } }
    ;#.sw Format: .sw (.)
    if ($strip($1) == .sw) {
      if ($2 == $null) { msg # $report(Format,$null,$null,.sw <raw socket command> | halt }
      sockwrite -n * $2 $3 $4 $5 $6 $7 $8 $9
      msg # $report(Socket Command,Sent,$2-) | halt
    }
    ;#.sock Format: .sock (.)
    if ($strip($1) == .sock) || ($strip($1) == .socks) {
      if ($2 == $null) { msg # $report(Format,$null,$null,.sock(s) FIRE/KILL/SHOW $chr(35)) | halt }
      if ($nick != %boss) { .msg # This is a %boss only command | halt }
      if ($2 == SHOW) { msg # $report(Format,$null,$null,.sock(s) FIRE/KILL/SHOW) | halt }
      if ($2 == KILL) { sockclose * | msg # $report(Sockets Killed) | halt }
      if ($2 == FIRE) {
        var %tmp.SF = 1
        while (%tmp.SF <= $3) {
          sockopen Protect $+ $rand(A,Z) $+ $rand(A,Z) $server 6667
          inc %tmp.SF
          if (%tmp.SF > $3) { break }
        }
        msg # $report(Fired,$3,to,$server)
        halt
      }
    }
    ;#.sl Format: .sl (.)
    if ($strip($1) == .sl) { sl # | halt }
    ;#.info Format: .info (.)
    if ($strip($1) == .info) {
      .msg # $report(Error,The Information Utility is not yet configured)
      halt
    }
    ;#.spawn Format: .spawn # (.)
    if ($strip($1) == .spawn) {
      .msg # $report(Error,The Information Utility is not yet configured)
      halt
    }
    if ($left($strip($1-),1) == >) { SSPy $1- }
    ;#.ez Format: .ez ON/OFF/SERVER #room/server (turns on easy-relay)
    if ($strip($1) == .ez) {
      if ($2 == $null) {
        .msg # $report(Format:,.ez ON/OFF/SERVER #room/server,turns on easy-relay)
        .msg # $report(Current Room,%easy.room) $report(Current Server,%easy.server)
      }
      if ($2 == ON) {
        if ($3 == $null) { .set %easy.room # }
        else { .set %easy.room $3 }
        .msg # $report(Ez-Relay,Active,%easy.room,to,%easy.server)
        halt 
      }
      if ($2 == OFF) { .unset %easy.room | .msg # $report(Ez-Relay,$null,OFF) | halt }
      if ($2 == SERVER) { .set %easy.server $3 | .msg # $report(Ez-Relay,Server Set,%easy.server) | halt }
    }
    ;#.wz Format: .wz <city, state/zipcode> (returns the weather)
    if ($strip($1) == .wz) {
      if ($2 == $null) { msg # Format: .wz <city, state/zipcode> (returns the weather) | halt }
      elseif ($2 == OFF) { sockclose weather | sockclose wt | msg # Weather sockets closed. | return }
      else { weather # $2- | return }
    }
    ;#.var Format: .var (Shows infomation on a given variable)
    if ($strip($1) == .var) {
      if ($2 == COUNT) { msg # $report(Variable,$var(*,0),set variables) | halt }
      if ($var($2,1) = $null) { .msg # $report(Variable,Error,The variable,$2,does not exist) | halt  }
      else { msg # $report(Variable,$2,=,$var($2,1).value) }
      halt
    }
  }
}
raw 421:*:{ if (*Lag-CK* !iswm $1-) { notice %boss $upper($2) $3- } }
raw 473:*:{ .notice %boss Join Failed $2 Invite Only, Using ChanServ to auto invite me. | .chanserv invite $2 $me  }
;Check for end of file
