# 字符集

## 修改字符集

```mysql
alter table table_name charset =utf8;

alter table table_name convert to character set utf8;
```

## 两者的区别

<font color=#555787>alter table table_name charset =utf8;</font>不能修改已经存在的列的字符集(即执行从命令后，假设表中新增加一列，新列的字符集才是utf8，但是其他列仍然为旧的字符集。)。

<font color=#555787>alter table table_name convert to character set utf8;</font>该命令则会将新列和就列的字符集统一修改为utf8。

执行以上操作时，要保证更换的字符集要包含旧的字符集，否则会报错。并且会进行<font color=red>锁表操作</font>。

