require_relative 'lib/ldap_identity_adapter'

Hector.server_name = ENV['IRC_SERVER'].dup # Uses dup method, because ENV returns frozen string object.
Hector.port = 6667
Hector.ssl_port = 6668
Hector::Identity.adapter = Hector::LdapIdentityAdapter.new
