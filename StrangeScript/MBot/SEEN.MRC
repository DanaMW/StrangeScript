;
;Originally based on !seen By: maconga On: 07-25-2010 At: https://forums.mirc.com/ubbthreads.php/users/78515/maconga
;
;          ;;;;;;;;
;;;;;;;;;;;;      ;;;;;;;;;;;;;;
;           .SEEN+             ;
;;;;;;;;;;;;      ;;;;;;;;;;;;;;
;          ;;;;;;;;
;
;-----------------------------------------------------
;--- Please submit working changes for inclusion. ----
;-----------------------------------------------------
;
;Major version (xx)
alias uu1 return 0
;
;Minor version (xx)
alias uu2 return 12
;
;month (xx)
alias uu3 return 04
;
;day (xx)
alias uu4 return 26
;
;year (xxxx)
alias uu5 return 2025
;-----------------------------------------------------
alias seenver return { $uu1 $+ . $+ $uu2 }
alias seenverfull return { $uu1 $+ . $+ $uu2 $+ . $+ $uu3 $+ . $+ $uu4 $+ . $+ $uu5 }
;
On 1:TEXT:.seen:#:{
  msg $chan $nick $+ , there are $findfile($mircdir\seen,*.*,0) seen records in my database. Please refine your search.
}
On 1:TEXT:Suggest seen *:#:{
  set %SugSeen102 * $+ $3 $+ *.*
  .timer 1 1 /notice $nick Based on your search, I would suggest you are looking for one of the following nicknames:
  .timer 1 3 /notice $nick $remove($nopath($findfile($mircdir\seen,%SugSeen102,1)),.ini)
  .timer 1 5 /notice $nick $remove($nopath($findfile($mircdir\seen,%SugSeen102,2)),.ini)
  .timer 1 7 /notice $nick $remove($nopath($findfile($mircdir\seen,%SugSeen102,3)),.ini)
  .timer 1 9 /notice $nick $remove($nopath($findfile($mircdir\seen,%SugSeen102,4)),.ini)
  .timer 1 11 /notice $nick $remove($nopath($findfile($mircdir\seen,%SugSeen102,5)),.ini)
  .timer 1 13 /notice $nick You can refine your search even more by supplying a better query. For example, *TAR* instead of *AR*
}
On 1:TEXT:.seen *:#:{
  ; if the guy is looking for u
  if ($chr(42) isin $2) {
    set %Seen102 * $+ $2 $+ *.*
    msg $chan 4 $nick $+ , there are $findfile($mircdir\seen,%Seen102,0) matching records in my database. To list them, type: suggest seen $2 
  }
  elseif ($2 == $me) { 
    /msg $chan $2 is running successfully. 
    .goto end 
  }
  ; Self search...
  elseif ($2 == $nick) { 
    /msg $chan $nick $+ , you do realise this is a computer don't you? 
    .goto end 
  } 
  ; Searched person already on the channel...
  elseif ($2 ison $chan) { 
    /msg $chan $nick $+ , $2- is online in $chan on $network $+ .
    .goto end 
  }
  ; else u can always check the ini files :D
  else { 
    if (($right($2,1) == ]) || ($left($2,1) == [)) { .set %seennick $replace($2,[,@) | .set %seennick $replace(%seennick,],~) }
    else { .set %seennick $2 }
    ; [ this are going to change @ and ] to ~
    :inifile {
      ; if he's not in the ini files...
      .set -u5 %seenaction $readini seen\ $+ $2 $+ .ini %seennick Action
      if (%seenaction == $null) { /msg $chan Sorry $nick $+ , i haven't seen $2- around }
      ; they joined a channel...
      if (%seenaction == join) { 
        .set -u5 %jointime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %joinchannel $readini seen\ $+ $2 $+ .ini %seennick Channel
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2- joined %joinchannel $duration($calc($ctime - %jointime),2) ago on %theNetwork $+ .
      }
      ; they departed a channel...
      if (%seenaction == part) { 
        .set -u5 %parttime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %partchannel $readini seen\ $+ $2 $+ .ini %seennick Channel
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 parted %partchannel $duration($calc($ctime - %parttime),2) ago on %theNetwork $+ .
      }
      ; they quit...
      if (%seenaction == quit) { 
        .set -u5 %quittime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %quitchannel $readini seen\ $+ $2 $+ .ini %seennick Channel
        .set -u5 %quitmessage $readini seen\ $+ $2 $+ .ini %seennick Message
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 quit %quitchannel with the message ( %quitmessage ) $duration($calc($ctime - %quittime),2) ago on %theNetwork $+ .
      }
      ; they were kicked...
      if (%seenaction == kick) { 
        .set -u5 %kicktime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %kickchannel $readini seen\ $+ $2 $+ .ini %seennick Channel
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 was kicked from %kickchannel $duration($calc($ctime - %kicktime),2) ago on %theNetwork $+ .
      }
      ; they changed nickname...
      if (%seenaction == nick) { 
        .set -u5 %nicktime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %nicknew $readini seen\ $+ $2 $+ .ini %seennick Nick
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 changed his nick to %nicknew $duration($calc($ctime - %nicktime),2) ago on %theNetwork $+ .
      }
      ; they said something...
      if (%seenaction == text) { 
        .set -u5 %texttime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %textchannel $readini seen\ $+ $2 $+ .ini %seennick Channel
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 said something on %textchannel $duration($calc($ctime - %texttime),2) ago on %theNetwork $+ .
      } 
      ; they did was an action...
      if (%seenaction == action) { 
        .set -u5 %actiontime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %actionchannel $readini seen\ $+ $2 $+ .ini %seennick Channel
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 did an action in %actionchannel $duration($calc($ctime - %actiontime),2) ago on %theNetwork $+ .
      }
      ; they came online...
      if (%seenaction == notify) { 
        .set -u5 %texttime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 came online $duration($calc($ctime - %texttime),2) ago on %theNetwork $+ .
      } 
      ; they went offline...
      if (%seenaction == unotify) { 
        .set -u5 %actiontime $readini seen\ $+ $2 $+ .ini %seennick Time
        .set -u5 %theNetwork $readini seen\ $+ $2 $+ .ini %seennick Network
        /msg $chan $nick $+ , $2 appears to have gone offline at $duration($calc($ctime - %actiontime),2) from %theNetwork $+ .
      }
    }
  }
  :end
}
; when someone joins the channel...
On 1:JOIN:#:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  ; [ are going to change @ and ] to ~
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action join
  .writeini seen\ $+ $nick $+ .ini %seennick Channel $chan 
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}

