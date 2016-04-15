#!/usr/bin/env bash

# Turn off iptables.
sudo service iptables stop
sudo service ip6tables stop
sudo chkconfig iptables off
sudo chkconfig ip6tables off

# Install utilities.
sudo yum -y install vim nano git screen tree

# Install Node.js v4.2.4.
wget https://nodejs.org/dist/v4.2.4/node-v4.2.4-linux-x64.tar.gz --no-check-certificate
sudo tar --strip-components 1 -xzvf node-v4.2.4-linux-x64.tar.gz -C /usr/local
rm $HOME/node-v4.2.4-linux-x64.tar.gz
sudo ln -s /usr/local/bin/npm /usr/bin/npm
sudo ln -s /usr/local/bin/node /usr/bin/node

# Install Nginx.
sudo cp /vagrant/config/nginx/nginx.repo /etc/yum.repos.d/nginx.repo
sudo yum -y install nginx
sudo cp /vagrant/config/nginx/nginx.conf /etc/nginx/nginx.conf
sudo chkconfig --levels 235 nginx on
sudo service nginx start

# Install MongoDB.
sudo cp /vagrant/config/mongodb/mongodb-org-3.2.repo /etc/yum.repos.d/mongodb-org-3.2.repo
sudo yum install -y mongodb-org
sudo cp /vagrant/config/mongodb/mongod.conf /etc/mongod.conf
sudo service mongod start
sudo chkconfig mongod on

# Install ntp.
sudo yum install -y ntp
sudo cp /vagrant/config/ntp.conf /etc/ntp.conf
sudo service ntpd start
sudo chkconfig ntpd on

# Add EPEL repo.
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Install beanstalkd.
sudo yum -y install beanstalkd
sudo chkconfig beanstalkd on
sudo cp /vagrant/config/beanstalkd.conf /etc/sysconfig/beanstalkd
sudo service beanstalkd start

# Install redis.
sudo yum -y install redis
sudo chkconfig --add redis
sudo chkconfig --level 345 redis on
sudo cp /vagrant/config/redis.conf /etc/redis.conf
sudo service redis start

# Install supervisord.
sudo yum -y install python-pip
sudo yum -y install supervisor
sudo yum -y remove supervisor
sudo pip install supervisor --pre
sudo cp /vagrant/config/supervisord/supervisord.init /etc/init.d/supervisord
sudo chmod 755 /etc/init.d/supervisord
sudo cp /vagrant/config/supervisord/supervisord.conf /etc/supervisord.conf
sudo mkdir -p /etc/supervisord/conf.d
sudo mkdir -p /var/log/supervisor
sudo service supervisord start
sudo chkconfig --add supervisord
sudo pip install --upgrade pip

# Install bower.
sudo npm install -g bower
sudo ln -s /usr/local/bin/bower /usr/bin/bower

# Install nodemon.
sudo npm install -g nodemon
sudo ln -s /usr/local/bin/nodemon /usr/bin/nodemon

# Custom vim setup.
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle $HOME/.vim/colors
sudo mkdir -p /root/.vim/autoload /root/.vim/colors
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
sudo curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cp /vagrant/config/vim/vimrc $HOME/.vimrc
sudo cp /vagrant/config/vim/vimrc /root/.vimrc
cp /vagrant/config/vim/TomorrowNightEighties.vim $HOME/.vim/colors/
sudo cp /vagrant/config/vim/TomorrowNightEighties.vim /root/.vim/colors/

# Install vim plugins.
cd $HOME/.vim/bundle/
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
cd ~
sudo cp -R /home/vagrant/.vim/bundle /root/.vim/bundle

# Custom bashrc.
cp /vagrant/config/bash/vagrant.bashrc $HOME/.bashrc
sudo cp /vagrant/config/bash/root.bashrc /root/.bashrc

# Add custom bash profile.
cp /vagrant/config/bash/vagrant.bash_profile $HOME/.bash_profile

# Custom aliases for git.
git config --global alias.co checkout


# TODO : Before packaging up the box, SSH into the VM and run these commands:
#sudo yum clean all
#sudo dd if=/dev/zero of=/bigemptyfile bs=1M
#sudo rm -rf /bigemptyfile
#sudo su
#history -c && exit
#cat /dev/null > ~/.bash_history && history -c && exit
