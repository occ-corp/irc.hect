irc.hect
================================================================================

This is a configuration script for [Hector](https://github.com/sstephenson/hector).
Hector is a private IRC server.


Requirements
-------------------------------------------------------------------------------

- Ubuntu Server 12.04 LTS
- Ruby 1.9.3
- LDAP Server


Setup
--------------------------------------------------------------------------------

Create a service user:

    $ sudo useradd hector

Clone this repository:

    $ cd /var/lib
    $ sudo clone https://github.com/webmagic-dev/irc.hect.git
    $ sudo chown -R hector:hector irc.hect

Install dependency libraries:

    $ cd irc.hect
    $ bundle

Edit upstart configuration file, and copy to `/etc/init`:

    $ vi conf/hector.conf # Edit your environment variables
    $ sudo cp conf/upstart/hector.conf /etc/init/

Copy the logrotate configuration file:

    $ sudo cp conf/logrotate.d/hector /etc/logrotate.d

Start the IRC daemon

    $ sudo service hector start


LICENSE
--------------------------------------------------------------------------------

Copyright &copy; 2013 OCC Corporation.
