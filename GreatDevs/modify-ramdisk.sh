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
cd ..

# generate final boot.img
./mkbootimg --kernel zImage --ramdisk ramdisk.gz --dt dt.img --cmdline "androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 msm_rtb.enable=0 lpj=192598 dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y" --base 0x00000000 --pagesize 2048 --ramdisk_offset 0x02000000 --tags_offset 0x01E00000 --output GDboot.img

exit 0
