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
