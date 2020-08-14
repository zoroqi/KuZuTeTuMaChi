# go

`GOOS=linux GOARCH=amd64`交叉编译参数

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

