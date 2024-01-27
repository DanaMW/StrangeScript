echo Coping Files for Update
REM goto skip
copy D:\SS\system\ALIAS0.INI D:\StrangeScript\system\ALIAS0.INI
copy D:\SS\system\ALIAS1.INI D:\StrangeScript\system\ALIAS1.INI
copy D:\SS\system\ALIAS2.INI D:\StrangeScript\system\ALIAS2.INI
copy D:\SS\system\ALIAS3.INI D:\StrangeScript\system\ALIAS3.INI
copy D:\SS\system\ALIAS4.INI D:\StrangeScript\system\ALIAS4.INI
copy D:\SS\system\ALIAS5.INI D:\StrangeScript\system\ALIAS5.INI
copy D:\SS\system\ALIAS6.INI D:\StrangeScript\system\ALIAS6.INI
copy D:\SS\system\ALIAS7.INI D:\StrangeScript\system\ALIAS7.INI
copy D:\SS\system\SCRIPT0.INI D:\StrangeScript\system\SCRIPT0.INI
copy D:\SS\system\SCRIPT1.INI D:\StrangeScript\system\SCRIPT1.INI
copy D:\SS\system\SCRIPT2.INI D:\StrangeScript\system\SCRIPT2.INI
copy D:\SS\system\SCRIPT3.INI D:\StrangeScript\system\SCRIPT3.INI
copy D:\SS\system\SCRIPT4.INI D:\StrangeScript\system\SCRIPT4.INI
copy D:\SS\system\SCRIPT5.INI D:\StrangeScript\system\SCRIPT5.INI
copy D:\SS\system\SCRIPT6.INI D:\StrangeScript\system\SCRIPT6.INI
copy D:\SS\system\SCRIPT7.INI D:\StrangeScript\system\SCRIPT7.INI
copy D:\SS\System\BOOM.INI D:\StrangeScript\system\BOOM.INI
copy D:\SS\system\CHAN1.INI D:\StrangeScript\system\CHAN1.INI
copy D:\SS\system\SSSTATS.INI D:\StrangeScript\system\SSSTATS.INI
copy D:\SS\system\CTCP.INI D:\StrangeScript\system\CTCP.INI
copy D:\SS\system\IPUNMSK.INI D:\StrangeScript\system\IPUNMSK.INI
copy D:\SS\system\NUKENAB.INI D:\StrangeScript\system\NUKENAB.INI
copy D:\SS\system\MENUBAR1.INI D:\StrangeScript\system\MENUBAR1.INI
copy D:\SS\system\NICK1.INI D:\StrangeScript\system\NICK1.INI
copy D:\SS\system\SOCKET.INI D:\StrangeScript\system\SOCKET.INI
copy D:\SS\system\RELOAD.TXT D:\StrangeScript\system\RELOAD.TXT
copy D:\SS\system\UPDATE.INI D:\StrangeScript\system\UPDATE.INI
copy D:\SS\system\SOCKET1.INI D:\StrangeScript\system\SOCKET1.INI
copy D:\SS\system\QUERY1.INI D:\StrangeScript\system\QUERY1.INI
copy D:\SS\system\STATUS1.INI D:\StrangeScript\system\STATUS1.INI
copy D:\SS\system\BlackJack.INI D:\StrangeScript\system\BlackJack.INI
copy D:\SS\system\Link.INI D:\StrangeScript\system\Link.INI
copy D:\SS\system\Split.INI D:\StrangeScript\system\Split.INI
copy D:\SS\system\mp3.INI D:\StrangeScript\system\mp3.INI
rem copy D:\SS\MBot\popups.ini D:\StrangeScript\MBot\popups.ini
rem copy D:\SS\MBot\aliases.ini D:\StrangeScript\MBot\aliases.ini
rem copy D:\SS\MBot\script0.ini D:\StrangeScript\MBot\script0.ini
rem copy D:\SS\MBot\script1.ini D:\StrangeScript\MBot\script1.ini
rem copy D:\SS\MBot\script2.ini D:\StrangeScript\MBot\script2.ini
rem copy D:\SS\MBot\unmask.ini D:\StrangeScript\MBot\unmask.ini
rem copy D:\SS\MBot\talker.ini D:\StrangeScript\MBot\talker.ini
rem copy D:\SS\MBot\BotHelp1.ini D:\StrangeScript\MBot\BotHelp1.ini
:skip
ECHO Making ZipFile
C:\Progra~1\winzip\wzzip.exe -a -P -r "D:\My Documents\My Downloads\StrangeScript\ScriptUpdate.zip" @MakeList.txt
Echo Done