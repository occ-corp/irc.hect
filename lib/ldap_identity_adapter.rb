require 'net-ldap'

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

    def ldap_login(username = nil, password = nil)
      ldap_server = ENV['LDAP_SERVER']
      ldap_domain = ENV['LDAP_DOMAIN']

      conn = Net::LDAP.new(
        :host => ldap_server,
        :auth => {
          :method   => :simple,
          :username => "uid=#{username},ou=Users,#{ldap_domain}",
        :password => password
        }
      )

      unless conn.bind
        raise Net::LDAP::LdapError.new
      end

      return true
    rescue Net::LDAP::LdapError => e
      puts "LDAP authentication error. #{e.to_s}. account => #{username}"
      return false
    end
  end
end
