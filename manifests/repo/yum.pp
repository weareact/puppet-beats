# Placeholder for when there are official repos
class beats::repo::yum {

  rpmkey { 'D88E42B4':
    ensure => present,
    source => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
  }

  case $::beats::version {
    /^5/: {
      yumrepo { 'elastic-beats':
        ensure   => 'present',
        baseurl  => 'https://artifacts.elastic.co/packages/5.x/yum',
        descr    => 'Elastic repository for 5.x packages',
        enabled  => '1',
        gpgcheck => '1',
        gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        require  => Rpmkey['D88E42B4'],
      }
    }
    default: {
      yumrepo { 'elastic-beats':
        ensure   => 'present',
        baseurl  => 'https://artifacts.elastic.co/packages/6.x/yum',
        descr    => 'Elastic repository for 6.x packages',
        enabled  => '1',
        gpgcheck => '1',
        gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
        require  => Rpmkey['D88E42B4'],
      }
    }
  }
}

