[script]
n0=;usage: /unmask xxxx.somewhere.com nick
n1=;usage: /unmask 123.456.xxx nick
n2=;--------------------------------------------------------
n3=alias unmask.mask {
n4=  unset %unmask*
n5=  if ($1 == $null) { echo 04 -a ( no mask given ) | halt }
n6=  if ($2 == $null) { echo 04 -a ( no nick given ) | halt }
n7=  set %unmask.count 45
n8=  set %unmask.masked $1
n9=  set %unmask.nick $2
n10=  set %unmask.len $count($gettok(%unmask.masked,1,46),x)
n11=  set %unmask.cur $calc(%unmask.len - 1)
n12=  set %unmask.last . $+ $deltok(%unmask.masked,1,46)
n13=  .enable #unmask
n14=  .raw who $chr(45) $+ $str(?,%unmask.cur) $+ %unmask.last
n15=}
n16=#unmask off
n17=alias who { echo 04 -a the who command is disabled during unmask scan }
n18=on 1:NICK:{ if ($nick == %unmask.nick) { set %unmask.nick $newnick } }
n19=raw 352:*:{ 
n20=  if ($6 == %unmask.nick) {
n21=    set %unmask.result %unmask.result $+ $chr(%unmask.count)
n22=    dec %unmask.cur
n23=    set %unmask.count 44
n24=    echo 04 -a ( unmasking status: $calc(100 / %unmask.len * (%unmask.len - %unmask.cur - 1)) $+ $chr(37) )
n25=  }
n26=  halt
n27=}
n28=raw 315:*:{ 
n29=  if (%unmask.count == 45) inc %unmask.count 2
n30=  if (%unmask.count == 57) set %unmask.count 96
n31=  if (%unmask.count == 62) inc %unmask.count
n32=  if (%unmask.count == 122) { echo 04 -a ( unable to unmask ) | .disable #unmask | halt }
n33=  if (%unmask.cur == -1) { echo 04 -a ( 
n34=    hack resolved $str(x,%unmask.len) $+ %unmask.last to: $lower(%unmask.result) $+ %unmask.last )
n35=    .notice %boss 11 $+ hack resolved $str(x,%unmask.len) $+ %unmask.last to: $lower(%unmask.result) $+ %unmask.last )
n36=    .disable #unmask
n37=    halt
n38=  }
n39=  inc %unmask.count
n40=  .raw who %unmask.result $+ $chr(%unmask.count) $+ $str(?,%unmask.cur) $+ %unmask.last
n41=  halt
n42=}
n43=#unmask end
n44=;<----------unmask ipz---------->
n45=alias unmask { 
n46=  unset %unmask*
n47=  if ($1 == $null) { echo 04 -a ( no mask given ) | .notice %boss 04 $+ no mask given | halt }
n48=  if ($2 == $null) { echo 04 -a ( no nick given ) | .notice %boss 04 $+ no nick given | halt }
n49=  echo 04 -a Unmasking $2 at ip $1
n50=  notice %boss 04 $+ Unmasking $2 at ip $1
n51=  set %unmask.count 48
n52=  set %unmask.len $len($gettok($1,4,46))
n53=  set %unmask.masked $deltok($replace($1,.,*),4,42) $+ $chr(42)
n54=  set %unmask.nick $2
n55=  set %unmask.cur $calc(%unmask.len - 1)
n56=  .enable #unmask.right
n57=  .raw who %unmask.masked $+ 0
n58=}
n59=#unmask.right off
n60=alias who { echo 04 -a the who command is disabled during unmask scan ) }
n61=on 1:NICK:{ if ($nick == %unmask.nick) { set %unmask.nick $newnick } }
n62=raw 352:*:{ 
n63=  if ($6 == %unmask.nick) {
n64=    set %unmask.result $chr(%unmask.count) $+ %unmask.result
n65=    dec %unmask.cur
n66=    set %unmask.count 47
n67=    echo 04 -a unmasking status: $calc(100 / %unmask.len * (%unmask.len - %unmask.cur - 1)) $+ $chr(37) 
n68=  }
n69=  halt
n70=}
n71=raw 315:*:{ 
n72=  if (%unmask.count == 58) { echo 04 -a ( unable to unmask ) | .disable #unmask.right | halt }
n73=  if (%unmask.cur == -1) { 
n74=    echo 04 -a hack resolved $replace(%unmask.masked,*,.) $+ $str(X,%unmask.len) to: $replace(%unmask.masked,*,.) $+ %unmask.result
n75=    .notice %boss 11 $+ hack resolved $replace(%unmask.masked,*,.) $+ $str(X,%unmask.len) to: $replace(%unmask.masked,*,.) $+ %unmask.result
n76=    .disable #unmask.right
n77=    halt
n78=  }
n79=  inc %unmask.count
n80=  .raw who %unmask.masked $+ $chr(%unmask.count) $+ %unmask.result
n81=  halt
n82=}
n83=#unmask.right end
