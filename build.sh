reset
cd ~/Sources/omni
export USE_CCACHE=1
export USER=Official
export KBUILD_BUILD_USER=Official
export KBUILD_BUILD_HOST=GreatDevs
export KBUILD_BUILD_VERSION=2
export CCACHE_DIR=~/Sources/omni/ccache
prebuilts/misc/linux-x86/ccache/ccache -M 80G

make clean
repo forall -vc "git reset --hard"
repo sync -j16

rm device/sony/qcom-common/cm.dependencies
sed -i 's/ liblight//' hardware/qcom/display/msm8974/Android.mk

#echo "Do you wish to continue?"; read

. build/envsetup.sh
#brunch amami
lunch omni_amami-userdebug
mka bootimage
