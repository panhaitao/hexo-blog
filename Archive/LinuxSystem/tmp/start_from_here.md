## 前提条件

本文只是梳理创建一个发行版的流程，只会谈到设计的工具，不会谈到软件开发和打包细节问题，发行版更重要的是一种管理模式，如何有效合理的维护，分发软件，下面的列出的是个人觉得发行版维护人员需要具备的基础知识：

* 首先对GNU/Linux有足够的兴趣，熟悉主流发行版本的安装和基础使用
* 码包的编译，安装础和相关工具的使用例如 `gcc，clang/llvm，autotools，make，camke，qmake`
* 熟悉比如：`git，svn`版本控制工具的使用，典型的
* 熟悉deb，rpm等常见包格式的制作,了解软件仓库的概念
* 具备一定的软硬件基础知识，操作系统与应用软件的区别和基础概念
* 比如了解何为bios或者uefi,熟悉启动引导过程及其相关工具的基本配置和使用，比如grub，isolinux
* 有过制作LFS的经历更佳

## 制定合理的计划

在学生时代，各种教材一直在强调，程序=算法+数据结构，在实际工作中，程序+工程管理才是软件开发的全部，没有良好的工程管理，有再好的算法，有再严谨的数据结构，也做不好软件，操作系统版本开发也一样.

* 定义一个合理的目标，要定位这个版本是面向哪些用户群体，提供哪些功能，投入多少人力物力
* 定义版本的生命周期：和软件开发，做应用项目一样，一个版本同样有它的生命周期，比如规划阶段，开发阶段，维护阶段，支持结束等一个完整的生命周期，定义合理的版本生命周期，有始有终是重中之重！
* 定义软件包命名方式：总体原则就是，创建一个团队内统一约定并且遵循的命名方式。

## LINUX发行版的工作流程

所有发行版大体都遵循这个流程：源码版本控制-> 打包制作安装包 -> 归档入库 -> 制作安装介质.创建一个GNU/Linux发行版，核心关注点个人理解就是三个，安装包，仓库，安装介质：
 
* 安装包：这项的关注点是如何从源码生成安装包，保证安装包间的依赖关系正确
* 仓库：这项的关注点是如何把安装包导入仓库，并保证仓库中索引和数据一致正确
* 安装介质：这项的关注点是从仓库同步获取最新的软件包，制作成可用可引导介质，比如安装光盘，安装U盘

## 其他细节与规范：

* 定义基础工具链: （kernel，libc，gcc，binutils）这些个核心是操作系统版本的基石,
* 使用版本控制工具来管理源码，源码的修改提交一定要是使用版本控制工具，不要觉得使用版本控制工具是多余的步骤，使用版本控制可以方便的完成跟踪，评审，甚至回滚等操作； 
* 打包制作安装包，从源码制作安装包：
   * 一个细节就是尽量每次都能在一个干净的环境下构建
   * 另外一个细节就是软件包每次构建的修订号要保持保持持续增加，就算是代码回滚，修订号依然要保持+1,很多时候的混乱根源就是从打包开始；
* 归档入库 -> 制作安装介质，向仓库导入软件包，有个原则，就是仓库内的软件包原则上只能升级，不能覆盖仓库里同版本的软件包，不能随意降级软件包版本，在生成安装介质的时候，一定要清空本地构建环境，每次都从仓库获取最新软件包；
 
