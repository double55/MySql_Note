# NULL和空值的区别

NULL也就是在字段中存储NULL值，空值也就是字段中存储空字符('')。

## 占用空间区别

```mysql
mysql>  select length(NULL), length(''), length('1');
+--------------+------------+-------------+
| length(NULL) | length('') | length('1') |
+--------------+------------+-------------+
| NULL         |          0 |           1 |
+--------------+------------+-------------+
1 row in set
```

小总结：从上面看出空值('')的长度是0，是不占用空间的；而的NULL长度是NULL，其实它是占用空间的，看下面说明。

    NULL columns require additional space in the row to record whether their values are NULL.

    NULL列需要行中的额外空间来记录它们的值是否为NULL。

通俗的讲：空值就像是一个真空态杯子，什么都没有，而NULL值就是一个装满空气的杯子，虽然看起来都是一样的，但是有着本质的区别。

## 插入/查询方式区别

创建一个表，tb_test

```mysql
CREATE TABLE `tb_test` (
  `one` varchar(10) NOT NULL,
  `two` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

插入进行验证：

```mysql
-- 全部插入 NULL，失败
mysql> INSERT tb_test VALUES (NULL,NULL);
1048 - Column 'one' cannot be null
```

```mysql
-- 全部插入 空值，成功
mysql> INSERT tb_test VALUES ('','');
Query OK, 1 row affected
```

模拟数据：

```mysql
INSERT tb_test VALUES (1,NULL);
INSERT tb_test VALUES ('',2);
INSERT tb_test VALUES (3,3);
```

空值字段：

```mysql
-- 使用 is null/is not null
mysql> SELECT * FROM tb_test where one is NULL;
Empty set

mysql> SELECT * FROM tb_test where one is not NULL;
+-----+------+
| one | two  |
+-----+------+
| 1   | NULL |
|     | 2    |
| 3   | 3    |
+-----+------+
3 rows in set
-- 使用 = 、!=
mysql> SELECT * FROM tb_test where one = '';
+-----+-----+
| one | two |
+-----+-----+
|     | 2   |
+-----+-----+
1 row in set

mysql> SELECT * FROM tb_test where one != '';
+-----+------+
| one | two  |
+-----+------+
| 1   | NULL |
| 3   | 3    |
+-----+------+
2 rows in set
```

NULL值字段：

```mysql
-- 使用 is null/is not null
mysql> SELECT * FROM tb_test where two is not NULL;
+-----+-----+
| one | two |
+-----+-----+
|     | 2   |
| 3   | 3   |
+-----+-----+
2 rows in set

mysql> SELECT * FROM tb_test where two is NULL;
+-----+------+
| one | two  |
+-----+------+
| 1   | NULL |
+-----+------+
1 row in set

-- 使用 = 、!=
mysql> SELECT * FROM tb_test where two = '';
Empty set

mysql> SELECT * FROM tb_test where two != '';
+-----+-----+
| one | two |
+-----+-----+
|     | 2   |
| 3   | 3   |
+-----+-----+
2 rows in set

```

小总结：如果要单纯查NULL值列，则使用 is NULL去查，单纯去查空值('')列，则使用 =''。

建议查询方式：NULL值查询使用is null/is not null查询，而空值('')可以使用=或者!=、<、>等算术运算符。

## COUNT 和 IFNULL函数

使用COUNT函数：

```mysql
mysql> SELECT count(one) FROM tb_test;
+------------+
| count(one) |
+------------+
|          3 |
+------------+
1 row in set

mysql> SELECT count(two) FROM tb_test;
+------------+
| count(two) |
+------------+
|          2 |
+------------+
1 row in set

mysql> SELECT count(*) FROM tb_test;
+----------+
| count(*) |
+----------+
|        3 |
+----------+
1 row in set
```

使用IFNULL函数：

```mysql
mysql> SELECT IFNULL(one,111111111) from tb_test WHERE one = '';
+-----------------------+
| IFNULL(one,111111111) |
+-----------------------+
|                       |
+-----------------------+
1 row in set

mysql> SELECT IFNULL(two,11111111) from tb_test where two is NULL;
+----------------------+
| IFNULL(two,11111111) |
+----------------------+
| 11111111             |
+----------------------+
1 row in set
```

小总结：使用 COUNT(字段) 统计会过滤掉 NULL 值，但是不会过滤掉空值。

说明：IFNULL有两个参数。 如果第一个参数字段不是NULL，则返回第一个字段的值。 否则，IFNULL函数返回第二个参数的值（默认值）。

## NULL索引失效



## 总结

1. 空值不占空间，NULL值占空间。当字段不为NULL时，也可以插入空值。

2. 当使用 IS NOT NULL 或者 IS NULL 时，只能查出字段中没有不为NULL的或者为 NULL 的，不能查出空值。

3. 判断NULL 用IS NULL 或者 is not null,SQL 语句函数中可以使用IFNULL()函数来进行处理，判断空字符用 =''或者<>''来进行处理。

4. 在进行count()统计某列的记录数的时候，如果采用的NULL值，会别系统自动忽略掉，但是空值是会进行统计到其中的。

5. MySql中如果某一列中含有NULL，那么包含该列的索引就无效了。这一句不是很准确。

6. 实际到底是使用NULL值还是空值('')，根据实际业务来进行区分。个人建议在实际开发中如果没有特殊的业务场景，可以直接使用空值。
7. 对于MySql特殊的注意事项，对于timestamp数据类型，如果往这个数据类型插入的列插入NULL值，则出现的值是系统当前时间。插入空值，则出现'0000-00-00 00:00:00'
8. 当使用Order By时，首先呈现NULL值。如果你用DESC以降序排序时，NULL值最后显示。当使用Group BY时。所用的NULL值被认为时相等的，故只显示一行。