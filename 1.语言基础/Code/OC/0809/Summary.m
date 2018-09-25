
# 一、计数器的基本操作
retain  : +1
release : -1
retainCount : 获得计数器的值

# 二、set方法的内存管理

# set方法的实现
- (void)setCar:(Car *)car {
    if ( _car != car ) {
        [_car release];
        _car = [car retain];
    }
}

# dealloc方法的实现(不要直接调用dealloc)
- (void)dealloc {
    
    [_car release];
    [super dealloc];
}

# 三、@property参数

# OC对象类型
@property (nonatomic, retain) 类名 *属性名;
@property (nonatomic, retain) Car *car;
@property (nonatomic, retain) id car;

// retain过的属性必须在dealloc方法中release
- (void)dealloc {
    [_car release];
    [super dealloc];
}

# 非OC对象类型（int\float\enum\struct）
@property (nonatomic, assign) 类型名称 属性名;
@property (nonatomic, assign) int age;

# 四、autorelease

#1.系统自带的方法中，如果不包含alloc、new、copy，那么这些方法返回的对象都是已经autorelease过的
[NSString stringWithFormat:....];
[NSDate date];

#2.开发中经常写一些类方法快速创建一个autorelease的对象
