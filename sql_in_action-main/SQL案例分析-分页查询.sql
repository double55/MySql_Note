-- 创建示例表
use niuke;
CREATE TABLE users1
(
    id          integer PRIMARY KEY,
    name        varchar(50) NOT NULL,
    pswd        varchar(50) NOT NULL,
    email       varchar(50),
    create_time timestamp   NOT NULL,
    notes       varchar(200)
);

-- 生成示例数据
-- MySQL语法
INSERT INTO users1(id, name, pswd, email, create_time)
WITH RECURSIVE t(id, name, pswd, email, create_time) AS (
    SELECT 1,
           CAST(concat('user', 1) AS char(50)),
           'e10adc3949ba59abbe56e057f20f883e',
           CAST(concat('user', 1, '@test.com') AS char(50)),
           '2020-01-01 00:00:00'
    UNION ALL
    SELECT id + 1,
           concat('user', id + 1),
           pswd,
           concat('user', id + 1, '@test.com'),
           create_time + INTERVAL mod(id, 2) MINUTE
    FROM t
    WHERE id < 1000000
)
SELECT /*+ SET_VAR(cte_max_recursion_depth = 1M) */*
FROM t;

-- 创建索引
CREATE INDEX idx_user_ct ON users1 (create_time);

-- OFFSET分页
SELECT count(*)
FROM users1;

EXPLAIN
SELECT *
FROM users1
ORDER BY create_time, id
LIMIT 20 offset 100000;

-- KEYSET分页
EXPLAIN
SELECT *
FROM users1
WHERE create_time >= '2020-11-01 00:10:00'
  and id > 20
ORDER BY create_time, id
LIMIT 20;

truncate users1;

select str_to_date('2020/5/1',
                   '%Y/%m/%d');


with test(id, num) as (select 客户id, count(distinct (运单号)) as num
                       from 揽收表
                       where date_format(创建日期, '%Y%m%d') between '20200501' and '20200531'
                       group by 客户id),
     test1(id, num, sign) as (select id,
                                     num,
                                     case
                                         when num <= 5 then '0-5'
                                         when num <= 10 then '6-10'
                                         when num <= 20 then '11-20'
                                         else '20以上' end as 'sign'
                              from test)
select sign                            as '单量',
       case
           when biao = '0-5' then count(distinct id)
           when biao = '6-10' then count(distinct id)
           when biao = '11-20' then count(distinct id)
           else count(distinct id) end as '客户数'
from test1;