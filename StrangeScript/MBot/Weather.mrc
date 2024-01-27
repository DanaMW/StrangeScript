alias weather {
  sockclose wt
  ;set %city $replace($gettok($1-,1,62),$chr(32),$chr(37) $+ 20)
  ;set %country $replace($gettok($1-,2,62),$chr(32),$chr(37) $+ 20)
  set %room msg $1
  set %line $replace($2-,$chr(32),$chr(37) $+ 20)
  ;if (S isin $gettok($1-,3,62)) { goto skip }
  ;if (C isin $gettok($1-,3,62)) { set %wt.type C } | else { set %wt.type F }
  set %wt.type F
  :skip
  sockopen wt $iif(%wt.proxy,%wt.proxy,www.weather.com) 80
  %room Please wait while i try to connect to weather.com ...
}
alias weather.get {
  sockclose wt.url
  sockopen wt.url $iif(%wt.proxy,%wt.proxy,www.w3.weather.com) 80
}
alias weather.proxy { if ($1 == off) { unset %wt.proxy } | else { set %wt.proxy $1 } }
on 1:sockopen:wt: {
  if ($sockerr > 0) { %room Cannot connect $+($chr(40),$gettok($sock($sockname).wsmsg,2-,32),$chr(41)) | return }
  var %s = sockwrite -tn wt
  ;%s GET $chr(104) $+ $chr(116) $+ $chr(116) $+ $chr(112) $+ $chr(58) $+ $chr(47) $+ $chr(47) $+ $chr(119) $+ $chr(119) $+ $chr(119) $+ $chr(46) $+ $chr(119) $+ $chr(101) $+ $chr(97) $+ $chr(116) $+ $chr(104) $+ $chr(101) $+ $chr(114) $+ $chr(46) $+ $chr(99) $+ $chr(111) $+ $chr(109) $+ $chr(47) $+ $chr(115) $+ $chr(101) $+ $chr(97) $+ $chr(114) $+ $chr(99) $+ $chr(104) $+ $chr(47) $+ $chr(115) $+ $chr(101) $+ $chr(97) $+ $chr(114) $+ $chr(99) $+ $chr(104) $+ $chr(63) $+ $chr(119) $+ $chr(104) $+ $chr(101) $+ $chr(114) $+ $chr(101) $+ $chr(61) $+ %city $+ $chr(37) $+ 2C $+ %country HTTP/1.1
  %s GET $chr(104) $+ $chr(116) $+ $chr(116) $+ $chr(112) $+ $chr(58) $+ $chr(47) $+ $chr(47) $+ $chr(119) $+ $chr(119) $+ $chr(119) $+ $chr(46) $+ $chr(119) $+ $chr(101) $+ $chr(97) $+ $chr(116) $+ $chr(104) $+ $chr(101) $+ $chr(114) $+ $chr(46) $+ $chr(99) $+ $chr(111) $+ $chr(109) $+ $chr(47) $+ $chr(115) $+ $chr(101) $+ $chr(97) $+ $chr(114) $+ $chr(99) $+ $chr(104) $+ $chr(47) $+ $chr(115) $+ $chr(101) $+ $chr(97) $+ $chr(114) $+ $chr(99) $+ $chr(104) $+ $chr(63) $+ $chr(119) $+ $chr(104) $+ $chr(101) $+ $chr(114) $+ $chr(101) $+ $chr(61) $+ %line HTTP/1.1
  %s Host: www.weather.com $iif(%wt.proxy,80)
  %s Connection: Close
  %s $crlf
}
on 1:sockread:wt: {
  if ($sockerr > 0) { %room Sockread Error for $sockname | sockclose $sockname | return }
  sockread %wt
  if ($sockbr == 0) { return }
  if (We did not find a match to your isin %wt) {
    %room Couldn't find weather for that city.
  }
  if ($gettok(%wt,1,32) == Location:) {
    set %wt.url $gettok(%wt,5-,47)
    sockclose wt
    weather.get
  }
  elseif (<font class="categoryTitle">Cities</font><br> isin %wt) {
    if ($window(@cities)) { window -c @cities }
  }
  elseif (<a href="/weather/local/ isin %wt) {
    var %p = $pos(%wt,/weather/local/)
    var %d = $calc(%p + 15)
    set %wt.cities $addtok(%wt.cities,$mid(%wt,%d,8),44)
    %room $gettok($gettok(%wt,2,62),1,60)
  }
}
on 1:sockopen:wt.url: {
  if ($sockerr > 0) { %room Sockopen Error for $sockname | sockclose $sockname | return }
  if ($sockerr > 0) { %room Connection failed $+($chr(40),$gettok($sock($sockname).wsmsg,2-,32),$chr(41)) | return }
  var %s = sockwrite -tn wt.url
  %s GET http://www.w3.weather.com/outlook/travel/local/ $+ %wt.url HTTP/1.1
  %s Host: www.w3.weather.com $iif(%wt.proxy,80)
  %s Connection: Close
  %s $crlf
  write -c temp.txt
}
on 1:sockread:wt.url: {
  if ($sockerr > 0) { %room Sockread Error for $sockname | sockclose $sockname | return }
  :relooper
  sockread %wt.read
  if ($sockbr == 0) { return }
  if (<B>Travel Forecast isin %wt.read) {
    if (>Home</A> !isin %wt.read) {
      var %c = $remove($mid(%wt.read,26),</b>)
      %room Weather conditions for %c
    }
    else {
      var %c = $remove($mid(%wt.read,134),</b>)
      %room Weather conditions for %c
    }
  }
  elseif (<TD VALIGN=MIDDLE ALIGN=CENTER CLASS=obsInfo2 WIDTH=50%><B CLASS=obsTempTextA> isin %wt.read) {
    var %o = $remove($mid(%wt.read,79),</b>,</td>)
    var %f = $left(%o,$calc($pos(%o,&deg;) -1))
    %room Temperature: %f $+ º F ( $+ $f2c(%f) $+ º C $+ )
    ;$iif(%wt.type == F,%f ºF,$f2c(%f) ºC)
  }
  elseif (<TD VALIGN=TOP ALIGN=CENTER CLASS=obsInfo2><B CLASS=obsTextA> isin %wt.read) {
    var %o = $remove($mid(%wt.read,66),</b>,</td>)
    %room  $+ Conditions: %o
  }
  elseif (<TD VALIGN=TOP ALIGN=CENTER CLASS=obsInfo2> <B CLASS=obsTextA> isin %wt.read) {
    var %p = $calc($pos(%wt.read,<br>) +4)
    var %t = $remove($mid(%wt.read,%p),</b>,</td>)
    var %f = $left(%t,$calc($pos(%t,&deg;) -1))
    %room Feels Like:  %f $+ º F ( $+ $f2c(%f) $+ º C $+ )
    ;$iif(%wt.type == F,%f ºF,$f2c(%f) ºC)
    sockclose wt.url
  }
  goto relooper
}
alias int2 {
  var %dec = $left($gettok($1,2,46),1)
  if (%dec >= 5) {
    var %int = $calc($gettok($1,1,46) + 1)
  }
  else { var %int = $gettok($1,1,46) }
  return %int
}
alias f2c {
  return $int2($calc(($1 - 32) * (5/9)))
}
alias chrs {
  var %o = 0
  while %o < $len($1-) {
    inc %o
    var %txt = %txt $chr(36) $+ + $chr(36) $+ chr( $+ $asc($mid($1-,%o,1)) $+ $chr(41)
  }
  return %txt
}
