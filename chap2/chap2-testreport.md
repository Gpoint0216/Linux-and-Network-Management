# 第二章 实验报告
## **一、vimtutor各章节实操录制记录地址**
* 1.1 https://asciinema.org/a/jAlnrlwH4xs6x05hoErCdSQfh
* 1.2 https://asciinema.org/a/1rNeJWzngXhD4EhqWsTKch3GH
* 1.3 https://asciinema.org/a/Tv4euGgkYgTQL83S51akndtGz
* 1.4 https://asciinema.org/a/VEgAUxiHoXyqlxeBkYbYuRi2N
* 1.5 https://asciinema.org/a/dbyeLvhuvISmcopGRa5IxAUgk
* 1.6 https://asciinema.org/a/M1hVCc2QFQobqBLaMMpT8f1cK
* 2.1 https://asciinema.org/a/XsxZW6yZgpsEOqDHUaZU1CdUc
* 2.2 https://asciinema.org/a/HRTkOag6rk0bHtKMLSUaLfNf3
* 2.3 https://asciinema.org/a/2842KEBo7OwhCfdH9jW9M0yZn
* 2.4 https://asciinema.org/a/BCWXzxs9MF3QtiiiEQbnDqhpU
* 2.5 https://asciinema.org/a/i2jNNqUpTTMt7YyvUbYocYuOu
* 2.6 https://asciinema.org/a/bhymcYBMSk5QVZlaIa2nVtRzt
* 2.7 https://asciinema.org/a/Eo5Lkt5aieqYZN2uRiC1ovbPI
* 3.1 https://asciinema.org/a/Fr5iMVLaMnSkitAFiRisTptIb
* 3.2 https://asciinema.org/a/7nqhcb5EE13aNTQMFzF7tyeTC
* 3.3 https://asciinema.org/a/vABlLS70M3G4CI9GN1sOZ1aLF
* 3.4 https://asciinema.org/a/CoWsaWzM0NRNEkBz9cv2eR31R
* 4.1 https://asciinema.org/a/HlqffnyZvp2fa3CqS4TUxiByZ
* 4.2 https://asciinema.org/a/LculJbMvuQdAtDRZCW36vcr8k
* 4.3 https://asciinema.org/a/odshdoGTE864YDDe72wRePLYG
* 4.4 https://asciinema.org/a/nWNJ8jgYze3Kgz7X31fDAqU1g
* 5.1 https://asciinema.org/a/loyKODhJqSbqypuqIHscfwi7d
* 5.2 https://asciinema.org/a/PiOClX6XWpgyah3U1Gctmessh
* 5.3 https://asciinema.org/a/8H3vlHVydqXIaFuLAh8crJGnl
* 5.4 https://asciinema.org/a/ufaMOotFDuwuPAt23yjjp9ots
* 6.1 https://asciinema.org/a/Zj6z8lYKKSzk1irBzyX4YBxUg
* 6.2 https://asciinema.org/a/kAw7ySyDYjq5AbFBRKztl4nh9
* 6.3 https://asciinema.org/a/2KdHiW8rxdjBFa2ae4Nh65So1
* 6.4 https://asciinema.org/a/NcFofePvU14OOzFdNqrIEdH0p
* 7.1 https://asciinema.org/a/pBk7Mj6PKWKVXWrj3gPNM99Iv
* 7.2 https://asciinema.org/a/C0KA5FwXf4dAKApuA3kcep8bX
* 7.3 https://asciinema.org/a/xmGbC4Wih5q2EzKqbc8sm0UjV
* 7.4 https://asciinema.org/a/241LkShG0voywj873mPFF4nkU
## **二、vim学习笔记**
 * **Vim模式**
   * 正常模式（Normal Mode）：默认模式，可以使用基础命令
   * 命令模式（Command Mode）：使用:开始，可以使用比正常模式更复杂的命令
   * 插入模式（Insert Mode）：主要用于编写文档
   * 可视模式（Visual Mode）：可以用来模拟鼠标选中内容
   * 替换模式（Replace Mode）：顾名思义，用来替换选中字符
### **Lesson 1**
```
h,j,k,l //分辨用于向左、下、上、右移动光标（方向键同样可以实现），在指令前加数字可以移动对应次数
:q! //放弃所有修改并强制退出编辑器
x //将光标位置字符删除，前附数字n可删除光标及之后位置的共n个字符
i //切换为插入模式
A //可向行尾追加内容
:wq //用于保存并退出编辑器
<Esc> //切换为正常模式
```
### **Lesson 2**
```
w //从当前光标位置移动到下一个单词起始处，前加数字n表示移动至第n个单词首
e //从当前光标位置移动到单词末尾，前加数字n表示移动至第n个单词末尾
0 //从当前位置移动到行首
$ //从当前位置移动到行末，前加数字n表示移动到第n行行尾
dw //将光标所在位置删除，中间加数字n表示删除当前及之后n个单词
d$ //将当前位置到该行末尾所有字符删除
de //当前位置到该单词末尾所有字符删除
d0 //当前位置到行首所有字符删除
dd //删除整行，前加数字表示删除几行
U //撤销上次队某行的修改
u //撤销上次编辑命令
Ctrl+r //重做上一次命令
```
### **Lesson 3**
```
//粘贴
p //将最后一次删除的内容粘贴到光标后
//替换
r<x> //x为任意字符，r会替换光标所在位置，x为替换后内容
//修改
cw //删除光标到单词末尾，并切换为插入模式
c$ //删除光标到行末尾
```
### **Lesson 4**
```
//移动光标
gg //光标跳转到第一行
G //光标跳转到最后一行，前加数字表示跳转至指定数字行
ctrl+G //显示目前文件信息与光标所在位置
//查找
/<str> //自上而下查找str字符串
/<str>\c //自上而下忽略大小写查找str字符串
?<str> //自下而上查找str字符串
n //查找下一个满足条件的字符串
N //查找上一个满足条件的字符串
ctrl+O //返回上一个查找位置
ctrl+I //返回下一个查找位置
% //配对括号查找
//替换
:s/old/mew //将光标所在行第一个old字符替换为new
:s/old/new/g //将所在行所有old替换为new
:n1,n2/old/new/g //将n1n2之间的所有old替换为new
%s/old/new/g //将整个文件中的old替换为new
:%s/old/new/gc //在前一条的基础上每次替换前要确认是否替换
```
### **Lesson 5**
```
//执行外部命令
:!<command> //command为任意外部命令
```
//保存
:w filename 
v motion :w FILENAME //部分保存，v切换至可视模式，移动光标选择保存内容
//可视模式
v //进入可视模式
提取与合并
:r filename // 将filename文件的内容以行为单位粘贴到光标下方
:r !<command> //将command 命令结果以行为单位粘贴到光标下方
### **Lesson 6**
```
//插入
o //在光标下新开一行并跳至行首，切换为插入模式
O //光标上新开一行并跳至行首，切换为插入模式
i //切换为插入模式
a //将光标向后移动一个字符，切换至插入模式
A //光标移动到行尾，切换至插入模式
//替换
R //切换至替换模式
//复制
y //将内容以字符为单位进行复制，使用p可以粘贴到光标位置后
//设置
:set ic(ignorecase) //设置查找替换时忽略大小写
:set noic(not ignorecase) //顾名思义，不忽略大小写
:set hls(hlsearch) //高亮显示所有匹配短语
:Set is(incsearch) //增量搜索
```

### **Lesson 7**
```
//帮助
<HELP> <F1> :help //使用在线帮助系统
//补全
<TAB> //自动选取一个补全命令
ctrl+D //列出补全备选项

```