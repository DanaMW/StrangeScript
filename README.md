# Welcome To StrangeScript Information

```text
The original mIRC script. StrangeScript ©1999-2026 Dana L. Meli-Wischman.
```

```text
I hope this old script helps you build up your own
script. There is some very good code in here that still
works perfectly. You can learn a lot from it.
I hope you have fun.
```

```text
You need to extract the StrangeScript (StrangeScript/StrangeScript) folder as your
top level script folder from this git. I intend to do
a package deal in the future.

To UPDATE grab the SYSTEM (StrangeScript/StrangeScript/System)
folder in StrangeScript. Then just do /RELOAD, and answer NO.
Do this with the script running. It won't hurt a thing.
```

```text
I put a bunch of time into this little thing.
If you are going to rip out a piece of it and add
it to your script at least give me credit, in
your script, or click me a like above, which is the
right thing to do. Thank you.
```

```text
Notice: This is NOT a beginner script.This script requires
skill with IRC servers and mIRC to use. I warned you.

*I started adding comments throughout strange, should help you.*
```

```text
In StrangeScript I started with the COMPLETE and ORIGINAL
StrangeScript just the way it was the day I parked it.
Now I have decided to work on it and fix all the things
I haven't done it in 20+ years. Here we go. This script is
mIRC only. I stashed the AdiIRC copy up there.
```

```text
There is a small bot, do /bot OFF first then /bot ON.
That resets the bot. You may use /bot OFF at any time the
bot needs resetting. The bot is multi-server, you can have
1 copy running on each server if you like.

I am fond of the main bot, MBot (StrangeScript/StrangeScript/MBot)
Runs off its own copy of mIRC in the MBot folder. That is
it's own session. It is fully integrated into the script.
But I like to copy everything over to another machine and
run it. You don't have to, but you can.
```

```text
I am updating the original bot, MasterBot (MBot).
It seems to be running fine but if you use it
and see something let me know.
```

## Help One
```text
If you run into trouble it is most likely a setting is unset.
To set something it is done:

Network specific Settings
-------------------------
[Write]
keywrite settings <segment> <value>
or
keywrite <#roomname> <segment> <value>

Example: /keywrite settings shitheadlast $address($2,4)
Example: /keywrite # lastinIP $myaddress2($nick)

[Read]
$key(settings,<segment>)
$key(<$network>,<segment>)

Example:
Example: $key($4,ownerkey)

Key(write) uses "<$network>.ini" named file in StrangeScript/text folder.

For overall script Settings
---------------------------
[Write]
The script uses a few titles but "settings" is the only one you really need.
masterwrite <Title> <Key> <Value>
masterwrite settings <Key> <Value>

Example: /masterwrite settings Sbnc.active OFF

[Read]
$master(settings,Key)

Example: $master(settings,socksay)
Example: $master(settings,autostartserver)

Master(write) uses "ScriptInfo.ini" in StrangeScript/text folder.

You can clear any key by leaving the <value> blank.

Example: /keywrite settings shithead

That clears the Shithead List.

```

@author Dana L. Meli-Wischman
