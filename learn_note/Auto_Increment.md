# MySQL自增主键值回溯问题

平时我们使用MySQL时，通常每一个表都会有一个自增主键ID，每新增一条数据，ID值就会自增1。但在8.0之前版本的MySQL中，这个自增值会存在一个回溯的问题。

例如，在一个新表中插入三条主键为1、2、3的数据行，这时候用<font color=#555787>SHOW CREATE TABLE</font>命令查看该表的<font color=#555787>AUTO_INCREMENT</font>的值是4，这是没问题的。

然后把ID=3的数据行删掉，再次查询<font color=#555787>AUTO_INCREMENT</font>的值，依然是4，这也是没问题的。

但如果重启一下MySQL，这个值就会变回3，而不是4，发生了回溯。

这是因为AUTO_INCREMENT的值只存储于内存中，不会持久化到磁盘，每次启动数据库时，MySQL会通过计算<font color=#555787>max(auto_increment字段) + 1</font>，重新作为该表下一次的主键ID的自增值。这个问题直至MySQL 8.0才修复。
