# grpc

## protobuf语法

1. 基本结构

```
syntax = "proto3";
message Request {
    int64 ...;
}

service Hello {
    rpc ...;
}

```

2. message

基本结构 `(repeated)? 类型 名称 = 序号;`. 可以嵌套和引用. `repeated`重复可以理解为数组.

```
message HelloRequest {
  int64 id = 1;
  string name = 2;
}

message HelloResponse {
    message Status {
        int64 id = 1;
        string msg = 2;
    }
    Status status = 1;
    repeated string name = 2;
}
```

3. service

接口定义, `rpc 名称(参数类型) returns (返回类型)`. #TODO 没查到可以支持多参数或多返回值的情况.

```
service HelloService {
  // 创建
  rpc Hello(HelloRequest) returns (HelloResponse);
```

## rpc

### java

* java需要下载[Protoc Gen GRPC Java](https://mvnrepository.com/artifact/io.grpc/protoc-gen-grpc-java/1.37.0)编译用文件

生成代码
```
protoc --plugin=protoc-gen-grpc-java=./gen/protoc-gen-grpc-java-1.37.0-osx-x86_64.exe --java_out=./java --grpc-java_out=./grpc hello.proto
```

客户端和服务端代码
```java
Server server = ServerBuilder
                .forPort(5000)
                .addService(new HelloService()) // 需要继承 HelloServiceImplBase. 这里根据你要求记录需要的代码


ManagedChannel channel = ManagedChannelBuilder.
                forAddress("localhost", 5000).build();
HelloService service = HelloServiceGrpc.newBlockingStub(channel);
service.Hello(..)
```

### golang

* golang需要安装`go install google.golang.org/protobuf/cmd/protoc-gen-go`和`go install google.golang.org/grpc/cmd/protoc-gen-go-grpc`

生产代码

```
protoc --go_out=./golang --go-grpc_out=./golang --proto_path=./proto/ proto/$pd
```

客户端和服务端代码
```golang
lis, _ := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
grpcServer := grpc.NewServer()
pb.RegisterHelloServiceServer(grpcServer, &helloService{})
grpcServer.Serve(lis)


conn, _ := grpc.Dial("localhost:5000")
defer conn.Close()
client := pb.NewHelloServiceClient(conn)
```

## 字段是否存在

java 和 golang 并没有判断这种方案. 在`ProtoReflect`里有相似的`Has`方法, 但判断依据是默认值进行判断的. 这个比较坑, 我想知道的是有没有值而不是默认值, 这导致我必须把要求不能传递默认值, 或用特殊字符替代.

java一个hasField的方法, 但判断方式和golang相同, 以默认值做判断.
```java
Map<String, Descriptors.FieldDescriptor> fields = HelloRequest.getDescriptor().getFields().stream().collect(Collectors.toMap(k -> k.getName(), k -> k));

request.hasField(fields.get("id"));
```
