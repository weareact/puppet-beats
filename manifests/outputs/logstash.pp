# Define beats::outputs::logstash
# Sets up LS outputs. If there's more than one...
define beats::outputs::logstash (
  $hosts                   = ['localhost:5044'],
  $index                   = $title,
  $worker                  = 2,
  $loadbalance             = false,
  $use_tls                 = false,
  $certificate_authorities = ['/etc/pki/tls/certs/logstash-forwarder.crt'],
  $ssl_certificate         = '/etc/pki/tls/certs/logstash-forwarder.crt',
  $ssl_key                 = '/etc/pki/tls/private/logstash-forwarder.key',
) {
  if ($beats::ensure != 'absent'){
    concat::fragment {"${title}-output-logstash":
      target  => "/etc/${title}/${title}.yml",
      content => template('beats/outputs/logstash.erb'),
      order   => 22,
      notify  => Service[$title],
    }
  }
}
