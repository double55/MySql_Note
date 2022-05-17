统计MySql一张表中的行数

> select count(1) from table;

> select count(*) from table;

> select count(name) from table;

区别：

- count(*)：计算所有数据中包含null值的行数
- count(1)：计算所有数据中包含null值的行数
- count(name)：计算指定列中不包含null值的行数

innodb下count(*)和count(1)一样快，快于count(列名)

> InnoDB handles SELECT COUNT(*) and SELECTCOUNT(1) operations in the same wayThere is no performance difference.

innodb通过遍历最小可用的二级索引来处理语句，如果二级索引不存在，则会扫描聚集索引。

myisam下count(*)快于或者等于count(1)，快于count(列名)
myisam的存储了表的总行数，使用count(*)不走统计，直接读取，所以最快。
那么当使用count(1)时，假如第一列为notnull，myisam也会直接读取总行数
进行优化。

count(列名)因为只统计不为null的，所以要遍历整个表，性能下降。