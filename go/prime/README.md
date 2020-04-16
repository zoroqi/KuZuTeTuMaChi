# prime

打印素数

1. 使用简单的[埃拉托斯特尼筛法](https://zh.wikipedia.org/zh-hans/%E5%9F%83%E6%8B%89%E6%89%98%E6%96%AF%E7%89%B9%E5%B0%BC%E7%AD%9B%E6%B3%95)
2. 使用goroutine进行每一层筛子的实现. 无法正常丢给下一层的筛子
3. 测试代码`go test -v prime_test.go prime.go`