; when someone parts the channel
On 1:PART:#:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action part
  .writeini seen\ $+ $nick $+ .ini %seennick Channel $chan
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}

; when someone quits the channel
On 1:QUIT:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action quit
  .writeini seen\ $+ $nick $+ .ini %seennick Channel $chan
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Message $1-
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}

; when some moron gets kicked...
On 1:KICxK:#:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action kick
  .writeini seen\ $+ $nick $+ .ini %seennick Channel $chan
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}

; when someone changes nick...
On 1:NICK:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action nick
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Nick $newnick
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}

; when someone says something in the channel
On 1:TEXT:*:#:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action text
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Channel $chan
  .writeini seen\ $+ $nick $+ .ini %seennick text $1-
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}

; when someone makes an action
On 1:ACTION:*:#:{
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action action
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Channel $chan
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}
on 1:NOTIFY: {
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action notify
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}
on 1:UNOTIFY: {
  if (($right($nick,1) == ]) || ($left($nick,1) == [)) { .set %seennick $replace($nick,[,@) | .set %seennick $replace(%seennick,],~) }
  else { .set %seennick $nick }
  .remini seen\ $+ $nick $+ .ini %seennick
  .writeini seen\ $+ $nick $+ .ini %seennick Action unotify
  .writeini seen\ $+ $nick $+ .ini %seennick Time $ctime
  .writeini seen\ $+ $nick $+ .ini %seennick Network $network
}
