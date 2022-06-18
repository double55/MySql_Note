# 创建角色

```mysql
create role test_role;

grant all on win.* to test_role with grant option;
```

# 用户与角色绑定

```mysql
create user doubll@'%' identified by 'password123';

grant test_role to doubll@'%';
```

# 显示用户权限

```mysql
show grants for doubll@'%';

show grants for doubll@'%' using test_role;
```

# 回收用户权限

```mysql
revoke test_role from doubll@'%';
```

# 删除角色

```mysql
drop role test_role;
```
