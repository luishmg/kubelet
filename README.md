Role Name
=========

Role create to install and configure the kubelet to run on host.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

k8s_bin_url: "http://192.168.1.73:8000/kubernetes/"
cntlr_cidr: "10.1.0.0/24"
k8s_ca_cert: "ca.pem"
k8s_ca_key: "ca-key.pem"
k8s_version: "v1.20.2"
logLevel: "3"
worker_cert_bin:
  - "http://192.168.1.73:8000/cfssl/1.4.1/cfssl"
  - "http://192.168.1.73:8000/cfssl/1.4.1/cfssljson"
k8s_cluster_cidr: "10.200.0.0/16"
k8s_cluster_dns: "10.96.0.10"
worker_directories:
  - "/var/lib/kubelet/pki"
  - "/opt/startup"
worker_dependencies:
  - "conntrack"
  - "ipset"
  - "socat"
worker_kube_bin:
  - "/kubelet"
  - "/kubectl"
worker_cert_bin:
  - "http://192.168.1.73:8000/cfssl/1.4.1/cfssl"
  - "http://192.168.1.73:8000/cfssl/1.4.1/cfssljson"
worker_templates:
  - { src: "config/sysctl.conf.j2", dst: "/etc/" }
  - { src: "systemd/kubelet.service.j2", dst: "/etc/systemd/system/" }
  - { src: "bootstrap/bootstrap-worker.sh.j2", dst: "/opt/startup/" }
  - { src: "bootstrap/generate-certs-and-configs.sh.j2", dst: "/opt/startup/" }
worker_symlinks:
  - { src: "/etc/resolv.conf", dst: "/run/systemd/resolve/resolv.conf" }
modules:
  - nf_conntrack

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    ---
    - name: Generate Kubernetes Worker Golden Image
      hosts: all
      become: yes
      become_user: root
      gather_facts: yes
      roles:
        - role: kubelet
          k8s_bin_url: "http://192.168.1.73:8000/kubernetes/"
          cntlr_cidr: "10.1.0.0/24"
          k8s_ca_cert: "ca.pem"
          k8s_ca_key: "ca-key.pem"
          k8s_version: "v1.20.2"
          logLevel: "3"
          worker_cert_bin:
            - "http://192.168.1.73:8000/cfssl/1.4.1/cfssl"
            - "http://192.168.1.73:8000/cfssl/1.4.1/cfssljson"

Customize and Test
------------------

To customize this role you should install pipenv, then follow the steps bellow:

This command will install the correct version of python and the dependencies, as a virtual environment:

`pipenv install`

This command will load the virtual environment:

`pipenv shell`

Now if you want to follow the TDD patter you should go to the molecule folder and create the test for the change that you want to implement, to run the molecule full test use the command below:

`molecule test`

Tips to speedup the tests
-------------------------

As a side note you can just use the command below to run your role:

`molecule converge`

Then you can use this command to run the choosen test suit:

`molecule verify`

License
-------

BSD

Author Information
------------------

[Luis Gomes](https://github.com/luishmg/luishmg.github.io)
