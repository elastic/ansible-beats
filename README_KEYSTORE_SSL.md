## Enable Beats Keystore for storing sensitve strings
To enable this feature set `enable_keystore: true` default is `false`.

Currently ony stores the elasticsearch reserver user password for the `remote_monitoring_user`
and the password for `beats_writer` users needed for publishing the metrics on the monitoring cluster.

See [Grant privileges and roles needed for publishing ](https://www.elastic.co/guide/en/beats/metricbeat/7.13/privileges-to-publish-events.html)
```yml
    remote_monitoring_pass: "{{remote_monitoring_user_pass}}"
    es_output_pass: "{{beats_mon_user_pass}}"
    enable_keystore: true
```	
These passwords are accessible in the beats configuration file via `nd `"${REMOTE_MONITORING_PASS}"` and  `"${ES_OUTPUT_PASS}"`

## Upload SSL CA files for the monitored and monitoring cluster.

To use this feature set  `es_enable_ssl: true` and `es_ssl_upload: true`.

```yml
    es_enable_ssl: true
    es_ssl_upload: true
    es_output_ssl_ca: "files/certs/es-output.ca"
    es_mon_ssl_ca: "files/certs/es-mon.ca"
```
### Generate CA files for your Monitorig Cluster and Node that it being monitored

```shell
openssl s_client -showcerts \
-connect es1-mon.example.com:9200 \
</dev/null 2>/dev/null|openssl x509 \
-outform PEM >es-mon.ca
```


### Sample Playbook
```yml
- hosts: 
  - es-nodes
  roles:
    - role: ansible-beats
  vars:
    beats_version:  "{{ es_version}}"
    node_name: "{{hostvars[inventory_hostname].node_name}}"
    es_host:   "{{ ansible_eth0.ipv4.address }}"
    remote_monitoring_pass: "{{remote_monitoring_user_pass}}"
    es_output_pass: "{{beats_mon_user_pass}}"
    enable_keystore: true
    es_enable_ssl: true
    es_ssl_upload: true
    es_output_ssl_ca: "files/certs/es-output.ca"
    es_mon_ssl_ca: "files/certs/es-mon.ca"
    beat: metricbeat
    beat_conf:
      fields:
        env: mon
        node_name: "{{node_name}}"
        host: "{{es_host}}"
        cluster: "{{cluster_name}}"
      name: "{{cluster_name}}-{{node_name}}"
      tags: ["elk", "es-node","metrics"]
      metricbeat.modules:
        - module: elasticsearch
          xpack.enabled: true
          period: 10s
          hosts:
            - "https://{{es_host}}:9200"
          username: remote_monitoring_user
          password: "${REMOTE_MONITORING_PASS}"
          ssl.verification_mode: certificate
          ssl.certificate_authorities: "{{es_ssl_certificate_path}}/{{es_mon_ssl_ca |basename}}"

    output_conf:
        elasticsearch:
          hosts: "{{elasticsearch_mon_host}}"
          protocol: "https"
          username: "beats_user"
          password: "${ES_OUTPUT_PASS}"
          ssl.verification_mode: certificate
          ssl.certificate_authorities: "{{es_ssl_certificate_path}}/{{es_output_ssl_ca |basename}}"
          loadbalance: true
          worker: 2

```

### Inventory File
```shell
[es-nodes]
es1 node_name=node-1
es2 node_name=node-3 
es3 node_name=node-3
[es-nodes:vars]
es_version=7.12.1
cluster_name=my-cluster
remote_monitoring_user_pass=changeme
beats_mon_user_pass=changeme
elasticsearch_mon_host=["es1-mon.example.com:9200","es2-mon.example.com:9200","es3-mon.example.com:9200"]
```

### Bonus
Playbook for removing metricbeat
```yml
- hosts:  es-nodes
  tasks:
    - service:
        name: metricbeat.service
        state: stopped
      become: true  
    - yum:
        name: metricbeat
        state: absent
      become: true
    - ansible.builtin.systemd:
        daemon_reexec: yes
      become: true  
    - file:
        path: "{{item}}"
        state: absent
      with_items:
        - /etc/metricbeat
        - /usr/share/metricbeat
        - /var/lib/metricbeat
      become: true
```	  