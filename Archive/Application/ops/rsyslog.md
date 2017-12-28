日志文件和相关服务进程
   日志文件用来记录系统，服务等在运行过程中发生的事件，事件发生的时间及事件的关键性程序。这些记录的信息在服务器运行出现问题时用来查看分析，以便解决问题。在Linux上，日志的记录一般有两种方式，一种是由软件自身完成自身运行状态的记录，例如httpd；另一种是由Linux上提供的日志文件管理系统来统一管理。运行的软件只需要调用这个管理系统中的相关服务，即可完成日志的记录。rsyslog就是这样的一个日志文件管理系统。
    rsyslog内置了很多facility，这个可以理解为服务，这些服务从功能或程序上对日志进行分类，并由专门的工具负责记录其日志。没有实现记录日志功能的软件可根据需要记录的日志的类型调用这些对应的服务完成日志的记录。
rsyslog设置的服务主要有下面一些：
auth               #记录认证相关的信息
authpriv         #记录认证授权相关的信息
cron                #记录例行性工作cron/at等产生的信息
daemon         #记录与各个daemon有关的.....
kern               #......帮助内核记录日志...
lpr                  #......打印相关的信息.....
mail               #........与邮件收发的收发有关的信息      
syslog            #.......服务自身产生的信息
news              #USENET news subsystem（下面几个不太了解.......）
user               #generic user-level messages
uucp              #UUCP subsystem

上面的每一个服务产生的信息都有等级之分。有的信息只是系统运行过程中的基本说明信息，有的则是报告系统存在的重大问题。至于后者应该引起系统管理员的注意。
信息等级：
debug                 #debug-level message，调试信息
info                     #informational message，基本说明信息
notice                  #normal, but significant, condition，需要关注的信息
warn, warning     #warning conditions，警告信息
err, error              #error conditions，错误信息
crit                       #critical conditions
alert                     #action must be taken immediately
emerg, panic        #system is unusable
以上的详细信息可查看man 3 syslog。

配置文件及书写语法
/etc/rsyslog.conf是rsyslog的主配置文件，里面记录了哪个facility产生的哪个级别的信息需要被记录以及记录的位置。rsyslog.conf的基本语法如下，随便举几个例子：
1
authpriv.*                                              /var/log/secure
这行表示aythpriv这个facility产生的所有级别的信息都会被记录到/var/log/secure中，“*”放在后面表示所有级别的信息，也可以放在前面，例如：
1
*.emerg                                                 *
表示所有的facility产生的emerg级别以及这个级别以上的信息，“.”表示比后面高的级别（含该级别）的信息都被记录下来。类似的还有：
1）“.：”    #明确指定哪个级别，不含其他的级别
2）“.！”    #不等于该级别
“*”放在最后面表示发送信息给所有在线的人。日志记录的位置还可以表示为@192.168.1.110，表示将日志发送给远程的日志服务器。若要记录所有的信息但不包括某些信息，可以这么写：
1
*.*;mail.none;authpriv.none;cron.none                @192.168.1.110
上面的一行也可以写成：
1
*.*;mail,authpriv,cron.none                @192.168.1.110
在日志记录的位置前面还可以添加“-”，表示异步写入，用在某些facility产生的信息比较多时，这样可以提高性能。

日志服务器的配置
实验环境
日志服务器：192.168.1.110
数据库服务器：192.168.1.113
httpd服务器：192.168.1.111
php服务器：192.168.1.112

在日志服务器端配置（这个配置文件遵循一定的语法，模块的添加必须写在#### MODULES ####中）：
vim /etc/rsyslog.conf
# Provides UDP syslog reception              
$ModLoad imudp                             #启动模块
$UDPServerRun 514                             #监听UDP端口，接受来自其他服务器的记录日志请求
 
# Provides TCP syslog reception      
$ModLoad imtcp                             
$InputTCPServerRun 514                        #监听TCP端口
重启服务，查看监听的端口：
1
2
3
4
5
6
7
8
[root@CentOS-6 ~]# service rsyslog restart
Shutting down system logger:                               [  OK  ]
Starting system logger:                                    [  OK  ]
[root@CentOS-6 ~]# ss -tuln | grep 514
udp    UNCONN     0      0                      *:514                   *:*     
udp    UNCONN     0      0                     :::514                  :::*     
tcp    LISTEN     0      25                    :::514                  :::*     
tcp    LISTEN     0      25                     *:514                   *:*

在客户端配置（192.168.1.104）：
1
2
vim /etc/rsyslog.conf
*.info;mail.none;authpriv.none;cron.none                @195.168.1.110
将所有facility产生的info级别以上的信息（不包括mail，authpriv，cron）不记录在本地，而是发送给日志服务器，当然在日志服务器的配置文件上也要有这个条目（*.info;mail.none;authpriv.none;cron.none，这个需要和服务器上的配置完全一致，服务器上记录到哪里日志就记录到哪里）。
重启服务之后，在服务器端查看是否有日志产生（例如重启一下DNS服务，DNS服务器部署在192.168.1.104上）：
1
2
3
4
5
6
[root@CentOS-6 ~]# tail /var/log/messages
........
Jul 12 20:41:57 www named[5324]: zone xiaoxiao.com/IN/iplocal: sending notifies (serial 10013)
Jul 12 20:41:57 www named[5324]: zone xiaoxiao.com/IN/ipother: sending notifies (serial 10006)
Jul 12 20:41:57 www named[5324]: running
Jul 12 20:42:00 CentOS-6 dhclient[1880]: DHCPREQUEST on eth0 to 192.168.1.1 port 67 (xid=0x3ca6627c)
已经有日志记录到服务器上。