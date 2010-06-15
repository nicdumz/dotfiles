#!/bin/bash
#
# pop-up calendar for dzen
#
# based on (c) 2007, by Robert Manea
# http://dzen.geekmode.org/dwiki/doku.php?id=dzen:calendar
# modified by urukrama
# 
#!/bin/bash
#
# pop-up calendar for dzen
#
# based on (c) 2007, by Robert Manea
# http://dzen.geekmode.org/dwiki/doku.php?id=dzen:calendar
# modified by urukrama
# 

BG="#222222"
FG="#B23308"
TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

CAL=`cal | python -c "import sys; t = sys.stdin.read().splitlines(); t[-2] = t[-2] + (7-len(t[-2].split()))*'   '; print '\n'.join(t)"`
(
echo "^fg($FG)"`date +'%A %d %B %Y %n'`; \
echo; echo "$CAL" | sed -re "s/(^|[ ])($TODAY)($|[ ])/\1^bg($FG)\2^bg()\3/"; \
sleep 60 
) \
    | dzen2 -fg '#F2EDD7' -bg "$BG" -fn 'Bitstream Vera Sans Mono-9' -x 1100 -y 20 -w 160 -l 9 -sa c -e 'button3=exit;button1=exit;onstart=uncollapse;'-


