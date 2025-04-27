# 第五章 实验报告
## 各项实验要求与操作步骤
* **使用IP地址方式均无法访问上述站点，并向访客展示自定义的友好错误提示信息页面-1**
  * 打开对应网址，并进入对应verynginx控制台
![](https://pic1.imgdb.cn/item/680df2f158cb8da5c8d0399a.png)
![](https://pic1.imgdb.cn/item/680df2f158cb8da5c8d0399b.png)
  * 在控制台中的 Matcher 中设置匹配逻辑
![](https://pic1.imgdb.cn/item/680df2f158cb8da5c8d03998.png)
  * 在回复中设置对应的页面
![](https://pic1.imgdb.cn/item/680df2f158cb8da5c8d03999.png)
  * 在过滤器中进行对应设置
![](https://pic1.imgdb.cn/item/680e1d2358cb8da5c8d04ac7.png)
  * 结果展示
![](https://pic1.imgdb.cn/item/680e1d3a58cb8da5c8d04acb.png)
* **DVWA只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-2**
  * 在控制台中的 Matcher 中设置匹配逻辑，筛选出访问dvwa页面且IP地址不在白名单的请求
![](https://pic1.imgdb.cn/item/680e1e8258cb8da5c8d04b72.png)
  * 设置相应的返回页面信息
![](https://pic1.imgdb.cn/item/680e1e8258cb8da5c8d04b75.png)
  * 在过滤器中进行相应设置
* **
