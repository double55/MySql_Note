WhERE与HAVING的根本区别在于：

- where子句在group by分组和数据汇总之前对数据行进行过滤
- having子句在group by分组和数据汇总之后对数据行进行过滤

在连接查询中，where和on的主要区别在于：

- 对于内连接查询，where子句和on子句等效
- 对于外连接查询，on子句在连接操作之前执行，where子句（逻辑上）在连接操作之后执行。