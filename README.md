Beats Role
=========

This role provides a generic means of installing Elastic supported beats using Ansible.  Currently this includes:

- Filebeat
- MetricBeat (TopBeat in 1.x)
- Packetbeat

Requirements
------------

This role requires:

- Ansible version > 2.0
- Beats version >= 1.x
- Target machines require access to an external repo, or means

The following OS are currently actively tested using kitchen:

- Centos 6 & 7
- Debian 8 & 9
- Ubuntu 14.04, 16.04 & 18.04

The above list is subject to change.

Role Variables
--------------

Supported variables are as follows:

- **beat** (*MANDATORY*): Beat product. Supported values are: "filebeat", "metricbeat" & "packetbeat".
- **beat_conf** (*MANDATORY*): Beat Configuration. Should be defined as a map (see [Example Playbook](#example-playbook))
- **beats_version** (*Defaults to `7.0.0`*): Beats version.
- **version_lock** (*Defaults to `false`*): Locks the installed version if set to true, thus preventing other processes from updating. This will not impact the roles ability to update the beat on subsequent runs (it unlocks and re-locks if required).
- **use_repository** (*Defaults to `true`*): Use elastic repo for yum or apt if true. If false, a custom custom_package_url must be provided.
- **start_service** (*Defaults to `true`*): service will be started if true, false otherwise.
- **restart_on_change** (*Defaults to `true`*): Changes to configuration or installed versions, will result in a restart if true.
- **daemon_args** (*Applicable to version 1.x of beats*): Allows run time params to be passed to beats.
- **logging_conf** (*Defaults to `{"files":{"rotateeverybytes":10485760}}`*): Logging configuration. Should be defined as a map (see [Example Playbook](#example-playbook)). Map is serialized into logging section of beat config.
- **shipper_conf** (*Applicable to version 1.x of beats*): Shipper configuration. Should be defined as a map (see [Example Playbook](#example-playbook)). Map is serialized into shipper section of beat config.
- **output_conf** (*Defaults to `{"elasticsearch":{"hosts":["localhost:9200"]}}`): Output configuration. Should be defined as a map (see [Example Playbook](#example-playbook)). Map is serialized into output section of beat config.
- **beats_pid_dir** (*Defaults to `/var/run`*): Location of beats pid file.
- **beats_conf_dir** (*Defaults to `/etc/{beat}`*): Location of conf directory for beats configuration file.

Dependencies
------------

- Ansible version > 2.0
- Beats version >= 6.x

Example Playbook
----------------

Example playbook is provided below. This installs Packetbeat and illustrates the need for configuration sections to be specified as maps.

    - name: Example playbook for installing packetbeat
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

## Testing

This playbook uses [Kitchen](https://kitchen.ci/) for CI and local testing.

### Requirements

* Ruby
* Bundler
* Docker
* Make

### Running the tests

To converge an Ubuntu 18.04 host
```sh
$ make converge
```

To run the tests
```sh
$ make verify
```

To list all of the different test suits
```sh
$ make list
```

The default test suite is Ubuntu 18.04. If you want to test another suite you can override this with the `PATTERN` variable
```sh
$ make converge PATTERN=standard-centos-7
```

The `PATTERN` is a kitchen pattern which can match multiple suites. To run all tests for CentOS
```sh
$ make converge PATTERN=centos-7
```

When you are finished testing you can clean up everything with
```sh
$ make destroy-all
```

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
