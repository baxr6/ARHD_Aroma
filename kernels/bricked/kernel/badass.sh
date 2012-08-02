#!/sbin/sh
#Badass configuration control

#look if we have an old script (from v1.0) in there and delete it.
if [ -e /system/etc/init.d/89sense4 ] ; then
	busybox rm /system/etc/init.d/89sense4
fi
#look if we already have a script in there and delete it.
if [ -e /system/etc/init.d/89badass ] ; then
	busybox rm /system/etc/init.d/89badass
fi

#create the script
busybox touch /system/etc/init.d/89badass

#set permissions
busybox chmod 755 /system/etc/init.d/89badass

#set script header
echo "#!/system/bin/sh" > /system/etc/init.d/89badass;
echo "" >> /system/etc/init.d/89badass;

#readout set values from aroma
val=$(cat /tmp/aroma-data/badass.prop | cut -d"=" -f2)
case $val in
	1)
	#set performance oriented configuration with init.d script
	echo "#performance oriented badass configuration" >> /system/etc/init.d/89badass;
	echo "echo 1080000 > /sys/devices/system/cpu/cpufreq/badass/two_phase_freq" >> /system/etc/init.d/89badass;
	echo "echo 1296000 > /sys/devices/system/cpu/cpufreq/badass/three_phase_freq" >> /system/etc/init.d/89badass;
	echo "echo 120 > /sys/devices/system/cpu/cpufreq/badass/busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 80 > /sys/devices/system/cpu/cpufreq/badass/busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 8 > /sys/devices/system/cpu/cpufreq/badass/semi_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 4 > /sys/devices/system/cpu/cpufreq/badass/semi_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 150 > /sys/devices/system/cpu/cpufreq/badass/gpu_semi_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 50 > /sys/devices/system/cpu/cpufreq/badass/gpu_semi_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 300 > /sys/devices/system/cpu/cpufreq/badass/gpu_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 450 > /sys/devices/system/cpu/cpufreq/badass/gpu_busy_threshold" >> /system/etc/init.d/89badass;
	;;

	2)
	#set balanced configuration with init.d script
	echo "#balanced badass configuration" >> /system/etc/init.d/89badass;
	echo "echo 918000 > /sys/devices/system/cpu/cpufreq/badass/two_phase_freq" >> /system/etc/init.d/89badass;
	echo "echo 1188000 > /sys/devices/system/cpu/cpufreq/badass/three_phase_freq" >> /system/etc/init.d/89badass;
	echo "echo 130 > /sys/devices/system/cpu/cpufreq/badass/busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 100 > /sys/devices/system/cpu/cpufreq/badass/busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 14 > /sys/devices/system/cpu/cpufreq/badass/semi_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 6 > /sys/devices/system/cpu/cpufreq/badass/semi_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 260 > /sys/devices/system/cpu/cpufreq/badass/gpu_semi_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 180 > /sys/devices/system/cpu/cpufreq/badass/gpu_semi_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 700 > /sys/devices/system/cpu/cpufreq/badass/gpu_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 500 > /sys/devices/system/cpu/cpufreq/badass/gpu_busy_clr_threshold" >> /system/etc/init.d/89badass;
	;;

	3)
	#set battery saving configuration with init.d script
	echo "#battery saving badass configuration" >> /system/etc/init.d/89badass;
	echo "echo 918000 > /sys/devices/system/cpu/cpufreq/badass/two_phase_freq" >> /system/etc/init.d/89badass;
	echo "echo 1188000 > /sys/devices/system/cpu/cpufreq/badass/three_phase_freq" >> /system/etc/init.d/89badass;
	echo "echo 140 > /sys/devices/system/cpu/cpufreq/badass/busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 110 > /sys/devices/system/cpu/cpufreq/badass/busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 80 > /sys/devices/system/cpu/cpufreq/badass/semi_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 20 > /sys/devices/system/cpu/cpufreq/badass/semi_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 300 > /sys/devices/system/cpu/cpufreq/badass/gpu_semi_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 250 > /sys/devices/system/cpu/cpufreq/badass/gpu_semi_busy_clr_threshold" >> /system/etc/init.d/89badass;
	echo "echo 750 > /sys/devices/system/cpu/cpufreq/badass/gpu_busy_threshold" >> /system/etc/init.d/89badass;
	echo "echo 600 > /sys/devices/system/cpu/cpufreq/badass/gpu_busy_clr_threshold" >> /system/etc/init.d/89badass;
	;;
esac

#set script footer
echo "" >> /system/etc/init.d/89badass;

return $?
