# maven

`-Dmaven.repo.local=~/.m2/repository` 指定本地仓库路径, 减少访问远程仓库

`-Dmaven.test.skip=true` 不进行测试

指定编码, 编译中出现编码问题时候, 需要指定. Windows平台编码默认是GBK, 文件是UTF-8编译会不通过
```
<properties>
    <!-- 文件拷贝时的编码 -->
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    <!-- 编译时的编码 -->
    <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
</properties>
```

代理仓库
```
<repositories>
  <repository>
    <id>aliyun</id>
    <url>https://maven.aliyun.com/repository/public</url>
  </repository>
</repositories>


<pluginRepositories>
  <pluginRepository>
    <snapshots>
      <enabled>false</enabled>
    </snapshots>
    <id>aliyun</id>
    <name>repo</name>
    <url>https://maven.aliyun.com/repository/public</url>
  </pluginRepository>
</pluginRepositories>
```
