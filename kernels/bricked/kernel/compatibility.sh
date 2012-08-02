#!/sbin/sh
#

#remove the binaries as they are no longer needed. (kernel handled)
if [ -e /system/bin/mpdecision ] ; then
	busybox mv /system/bin/mpdecision /system/bin/mpdecision_backup
fi
if [ -e /system/bin/thermald ] ; then
	busybox mv /system/bin/thermald /system/bin/thermald_backup
fi
#and part 3, delete fauxs init.d script
if [ -e /system/etc/init.d/50faux ] ; then
	busybox rm /system/etc/init.d/50faux
fi

#Check for renamed init.qcom.post_boot.sh alá ARHD ;)...
#delete it, push my replacement, rename that and set rights.
if [ -e /system/etc/init.post_boot.sh ] ; then
	#Insert run-parts into init.qcom.post_boot.sh if it's in there (which it shouldn't)
	#ARHD compatibility fix
	found=$(find /system/etc/init.post_boot.sh -type f | xargs grep -oh "run-parts");
	if [ "$found" = 'run-parts' ]; then
		echo "" >> /system/etc/init.qcom.post_boot.sh;
		echo "# Execute /system/etc/init.d scripts on boot" >> /system/etc/init.qcom.post_boot.sh;
		echo "sysrw" >> /system/etc/init.qcom.post_boot.sh;
		echo "chgrp -R 2000 /system/etc/init.d" >> /system/etc/init.qcom.post_boot.sh;
		echo "chmod -R 755 /system/etc/init.d" >> /system/etc/init.qcom.post_boot.sh;
		echo "sysro" >> /system/etc/init.qcom.post_boot.sh;
		echo "/system/xbin/busybox run-parts /system/etc/init.d" >> /system/etc/init.qcom.post_boot.sh;
		echo "" >> /system/etc/init.qcom.post_boot.sh;
	fi
	busybox rm /system/etc/init.post_boot.sh
	busybox mv /system/etc/init.qcom.post_boot.sh /system/etc/init.post_boot.sh
	busybox chmod 755 /system/etc/init.post_boot.sh
fi

return $?
