# Linux系统与网络管理学习笔记
## 第三章 Linux服务器系统管理基础
_System Administrator is root_
1. Linux服务器管理员的典型工作场景和需求 
* 本地工作电脑是Windows或Mac，Linux是远程服务系统
* 服务器7×24小时开机，除需重启服务器的情况
* 远程ssh登录到服务器上是工作常态
* 移动办公时可以保持远程服务器上的操作被记住和按需复原
* 让进程更优雅的运行在后台，退出SSH会话不影响刚才启动的进程。
2. **远程管理工具箱**
* 工作电脑
  * SSH客户端软件
  * VScode Remote-SSH
* 服务器
  * tmux（screen的增强版）  
* 系统依赖条件
  * 工作主机依赖条件
    * SSH客户端软件
  * 远程主机依赖条件  
    * 开启SSH服务
      * 远程主机可以访问互联网  
3. **tmux**
  * tmux创建会话
  * ctrl+b,d退出
  * tmux ls 查看会话
  * tmux attach -t n 连接到n号会话
_可搜索tmuxcheatsheet了解更多常用操作_
4. **用户/组与权限管理
  * 相关命令
  ```
  su //切换用户
  sudo //切换用户做
  visudo //使用vi编辑器编辑文件
  passwd
  adduser/useradd //添加用户
  groupadd/addgroup
  usermod
  getfacl/setfacl
  ```
  * 用户标识（uid）
 * 权限含义——r读，w写，x执行，d目录，t临时目录，s特殊权限位
 * 文件类型
  * b 块特殊文件
  * c 字符特殊文件
  * d 目录
  * l 符号链接
  * s 套接字连接
  * p 命名管道
  * - 普通文件
* SUID（Saved UID）
一个被设置了SUID的程序，其他用户执行该程序时会暂时得到文件拥有者的权限
* 改变文件和目录的属主和权限
  * chown //change owner
  * chgrp //change group
  * chmod //change mod
  * umask 
* sudo使用注意事项
  * shell内部命令无法sudo
  * 以下情况不要sudo
    * 编辑用户家目录下文件
    * 源代码编译 
* 文件系统与存储管理
  * 文件系统格式
    * ext3/ext4/swap
    * mkfs //创建文件系统
  * 文件分区
    * 分区原则与策略
    * fdisk/gdisk（fdisk不支持2TB以上分区）
    * 大于2TB分区支持使用parted
  * 文件系统挂载
    * U盘/NFS/iso/光盘 （使用mount命令完成）
    * /etc/fstab （过去通过编辑此文件实现分区管理）
  * 常规磁盘管理步骤
  ```
  sudo su - //使用管理员权限
  lsblk //选择物理磁盘
  fdisk {{/dev/sdX}} //创建分区
  mkfs -t {{ext4}} {{path/to/partition}} //在指定分区上创建文件系统
  mount -t {{filesystem_type}} {{path/to/device_file}} {{path/to/target_directory}} //将分区挂载到指定目录
  ```
* LVM-逻辑卷管理
  * 可用在Linux内核的逻辑分卷管理器；可用于管理磁盘驱动器或其他类似的大容量存储设备
_可配合存储硬件的Raid技术_
  * LVM基本组成快
    * 物理卷（PV）
    * 卷组（VG）
    * 逻辑卷（LV）
    * 物理区域（PE） 
  * LVM磁盘管理步骤
    ```
    sudo su - //使用管理员权限
    lsblk //选择物理磁盘
    fdisk {{/dev/sdX}} //创建分区
    pvcreate {{/dev/sdX1}} // PV管理阶段 ：在物理分区上创建PV
    pvs/pvscan //查看所有可用PV
    vgcreate {{ubuntu-vg}} {{/dev/sda1}} {{/dev/sdb1}} {{/dev/sdc1}} //VG管理阶段：创建VG（将三个物理分区加入到一个名为ubuntu-vg的VG
    vgreduce {{ubuntu-vg}} {{/dev/sdc1}} //从指定VG中移除一个PV
    vgextend {{ubuntu-vg}} {{/dev/sda5}} //将一个PV加入到一个指定VG中
    vgdisplay //查看VG详细信息
    lvcreate -L 10G -n {{demo-lv}} {{ubuntu-vg}} 
    lvcreate -l {{100%FREE}} -n {{demo-lv}} {{ubuntu-vg}} //LV阶段，-L指定分区大小，-n 指定逻辑分区名称
    lvdisplay //查看LV详细信息
    mkfs -t {{ext4}} {{path/to/partition}} //在指定分区上创建文件系统
    mkdir -p {{path/to/target_directory}} //
    mount -t {{filesystem_type}} {{path/to/target_directory}} //将分区挂载到指定目录
    umount {{path/to/device_file}} //卸载指定LVM分区
    e2fsck -f {{path/to/device_file}} //检查各分区是否有损坏
    lvresize --size +{{120G}} --resizefs {{volume_group}}/{{logical_volume}}
    lvresize --size {{100}}%FREE {{volume_group}}/{{logical_volume}} //分区扩容
    lvresize --size -{{120G}} --resizefs {{volume_group}}/{{logical_volume}} //分区缩减
    ```
* 文件备份与打包
_每个程序只做一件事，不要试图在单个程序中完成_
  *tar-对文件目录进行打包
  连同所有目录、文件的属主信息、时间戳信息一并打包保存
* **在系统正常时要定期测试备份文件是否可以正常恢复和还原**
  恢复前要记得先备份当前目标目录和文件，避免错误、不可逆的文件覆盖
  恢复前检查备份文件完整性
* 备份策略设计约束性因素
  * 可移植性
  * 无人值守
  * 用户友好
  * 远程备份 
  * 网络备份
  * 存储介质
  * 可审计
* **网络配置管理工具——ifupdown（与netplan冲突）
* netplan快速配置
  * 配置文件路径 /etc/netplan/*.yaml
  * 测试和应用配置使用netplan apply
  * 验证yaml语法正确性 yamllint
* 网卡名称解析
例： enp3s0
en表示以太网卡
p3s0代表PCI接口的物理位置为（3，0），横坐标代表bus，纵坐标代表slot
* 开机自启动项管理
 * SysVinit LSBInitScripts OpenRC
   早期开机自启动项管理机制，依赖/etc/init.d下脚本实现
 * Upstart：Ubuntu曾经研发的系统服务启动控制机制
 * Systemd：目前使用的机制
* Systemd各章节实操录制记录地址**
  * 1-3 https://asciinema.org/a/E8uJC40kpFvo1hDNVJ7qQc70m
  * 4-5 https://asciinema.org/a/A8EBKJkkWNBQMbU3vmoLkVtbT
  * 6-7 https://asciinema.org/a/tLkQ72HZVpKbNExlKxH06qumD
  * 应用 https://asciinema.org/a/G9yKVH6qXYanK84diwbQu4X8c