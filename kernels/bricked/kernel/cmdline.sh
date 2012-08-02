#!/sbin/sh
#cmdline.sh by show-p1984
#Features: 
#maxkhz/minkhz/gov/maxscroff added to the kernels cmdline
#clean cmdline of foreigns in case of something wicked is going on in there
#(supports my kernel edits, so that the kernel boots with that values)

##find the zip and get the options
zipname="Bricked-3.0-v1.4-ics-"

ziploc=$(find /sdcard/ -name $zipname*)
#remove .zip
ziploc=${ziploc%.zip}
#remove path
ziploc=${ziploc##*/}
#remove filenamebase
opt=${ziploc#Bricked*ics-}

#split options
#set maxkhz
opt=${opt#maxkhz=*}
maxkhz=${opt%%-*}
opt=${opt#*-}
#set minkhz
opt=${opt#minkhz=*}
minkhz=${opt%%-*}
opt=${opt#*-}
#set maxscroff
opt=${opt#maxscroff=*}
maxscroff=${opt%-*}
#opt=${opt##*-}

##end find

##Get 3dgpuoc from aroma tmp
val=$(cat /tmp/aroma-data/3dgpu.prop | cut -d"=" -f2)
case $val in
  1)
    gpu3d="266667000"
    ;;
  2)
    gpu3d="300000000"
    ;;
  3)
    gpu3d="320000000"
    ;;
esac
##end Get 3dgpuoc from aroma tmp

##Get 2dgpuoc from aroma tmp
val=$(cat /tmp/aroma-data/2dgpu.prop | cut -d"=" -f2)
case $val in
  1)
    gpu2d="200000000"
    ;;
  2)
    gpu2d="228571000"
    ;;
  3)
    gpu2d="266667000"
    ;;
esac
##end Get 2dgpuoc from aroma tmp

##Get governor from aroma tmp
val=$(cat /tmp/aroma-data/gov.prop | cut -d"=" -f2)
case $val in
  1)
    gov="badass"
    ;;
  2)
    gov="ondemand"
    ;;
  3)
    gov="lazy"
    ;;
  4)
    gov="interactive"
    ;;
  5)
    gov="lagfree"
    ;;
  6)
    gov="conservative"
    ;;
  7)
    gov="userspace"
    ;;
  8)
    gov="powersave"
    ;;
  9)
    gov="performance"
    ;;
esac
##end Get governor from aroma tmp

#clean cmdline from foreigns. failsafe
#needed since some cmdlines are full of rubbish :)
sed -i 's/no_console_suspend=1[^$]*$/no_console_suspend=1/g' /tmp/boot.img-cmdline

#Add maxkhz to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="maxkhz="
maxkhz="maxkhz="$maxkhz
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/maxkhz=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $maxkhz>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $maxkhz>/tmp/boot.img-cmdline
	;;
esac
#end maxkhz

#Add minkhz to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="minkhz="
minkhz="minkhz="$minkhz
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/minkhz=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $minkhz>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $minkhz>/tmp/boot.img-cmdline
	;;
esac
#end minkhz

#Add gov to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="gov="
gov="gov="$gov
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/gov=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $gov>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $gov>/tmp/boot.img-cmdline
	;;
esac
#end gov

#Add maxscroff to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="maxscroff="
maxscroff="maxscroff="$maxscroff
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/maxscroff=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $maxscroff>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $maxscroff>/tmp/boot.img-cmdline
	;;
esac
#end maxscroff

#Add 3dgpu to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="3dgpu="
gpu3d="3dgpu="$gpu3d
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/3dgpu=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $gpu3d>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $gpu3d>/tmp/boot.img-cmdline
	;;
esac
#end 3dgpu

#Add 2dgpu to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="2dgpu="
gpu2d="2dgpu="$gpu2d
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/2dgpu=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $gpu2d>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $gpu2d>/tmp/boot.img-cmdline
	;;
esac
#end 2dgpu

