# mysql

### 建库

`create database name;`

指定字符集
```
CREATE DATABASE  `name` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

### 用户创建和授权

创建

`CREATE USER 'username'@'host' IDENTIFIED BY 'pw';`

- username: 用户名
- host: 访问限制, 只有本地用户访问可以使用`localhost`, 所有ip都可以方位可以使用`%`通配符
- pw: 密码, 可以为空

授权

`GRANT privileges ON databasename.tablename TO 'username'@'host'`

- privileges: SELECT，INSERT，UPDATE等，如果要授予所的权限则使用ALL
- databasename: 库名
- tablename: 表名, 可以使用`*`作为通配符
- username: 用户名
- host: 访问限制

取消授权
REVOKE privilege ON databasename.tablename FROM 'username'@'host';

修改密码

`SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');`

删除密码

`DROP USER 'username'@'host';`

更多功能的授权, 需要 root 权限

GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user' IDENTIFIED BY 'pw';

## 查看配置文件

`show variables;`

查看具体配置: `show variables like 'log_bin';`

也可以使用 `select @@log_bin;`. 但和上边的输出结果形式可能不同, 一个是 ON, 一个是 1
