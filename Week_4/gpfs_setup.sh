cd /lib/modules/2.6.32-696.23.1.el6.x86_64
rm -f build
ln -sf /usr/src/kernels/2.6.32-696.23.1.el6.x86_64 build

rpm -ivh /usr/lpp/mmfs/4.1/gpfs*.rpm

cd /usr/lpp/mmfs/src
make Autoconfig
make World
make InstallImages
