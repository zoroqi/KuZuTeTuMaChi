# redis 配置

## redis 链接不上问题总结

1. 启动了`protected-mode`模式
    1. 关联参数
        ```
        protected-mode = no
        bind = 127.0.0.1
        requirepass pass
        ```
    2. 效果
        1. 关闭, 网络可以直接访问
        2. 打开, `bind ip`或者设置访问密码
