# = Class: python::dev
#
# This class installs python development packages
#
# == Parameters
#
# [* version *]
#   The major/minor python version after which base packages are named.
#   For example, '26' to install the python26 family of packages.
#   Defaults to 'latest', which actually installs 'python' (and not
#   necessarily the latest packages)
#
# [* pkgversion *]
#   The specific package version/release you want installed.
#   If not specified, then no particular version is enforced.
#
class python::dev($ensure=present, $version=latest, $pkgversion='') {

  $python = $version ? {
    'latest' => 'python',
    default => "python${version}",
  }

  # python development packages depends on the correct python package:
  $package_suffix = $::operatingsystem ? {
    /(?i:centos|fedora|redhat)/ => 'devel',
    default                     => 'dev',
  }

  if ($ensure == present and $pkgversion) {
    $my_ensure = $pkgversion
  } else {
    $my_ensure = $ensure
  }

  package { "${python}-${package_suffix}":
    ensure => $my_ensure,
  }
}
