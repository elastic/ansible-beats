# ansible-beats
[![Build Status](https://img.shields.io/jenkins/s/https/devops-ci.elastic.co/job/elastic+ansible-beats+main.svg)](https://devops-ci.elastic.co/job/elastic+ansible-beats+main/)
[![Ansible Galaxy](https://img.shields.io/badge/ansible--galaxy-elastic.beats-blue.svg)](https://galaxy.ansible.com/elastic/beats/)

⚠️ **This Ansible role is being deprecated and will not be updated to support Beats 8.0.0 and the following versions.**

This role provides a generic means of installing Elastic supported Beats

**Tested Beats**

* Filebeat
* MetricBeat (TopBeat in 1.x)
* Packetbeat

**Tested Versions**

* 7.x
* 6.x

**Tested Platforms**

* Ubuntu 16.04
* Ubuntu 18.04
* Ubuntu 20.04
* Debian 8
* Debian 9
* Debian 10
* CentOS 7
* Amazon Linux 2

## Usage

Create your Ansible playbook with your own tasks, and include the role beats. You will have to have this repository accessible within the context of playbook.

```sh
ansible-galaxy install elastic.beats,v7.17.0
```

Then create your playbook yaml adding the role beats.
The application of the beats role results in the installation of a node on a host.

The simplest configuration therefore consists of:

```yaml
  hosts: localhost
  roles:
    - role: elastic.beats
  vars:
    beats_version: 7.17.0
    beat: filebeat
    beat_conf:
      filebeat:
        inputs:
          - type: log
            enabled: true
            paths:
              - /var/log/*.log
```

The above installs Filebeat 7.17.0 on the hosts 'localhost'.

**Notes**:
- Beats default version is described in [`beats_version`](https://github.com/elastic/ansible-beats/blob/main/defaults/main.yml#L4). You can override this variable in your playbook to install another version.
While we are testing this role only with one 7.x and one 6.x version (respectively [7.17.0](https://github.com/elastic/ansible-beats/blob/main/defaults/main.yml#L4) and [6.8.23](https://github.com/elastic/ansible-beats/blob/main/test/integration/standard-6x.yml#L7) at the time of writing), this role should work with others version also in most cases.
- Beat product is described in `beat` variable. While currently tested Beats are Filebeat, Metricbeat & Packetbeat, this role should work also with other member of [The Beats Family](https://www.elastic.co/products/beats) in most cases.

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

### Basic Beats configuration

All Beats configuration parameters are supported.  This is achieved using a configuration map parameter `beat_conf` which is serialized into the `${beat}.yml` file.
The use of a map ensures the Ansible playbook does not need to be updated to reflect new/deprecated/plugin configuration parameters.

In addition to the `beat_conf` map, several other parameters are supported for additional functions e.g. script installation.  These can be found in the role's `defaults/main.yml` file.

The following illustrates applying configuration parameters to Packetbeat instance.

```yaml
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
```

### Additional Configuration

Supported variables are as follows:

- **beat** (*MANDATORY*): Beat product. Supported values are: "filebeat", "metricbeat" & "packetbeat" (others beats from [The Beats Family](https://www.elastic.co/products/beats) should work in most cases but aren't currently tested).
- **beat_conf** (*MANDATORY*): Beat Configuration. Should be defined as a map.
- **beats_version** (*Defaults to `7.17.0`*): Beats version.
- **version_lock** (*Defaults to `false`*): Locks the installed version if set to true, thus preventing other processes from updating. This will not impact the roles ability to update the beat on subsequent runs (it unlocks and re-locks if required).
- **use_repository** (*Defaults to `true`*): Use elastic repo for yum or apt if true. If false, a custom custom_package_url must be provided.
- **beats_add_repository** (*Defaults to `{use_repository}`*): Install elastic repo for yum or apt if true. If false, the present repositories will be used. Useful if you already have beats packages in your repo.
- **start_service** (*Defaults to `true`*): service will be started if true, false otherwise.
- **restart_on_change** (*Defaults to `true`*): Changes to configuration or installed versions, will result in a restart if true.
- **daemon_args** (*Applicable to version 1.x of beats*): Allows run time params to be passed to beats.
- **logging_conf** (*Defaults to `{"files":{"rotateeverybytes":10485760}}`*): Logging configuration. Should be defined as a map. Map is serialized into logging section of beat config.
- **shipper_conf** (*Applicable to version 1.x of beats*): Shipper configuration. Should be defined as a map . Map is serialized into shipper section of beat config.
- **output_conf** (*Defaults to `{"elasticsearch":{"hosts":["localhost:9200"]}}`*): Output configuration. Map is serialized into output section of beat config.
- **beats_pid_dir** (*Defaults to `/var/run`*): Location of beats pid file.
- **beats_conf_dir** (*Defaults to `/etc/{beat}`*): Location of conf directory for beats configuration file.
- **default_ilm_policy** (*Defaults undefined*): local path to default policy if any custom one is defined

### Focus on ILM

By default, *beat* will create a default policy defined as part of the beat being deployed.
You can override default ILM setup by defining ILM conf as part of *beat_conf*.
For example:

```
- role: ansible-beats
  beat: metricbeat
  beat_conf:
    setup:
      ilm:
        policy_file: /etc/filebeat/policies/my-default-metricbeat.json
        overwrite: true
      metricbeat.modules:
        ...
  default_ilm_policy: conf/my-default-metricbeat.json
  become: yes
```

This will copy *conf/my-default-filebeat.json* to */etc/filebeat/policies/my-default-filebeat.json*.
This policy will be used as default one for this beat.

## License

Apache 2.0

## Limitations

Multiple instances of the same beat cannot be installed on the same target server.

## Questions on Usage

We welcome questions on how to use the role.  However, in order to keep the GitHub issues list focused on "issues" we ask the community to raise questions at https://discuss.elastic.co/c/beats.  This is monitored by the maintainers.

Community Contributions always appreciated and welcome!  Please ensure all contributions include tests as appropriate.
