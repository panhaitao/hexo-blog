# 目录

* [概述](README.md)
* [安装部署](system/install.md)
* [服务器系统](system/readme.md)
    * [设置本地化与时区](system/locale_and_timezone.md)
    * [设置日期和时间](system/date_and_time.md)
    * [管理用户与组](system/users_and_group.md)
    * [管理网络配置](system/networking.md)
    * [网络实用工具](system/nettools.md)
        * [ping](system/nettools/ping.md)
        * [traceroute](system/nettools/traceroute.md)
        * [netstat](system/nettools/netstat.md)
        * [dhclient](system/nettools/dhclient.md)
        * [ifconfig](system/nettools/ifconfig.md)
        * [route](system/nettools/route.md)
        * [ss](system/nettools/ss.md)
        * [ip](system/nettools/ip.md)
        * [host](system/nettools/host.md)
        * [nslookup](system/nettools/nslookup.md)
        * [nc](system/nettools/nc.md)
    * [软件仓库管理](system/software_managing.md)
    * [服务与守护进程](system/service-and-daemon.md)
* [服务器软件](software/software.md)
    * [下载工具](software/download-tools.md)
    * [远程连接](software/sshd.md)
    * [邮件服务](software/mail.md)
    * [域名服务](software/bind.md)
    * [DHCP服务](software/dhcpd.md)
    * [http服务](software/httpd.md)
    * [tomcat中间件](software/tomcat.md)
    * [jboss中间件](software/jboss.md)
    * [PHP服务器](software/php5.md)
    * [mysql数据库](software/mysql.md)
    * [postgresql数据库](software/postgresql.md)
    * [redis数据库](software/redis.md)
    * [mongodb数据库](software/mongodb.md)
* [服务器安全]( security/security.md)
    * [iptable的基础使用](security/iptable.md)
    * [selinux的基础使用](security/selinux.md)
    * [PAM参考配置](security/pam.md)
    * [弱口令检查工具john](security/john.md)
    * [端口扫描工具nmap](security/nmap.md)
    * [安全审计工具audit](security/audit.md)
    * [文件完整性检查afick](security/afick.md)
* [容器与虚拟化](vz/container_and_virtualzation.md)
   * kvm
     * libvirt
     * [vagrant](vz/vagrant-libvirtd.md)
   * docker
     * network
     * flannel
     * weave
     * pipework
     * tinc
     * socketplane
   * [编排调度](vz/docker_orchestration.md) 
     * fleet
     * marathon
     * swarm
     * mesos
     * kubernetes
     * compose
   * service_discovery
     * etcd
     * consul
     * zookeeper
   * SDN 
     * openvswitch
     *
* [集群与云服务]()
  * openstack
  * hadoop   
* [服务器运维](ops/ops.md)
  * 代码审查 
    * [Review Board](ops/review_board.md)
  * 配置管理
    * Ansible
  * [监控报警](monitor.md)
    * nagios
    * nagios-plugins
    * nagios-nrpe
    * nagios-ncpa
  * [icinga2]()
    * [icinga2-web2]()
    * [icinga2-dashing](ops/icing2-dashing.md)
  * 性能监控
    * collectd
    * collect-web
    * InfluxDB
    * Grafana
    * cacti   
    * RRDTools
  * 系统维护工具集
    * [htop](ops/htop.md)
    * [iostat](ops/iostat.md)
    * [iftop](ops/iftop.md)
    * [procps](ops/procps.md)
    * [nload](ops/nload.md)
    * [sar](ops/sar.md)
    * [mpstat](ops/mpstat.md)
    * [lsof](ops/lsof.md)
    * [e2fsprogs](ops/e2fsprogs.md)
    * [strace](ops/strace.md)
    * [ltrace](ops/ltrace.md)
    * [dmidecode](ops/dmidecode.md)
* [解决方案](src/solution.md)
  * 运维方案
    * [性能监控:Grafana+collectd+InfluxDB](ops/Grafana_collectd_InfluxDB.md)
  * 日志分析                 
    * [Rsyslog+Mysql+loganalyzer](src/solution/lognanlyzer.md)