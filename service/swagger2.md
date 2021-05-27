# swagger

快速生成简单接口文档.

## spring

spring 接入 mvn 依赖

```xml
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.9.2</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.9.2</version>
</dependency>
```

代码引入

```java
@SpringBootApplication
@EnableSwagger2
public class AppApplication extends WebMvcConfigurerAdapter {

    @Bean
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build();
    }

    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //enabling swagger-ui part for visual documentation
        registry.addResourceHandler("swagger-ui.html").addResourceLocations("classpath:/META-INF/resources/");
        registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
    }
    public static void main(String[] args) throws IOException, InterruptedException {
        SpringApplication.run(AppApplication.class, args);
    }
}
```

**测试链接 `/v2/api-docs`和`/swagger-ui.html`**

特别声明: 代码中不要出现重名类, 会出现覆盖现象. \(我是用内部类作为接口参数, 个多Controller中存在重名类, 最后出现了覆盖\)
