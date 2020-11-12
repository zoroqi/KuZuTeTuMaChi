# go

`GOOS=linux GOARCH=amd64 go build`交叉编译参数

`GOOS`编译系统, `GOARCH`指令集, `GOARM`arm版本

GOOS | GOARCH  |  OS version
--- | --- | ---
linux | 386 / amd64 / arm  | >= Linux 2.6
darwin | 386 / amd64 | OS X (Snow Leopard + Lion)
freebsd | 386 / amd64 | >= FreeBSD 7 |
windows | 386 / amd64 | >= Windows 2000 |
js(WebAssembly) | wasm | |

`go mod graph` 查看依赖关系

`go list -m all` 查看准确依赖版本

`go mod why -m all` 查看依赖路径

`go mod why -m github.com/xxx/xxx` 指定package依赖路径

`go build ldflags " -X main.Version=1.0.0"`可以添加一些固定参数. 对应的代码需要存在变量


### 测试

`go test` 执行所有测试用例

`-run` 执行指定的测试代码, 支持通配符

#### 基准测试
`-bench` 执行指定的`Benchmark`测试代码, 支持通配符

`-count` 执行次数

`-cpu` 设置核数, 可以减少环境影响

`-benchmem` 输出内存使用情况

#### 测试工具

`benchstat`基准测试工具统计分析

### 代码辅助工具
`GOSSAFUNC=func_name go build` 生成代码编译过程内容, 从代码到汇编的转换过程

### 内存分配

查看分配内存次数, 是次数不是内存大小
```
// runs >= 1, 代表执行次数+1. runs==1, 共执行2次, 一次基本运行, 第二次之后进行统计.
// f内尽量不要有日志或Print等操作, 这些会额外申请内存, 影响结果.
testing.AllocsPerRun(runs,func f())
```

### 运算优先级

左右移优先级高于加减法, java和c相反左右移是高的.

```
高  优先级     运算符
|    7        ^ !
|    6        * / % << >> & &^
|    5        + - | ^
|    4        == != < <= >= >
|    3        <-
v    2        &&
低   1        ||
```
