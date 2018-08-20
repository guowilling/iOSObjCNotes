**Tips: 不要同时开太多线程，耗时操作放到子线程执行!**

## 线程基本概念

> a.主线程：UI 线程，显示、刷新 UI 界面，处理 UI 控件的事件   
> b.子线程：后台线程，异步线程

## 一、NSThread

* 1.1.创建和启动线程的三种方式

```` objc
// 先创建后启动
NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
[thread start];

// 创建完自动启动
[NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];

// 隐式创建自动启动
[self performSelectorInBackground:@selector(run) withObject:nil];

````

* 1.2.常见用法

```` objc
+ (NSThread *)currentThread;
+ (NSThread *)mainThread;

// 睡眠、暂停当前线程
+ (void)sleepUntilDate:(NSDate *)date;
+ (void)sleepForTimeInterval:(NSTimeInterval)ti;

// 线程的名字
@property (copy) NSString *name
````

## 二、线程同步

> 1.本质：防止多个线程访问同一个资源造成数据安全问题   
> 2.实现：加一个互斥锁(同步锁)

```` objc
@synchronized(self) {
	// code here
}

````

## 三、GCD(Grand Central Dispatch)

* 1.队列和任务 
	* 1.1.任务: 需要执行的操作 block
	* 1.2.队列: 存放任务
	* 1.2.1.全局并发队列(系统提供)

		```` objc
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		````

	* 1.2.2.串行队列(手动创建)

		```` objc
		dispatch_queue_t queue = dispatch_queue_create("aQueue”, NULL);
		````

	* 1.2.3.主队列(主线程中执行)           
		
		```` objc
		dispatch_queue_t queue = dispatch_get_main_queue();
		````

* 2.执行任务的函数
	* dispatch_sync.. 同步执行, 不具备开启新线程的能力  
	* dispatch_async  异步执行, 具备开启新线程的能力

* 3.常用组合
	* dispatch_async… + 并发队列   
	* dispatch_async… + 串行队列

* 4.线程间通信

```` objc
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // 子线程执行耗时操作...
      dispatch_async(dispatch_get_main_queue(), ^{
        // 主线程刷新 UI...
        });
});
````

* 5.GCD的所有API都在 libdispatch.dylib, Xcode 会自动导入主头文件: #import \<dispatch/dispatch.h>

* 6.延迟执行

```` objc
// perform..
[self performSelector:@selector(download:) withObject:@"http://555.jpg" afterDelay:3];

// dispatch_after..
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), queue, ^{
    // 延迟执行的代码...
});
````

* 7.只执行一次

```` objc
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    // 程序运行过程中只执行一次的代码...
});
````

* 8.队列组: dispatch\_group\_async \ dispatch\_group\_notify

## 四、单例模式

```` objc
// 懒汉式 GCD 实现
@interface HMDataTool : NSObject

+ (instancetype)sharedDataTool;

@end

#import "HMDataTool.h"

@implementation HMDataTool

static id instace;

+ (id)allocWithZone:(struct _NSZone *)zone {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [super allocWithZone:zone];
    });
    return instace;
}

+ (instancetype)sharedDataTool {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return instace;
}

- (id)copyWithZone:(NSZone *)zone {

    return instace;
}

@end

````

## 五、NSOperation

**NSOperation 是一个抽象的基类, 通常使用子类 NSBlockOperation 或 NSOperationQueue**

* 1.队列的类型

```` objc
// 主队列: 添加到主队列中的操作在主线程中执行
[NSOperationQueue mainQueue]    

// 非主队列: 添加到非主队列中的操作在子线程中执行
[[NSOperationQueue alloc] init] 
````

* 2.添加任务到队列

```` objc
- (void)addOperation:(NSOperation *)operation;   

- (void)addOperationWithBlock:(void(^)(void))block;
````


* 3.常见用法

```` objc
// 最大并发数
@property NSInteger maxConcurrentOperationCount;

// 取消所有操作
- (void)cancelAllOperations;

// 暂停所有操作
[aQueue setSuspended:YES];

// 恢复所有操作
[aQueue setSuspended:NO];
````

* 4.设置依赖

```` objc
// NSOperation 之间可以设置依赖关系来保证执行顺序

// 操作 B 依赖操作 A, A 执行完毕之后才会执行 B
[operationB addDependency:operationA];

// 注意: 1.不能相互依赖; 2.可以在不同队列的操作之间设置依赖关系.
````

* 5.线程之间的通信

```` objc
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
[queue addOperationWithBlock:^{ 
    // 异步线程执行耗时操作...
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // 主线程刷新界面...
    }];
}];
````

## 六、从其他线程回到主线程的三种方式

```` objc
// perform…
[self performSelectorOnMainThread:(SEL) withObject:(id) waitUntilDone:(BOOL)];

// GCD
dispatch_async(dispatch_get_main_queue(), ^{
	// code here
});

// NSOperationQueue
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
	// code here
}];
````

## 七、判断编译器的环境
```` objc
#if _has_feature(objc_arc)
// ARC 环境
#else
// MRC 环境
#endif
````

## 八、类的初始化方法
```` objc
// 绝对只执行一次, 启动程序加载类到内存时调用.
+ (void)load

// 一般只执行一次, 第一次使用到类时调用(比如调用 alloc 等方法).
+ (void)initialize
````
