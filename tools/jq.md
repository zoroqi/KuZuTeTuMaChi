# jq

安装: `brew install jq`

官网: [jq](https://stedolan.github.io/jq), [git](https://github.com/stedolan/jq) [wiki](https://github.com/stedolan/jq/wiki)

很方便的一个命令行工具, 后端调试可以方便做大json的分析和查询. 简单帮助 `jq --help`

常用操作
```
curl 'xxx' | jq
cat xxx.json | jq
echo "{xxx}" | jq
```

---

个人常用参数
1. -c 行输出
2. -r 将字符串提取

支持管道过滤和自定义生成新的json操作, 这里有详细解释 [jq Language Description
](https://github.com/stedolan/jq/wiki/jq-Language-Description)

个人常用路径写法, 我很少用主动生成的.

* `.data[]` 打印数组`data`
* `.data[].xxx` 打印数组所有对象的`xxx`元素
* `.data[0].xxx` 打印索引0对象的`xxx`元素
* `.data[] | select(.xxx == "abc")` 打印所有数组中`xxx`元素等于`abc`的对象

