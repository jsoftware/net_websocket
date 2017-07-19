NB. html

NB. =========================================================
NB. format table from dbread as html
tab2html=: 3 : 0
'cls dat'=. y
msk=. (<:+:#cls) $1 0
cls=. msk expand cls
dat=. msk expand dat
rws=. #0 pick dat
dat=. (<rws#a:) (I. msk=0)} dat
th=. '<th>' , ,&'</th>'
tr=. '<tr>' , ,&'</tr>'
hdr=. tr ; th each cls
td0=. rws $ '<td>';'<td class="alt">'
td1=. '</td>'
td=. td0 (,td1,~":) each ]
ndx=. I. 0<L.&> dat
dat=. (td each ndx{dat) ndx} dat
td0=. rws $ '<td class="right">';'<td class="right alt">'
td=. td0 (,td1,~":) each ]
ndx=. I. 0=L.&> dat
dat=. (td each ndx{dat) ndx} dat
dat=. > ,.each/ dat
dat=. (<'<tr>'),.dat,.<'</tr>',LF
bdy=. ; <@;"1 dat
'<table>',hdr,bdy,'</table>'
)
NB. main

NB. =========================================================
NB. show select result
showselect=: 3 : 0
try.
  tab2html dbread y
catcht.
  '<p>query failed: ',y,'</p>'
end.
)

NB. =========================================================
NB. show first 5 rows of each table
showtables=: 3 : 0
t=. dbtables''
s=. (,' - ' , ' records' ,~ ":@dbsize) each t
p=. ('<b>',,&'</b>') each s
r=. tab2html@dbread each t ,each <' limit 5'
; (p ,each r) ,each LF
)

load 'data/sqlite/sqlitez'

dbopen '~addons/data/sqlite/db/chinook.db'

load 'net/websocket'
init_jws_ 5022
