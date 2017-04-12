# node-mongodb-vagrant-source

## Source environment for my Node.js & MongoDB vagrant box on CentOS

**NOTE:** This is the environment used to build the Vagrant box. If you are looking for an Node.js environment, just use the box: [server4001/node-mongodb-centos](https://atlas.hashicorp.com/server4001/boxes/node-mongodb-centos).


### Versions

* CentOS v6.7
* Node.js v7.9.0
* NPM v4.2.0
* Nodemon v1.11.0
* Bower v1.8.0
* Nginx v1.10.3
* MongoDB v3.2.12
* Supervisord v3.3.1
* PIP v9.0.1
* Beanstalkd v1.10
* Redis v2.4.10

### Instructions

* `vagrant up`
* Make any changes you need to the box. Be sure to reflect these changes in the `provision.sh` script.
* Before packaging up the box, ssh in, and run the commands that are in the comments at the end of `provision.sh`.
* Package up the box with `vagrant package --output node-mongodb-1.0.0.box`. Replace `1.0.0` with the version number.
* Destroy the vm with `vagrant destroy --force`.
* Add the new box to vagrant's local list with: `vagrant box add node-mongodb-100 node-mongodb-1.0.0.box`. Again, replace `100` and `1.0.0` with the version number.
* Delete the `.vagrant` folder with `rm -rf .vagrant`.
* Test out the box by going to a different folder, running `vagrant init node-mongodb-100`, and changing the `Vagrantfile` to fit your needs. Next, run `vagrant up`, and ensure everything is working.
* Create a new version on Atlas.
* Add a new provider to the version. The type should be `virtualbox`. Upload the `.box` file output by the `vagrant package` command above.
* Commit your changes to git.
* Create a new git tag: `git tag 1.0.0 && git push origin 1.0.0`.
