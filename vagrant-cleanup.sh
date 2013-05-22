# Display Warning
DELAY=$1
cat - <<EOF
WARNING, YOU ARE ABOUT TO DO SOMETHING POTENTIALLY DESTRUCTIVE!!!

This script cleans the guest disks to minimize the size of our Vagrant Box.

Ideally, you should run this in singleuser mode

Press CTRL-C within ${DELAY} seconds to cancel this process

EOF
for i in {1..$DELAY}; do sleep 1; echo -n '.'; done;
echo

echo -n 'Cleaning up yum'
yum clean all

echo -n 'Cleaning up bash history...'
unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
[ -f /home/vagrant/.bash_history ] && rm /home/vagrant/.bash_history
echo 'done!'

echo -n 'Cleaning up log files...'
find /var/log -type f | while read f; do echo -ne '' > $f; done;
echo 'done!'

echo 'Zero-ing out /'
count=`df --sync -kP / | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/zero bs=1024 count=$count;
rm /zero;
echo 'done!'

echo 'Zero-ing out /var'
count=`df --sync -kP /var | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/var/zero bs=1024 count=$count;
rm /var/zero;
echo 'done!'

echo 'Zero-ing out /boot'
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/zero bs=1024 count=$count;
rm /boot/zero;
echo 'done!'

echo 'Zero-ing out swap'
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;

rm -f /etc/udev/rules.d/70-persistent-net.rules
#poweroff
