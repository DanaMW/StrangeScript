on *:TEXT:*:#:{
  ;sstalkflood $nick
  if ($istok(%talk.room. [ $+ [ $network ] ],$chan,44) != $true) { halt }
  if ($nick == $chan(#)) { halt }
  if ($nick == %boss. [ $+ [ $network ] ]) { if (*shutup* iswm $strip($1-)) { $pointer $report(Speach interaction,$null,$null,Off) | .unload -rs talker.mrc | halt  } }
  if (*shutup* iswm $strip($1-)) { .msg # Yeah right like you could ever tell me what to do | halt }
  if (godamn isin $strip($1-)) { .msg # $read $mircdirtext\god.txt | halt }
  if (goddamn isin $strip($1-)) { .msg # $read $mircdirtext\god.txt | halt }
  if (damn isin $strip($1-)) { .msg # $read $mircdirtext\damn.txt | halt }
  if (*pussy* iswm $strip($1-)) { .msg # $read $mircdirtext\pussy.txt | halt }
  if (*slut* iswm $strip($1-)) { .msg # $read $mircdirtext\slut.txt | halt }
  if (*bitch* iswm $strip($1-)) { .msg # $read $mircdirtext\bitch.txt | halt }
  if (*fuck* iswm $strip($1-)) { .msg # $read $mircdirtext\fuck.txt | halt }
  if (*addy* iswm $strip($1-)) { .msg # http://www.strangeout.com | halt }
  if (*cum* iswm $strip($1-)) { .msg # $read $mircdirtext\cum.txt | halt }
  if (*cunt* iswm $strip($1-)) { .msg # $read $mircdirtext\cunt.txt | halt }
  if (*bastard* iswm $strip($1-)) { .msg # $read $mircdirtext\bastard.txt | halt }
  if (*dick* iswm $strip($1-)) { .msg # $read $mircdirtext\dick.txt | halt }
  if (*fag* iswm $strip($1-)) { .msg # $read $mircdirtext\fag.txt | halt }
  if (*ok* iswm $strip($1-)) && (*joke* !iswm $strip($1-)) { if ($rand(1,3) == 1) { .msg # $+ It better be ok. } | halt } 
  if (*tramp* iswm $strip($1-)) { .msg # $read $mircdirtext\tramp.txt | halt }
  if (*asshole* iswm $strip($1-)) { .msg # $read $mircdirtext\ass.txt | halt }
  if (*shit* iswm $strip($1-)) { .msg # $read $mircdirtext\shit.txt | halt } 
  if (*lamer* iswm $strip($1-)) { .msg # $read $mircdirtext\lamer.txt | halt }
  if (*hoe* iswm $strip($1-)) { .msg # $read $mircdirtext\hoe.txt | halt }
  if (*whore* iswm $strip($1-)) { .msg # $read $mircdirtext\hoe.txt | halt }
  if (*no* iswm $strip($1-)) { if ($rand(1,3) == 1) { .msg # uh huh | halt } }
  if (*lol* iswm $strip($1-)) { if ($rand(1,3) == 1) { .msg # $read $mircdirtext\laugh.txt } | halt }
  if (*question* iswm $strip($1-)) { .msg # Oh great! another fucking question from $nick | halt }
  if ($chr(63) isin $strip($1-)) { if ($rand(1,3) == 1) { .msg # Oh great! another fucking question from $nick } | halt } 
  if (*llol* iswm $strip($1-)) { .msg # Cant you fucking spell $nick | halt }
  if (*loll* iswm $strip($1-)) { .msg # Cant you fucking spell $nick | halt }
  if (*lool* iswm $strip($1-)) { .msg # Whats a LOOL $nick? | halt }
  if (*good* iswm $strip($1-)) { if ($rand(1,3) == 1) { .msg # You know I'm good. | halt } }
  if (*brb* iswm $strip($1-)) { .msg # Dont worry I'll be here! | halt }
  if (*test* iswm $strip($1-)) { .msg # $read $mircdirtext\test.txt | halt }
  if (*later* iswm $strip($1-)) { .msg # OK later. I'll be around. | halt }
  if (*butt* iswm $strip($1-)) { .msg # Kiss my butt. | halt }
  if (*night* iswm $strip($1-)) { .msg # Good night $nick. | halt }
  if (*yes* iswm $strip($1-)) { if ($rand(1,3) == 1) { .msg # No Way | halt } }
  if (*bot* iswm $strip($1-)) { if ($rand(1,3) == 1) { .msg # $read $mircdirtext\bot.txt | halt } }
  if (*good night* iswm $strip($1-)) { .msg # Good night $nick. | halt }
  if (*rofl* iswm $strip($1-)) { .msg # Get up off the floor. | halt }
  if (*lmao* iswm $strip($1-)) { .msg # thats alot of ass to laugh off $nick | halt }
  if (*opinion* iswm $strip($1-)) { .msg # $+ Pot should remain legal | halt }
  if (*kewl* iswm $strip($1-)) { .msg # Thanks I think I'm kewl too. | halt }
  if (*cool* iswm $strip($1-)) { .msg # I am the coolest! | halt }
  if (*bye* iswm $strip($1-)) { .msg # $read $mircdirtext\bye.txt | halt }
  if (*yep* iswm $strip($1-)) { .msg # yep I'm right. | halt }
  if (*coo iswm $strip($1-)) { .msg # Wheres the L? | halt }
  if (*stoned* iswm $strip($1-)) { .msg # I'm always stoned | halt }
  if (*script* iswm $strip($1-)) { .msg # I write my own damn scripts. | halt }
  if (*sleep* iswm $strip($1-)) { .msg # You need some sleep $nick, you look like shit. | halt }
  if (*yup* iswm $strip($1-)) { .msg # Nope | halt }
  if (*hello* iswm $strip($1-)) { .msg # Well hello there $nick | halt }
  if (*dana* iswm $strip($1-)) { .msg # $read $mircdirtext\dana.txt | halt }
  if (*uh huh* iswm $strip($1-)) { .msg # Not today | halt }
  if (*anal* iswm $strip($1-)) { .msg # Studies have shown people that use the word anal like it up the ass | halt }
  if (*written by* iswm $strip($1-)) { .msg # I was written by Dana L. Meli-Wischman. | halt }
  if (*wrote* iswm $strip($1-)) { .msg # I was written by Dana L. Meli-Wischman. | halt }
  if (*stupid* iswm $strip($1-)) { .msg # I know someone stupid! It's $nick | halt }
  if (*shut up* iswm $strip($1-)) { .msg # You shut the fuck up $nick, or i'll stomp you | halt }
  if (*strange* iswm $strip($1-)) && (* $+ $me $+ * !iswm $strip($1-)) { .msg # Strange is the man!! | halt }
  if (*joke* iswm $strip($1-)) { .msg # $read -n $mircdirtext\Redneck.txt | halt }
  if (* $+ $me $+ * iswm $strip($1-)) { .msg # I'm a bot dumbass leave me alone. | halt }
}
