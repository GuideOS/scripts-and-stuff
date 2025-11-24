egrep -lRZ "bookworm" . | xargs -0 -l sed -i -e 's/bookworm/trixie/g'
egrep -lRZ "SpiralLinux" . | xargs -0 -l sed -i -e 's/SpiralLinux/GuideOS/g'
find . -type f -name '*spirallinux*' -exec rename 's/spirallinux/guideos/' {} +
find . -type f -name '*SpiralLinux*' -exec rename 's/SpiralLinux/GuideOS/' {} +
