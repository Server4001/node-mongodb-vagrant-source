# node-mongodb-vagrant-source

### Source environment for my Node.js & MongoDB vagrant box

## Versions

* Node.js v4.2.4
* NPM v2.14.12
* Nodemon v1.9.1
* Bower v1.7.9
* Nginx v1.8.1
* MongoDB v3.2.5
* Supervisord v3.2.3
* PIP v8.1.1
* Beanstalkd v1.10
* Redis v2.4.10

## Instructions

* `vagrant up`
* Make any changes you need to the box. Be sure to reflect these changes in the `provision.sh` script.
* Before packaging up the box, ssh in, and run the commands that are in the comments at the end of `provision.sh`.
* Package up the box with `vagrant package --output node-mongodb-0.1.0.box`. Replace `0.1.0` with the version number.
* Destroy the vm with `vagrant destroy --force`.
* Add the new box to vagrant's local list with: `vagrant box add node-mongodb-010 node-mongodb-0.1.0.box`. Again, replace `010` and `0.1.0` with the version number.
* Delete the `.vagrant` folder with `rm -rf .vagrant`.
* Test out the box by going to a different folder, running `vagrant init node-mongodb-010`, and changing the `Vagrantfile` to fit your needs. Next, run `vagrant up`, and ensure everything is working.
* Create a new version on Atlas.
* Add a new provider to the version. The type should be `virtualbox`. Upload the `.box` file output by the `vagrant package` command above.
