on *:TEXT:*:#:{
  if (%talk.on. [ $+ [ $network ] ] == ON) {
    ;sstalkflood $nick
    if ($istok(%talk.room. [ $+ [ $network ] ],$chan,44) != $true) { halt }
    if ($nick == $chan(#)) { halt }
    if ($nick == %boss. [ $+ [ $network ] ]) { if (*shutup* iswm $strip($1-)) { $pointer $report(Speach interaction,$null,$null,Off) } }
    if (*shutup* iswm $strip($1-)) { $point Yeah right like you could ever tell me what to do | halt }
    if (godamn isin $strip($1-)) { $point $read $mircdirtext\god.txt | halt }
    if (goddamn isin $strip($1-)) { $point $read $mircdirtext\god.txt | halt }
    if (damn isin $strip($1-)) { $point $read $mircdirtext\damn.txt | halt }
    if (*pussy* iswm $strip($1-)) { $point $read $mircdirtext\pussy.txt | halt }
    if (*slut* iswm $strip($1-)) { $point $read $mircdirtext\slut.txt | halt }
    if (*bitch* iswm $strip($1-)) { $point $read $mircdirtext\bitch.txt | halt }
    if (*fuck* iswm $strip($1-)) { $point $read $mircdirtext\fuck.txt | halt }
    if (*addy* iswm $strip($1-)) { $point http://www.strangeout.com | halt }
    if (*cum* iswm $strip($1-)) { $point $read $mircdirtext\cum.txt | halt }
    if (*cunt* iswm $strip($1-)) { $point $read $mircdirtext\cunt.txt | halt }
    if (*bastard* iswm $strip($1-)) { $point $read $mircdirtext\bastard.txt | halt }
    if (*dick* iswm $strip($1-)) { $point $read $mircdirtext\dick.txt | halt }
    if (*fag* iswm $strip($1-)) { halt }
    if (*ok* iswm $strip($1-)) && (*joke* !iswm $strip($1-)) { if ($rand(1,3) == 1) { $point $+ It better be ok. } | halt } 
    if (*tramp* iswm $strip($1-)) { $point $read $mircdirtext\tramp.txt | halt }
    if (*asshole* iswm $strip($1-)) { $point $read $mircdirtext\ass.txt | halt }
    if (*shit* iswm $strip($1-)) { $point $read $mircdirtext\shit.txt | halt } 
    if (*lamer* iswm $strip($1-)) { halt }
    if (*hoe* iswm $strip($1-)) { $point $read $mircdirtext\hoe.txt | halt }
    if (*whore* iswm $strip($1-)) { $point $read $mircdirtext\hoe.txt | halt }
    if (*no* iswm $strip($1-)) { if ($rand(1,3) == 1) { $point uh huh | halt } }
    if (*lol* iswm $strip($1-)) { if ($rand(1,3) == 1) { $point $read $mircdirtext\laugh.txt } | halt }
    if (*question* iswm $strip($1-)) { $point Oh great! another question from $nick | halt }
    if ($chr(63) isin $strip($1-)) { if ($rand(1,3) == 1) { $point What is real, anyway? } | halt } 
    if (*llol* iswm $strip($1-)) { $point lol | halt }
    if (*loll* iswm $strip($1-)) { $point lol | halt }
    if (*lool* iswm $strip($1-)) { $point lol | halt }
    if (*good* iswm $strip($1-)) { if ($rand(1,3) == 1) { $point You know I'm good. } | halt }
    if (*brb* iswm $strip($1-)) { $point Dont worry I'll be here! | halt }
    if (*test* iswm $strip($1-)) { $point $read $mircdirtext\test.txt | halt }
    if (*later* iswm $strip($1-)) { $point OK later. I'll be around. | halt }
    if (*butt* iswm $strip($1-)) { $point Kiss my butt. | halt }
    if (*night* iswm $strip($1-)) { $point Good night $nick. | halt }
    if (*yes* iswm $strip($1-)) { if ($rand(1,3) == 1) { $point No Way } | halt }
    if (*bot* iswm $strip($1-)) { if ($rand(1,3) == 1) { $point $read $mircdirtext\bot.txt } | halt }
    if (*good night* iswm $strip($1-)) { $point Good night $nick. | halt }
    if (*rofl* iswm $strip($1-)) { $point Get up off the floor. | halt }
    if (*lmao* iswm $strip($1-)) { $point thats alot of ass to laugh off $nick | halt }
    if (*opinion* iswm $strip($1-)) { $point $+ Pot should remain legal | halt }
    if (*kewl* iswm $strip($1-)) { $point Thanks I think I'm kewl too. | halt }
    if (*cool* iswm $strip($1-)) { $point I am the coolest! | halt }
    if (*bye* iswm $strip($1-)) { $point $read $mircdirtext\bye.txt | halt }
    if (*yep* iswm $strip($1-)) { $point yep I'm right. | halt }
    if (*stoned* iswm $strip($1-)) { $point I'm always stoned | halt }
    if (*script* iswm $strip($1-)) { $point $read $mircdirtext\script.txt | halt }
    if (*sleep* iswm $strip($1-)) { $point You need some sleep $nick, you look like shit. | halt }
    if (*yup* iswm $strip($1-)) { $point Nope | halt }
    if (*hello* iswm $strip($1-)) { $point Well hello there $nick | halt }
    if (*dana* iswm $strip($1-)) { $point $read $mircdirtext\dana.txt | halt }
    if (*uh huh* iswm $strip($1-)) { $point Not today | halt }
    if (*anal* iswm $strip($1-)) { $point Studies have shown people that use the word anal like it up the pooper | halt }
    ;if (*written by* iswm $strip($1-)) { $point I was written by Dana L. Meli-Wischman. | halt }
    ;if (*wrote* iswm $strip($1-)) { $point I was written by Dana L. Meli-Wischman. | halt }
    if (*stupid* iswm $strip($1-)) { $point Holds up a mirror for $nick | halt }
    if (*shut up* iswm $strip($1-)) { $point Harsh. | halt }
    if (*strange* iswm $strip($1-)) && (* $+ $me $+ * !iswm $strip($1-)) { $point Strange is the man!! | halt }
    if (*joke* iswm $strip($1-)) { $point $read -n $mircdirtext\Redneck.txt | halt }
    if (hey $me iswm $strip($1-)) { $point $read -n $mircdirtext\ME.TXT | halt }
  }
}
