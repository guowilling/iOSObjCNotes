
## HTTP 请求的基本要素

* URL: 客户端请求那台服务器的那个资源
* 请求参数: 客户端发送给服务器的数据(用户名和密码等)
* 返回结果: 服务器返回给客户端的数据(JSON或XML等)

## 移动客户端 HTTP 请求的步骤

* 确定请求地址: "请求URL" + "?" + "请求参数"
	* 请求参数的格式: 参数名=参数值
	* 多个请求参数之间用 '&' 隔开: 参数名1=参数值1&参数名2=参数值2
	* http://localhost:8080/MJServer/login?username=123&pwd=456
* 发送请求
* 解析服务器返回的数据

## JSON 解析

* NSJSONSerialization

````objc
// JSON 数据(NSData) --> ObjC Foundation 对象(NSDictionary、NSArray、NSString、NSNumber...)
+ (id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;
````

* JSON 解析规律

| JSON | Foundation |
|:-----:|:-----------------:|
| { }   | NSDictionary @{ } |
| [ ]   | NSArray  @[ ]     |
| " "   | NSString @" "     |
| 10    | NSNumber @10      |

## XML 解析

````
1.语法
<?xml version="1.0" encoding="UTF-8" ?>
<videos>
    <video name="小黄人 第01部" length="10"/>
    <video name="小黄人 第01部" length="10"/>
</videos>

1.1.文档声明:<?xml version="1.0" encoding="UTF-8" ?>
1.2.元素:<videos></videos>
1.3.属性:name="小黄人 第01部" length="10"
* videos、video称为元素（节点）
* name、length称为元素的属性
* video元素是videos元素的子元素
````  
````
2.解析
2.1.SAX解析：逐个元素解析，适合大文件
* NSXMLParser
2.2.DOM解析：直接加载整个XML文档，适合小文件
* GDataXML
````

## HTTP 的请求方法
  
* GET    
	* 特点：所有请求参数都拼接在 url 后面
	* 缺点：
		* url 中暴露了请求信息不安全
		* url 的大小有限制通常不超过1kb
	* 使用场合
		* 仅仅向服务器索要数据
	* 如何发送 GET 请求
		* 默认就是 GET 请求   
  
````objc
NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
NSURLRequest *request = [NSURLRequest requestWithURL:url];
[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
}];
````

* POST    
	* 特点
		* 所有请求参数放在请求体 HTTPBody 
		* 理论上发给服务器数据的大小没有限制

	* 使用场合
		* 除非单纯的索要数据其他都用 POST 请求
		* 数据安全

	* 如何发送 POST 请求

````objc
NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/login"];
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
request.HTTPMethod = @"POST";
NSString *param = [NSString stringWithFormat:@"username=%@&pwd=%@", usernameText, pwdText];
request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
}];
````

## NSMutableURLRequest 的常用方法

````objc
// 设置请求方法   
request.HTTPMethod = @"POST";   

// 设置超时时间   
request.timeoutInterval = 5;
````

## URL中文转码

* URL 中如果有中文需要进行转码    

````objc
NSString *urlStr = [NSString stringWithFormat:@"http://localhost/login?username=喝喝&pwd=123"];
urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//urlStr == @"http://localhost/login?username=喝喝&pwd=123"
//urlStr == @"http://localhost/login?username=%E5%96%9D%E5%96%9D&pwd=123"
````

## 数据安全

* 网络传输
	* 加密对象
		* 隐私数据
		* 密码
		* 银行信息
	* 加密方案
		* 使用 POST 请求
		* 使用加密算法
	* 加密增强加大破解难度
		* 2次 MD5: MD5(MD5($pass))
		* 先撒盐再 MD5: MD5($pass.$salt)

* 本地存储
	* 加密对象
		* 单击游戏数据

* 代码安全
	* 现在已经有工具和技术能反编译出源代码
		* 逆向工程
		* 反编译出来的是纯C语言可读性不高, 
		* 但能知道源代码里面用的是哪些框架
	* 参考书籍
		* iOS 逆向工程
	* 解决方案
		* 发布之前对代码进行混淆
		

````objc
// 混淆之前
@interface HMPerson :NSObject

- (void)run;
- (void)eat;
- 
@end

// 混淆之后
@interface A :NSObject

- (void)a;
- (void)b;
- 
@end
````

## 文件的 MIMEType

* 百度搜索

* 查找服务器下面的xml文件
apache-tomcat-6.0.41\conf\web.xml

* 加载文件通过返回的 Response 获得

````objc 
- (NSString *)MIMEType:(NSURL *)URL 
{
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}
````

* 通过 C 语言函数

````objc
+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
	if (![[NSFileManager alloc] init] fileExistsAtPath:path]) {
		return nil;
	}
	CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
	if (!MIMEType) {
		return @"application/octet-stream";
	}
    return NSMakeCollectable(MIMEType);
}
````

## NSURLSession
* 使用步骤
	* 获得 NSURLSession 对象
	* 利用 NSURLSession 对象创建对应的任务 task
	* 开始任务 [task resume]

* 如何获得 NSURLSession 对象

````objc
[NSURLSession sharedSession]  // 无代理
self.session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];  //有代理
````

* 任务类型

NSURLSessionDataTask: 一般用于非文件下载的GET \ POST请求

````objc
NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
NSURLSessionDataTask *task = [self.session dataTaskWithURL:url];
NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
}];
````

NSURLSessionDownloadTask: 一般用于文件下载, 自动边下载边写入到沙盒的 tmp 文件夹中，不耗费内存，容易实现断点下载

````objc
NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];
NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url];
NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    
}];
````

# 文件解压缩

* 第三方框架: SSZipArchive (依赖的动态库: libz.dylib)

* 压缩

````objc
// 方法1
/**
 * zipFile   :  压缩到什么地方
 * directory :  要压缩的文件夹路径
 */
[SSZipArchive createZipFileAtPath:zipFile withContentsOfDirectory:directory];

// 方法2
/**
 * zipFile   :  压缩到什么地方
 * files     :  要压缩的文件的路径(数组)
 * files == @[@"/Users/apple/Destop/1.png", @"/Users/apple/Destop/2.txt"]
 */
[SSZipArchive createZipFileAtPath:zipFile withFilesAtPaths:files];
````

* 解压缩

````objc
/**
 * zipFile   :  要解压的zip文件的路径
 * dest      :  解压到什么地方
 */
[SSZipArchive unzipFileAtPath:zipFile toDestination:dest];
````