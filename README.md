# beats
Elastic beats puppet module
=======
License
-------
GPL v2 

## WARNING ##

This module is under development. Most things work most of the time, mostly. 
Some protocols and settings are still missing. 
*Minimally tested on Debian-flavour systems. Filebeats tested on RedHat/CentOS 6/7*

## Example Use ##
```
class { 'beats':
    outputs_deep_merge => false,
    outputs_logstash => {
      "filebeat" => { "hosts" => [ "logstash.example.com:5044" ],
                                   "use_tls" => true,
                    },
    },
    version_v5 => true,
    agentname   => 'server-name',
}

class { 'beats::filebeat':
    prospectors => { 
              'syslog' => { 
                  'document_type' => "syslog",
                  'paths'  => [ "/var/log/messages",
                                "/var/log/secure",
                                "/var/log/yum.log",
                                "/var/log/cron",
                                "/var/log/maillog",
                                "/var/log/ntp",
                              ],
              },
              'nginx-error'  => {
                  'document_type' => "nginx-error",
                  'paths'  => [
                                  "/var/log/nginx/*.error.log",
                                 "/var/log/nginx/error.log",
                              ],
              },
              'nginx-access'  => {
                  'document_type' => "nginx-access",
                  'paths'  => [
                                 "/var/log/nginx/*.access.log",
                                 "/var/log/nginx/access.log",
                              ],
              },
    },
}
```

## Example Use with hiera ##

```
include ::beats
include ::beats::topbeat
include ::beats::filebeat
```


### Hiera ###
```
"beats::filebeat::prospectors": {
  "syslog": {
    "fields": {
      "type": "syslog"
    },
    "paths": [
      "/var/log/syslog"
    ]
  }
},
"beats::outputs_deep_merge": true,
"beats::outputs_logstash": {
  "filebeat": {
    "hosts": [
      "localhost:5044"
    ]
  },
  "topbeat": {
    "hosts": [
      "localhost:5044"
    ]
  }
}
```

The ES output *should* work, but I've not tested it yet. 
Some digging around inside the module will be necessary to make bits work.
