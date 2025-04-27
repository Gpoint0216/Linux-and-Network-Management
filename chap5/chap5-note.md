# Linux系统与网络管理学习笔记
## 第五章 WEB服务器
* Web是一个信息空间，文档和其他Web资源使用URL标识并用超链接相互连接在一起
* URI/URL/URN/IRI
早期，将URI分为两类：URL(资源地址)与URN（资源名称）
后来，有人建议URI还能标识元数据而不仅是资源本身，因此，又提出了统一资源引用（URC）
故URI进行命名空间划分为：URL,URN和其他子命名空间
现代，URL是一种特殊的URI
IRI是URI语法的扩展，用于支持非ASCII字符集，例如UTF-8
* **URL**
* URL的一般形式：
```
genericurl      = scheme ":" schemepart
scheme          = 1*[ lowalpha | digit | "+" | "-" | "." ]
schemepart      = *xchar | ip-schemepart
ip-schemepart   = "//" login [ "/" urlpath ]

//*表示重复0次或多次后面的内容
//1*表示仅允许后面的内容出现一次
```
* **常见SCHEME**
  * ftp-文件传输协议
  * http-超文本传输协议
  * mailto-电子邮件地址
  * file-主机文件名 
* host-网络主机的FQDN（Fully Qualified Domain Name） 或IP地址
* port-端口号如果省略，则左边冒号必须一并省掉
* 哪些大小写敏感？：
  * scheme-不区分大小写
  * host-不区分大小写
  * path-与HTTP服务器实现相关
* NGINX服务器
  * 核心特性
    *  HTTP服务器
    *  邮件代理服务器
    *  TCP/UDP代理服务器
* 应用程序服务器 
  * PHP：PHP-FPM/Apache的mod_php/swoole
  * nodejs
  * python：uwsgi兼容web服务器/wsgi兼容web服务器/fastcgi兼容web服务器/apache的mod_python
  * ruby:unicorn/Phusion Passenger
* CGI/FASTCGI
  * CGI(通用网关接口)
    * 描述客户端和这个程序间传输数据的标准，是一种协议规范，独立于具体编程语言实现。
  * FASTCGI是CGI的一种改进方案
    * 像是一个常驻的CGI，可以一直执行，在请求到达时不会花费时间去fork一个进程来处理
    * PHP-FPM：FastCGI的PHP版本实现 
* 客户端
  * GUI（图形界面）/CLI（命令行）