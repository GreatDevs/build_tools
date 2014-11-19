#!/sbin/sh

# unpack combinedroot
mkdir /tmp/ramdisk
cd /tmp/ramdisk
gunzip -c ../boot.img-ramdisk.gz | cpio -i
rm ../boot.img-ramdisk.gz

# changing logo
cp ../logo.rle .

# replaceing current recovery with twrp recovery
cp ../ramdisk-recovery.cpio sbin/ramdisk-recovery.cpio

# unpack ramdisk
mkdir sbin/ramdisk
cd sbin/ramdisk
cpio -i  < ../ramdisk.cpio
rm ../boot.img-ramdisk.gz

# edit init.qcom.rc
sed -i '/start mpdecision/d' init.qcom.rc
sed -i '/stop mpdecision/d' init.qcom.rc

# build new cpio ramdisk 
find . | cpio -o -H newc > ../ramdisk.cpio
cd ..
rm -rf ramdisk

cd ..
find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz

exit 0
