# # Linux系统与网络管理学习笔记
## 第四章 SHELL脚本编程基础
_DON'T REPEAT YOURSELF_
### 部分语法与命令
* 注释符号 #
* 文件起始处的#!表示自己是一个脚本文件
* 当前shell脚本默认使用的解释器
```
ps | grep $$ //查看当前正在使用的shell解释器
type bash //查看当前shell解释器对应的文件绝对路径
bash --version //查看当前bash的版本号
help type //查看内置命令使用方法
help help //查看内置命令使用方法
```
* **变量相关语法**
  _Read-Eval-Print-Logs_
  * 变量名区分大小写
  * =左右两边不能有空格
  * 单引号包围的字符串中不对特殊符号做解释执行
  * 双引号包围的字符串中对特殊符号解释执行
  * 使用\转义特殊符号避免被解释执行
  * 使用${}包围变量名避免变量名被解释执行时的二义性
  * 使用双引号""包围变量名可以保留所有空格字符（单引号会把空格压缩掉）
  * ``符号和$()都可以用于命令输出结果替换变量赋值结果
* **脚本调试方法**
  ```
  $ bash -x <script.sh> //调试模式运行，逐行执行命令并打印命令接受的输入参数值
  # 代码片段临时开启调试模式
  set -x
  w
  set +x
  echo -e "$msg" >> /tmp/debug.log //写文件
  ```
* **脚本传参**
  * $0 表示脚本文件本身，$1表示命令行上第一个参数，n表示第n个，$@表示所有参数（数组）,$#表示参数个数（数组大小）
* **数组**
```
echo $P{#my_array[@]} //数组元素个数
echo ${my_array[2]} //随机读取数组中的元素

//遍历数组
for ele in "${my_Array[@]}";do
    echo "$ele"
done

//关联数组
for key in "${!associative_arr[@]}";do
    echo "$key ${associative_Arr[$key]}"
done 
```
* **基本算术运算**
  使用${{expression}},只支持整数运算（进阶算术运算需要命令行工具bc）
  ```
  pi=$(echo "scale=10;4*a(1)" | bc -l) //计算4* arctangent(1)，计算结果保留10位有效数字，-l表示使用标准数学库
  ```
* **条件判断**
```
if [ expression ]; then
elif [ expression ]; then
else
//括号中空格不能省略，且最好使用双方括号
```
* **循环**
```
for arg in [list]
do
 command[s]
done

until [ condition ]
do
 command[s]
done
```
* **编写健壮的SHELL脚本**
  * FAIL-FAST：避免错误蔓延
    * 越早期的bug越容易被检测到
    * 避免一连串bug协同后产生的雪崩效应
    * 应用于测试驱动开发与持续集成
  ```
  set -e //有错误就终止
  set -o pipefail //-e不能终止管道命令中错误的语句，顾名思义，pipefail可以实现检测管道中出错的语句
  ```
  * **函数**
  ```
  //基本定义方法，可移植性最好
  function_name () compound
  -command
   [ redirections
    ]
  //现代主流shell均支持的语法，可以避免alias机制污染函数名
  function function_name[ () ] compound
  -command
   [ redirections ]
    
  ```
  * **特殊变量**
  ```
  $0 //当前脚本文件名
  $n //脚本或函数的第n个传参
  $# //脚本或函数传入参数的个数
  $@ //脚本或函数传入的所有参数（数组形式）
  $* //脚本或函数传入的所有参数（字符串形式）
  $? //最近一条命令或函数的退出状态码
  $$ //当前shell解释器的进程编号
  $! //最近一个进入后台执行的进程编号
  //上述信息均可通过man bash查看
  ```
