Beats Role
=========

This role provides a generic means of installing Elastic supported beats using Ansible.  Currently this includes:

- Filebeat
- Topbeat
- Packetbeat

Requirements
------------

This role requires:

- Ansible version > 2.0
- Beats version >= 1.x
- Target machines require access to an external repo, or means

The following OS are currently actively tested using kitchen:

- Centos 6 & 7
- Debian 7 & 8
- Ubuntu 14.04

The above list is subject to change.

Role Variables
--------------

Supported variables are as follows:

- use_repository - use elastic repo for yum or apt if true. If false, a custom custom_package_url must be provided. Defaults to true.
- start_service - service will be started if true, false otherwise.  Defaults to true.
- restart_on_change - Changes to configuration or installed versions, will result in a restart if true.  Defaults to true.
- daemon_args - Applicable to version 1.x of beats.  Allows run time params to be passed to beats.
- logging_conf - Logging configuration.  Should be defined as a map - see Example playbook below.  Map is serialized into logging section of beat config. Defaults to "{"files":{"rotateeverybytes":10485760}}"
- shipper_conf - Applicable to version 1.x of beats.  Shipper configuration. Should be defined as a map - see Example playbook below. Map is serialized into shipper section of beat config. Defaults to "".
- output_conf - Output configuration. Should be defined as a map - see Example playbook below. Map is serialized into output section of beat config. Defaults to "{"elasticsearch":{"hosts":["localhost:9200"]}}".
- beats_pid_dir - Location of beats pid file. Defaults to "/var/run".
- beats_conf_dir: - Location of conf directory for beats configuration file. Defaults to "/etc/{{beat}}".
- version_lock: Locks the installed version if set to true, thus preventing other processes from updating.  This will not impact the roles ability to update the beat on subsequent runs (it unlocks and re-locks if required). Defaults to true.

Dependencies
------------

- Ansible version > 2.0
- Beats version >= 1.x

Example Playbook
----------------

Example playbook is provided below.  This installs Packetbeat and illustrates the need for configuration sections to be specified as maps.

    - name: Example playbook for installing packetbear
      hosts: localhost
      roles:
        - { role: beats, beat: "packetbeat",
            beat_conf: {
              "interfaces": {"device":"any"},
              "protocols": {
                "dns": {
                  "ports": [53],
                  "include_authorities":true
                },
                "http": {
                  "ports": [80, 8080, 8000, 5000, 8002]
                },
                "memcache": {
                  "ports": [11211]
                },
                "mysql": {
                  "ports": [3306]
                },
                "pgsql": {
                  "ports": [5432]
                },
                "redis": {
                  "ports": [6379]
                },
                "thrift": {
                  "ports": [9090]
                },
                "mongodb": {
                  "ports": [27017]
                }
              }
            },
            output_conf : {
              "elasticsearch": {
                "hosts": ["localhost:9200"]
              }
            }
        }
      vars:
        use_repository: "true"

License
-------

Apache 2.0

Limitations
------------

Multiple instances of the same beat cannot be installed on the same target server.

Author Information
------------------

Dale McDiarmid
For further assistance, outside of issues, please use discuss.elastic.co.

Community Contributions always appreciated and welcome!  Please ensure all contributions include tests as appropriate.
