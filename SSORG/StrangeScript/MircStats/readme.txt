-------------------------------------------------------------------------
-- mIRCStats v1.19 - Uploaded 10.6.2002                                --			
-- by Mikko 'Ave' Auvinen (comments to mircstats@nic.fi)               --
--                                                                     --
-- homepage: http://www.nic.fi/~mauvinen/mircstats/                    --
--       or  http://www.mircstats.com/                                 --
--      FAQ: http://www.nic.fi/~mauvinen/mircstats/mircstatsfaq.html   --
-------------------------------------------------------------------------
FTP and HTTP-Components are programmed by Francois Piette (http://www.rtfm.be/fpiette).
  - mIRCStats occasinally checks for a "New version" message from nic.fi's web server.
    This uses HTTP GET method, and doesn't send any information out.
    If new mIRCStats version is available, a message window pops up.
-------------------------------------------------------------------------


mIRCStats is an easy-to-use IRC channel reporting tool, which analyzes channel log-files
produced by the most commonly used IRC-client, mIRC, and creates a nice looking
HTML-page consisting of channel activity statistics, user reports, tables about changed
channel topics and all kinds of miscellaneous information taken from the log file. 


Some guidelines:
----------------
It's easy to start creating statistics using mIRCStats: 

	* Make sure you have a mIRC client program (version 5.31 or higher). 
	  (download: http://www.mirc.co.uk) 

 	* In mIRC Options/IRC/Logging settings page:
	  - Turn on "Automatically log channels" 	  
    	  - Check (=turn on) "Strip codes"
	  - Check "Timestamp logs" (Adds timestamp to logs even if you don't use them in channel windows)
	  - Uncheck "Lock log files" (This lets mIRCStats analyze logs while mIRC is active)

	  - Uncheck "Show mode prefix" at Options/Irc page

	After doing this your mIRC is making .log-files of all channel activities on those channels
	you are on. You can generate statistics any time by running mIRCStats and selecting a
	proper mirc log file. 


	Basic information how to publish your stats in the internet:
	
	* Stats pages are created by default to /html directory under your mircstats dir.
        * You can configure a built-in ftp client to upload stats files to your web server
        * or use any ftp client (WS_FTP for example) to upload the generated files
          (html, css, gif and jpg) to some directory ("stats" for example) at your web server.
	* Display your stats page url at your irc channel to your friends 
          (http://www.yourserver.com/~yourname/stats/yourchannel.html)

	
	mIRCStats accepts following command line parameters:

	mircstats.exe [-l logfile] [-h htmlfile] [-c configfile] [-req request_name]
	You can load multiple config files by specifying more [-c configfile] parameters.


mIRCStats is a SHAREWARE program

	  If you like to use mIRCStats, please register it. By doing that you 
	  also support developing of new features, which you can take full advantage of! 
	
	  Take a look at register.txt for further info.


GETTING HELP
============

Pressing F1 while running mIRCStats opens the On-line help.
Use index and search to find the subject.



VERSION INFO
============

See file versionhistory.txt



Limitations:
============
- Maximum number of days to be analyzed with a single scan.............. 2000
- Maximum number of lines per day to be saved to channel history...... 262140
- Maximum number of days in channel history......................... NO LIMIT
- Maximum number of nicks in one scan............................... NO LIMIT
- Maximum number of words in word stats............................. NO LIMIT
- Most variables are limited by range of signed 32-bit integer.... 2147483647


Thanks to:
==========

* All registered users who believe that it can still be developed further
* mIRCStats beta tester group
* Language file writers from countries all around the world.
* Everyone who has sent me mail and suggestions about mIRCStats.


Please report bugs to mircstats@nic.fi


DISCLAIMER
==========

Author doesn't take any responsibility of any damage this program may cause.
Copyright of mIRCStats is owned by Mikko Auvinen
