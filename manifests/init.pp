# == Class: resolvconf
#
# Apply configuration to `resolv.conf` using `resolvconf(8)`
#
# === Parameters
#
# Accepts the basic parameters from `resolvconf.conf` man page.
#
# Common ones are:
#
# [*search_domains*]
#   Specify one or more search domains as a space delimited string
#
# [*name_servers*]
#   Specify one or more nameservers as a space delimited string
#
# === Examples
#
#  class { resolvconf:
#    nameservers => "8.8.8.8 8.8.4.4",
#  }
#
# === Authors
#
# Caius Durling <dev@caius.name>
#
# === Copyright
#
# Copyright 2015 Caius Durling, unless otherwise noted.
#
class resolvconf(
  $interface_order = undef,
  $dynamic_order = undef,
  $search_domains = undef,
  $search_domains_append = undef,
  $name_servers = undef,
  $name_servers_append = undef,
  $private_interfaces = undef,
  $state_dir = undef,
) {

  $resolvconf = "/sbin/resolvconf"
  $resolvconf_conf = "/etc/resolvconf.conf"

  file { $resolvconf_conf:
    ensure => present,
    owner => "root",
    group => "wheel",
    mode => "0644",
    content => template("resolvconf/conf.erb"),
  }

  exec { "$resolvconf -u":
    subscribe => File[$resolvconf_conf],
    refreshonly => true,
  }
}
