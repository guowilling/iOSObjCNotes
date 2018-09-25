一、选择结构
if
结构
if (条件) {

} else if (条件2) {

} else if (条件3) {

} else {
    
}

特点
    同一时刻，只有一个大括号里面的代码会被执行

switch
结构
switch (数值)
{
    case 数值1:
        break;
    
    case 数值2:
        break;
    
    case 数值3:
        break;
    
    default:
        break;
}
特点
    默认只有一个case后面的代码会被执行
    如果一个case后面没有break，而且这个case成立，就会执行后面所有case中的语句，遇到break为止
    如果要在case后面定义新的变量，必须使用大括号{}

二、循环结构
while
特点：如果开始条件不成立，不会执行循环体

do while
特点：不管开始条件是否成立，至少会执行一次循环体

for

1> 优先使用for循环
2> 再考虑while
3> 再考虑do while