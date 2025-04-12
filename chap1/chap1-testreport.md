# 第一章 实验报告
## 实验问题
* 如何配置无人值守安装iso并在Virtualbox中完成自动化安装？
* Virtualbox安装完Ubuntu之后新添加的网卡如何实现自动启用和自动获取IP？
* 如何使用sftp在虚拟机和宿主机之间传输文件？
### 一、在Virtualbox中通过配置无人值守安装iso实现自动化安装的操作流程
* 下载对应版本镜像并安装虚拟机，做好各项配置（包括更换可用的镜像源，安装openssh-server），为后续实验做准备
![](https://pic1.imgdb.cn/item/67f9e11288c538a9b5cb90aa.png)
* 通过chown命令更改/var/log/installer目录下生成的记录手动安装配置的autoinstall-user-data文件的归属者，方便使用winscp将其下载至本机中，以方便后续对该文件的修改
![](https://pic1.imgdb.cn/item/67f9e11288c538a9b5cb90ab.png)
![](https://pic1.imgdb.cn/item/67f9e11388c538a9b5cb90ae.png)
* 修改配置文件，包括时区，删除序列号，修改部分磁盘设置等，并将其命名为user-data，新建一个名为meta-data的空文件，并创建新镜像
![](https://pic1.imgdb.cn/item/67f9e11c88c538a9b5cb90d6.png)
* 创建虚拟机，并按照要求修改控制器SATA设置
![](https://pic1.imgdb.cn/item/67f9e11c88c538a9b5cb90d7.png)
* 成功实现无人值守安装
![](https://pic1.imgdb.cn/item/67f9e24688c538a9b5cb94d6.png)
### 二、Virtualbox安装完成Ubuntu后新添加的网卡如何实现自动启用和自动获取IP
_通过编辑Netplan配置文件进行设置_
* 在virtualbox中新添加网卡
* 启动虚拟机在虚拟机中使用ip a指令确认新网卡名称
![](https://pic1.imgdb.cn/item/67f9e37388c538a9b5cb9840.png)
* 使用文本编辑器打开etc/netplan目录下的配置文件00-installer-config.yaml，并修改新网卡配置以实现自动启用和自动获取IP
![](https://pic1.imgdb.cn/item/67f9e36f88c538a9b5cb9835.png)
* 使用sudo netplan apply命令应用网络配置
* 使用命令测试网络是否配置成功
![](https://pic1.imgdb.cn/item/67f9e39888c538a9b5cb9894.png)

### 三、如何使用sftp在虚拟机和宿主机之间传输文件？
* 确保虚拟机开启ssh服务
* 在宿主机中使用sftp username@虚拟机IP命令建立连接
![](https://pic1.imgdb.cn/item/67f9e36388c538a9b5cb981c.png)
* 使用如下命令实现文件传输
```
put /宿主机路径/file.txt   # 上传到虚拟机当前目录
get /虚拟机路径/file.txt  # 下载到宿主机当前目录
```
![](https://pic1.imgdb.cn/item/67f9e3b988c538a9b5cb98f7.png)
![](https://pic1.imgdb.cn/item/67f9e3c888c538a9b5cb9917.png)
![](https://pic1.imgdb.cn/item/67f9e3c888c538a9b5cb9916.png)