#!/sbin/sh
echo \#!/sbin/sh > /tmp/createnewboot.sh
echo /tmp/mkbootimg --kernel /tmp/zImage --ramdisk /tmp/boot.img-ramdisk.gz --dt /tmp/dt.img --cmdline \"$(cat /tmp/boot.img-cmdline)\" --base $(cat /tmp/boot.img-base) --pagesize $(cat /tmp/boot.img-pagesize) --ramdisk_offset $(cat /tmp/boot.img-ramdisk_offset) --output /tmp/newboot.img >> /tmp/createnewboot.sh
chmod 777 /tmp/createnewboot.sh
sh /tmp/createnewboot.sh
return $?
