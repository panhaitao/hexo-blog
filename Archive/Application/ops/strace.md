
strace概述
strace是一个集诊断、调试、统计于一体的工具。strace常用来跟踪进程执行时的系统调用和所接收的信号。 在Linux中进程不能直接访问硬件设备，当进程需要访问硬件设备(比如读取磁盘文件，接收网络数据等等)时，必须由用户态模式切换至内核态模式，通过系统调用访问硬件设备。
 
我们可以使用strace对应用的系统调用和信号传递的跟踪结果来对应用进行分析，以达到解决问题或者是了解应用工作过程的目的。strace可以跟踪到一个进程产生的系统调用,包括参数，返回值，执行消耗的时间。
 
strace的最简单的用法就是执行一个指定的命令，在指定的命令结束之后它也就退出了。在命令执行的过程中，strace会记录和解析命令进程的所有系统调用以及这个进程所P接收到的所有的信号值。
 
strace安装
在深度服务器操作系统strace工具的安装方式有两种：
Tasksel安装方式
1. 配置好软件源，配置软件源请参考本手册的2.3节。
2. 在命令行执行tasksel命令，在打开的tasksel软件选择界面，选中“strace”，	光标移动到“ok/确定”按钮，敲击回车键，系统就开始安装。
 
命令行安装方式
1. 配置好软件源，配置软件源请参考本手册的2.3节。
2. 在命令行执行命令apt-get install strace或aptitude 	install strace，系统就开始安装。
 
strace用法
strace的一般用法
strace [-CdffhiqrtttTvVxxy] [-I n] [-e expr]...
[-a column] [-o file] [-s strsize] [-P path]...
-p pid... / [-D] [-E var=val]... [-u username] PROG [ARGS]
 
or: strace -c[df] [-I n] [-e expr]... [-O overhead] [-S sortby]
     -p pid... / [-D] [-E var=val]... [-u username] PROG 	[ARGS]
 
strace命令常用的选项参数及其含义如表5.16所示。
 
表5.16 strace常用选项参数及其含义
参数
含义
-c
统计每一系统调用的所执行的时间,次数和出错的次数等
-p
跟踪指定的进程
-f
跟踪由fork调用所产生的子进程
-F
尝试跟踪vfork调用，在-f时,vfork不被跟踪
-o
将strace的输出写入指定文件
-ff
如果提供-o filename,则所有进程的跟踪结果输出到相应的filename.pid中,pid是各进程的进程号
-r
打印每一个系统调用的相对时间
-t
在输出中的每一行前加上时间信息。-tt 时间确定到微秒级。还可以使用-ttt打印相对时间
-v
输出所有的系统调用.一些调用关于环境变量,状态,输入输出等调用由于使用频繁,默认不输出
-s
指定每一行输出字符串的长度,默认是32。文件名一直全部输出
-e
 输出过滤器，通过表达式，可以过滤出掉你不想要输出
-u
以username的UID和GID执行被跟踪的命令
-x
以十六进制形式输出非标准字符串
-T
显示每一调用所耗的时间
-V
输出strace的版本信息
-h
显示帮助信息
-d
输出strace关于标准错误的调试信息
 
strace命令的其他更多参数及其含义，用户可以直接运行man strace即可查看。
 
strace应用举例
1. 确保gcc编译工具在测试机1已经安装。
2. 在测试机1的tty1以tester用户身份登录系统，编辑测试程序test02.c内容如下
　　#include<stdio.h>
        void main()
        {
        printf("This is a testing program about 	strace!\n");
        }
3. 执行gcc -o test02 test02.c命令，生成可执行文件test02。
4. 从测试机2通过ssh方式以tester1用户身份登录测试机1，执行strace -o 	test02.txt ./test02命令．
5. 执行cat test02.txt，在此文件中保存了执行test02程序需要的所有系统调	用。
6. 执行命令 strace -T -x -c  -o test02.txt ./test02，
7. 执行cat test02.txt，在此文件中保存了执行test02程序需要的所有系统调	用统计列表，显示如下
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- P----------------
  0.00    0.000000           0         1           read
  0.00    0.000000           0         1           write
  0.00    0.000000           0         2           open
  0.00    0.000000           0         2           close
  0.00    0.000000           0         3           fstat
  0.00    0.000000           0         9           mmap
  0.00    0.000000           0         3           mprotect
  0.00    0.000000           0         1           munmap
  0.00    0.000000           0         1           brk
  0.00    0.000000           0         3         3 access
  0.00    0.000000           0         1           execve
  0.00    0.000000           0         1           arch_prctl
------ ----------- ----------- --------- --------- ----------------
100.00    0.000000                    28         3 total