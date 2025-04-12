# Linux系统与网络管理学习笔记
## 第一章 Linux基础
_从使用到基本概念的扫盲_
### 一、Linux发展历程
* 1970年-Unix操作系统发布
* 1977年-基于Unix开发的BSD操作系统发布
* 1983年- Richard Stallman创建了类Unix，与POSIX兼容的操作系统为目标的GNU计划
* 1987年-MINIX系统（16位兼容POSIX标准的类UNIX系统）发布
* 1991年-Linux0.01版发布（已经使用到了一些GNU软件）
### 二、Linux生态圈
* **开发社区与Git**
早期Linux内核开发使用商业化版本控制软件BitKeeper进行代码管理。
不同于CVS、SVN等集中式版本控制工具，git采用分布式版本管理，不需要服务器端软件。
* **Git与GitHub**
  Git是一款免费、开源的分布式版本控制系统。
  GitHub是用Git做版本控制为全球开源软件作者提供免费、集中的代码托管平台。
* 开源与商业化
 Linux基金会、OpenStack基金会等通过采用会员制度进行盈利，其余盈利方式还包括认证、培训、部署、架构、集成等。
* Linux生态圈——发行版
  1. Linux内核
   * Debian:非盈利性组织运营的开源软件构建发布版本。
    Ubuntu:商业公司基于Debian构建和维护
    Linux Mint：开源社区维护
   * Fedora  
   * Oracle Linux：不断电不重启更新内核
   * SUSE
   * Arch Linux
   * Gentoo
   * Slackware
  _搭建环境时要多加注意_
  2. Linux Standard Base
_write once run everywhere_
  3. Carrier Grade Linux :电信运营商级Linux
为Linux发行版厂商制定实现规范，帮助上游厂商在技术上整合实现以满足上述需求标准（可用性、集群、可服务、性能、标准化、硬件、安全）。
  4. **Open-Source Software Community-开源软件社区**
### 三、命令行
* CLI：Command Line Interface：使用键盘输入命令，屏幕文字输出结果
* GUI：Graphics User Interface：使用键鼠等输入命令，图文音输出结果
* CUI：Conversational User Interface：使用语音输入命令，五感反馈
* **命令行的特点**
  * 命令行界面让完成复杂的任务成为可能。
  * 全键盘输入：专业工作效率高
  * 面向自动化：管道、文件、脚本 
 5. **Shell**
   * shell是一个执行命令的宏处理器：输入的文本和符号被扩展为更宏大的表达式
   * Unix shell是一个命令解释器，也是一种编程语言
   * shell的运行模式包括交互模式与非交互模式，交互模式从键盘输入指令解释执行，非交互模式从文件读取指令解释执行
   * shell同时支持同步或异步执行指令
 6. 文本编辑与查看命令
   * echo
   * cat
   * less
   * vim/vimtutor
   * sort
   * uniq
   * wc
