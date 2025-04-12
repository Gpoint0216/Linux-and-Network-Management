# Linux系统与网络管理学习笔记
## 第二章 **Linux服务器系统使用基础**
### 一、**软件包管理**
* **软件包类型代号**
  * Main-Canonical官方支持的免费和开源软件
  * Universe-（开源）社区维护的免费和开源软件
  * Restricted-私有设备驱动
  * Multiverse-有版权限制的私有软件
  * backports-官方安全审查小组不提供任何安全审查和安全性承诺保障
  * partner-非Ubuntu系统的必要组件
* **apt-get update的过程**
_每天第一次打开虚拟机时最好使用一次apt-get update_
访问一个构造好的URL，该URL使用内置的字符串“拼接”规则构成（镜像源+dists+版本代号+软件类型+与系统相关的地址）
_遇到无法访问的网站时，可以使用ipip.net进行查询_
* **apt-get update, apt-get upgrade, apt-get dist-upgrade**
```
apt-get update   使用/etc/apt/sources.list中的镜像源地址更新可用软件包
apt-get upgrade //更新已安装软件版本
apt-get dist-upgrade //能解决部分软件升级时需卸载其他软件的自动依赖关系推导问题
```
* **apt-get remove,apt-get purge,apt-get clean，apt-get autoclean,apt-get autoremove**
  ```
  apt-get remove //删除已安装软件包但不删除配置文件
  apt-get purge //删除已安装软件包和配置文件
  apt-get clean //删除/var/cache/apt/archives/和/var/cache/apt/archives/partical/下除lock外的所有已下载文件
  aotuclean //相较于clean更加智能
  autoremove //删除所有用于满足其他软件依赖关系但现在已不需要的软件包
  ```
* **如何查找你需要的软件包？**
```
apt-get install <package_name> //知道软件包名时
apt-cache search ssh | grep <keywords> //知道软件名，但不知道软件包名,利用管道搜索关键字(搜索引擎搜索亦可以)
aptitude //对apt-get进行封装的一哥更友好、更已用的包管理工具（用于解决疑难杂症）
```
_在软件包后加版本后缀用以安装特定版本软件_
* **软件被装到哪里去了？**
```
apt-cache depends <package> //查找指定软件包依赖哪些软件包
dpkg -L <package> //查找指定软件包在系统上创建了哪些目录和文件
```
_谨慎修改/etc/apt/sources.list和在/etc/apt/sources.list.d/下创建第三方镜像配置文件_
### **二、文件管理基本命令**
```
ls //列出当前目录下文件
touch //创建一个新文件（实际是用于改变文件最后修改时间，没有就创建一个新文件）
rm //删除文件
shred //不可恢复的删除文件
ln //创建软链接
find //文件名查找
grep //文件内容查找
```
_ctrl+R键后输入历史命令内的字符可快速检索历史命令，提高效率_
* **什么是管道？**
```
cd ~/cd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt 
```
上述指令中 -print0将标准输出中多条记录使用NULL自负拼接成一哥长字符串输出到标准输出
xargs的-0参数将标准输入中的NULL自负视为数组分割符来解析标准输入内容
xargs从标准输入中每解析一个参数就按照构造好的命令加参数执行一次指定的命令，直到标准输入解析完毕
* **sed**
即流式编辑器，可用于进行文本替换、选择性输出文本文件，从某处开始编辑，实现无交互式编辑。
* **正则表达式**
_用于匹配字符串中字符组合的模式_
* 在线学习工具：检索regular expression tester
* **社区帮助手册-tldr**
_Too Long, Don't Read_
使用前记得从自建gitee镜像下载tldr所有手册页，否则会访问困难
* **文本内容查找替换工具**
  * AWK
  * head/tail
  * cut
  * tr
* **alias——别名机制，方便减少输入**
* **文件的压缩与解压缩**
  * 常见命令
  ```
  gzip
  bzip2
  zip
  tar
  7z
  rar //Linux中只能进行解压缩
  ```
* **进程管理**
  * 常见命令
  ```
  ps aux
  pstree
  pidof
  top
  htop
  kill
  ```
* **目录管理**
  * 常见命令
  ```
  man hier
  ls
  mkdir
  rm -rf
  mrdir
  ```