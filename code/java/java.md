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
- [jvm说明](http://jvm-options.tech.xebia.fr/)

`java -XX:+AggressiveOpts -XX:+UnlockDiagnosticVMOptions -XX:+UnlockExperimentalVMOptions -XX:+PrintFlagsFinal -version` 可以当前默认参数

`jinfo -flags pid` 可以查看启动参数

部分参数说明

| 参数名称和实例 | 中文描述 |
| --- | --- |
| -server                                              |  服务器模式 |
| -Xms2g                                               |  初始化堆内存大小 |
| -Xmx2g                                               |  堆内存最大值 |
| -Xmn256m                                             |  年轻代内存大小，整个JVM内存=年轻代 + 年老代 + 持久代 |
| -Xss256k                                             |  设置每个线程的堆栈大小 |
| -XX:PermSize=256m                                    |  持久代内存大小 |
| -XX:MaxPermSize=256m                                 |  最大持久代内存大小 |
| -XX:ReservedCodeCacheSize=256m                       |  代码缓存，存储已编译方法生成的本地代码 |
| -XX:+UseCodeCacheFlushing                            |  代码缓存满时，让JVM放弃一些编译代码 |
| -XX:+DisableExplicitGC                               |  忽略手动调用GC, System.gc()的调用就会变成一个空调用，完全不触发GC |
| -Xnoclassgc                                          |  禁用类的垃圾回收，性能会高一点 |
| -XX:+UseConcMarkSweepGC                              |  并发标记清除（CMS）收集器 |
| -XX:+CMSParallelRemarkEnabled                        |  启用并行标记，降低标记停顿 |
| -XX:+UseParNewGC                                     |  对年轻代采用多线程并行回收，这样收得快 |
| -XX:+UseCMSCompactAtFullCollection                   |  在FULL GC的时候对年老代的压缩，Full GC后会进行内存碎片整理，过程无法并发，空间碎片问题没有了，但提顿时间不得不变长了 |
| -XX:CMSFullGCsBeforeCompaction=3                     |  多少次Full GC 后压缩old generation一次 |
| -XX:LargePageSizeInBytes=128m                        |  内存页的大小 |
| -XX:+UseFastAccessorMethods                          |  原始类型的快速优化 |
| -XX:+UseCMSInitiatingOccupancyOnly                   |  使用设定的回收阈值(下面指定的70%)开始CMS收集,如果不指定,JVM仅在第一次使用设定值,后续则自动调整 |
| -XX:CMSInitiatingOccupancyFraction=70                |  使用cms作为垃圾回收使用70％后开始CMS收集 |
| -XX:SoftRefLRUPolicyMSPerMB=50                       |  Soft reference清除频率，默认存活1s,设置为0就是不用就清除 |
| -XX:+AlwaysPreTouch                                  |  强制操作系统把内存真正分配给JVM |
| -XX:+PrintClassHistogram                             |  按下Ctrl+Break后，打印类的信息 |
| -XX:+PrintGCDetails                                  |  输出GC详细日志 |
| -XX:+PrintGCTimeStamps                               |  输出GC的时间戳（以基准时间的形式） |
| -XX:+PrintHeapAtGC                                   |  在进行GC的前后打印出堆的信息 |
| -XX:+PrintGCApplicationConcurrentTime                |  输出GC之间运行了多少时间 |
| -XX:+PrintTenuringDistribution                       |  参数观察各个Age的对象总大小 |
| -XX:+PrintGCApplicationStoppedTime                   |  GC造成应用暂停的时间 |
| -Xloggc:../log/gc.log                                |  指定GC日志文件的输出路径 |
| -ea                                                  |  打开断言机制，jvm默认关闭 |
| -Dsun.io.useCanonCaches=false                        |  java_home没有配置，或配置错误会报异常 |
| -Dsun.awt.keepWorkingSetOnMinimize=true              |  可以让IDEA最小化到任务栏时依然保持以占有的内存，当你重新回到IDEA，能够被快速显示，而不是由灰白的界面逐渐显现整个界面，加快回复到原界面的速度 |
| -Djava.net.preferIPv4Stack=true                      |  让tomcat默认使用IPv4 |
| -Djdk.http.auth.tunneling.disabledSchemes=""         |  等于Basic会禁止proxy使用用户名密码这种鉴权方式,反之空就可以使用 |
| -Djsse.enablesSNIExtension=false                     |  SNI支持，默认开启，开启会造成ssl握手警告 |
| -XX:+HeapDumpOnOutOfMemoryError                      |  表示当JVM发生OOM时，自动生成DUMP文件 |
| -XX:HeapDumpPath=D:/data/log                         |  表示生成DUMP文件的路径，也可以指定文件名称，如果不指定文件名，默认为：java_<pid>_<date>_<time>_heapDump.hprof。 |
| -XX:-OmitStackTraceInFastThrow                       |  省略异常栈信息从而快速抛出,这个配置抛出这个异常非常快，不用额外分配内存，也不用爬栈,但是出问题看不到stack trace，不利于排查问题 |
| -Dfile.encoding=UTF-8 |  |
| -Duser.name=qhong |  |
| NewRatio：3                                          |  新生代与年老代的比例。比如为3，则新生代占堆的1/4，年老代占3/4。 |
| SurvivorRatio：8                                     |  新生代中调整eden区与survivor区的比例，默认为8，即eden区为80%的大小，两个survivor分别为10%的大小。 |
| PretenureSizeThreshold：10m                          |  晋升年老代的对象大小。默认为0，比如设为10M，则超过10M的对象将不在eden区分配，而直接进入年老代。 |
| MaxTenuringThreshold：15                             |  晋升老年代的最大年龄。默认为15，比如设为10，则对象在10次普通GC后将会被放入年老代。 |
| -XX:MaxTenuringThreshold=0                           |  垃圾最大年龄，如果设置为0的话,则年轻代对象不经过Survivor区,直接进入年老代，该参数只有在串行GC时才有效 |
| -XX:+HeapDumpBeforeFullGC                            |  当JVM 执行 FullGC 前执行 dump |
| -XX:+HeapDumpAfterFullGC                             |  当JVM 执行 FullGC 后执行 dump |
| -XX:+HeapDumpOnCtrlBreak                             |  交互式获取dump。在控制台按下快捷键Ctrl + Break时，JVM就会转存一下堆快照 |
| -XX:+PrintGC                                         |  输出GC日志 |
| -verbose:gc                                          |  同PrintGC,输出GC日志 |
| -XX:+PrintGCDateStamps                               |  输出GC的时间戳（以日期的形式，如 2013-05-04T21:53:59.234+0800） |
| -XX:+PrintFlagsInitial                               |  显示所有可设置参数及默认值 |
| -enablesystemassertions                              |  激活系统类的断言 |
| -esa                                                 | 激活系统类的断言 |
| -disablesystemassertions                             |  关闭系统类的断言 |
| -dsa                                                 | 关闭系统类的断言 |
| -XX:+ScavengeBeforeFullGC                            |  FullGC前回收年轻代内存，默认开启 |
| -XX:+CMSScavengeBeforeRemark                         |  CMS remark前回收年轻代内存 |
| -XX:+CMSIncrementalMode                              |  采用增量式的标记方式，减少标记时应用停顿时间 |
| -XX:+CMSClassUnloadingEnabled                        |  相对于并行收集器，CMS收集器默认不会对永久代进行垃圾回收。如果希望回收，就使用该标志，注意，即使没有设置这个标志，一旦永久代耗尽空间也会尝试进行垃圾回收，但是收集不会是并行的，而再一次进行Full GC |
| -XX:+CMSConcurrentMTEnabled                          |  当该标志被启用时，并发的CMS阶段将以多线程执行(因此，多个GC线程会与所有的应用程序线程并行工作)。该标志已经默认开启，如果顺序执行更好，这取决于所使用的硬件，多线程执行可以通过-XX：-CMSConcurremntMTEnabled禁用。 |

- [中文来源](https://www.cnblogs.com/hongdada/p/10277782.html)
