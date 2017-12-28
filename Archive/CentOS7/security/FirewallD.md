---
title: "FirewallD"
categories: CentOS7
tags: 系统管理
---

## FirewallD

### 概述

深度服务器操作系统V16开始使用firewalld服务替代传统的iptables服务。iptables 服务在每一次变更规则重启服务时，都要清除所有旧有的规则和从 /etc/sysconfig/iptables里读取并创建新的规则，而使用 firewalld 却不会再创建任何新的规则；仅仅运行规则中的不同之处。firewalld 可以在运行时间内，改变设置而不丢失现行连接，因此也称为动态防火墙。以下是防火墙堆栈示意图：
       
### FirewallD的zone区域
 
动态防火墙后台程序 firewalld 提供了一个 动态管理的防火墙，用以支持网络 “zones” ，以分配对一个网络及其相关链接和界面一定程度的信任。它具备对 IPv4 和 IPv6 防火墙设置的支持。它支持以太网桥，并有分离运行时间和永久性配置选择。它还具备一个通向服务或者应用程序以直接增加防火墙规则的接口。
相比于传统的防火墙管理工具还支持了动态更新技术并加入了“zone区域”的概念，简单来说就是为用户预先准备了几套防火墙策略集合（策略模板），然后可以根据生产场景的不同而选择合适的策略集合，实现了防火墙策略之间的快速切换。常见的zone区域名称及应用可见下表（默认为public）：

| 区域	    | 默认规则策略                                                                                                            |
|-----------|-------------------------------------------------------------------------------------------------------------------------|
| trusted   | 允许所有的数据包                                                                                                        |  
| home	    | 拒绝流入的数据包，除非与输出流量数据包相关或是 ssh,mdns,ipp-client,samba-client与dhcpv6-client服务则允许                |
| internal  | 等同于home区域                                                                                                          |
| work	    | 拒绝流入的数据包，除非与输出流量数据包相关或是ssh,ipp-client与dhcpv6-client服务则允许                                   |
| public    | 拒绝流入的数据包，除非与输出流量数据包相关或是ssh,dhcpv6-client服务则允许                                               |
| external  | 拒绝流入的数据包，除非与输出流量数据包相关或是ssh服务则允许                                                             |
| dmz	    | 拒绝流入的数据包，除非与输出流量数据包相关或是ssh服务则允许                                                             | 					
| block	    | 拒绝流入的数据包，除非与输出流量数据包相关                                                                              |
| drop	    | 拒绝流入的数据包，除非与输出流量数据包相关                                                                              |

### FirewallD的配置
    
FirewallD 使用 XML 定义配置，配置文件位于两个目录中：

* /usr/lib/FirewallD 下保存默认配置，如默认区域和公用服务
* /etc/firewalld 下保存系统配置文件, 这些文件将覆盖默认配置。
 
/usr/lib/firewalld/services/ 目录中，还保存了另外一类配置文件，每个文件对应一项具体的网络服务，如 ssh 服务等.与之对应的配置文件中记录了各项服务所使用的 tcp/udp 端口，在最新版本的 firewalld 中默认已经定义了 70+ 种服务供我们使用.当默认提供的服务不够用或者需要自定义某项服务的端口时，我们需要将 service 配置文件放置在 /etc/firewalld/services/ 目录中。

FirewallD 提供了命令行管理工具firewall-cmd和 命令行配置工具firewall-config，FirewallD 使用两个配置集：“运行时”和“持久”。 在系统重新启动或重新启动 FirewallD 时，不会保留运行时的配置更改，而对持久配置集的更改不会应用于正在运行的系统。
 
### FirewallD的基本操作

| 命令                                    |  备注                                              |
|-----------------------------------------|----------------------------------------------------|
| systemctl start firewalld.service       |  启动firewalld                                     |
| systemctl stop firewalld.service        |  关闭firewalld                                     |                          
| systemctl enable firewalld.service      |  加入到系统默认服务                                |  
| systemctl disable firewalld.service     |  从系统默认服务移除                                |                
| firewall-cmd --reload                   |  重新加载防火墙，并不中断用户连接，即不丢失状态信息|
| firewall-cmd --complete-reload          |  重新加载防火墙并中断用户连接，即丢弃状态信息，通常在防火墙出现严重问题时，这个命令才会被使用。比如，防火墙规则是正确的，但却出现状态信息问题和无法建立连接|


### FirewallD的操作实例

* 开启80端口 `firewall-cmd --zone=public --add-port=80/tcp --permanent && systemctl restart  firewalld` 