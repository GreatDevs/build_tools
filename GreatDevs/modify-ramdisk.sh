#!/sbin/sh

# unpack combinedroot
mkdir /tmp/ramdisk
cd /tmp/ramdisk
gunzip -c ../boot.img-ramdisk.gz | cpio -i

# change logo
cp ../logo.rle .

# replace current recovery with twrp recovery
cp ../ramdisk-recovery.cpio sbin

# unpack ramdisk
mkdir sbin/ramdisk
cd sbin/ramdisk
cpio -i  < ../ramdisk.cpio
rm ../ramdisk.cpio

# edit init.qcom.rc
sed -i '/start mpdecision/d' init.qcom.rc
sed -i '/stop mpdecision/d' init.qcom.rc

# build new cpio ramdisk 
find . | cpio -o -H newc > ../ramdisk.cpio
cd ../..
rm -rf sbin/ramdisk
find . | cpio -o -H newc | gzip > ../ramdisk.gz

exit 0
