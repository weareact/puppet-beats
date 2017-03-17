# Placeholder for when there are official repos
class beats::repo::yum {

  rpmkey { 'D88E42B4':
    ensure => present,
    source => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
  }

  if ($::beats::use_repo_v5) {
    yumrepo { 'elastic-beats':
      ensure      => 'present',
      baseurl     => 'https://artifacts.elastic.co/packages/5.x/yum',
      descr       => 'Elastic repository for 5.x packages',
      enabled     => '1',
      gpgcheck    => '1',
      gpgkey      => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
      require     => Rpmkey['D88E42B4'],
    }
  }
  else
  {
    yumrepo { 'elastic-beats':
      ensure   => 'present',
      baseurl  => 'https://packages.elastic.co/beats/yum/el/$basearch',
      descr    => 'Elastic Beats Repository',
      enabled  => '1',
      gpgcheck => '1',
      gpgkey   => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
      require  => Rpmkey['D88E42B4'],
    }
  }

}


