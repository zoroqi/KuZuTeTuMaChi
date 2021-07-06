# jvm参数


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
| -XX:G1HeapRegionSize=n | 设置的 G1 区域的大小。值是 2 的幂，范围是 1 MB 到 32 MB 之间。目标是根据最小的 Java 堆大小划分出约 2048 个区域。 |
| -XX:MaxGCPauseMillis=200 | 为所需的最长暂停时间设置目标值。默认值是 200 毫秒。指定的值不适用于您的堆大小。 |
| -XX:G1NewSizePercent=5 | 设置要用作年轻代大小最小值的堆百分比。默认值是 Java 堆的 5%。这是一个实验性的标志。有关示例，请参见“如何解锁实验性虚拟机标志”。此设置取代了 -XX:DefaultMinNewGenPercent 设置。Java HotSpot VM build 23 中没有此设置。 |
| -XX:G1MaxNewSizePercent=60 | 设置要用作年轻代大小最大值的堆大小百分比。默认值是 Java 堆的 60%。这是一个实验性的标志。有关示例，请参见“如何解锁实验性虚拟机标志”。此设置取代了 -XX:DefaultMaxNewGenPercent 设置。Java HotSpot VM build 23 中没有此设置。 |
| -XX:ParallelGCThreads=n | 设置 STW 工作线程数的值。将 n 的值设置为逻辑处理器的数量。n 的值与逻辑处理器的数量相同，最多为 8。如果逻辑处理器不止八个，则将 n 的值设置为逻辑处理器数的 5/8 左右。这适用于大多数情况，除非是较大的 SPARC 系统，其中 n 的值可以是逻辑处理器数的 5/16 左右。 |
| -XX:ConcGCThreads=n | 设置并行标记的线程数。将 n 设置为并行垃圾回收线程数 (ParallelGCThreads) 的 1/4 左右。 |
| -XX:InitiatingHeapOccupancyPercent=45 | 设置触发标记周期的 Java 堆占用率阈值。默认占用率是整个 Java 堆的 45%。 |
| -XX:G1MixedGCLiveThresholdPercent=65 | 为混合垃圾回收周期中要包括的旧区域设置占用率阈值。默认占用率为 65%。这是一个实验性的标志。有关示例，请参见“如何解锁实验性虚拟机标志”。此设置取代了 -XX:G1OldCSetRegionLiveThresholdPercent 设置。Java HotSpot VM build 23 中没有此设置。 |
| -XX:G1HeapWastePercent=10 | 设置您愿意浪费的堆百分比。如果可回收百分比小于堆废物百分比，Java HotSpot VM 不会启动混合垃圾回收周期。默认值是 10%。Java HotSpot VM build 23 中没有此设置。 |
| -XX:G1MixedGCCountTarget=8 | 设置标记周期完成后，对存活数据上限为 G1MixedGCLIveThresholdPercent 的旧区域执行混合垃圾回收的目标次数。默认值是 8 次混合垃圾回收。混合回收的目标是要控制在此目标次数以内。Java HotSpot VM build 23 中没有此设置。 |
| -XX:G1OldCSetRegionThresholdPercent=10 | 设置混合垃圾回收期间要回收的最大旧区域数。默认值是 Java 堆的 10%。Java HotSpot VM build 23 中没有此设置。 |
| -XX:G1ReservePercent=10 | 设置作为空闲空间的预留内存百分比，以降低目标空间溢出的风险。默认值是 10%。增加或减少百分比时，请确保对总的 Java 堆调整相同的量。Java HotSpot VM build 23 中没有此设置。 |


- [中文来源](https://www.cnblogs.com/hongdada/p/10277782.html)
- [g1gc部分参数](https://www.oracle.com/cn/technical-resources/articles/java/g1gc.html)
