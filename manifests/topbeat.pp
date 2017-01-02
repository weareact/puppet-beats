# Topbeat class
class beats::topbeat (
  $ensure           = present,
  $period           = 10,
  $procs            = ['.*'],
  $stats_system     = true,
  $stats_proc       = true,
  $stats_filesystem = true,
){

  if ($ensure == 'absent'){
    $service_ensure = undef
    $service_enable = undef
  }
  else{
    $service_ensure = $beats::ensure
    $service_enable = $beats::enable
  }

  include ::beats::topbeat::config

  case $::osfamily {
    'RedHat': {
      package {'topbeat':
        ensure  => $ensure,
        require => Yumrepo['elastic-beats'],
      }
    }
    default: {
      include ::apt::update

      package {'topbeat':
        ensure  => $ensure,
        require => Class['apt::update'],
      }
    }
  }

  service { 'topbeat':
    ensure => $service_ensure,
    enable => $service_enable,
  }

  if ($ensure != 'absent'){
    Package['topbeat'] -> Class['beats::topbeat::config'] ~> Service['topbeat']
  }
  else{
    Package['topbeat'] ~> Service['topbeat']
  }
}