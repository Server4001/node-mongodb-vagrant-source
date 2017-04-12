#!/usr/bin/env bash

# Turn off iptables.
service iptables stop
service ip6tables stop
chkconfig iptables off
chkconfig ip6tables off

# Install utilities.
yum -y install vim nano git screen tree

# Install Node.js v4.2.4.
curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
yum -y install nodejs

# Install Nginx.
cp /vagrant/config/nginx/nginx.repo /etc/yum.repos.d/nginx.repo
yum -y install nginx
cp /vagrant/config/nginx/nginx.conf /etc/nginx/nginx.conf
service nginx start
chkconfig nginx on

# Install MongoDB.
cp /vagrant/config/mongodb/mongodb-org-3.2.repo /etc/yum.repos.d/mongodb-org-3.2.repo
yum install -y mongodb-org
cp /vagrant/config/mongodb/mongod.conf /etc/mongod.conf
cp /vagrant/config/mongodb/99-mongodb-nproc.conf /etc/security/limits.d/99-mongodb-nproc.conf
service mongod start
chkconfig mongod on

# Install ntp.
yum install -y ntp
service ntpd start
chkconfig ntpd on

# Add EPEL repo.
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Install bash auto-completions.
yum install -y bash-completion

# Install beanstalkd.
yum -y install beanstalkd
cp /vagrant/config/beanstalkd.conf /etc/sysconfig/beanstalkd
service beanstalkd start
chkconfig beanstalkd on

# Install redis.
yum -y install redis
cp /vagrant/config/redis.conf /etc/redis.conf
service redis start
chkconfig redis on

# Install supervisord.
yum -y install python-pip supervisor
yum -y remove supervisor
pip install supervisor --pre
cp /vagrant/config/supervisord/supervisord.init /etc/init.d/supervisord
chmod 755 /etc/init.d/supervisord
cp /vagrant/config/supervisord/supervisord.conf /etc/supervisord.conf
mkdir -p /etc/supervisord/conf.d
mkdir -p /var/log/supervisor
service supervisord start
chkconfig supervisord on

# Upgrade PIP
pip install --upgrade pip

# Install bower and nodemon.
npm install -g bower nodemon

# Custom vim setup.
mkdir -p /home/vagrant/.vim/autoload /home/vagrant/.vim/bundle /home/vagrant/.vim/colors
mkdir -p /root/.vim/autoload /root/.vim/colors
curl -LSso /home/vagrant/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cp /vagrant/config/vim/vimrc /home/vagrant/.vimrc
cp /vagrant/config/vim/vimrc /root/.vimrc
cp /vagrant/config/vim/TomorrowNightEighties.vim /home/vagrant/.vim/colors/
cp /vagrant/config/vim/TomorrowNightEighties.vim /root/.vim/colors/

# Install vim plugins.
cd /home/vagrant/.vim/bundle/
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/spf13/PIV.git
git clone https://github.com/ctrlpvim/ctrlp.vim.git
git clone https://github.com/msanders/snipmate.vim.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/Raimondi/delimitMate.git
git clone https://github.com/Shougo/neocomplcache.vim.git
git clone https://github.com/Shougo/neosnippet.vim.git
git clone https://github.com/Shougo/neosnippet-snippets.git
git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/spf13/vim-autoclose.git
git clone https://github.com/terryma/vim-multiple-cursors.git
git clone https://github.com/tpope/vim-vinegar.git
cd /root
cp -R /home/vagrant/.vim/bundle /root/.vim/bundle
chown -R vagrant:vagrant /home/vagrant/.vimrc /home/vagrant/.vim

# Custom bashrc.
cp /vagrant/config/bash/vagrant.bashrc /home/vagrant/.bashrc
chown vagrant:vagrant /home/vagrant/.bashrc
cp /vagrant/config/bash/root.bashrc /root/.bashrc

# Add custom bash profile.
cp /vagrant/config/bash/vagrant.bash_profile /home/vagrant/.bash_profile
chown vagrant:vagrant /home/vagrant/.bash_profile

# TODO : Before packaging up the box, SSH into the VM and run these commands:
#sudo yum clean all
#sudo dd if=/dev/zero of=/bigemptyfile bs=1M
#sudo rm -rf /bigemptyfile
#sudo su
#history -c && exit
#cat /dev/null > ~/.bash_history && history -c && exit
