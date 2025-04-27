# Linux系统与网络管理学习笔记
## 第六章 网络资源共享
_Keep Things Shared and Synchronized_
* 经典文件共享服务
  * FTP
    文件传送协议，基于TCP协议，用于计算机之间下载文件使用，由于使用明文数据传输，因此容易被拦截，使用C/S通信模型
    * 常见FTP服务器软件：ftpd、vsftpd、proftpd、pure-ftpd
  * NFS
    NFS允许系统将目录和文件共享给网络上的其它系统，通过NFS，用户和应用程序可以像访问本地文件一样访问远程系统上的文件
  * SMB/CIFS（SMB协议的本地化实现）
    使用C/S模式实现，由一系列客户端请求和服务器响应数据构成：
    * 会话控制报文-和共享服务资源建立和断开连接
    * 文件访问报文-访问和控制远程服务器上文件和目录
    * 通用信息报文-发送数据到打印队列、邮件投递接口、命名管道，并提供打印队列状态信息
* Samba
  用于为windows环境提供和整合常用服务，包括文件和打印机共享服务、目录服务、认证和权限服务等
  * 相关命令
    ```
    #安装Samba服务器
    sudo apt-get install samba
    #创建Samba共享专用的用户
    sudo useradd -N -s /sbin/nologin demoUser
    sudo groupadd demoGroup
    sudo usermod -a -G demoGroup demoUser
    sudo passwd demoUser
    #创建的用户必须有一个同名的Linux用户，但密码独立
    sudo smbpasswd -a <username>
    #创建测试使用共享目录
    sudo mkdir -p /srv/samba/demo
    sudo chown -R demoUser:demoGroup /srv/samba/demo
    ```
* 远程管理Windows主机方法
  * GUI：Windows远程桌面
  * CLI
    * PowerShell Remote
    * SSH 
  