# Stored Procedure

## 实例

```mysql
DELIMITER //

CREATE PROCEDURE proc_test1(IN total INT, OUT res INT)
BEGIN
    DECLARE i INT;
    SET i = 1;
    SET res = 1;
    IF total <= 0 THEN
        SET total = 1;
    END IF;
    WHILE i <= total
        DO
            SET res = res * i;

            SET i = i + 1;
        END WHILE;
END;
//

DELIMITER ;

SET @total = 10;
SET @res = 1;

CALL proc_test1(@total, @res);
SELECT @res;
```

***例如***

创建存储过程的用户已经删除，则其他用户文法使用该存储过程。

***解决方法***

```mysql
UPDATE proc
SET DEFINER = "root@localhost"
WHERE db = 'table'
limit 1;
```

information_schema源数据库都是内存的信息(即只读),对于关于Procedure的表，是从mysql库下pro读取的。要想修改存储过程源信息是，只能在mysql库下pro表进行修改。执行以上语句后，重启mysql。

# 函数

## 实例

```mysql
DELIMITER //

CREATE FUNCTION func_test1(total INT)
    RETURNS BIGINT
BEGIN
    DECLARE i INT;
    DECLARE res INT;
    SET i = 1;
    SET res = 1;
    IF total <= 0 THEN
        SET total = 1;
    END IF;
    WHILE i <= total
        DO
            SET res = res * i;

            SET i = i + 1;
        END WHILE;
    RETURN res;
END; //

DELIMITER ;

SELECT func_test1(10);
```