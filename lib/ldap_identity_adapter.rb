require 'ldap'

module Hector
  class LdapIdentityAdapter
    def authenticate(username, password)
      yield ldap_login(username, password)
    end

    def remember(username, password)
      false
    end

    def forget(username)
      false
    end

    def normalize(username)
      username.strip.downcase
    end

    private
      def ldap_login(username, password)
        ldap_server = ENV['LDAP_SERVER']
        ldap_domain = ENV['LDAP_DOMAIN']

        dn="uid=#{username},ou=Users,#{ldap_domain}"

        conn = LDAP::Conn.new(ldap_server, LDAP::LDAP_PORT)
        conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3)

        conn.bind(dn, password)
        return true
      rescue LDAP::ResultError => e
        puts "Ldap authentication error. #{e.to_s}. account => #{username}"
        return false
      ensure
        conn.unbind
      end
  end
end
