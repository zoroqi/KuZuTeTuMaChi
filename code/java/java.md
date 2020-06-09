# java

一些没用的注意点.

1. `synchronized`**不可被中断**, 线程因`synchronized`变为`BLOCKED`后可以完全锁住, 导致线程泄露. `synchronized`内代码一定要可以执行完成, 不要死循环等状态.
    * `hbase-shaded-client:1.2.0`的`ConnectionManager`中存在一把全局锁,`locateMeta`方法会加锁, 加锁后会查询`zk`中`meta`信息.
    * 在`zk`挂了的情况下, 会反复查询, 这中间涉及到了`sleep`操作, 要外部代码没有进行`interrupt`的话, 可能导致大面积的死锁.
