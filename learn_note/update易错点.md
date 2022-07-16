1. 表设计

```mysql
CREATE TABLE d
(
    id          INTEGER NOT NULL PRIMARY KEY,
    current_val INTEGER,
    old_val     INTEGER
);
```

2. 插入语句

```mysql
INSERT INTO d
VALUES (1, 1, NULL);
```

```mysql
(doubll@localhost) [win]> SELECT * FROM d;
+----+-------------+---------+
| id | current_val | old_val |
+----+-------------+---------+
|  1 |           1 |    NULL |
+----+-------------+---------+
1 row in set (0.00 sec)
```

3. update语句

```mysql
UPDATE d
SET current_val = 2,
    old_val     = current_val
WHERE id = 1;
```

```mysql
(doubll@localhost) [win]> SELECT * FROM d;
+----+-------------+---------+
| id | current_val | old_val |
+----+-------------+---------+
|  1 |           2 |       2 |
+----+-------------+---------+
1 row in set (0.00 sec)
```

此时发现，查询结果出现偏差， old_val 应为 1 。

4. 修改 update 语句

```mysql
UPDATE d
SET old_val     = current_val,
    current_val = 2
WHERE id = 1;
```

```mysql
(doubll@localhost) [win]> SELECT * FROM d;
+----+-------------+---------+
| id | current_val | old_val |
+----+-------------+---------+
|  1 |           2 |       1 |
+----+-------------+---------+
1 row in set (0.00 sec)
```

5 ***总结***

mysql更新数据：
引用存在的字段变量需要写在前面，否则会出现数据错误。