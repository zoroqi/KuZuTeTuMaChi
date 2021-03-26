# java工具

## 依赖分析工具

#### [spoiklin](http://edmundkirwan.com/)

运行`java -jar spoiklin.jar`. 提供`包`, `类`, `方法`间依赖关系. 可以可视化的观察依赖关系. 特别声明, 方法级别的是没有办法看的, 工程稍微大点就及其混乱了.

工具对spring这种注解进行串联的代码可能分析效果不好. 针对1.8可能也不会太友好, 内部类太多.


## 反编译

#### [jd-gui](https://github.com/java-decompiler/jd-gui)

至少是现在发现的比较好用的反编译工具`java -jar jd-gui.jar`运行, 之后就是鼠标操作了.
