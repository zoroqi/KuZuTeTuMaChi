# prometheus

## 简单介绍

提供简单的业务和技术统计方案, 内部自行埋点进行统计, 方便快捷. 主要指标

四种指标
1. Counter 计数器, 样本数据单调递增的指标
    * 常用查询函数
        * rate
        * sum
        * topk
2. Guage 仪表盘, 样本数据可以任意变化的指标, 可增可减
    * 常用查询函数
        * dalta
        * predict_linear
3. Histogram 直方图, 分段统计, 一段时间范围内对数据进行采样(通常是请求持续时间或响应大小等), 并将其计入可配置的存储桶(bucket)中,后续可通过指定区间筛选样本, 也可以统计样本总数,最后一般将数据展示为直方图. 提供, sum, count, bucket三部分统计信息
    * 常用查询函数
        * histogram_quantile
        * sum
        * rate
4. Summary 摘要, 与 Histogram 类型类似, 它直接存储了分位数.
    * 常用查询函数
        * sum
        * rate

查询语句支持加减乘除

## 相关git和参考

1. [prometheus-git](https://github.com/prometheus/prometheus)
2. [prometheus-go-client](https://github.com/prometheus/client_golang)
3. [prometheus-java-client](https://github.com/prometheus/client_java)
4. [prometheus-redis-exporter](https://github.com/oliver006/redis_exporter)
5. [prometheus-中文文档](https://fuckcloudnative.io/prometheus/)
    * [prometheus-中文文档-git](https://github.com/yangchuansheng/prometheus-handbook)

## 相关demo

**以基础使用为主, 需要深入的话继续找文档和看源码**

### prometheus部署

开包即用, 下载对应平台包, 让后`./prometheus`就好.

常用参数
```
--web.listen-address :9090 // 指定端口
--storage.tsdb.retention.time 90d // 保存日期
```

配置文件编写prometheus.yml

```yml
# 基本可用
- job_name: first_job
  scrape_interval: 20s
  scrape_timeout: 20s
  metrics_path: /metrics # 接口名称
  scheme: http           # 接口方式
  static_configs:
  - targets:             # 目标地址
    - 127.0.0.1:8080
    - 127.0.0.2:8080
    - 127.0.0.3:8080
```

### go-client接入

依赖`go get -u github.com/prometheus/client_golang`

```golang
// 新的register
reg := prometheus.NewRegistry()

// 统计指标
counter := prometheus.NewCounterVec(prometheus.CounterOpts{
        NameSpace: "space",
        Name: "name",
        Help: "help",
    }, []string{"label1", "label2"})

// 两种注册方式, 根据情况处理
reg.MustRegister(counter) // 失败会painc
reg.Register(counter) // 失败返回error

// 执行
// 自动匹配label, 数量需要匹配
counter.WithLabelValues("one","two").Inc()
// label name必须声明的相同, 且数量匹配
counter.With(prometheus.Labels{"label1": "one", "label2": "two"}).Inc()


// 暴露接口
// 生成http.handler.
promhttp.HandlerFor(reg, promhttp.HandlerOpts{})
// 这里和别的web框架结合可能需要进行调整
promhttp.HandlerFor(reg, promhttp.HandlerOpts{}).ServeHTTP(w,r)

// 没有找到文本输出

```

### java-client接入

基础依赖, 根据需求可以扩充
```xml
<dependency>
    <groupId>io.prometheus</groupId>
    <artifactId>simpleclient</artifactId>
    <version>${version}</version>
</dependency>
```

接口暴露方式, 印象中是从spring插件中找到的. 使用其他框架可以, 可以仿照写一个.

```java
import io.prometheus.client.CollectorRegistry;
import io.prometheus.client.exporter.common.TextFormat;

@RequestMapping("/metrics") // 随意, 这个要和prometheus配置相关
@ResponseBody
public ResponseEntity prometheus() {
    String result = writeRegistry(Collections.emptySet());
    return (ResponseEntity.ok().header("Content-Type",
            new String[]{"text/plain; version=0.0.4; charset=utf-8"})).body(result);
}

// 可以直接生成文本,
private String writeRegistry(Set<String> metricsToInclude) {
    try {
        Writer writer = new StringWriter();
        // register自己定义
        TextFormat.write004(writer, register.filteredMetricFamilySamples(metricsToInclude));
        return writer.toString();
    } catch (Exception var3) {
        throw new RuntimeException("Writing metrics failed", var3);
    }
}
```

基本使用
```java
CollectorRegistry reg = new CollectorRegistry(true);
// 统计指标
Histogram histogram = Histogram.build().
        name("name").
        help("help").
        labelNames("label1", "label2").
        linearBuckets(0, 50, 20).
        register(reg);

histogram.labels("one","two").observe(100.0);
```

### redis-exporter部署



