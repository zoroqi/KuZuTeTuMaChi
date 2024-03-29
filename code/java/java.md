# java

## synchroized
* `synchronized`**不可被中断**, 线程因`synchronized`变为`BLOCKED`后可以完全锁住, 导致线程泄露. `synchronized`内代码一定要可以执行完成, 不要死循环等状态.
    * `hbase-shaded-client:1.2.0`的`ConnectionManager`中存在一把全局锁,`locateMeta`方法会加锁, 加锁后会查询`zk`中`meta`信息.
    * 在`zk`挂了的情况下, 会反复查询, 这中间涉及到了`sleep`操作, 要外部代码没有进行`interrupt`的话, 可能导致大面积的死锁.

## jvm启动参数

java启动参数共分为三类；
其一是 **标准参数**（\-），所有的JVM实现都必须实现这些参数的功能，而且向后兼容；
其二是 **非标准参数**（\-X），默认jvm实现这些参数的功能，但是并不保证所有jvm实现都满足，且不保证向后兼容；
其三是 **非Stable参数**（\-XX），此类参数各个jvm实现会有所不同，将来可能会随时取消，需要慎重使用；


- [perfma](https://www.perfma.com/) 寒泉子大大关于jvm优化公司, 可以找到jvm参数解释
- [官方参考](https://www.oracle.com/java/technologies/javase/vmoptions-jsp.html)

**`java -XX:+AggressiveOpts -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+PrintFlagsFinal -version` 可以当前默认参数**

**`jinfo -flags pid` 可以查看启动参数**

**`jcmd pid VM.flags 同样也可以查看启动参数`** 添加`-all`参数可以获得全量参数情况.

**[部分参数列表含义-中文](./jvm参数.md)**

### jvm参数分享网站

* [chriswhocodes](https://chriswhocodes.com/hotspot_options_jdk11.html)

* [jvm参数说明](http://jvm-options.tech.xebia.fr/)


### 源码

### gc相关

可以在代码中搜索`globals.hpp`文件查看对应说明, 里边有相应的参数和说明. 一下截取的是jdk15的源码\(15已经移除 CMS 算法\)

```
./src/hotspot/share/c1/c1_globals.hpp
./src/hotspot/share/compiler/compiler_globals.hpp
./src/hotspot/share/gc/epsilon/epsilon_globals.hpp
./src/hotspot/share/gc/g1/g1_globals.hpp
./src/hotspot/share/gc/parallel/parallel_globals.hpp
./src/hotspot/share/gc/serial/serial_globals.hpp
./src/hotspot/share/gc/shared/gc_globals.hpp
./src/hotspot/share/gc/shenandoah/shenandoah_globals.hpp
./src/hotspot/share/gc/z/z_globals.hpp
./src/hotspot/share/jvmci/jvmci_globals.hpp
./src/hotspot/share/opto/c2_globals.hpp
./src/hotspot/share/runtime/globals.hpp
```

## 查看繁忙线程

[show-busy-java-threads](./show-busy-java-threads) 源代码来源于 [oldratlee/useful-scripts](github.com/oldratlee/useful-script)

## jdk 命令

### jcmd

1.7 推出的新命令.

* [13 jcmd 说明](https://docs.oracle.com/en/java/javase/13/docs/specs/man/jcmd.html)
* [17 jcmd 说明](https://docs.oracle.com/en/java/javase/17/docs/specs/man/jcmd.html)

简单说明

`jcmd [pid | main-class] command... | PerfCounter.print | -f filename`

几个常用的 command 命令
其中command的说明如下：

| 命令 | 说明 |
| --- | --- |
| help | 打印帮助信息，示例：jcmd help  |
| ManagementAgent.stop | 停止JMX Agent |
| ManagementAgent.start\_local | 开启本地JMX Agent |
| ManagementAgent.start | 开启JMX Agent |
| Thread.print | 参数-l打印java.util.concurrent锁信息，相当于：jstack |
| PerfCounter.print | 相当于：jstat -J-Djstat.showUnsupported=true -snap |
| GC.class\_histogram | 相当于：jmap -histo |
| GC.heap\_dump | 相当于：jmap -dump:format=b,file=xxx.bin |
| GC.run\_finalization | 相当于：System.runFinalization() |
| GC.run | 相当于：System.gc() |
| VM.uptime | 参数-date打印当前时间，VM启动到现在的时候，以秒为单位显示 |
| VM.flags | 参数-all输出全部，相当于：jinfo -flags , jinfo -flag |
| VM.system\_properties | 相当于：jinfo -sysprops |
| VM.command\_line | 相当于：jinfo -sysprops |


