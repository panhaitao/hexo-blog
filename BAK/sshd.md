
OpenSSH及ssh连接过程概述
OpenSSH（OpenBSD Secure Shell）是使用SSH通过计算机网络加密通信的实现。它是替换由SSH Communications Security所提供的商用版本的开放源代码方案。目前OpenSSH是OpenBSD的子项目。OpenSSH常常被误认为与OpenSSL有关系，但实际上这两个项目的有不同的目的，不同的发展团队，名称相近只是因为两者有同样的软件发展目标──提供开放源代码的加密通信软件。
 
ssh客户端与服务器端认证通信流程可划分成四个阶段：
第一阶段:
双方协商SSH版本号和协议,协商过程数据不加密。
第二阶段:
双方协商RSA/DSA主机密钥,数据加密算法,消息摘要。
其中主机密钥用于确认服务端的身份,数据加密算法用于加密通信数据,消息摘要	用于校验数据的完整性,登录认证方式.主要思想是服务端提供各种加密/认证方式,	客户端在这中间选择加密/认证方式.
第三阶段:
由于双方已经确认了可以使用的加密算法,消息摘要,协议版本号,主机密钥等信息,	这阶段由客户端根据选择的认证方式发起登录验证申请.
服务端对客户端提供的密码等信息进行校验.如认证不通过,则试图进行下一种认	证方式的申核,直到成功/失败,或者超时。
第四阶段:
客户端如果校验成功,则服务端会创建一个客户端的session(进程),同时会转送环	境变量,最后给客户端一个bash的机会.
 
Ssh服务器的安装
深度服务器操作系统中默认已经集成了OpenSSH服务器和客户端。
 
Ssh服务配置文件
ssh远程连接采用客户机/服务器模式，故ssh配置文件也分为ssh服务器配置文件和ssh客户端配置文件。
 
ssh服务配置文件为/etc/ssh/sshd_config , ssh客户端配置文件为/etc/ssh/ssh_config
 
Ssh服务基本功能测试
 	前提条件：
测试机１（ssh服务器10.1.11.105）测试机２（ssh客户端）在同一网段，且能够	互相通讯．测试机１上已经存在普通用户tester.
 
具体操作步骤：
1. 在测试机１的tty1以root用户身份登录系统，执行命令systemctl 	status 	ssh.service．可看到ssh服务默认已经启动。
2. 在测试机２的tty1执行命令ssh tester@10.1.11.105，在出现	tester@10.1.11.105's password: 提示后输入tester用户的登录口令，敲击回	车键。结果用户tester通过ssh远程登录成功
3. 切换到测试机１，root	用户执行命令systemctl stop ssh.service.
停止ssh服务。
4. 切换到测试机２的tty2执行命令ssh tester@10.1.11.105．敲击回车键。	结果因	ssh服务关闭导致远程连接失败。