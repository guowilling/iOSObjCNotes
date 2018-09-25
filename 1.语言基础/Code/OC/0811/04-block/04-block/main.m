//
//  main.m
//  04-block
//
//  Created by apple on 13-8-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef int (*SumP)(int, int);

typedef int (^MyBlock)(int, int);

int main()
{
    // int (*p)(int, int) = sum;
    // int (*p2)(int, int) = sum;
    // SumP p = sum;
    // SumP p2 = sum;
    
    /**
    int (^sumBlock)(int, int);
    
    sumBlock = ^(int a, int b) {
        return a + b;
    };
    
    int (^minusBlock)(int, int) = ^(int a, int b) {
        return a - b;
    };
     */
    
    MyBlock sumBlock;
    sumBlock = ^(int a, int b) {
        return a + b;
    };
    
    MyBlock minusBlock = ^(int a, int b) {
        return a - b;
    };
    
    MyBlock multiplyBlock = ^(int a, int b) {
        return a * b;
    };
    
    NSLog(@"%d - %d - %d", multiplyBlock(2, 4),  sumBlock(10 , 9), minusBlock(10, 8));
     
    return 0;
}

void test3()
{
    int a = 10;
    __block int b = 20;
    
    void (^block)();
    
    block = ^{
        // block内部可以访问外面的变量
        // NSLog(@"a = %d", a);
        
        // 默认block内部不能修改外面的局部变量
        // a = 20;
        
        // 局部变量加上__block关键字, block内部可以修改
        b = 25;
    };
    
    block();
}

int sum(int a, int b)
{
    return a + b;
}
// 有返回值、有形参的block
void test2()
{
    
    // 指向函数的指针
//    int (*p)(int, int) = sum;
//    int d = p(10, 12);
//    NSLog(@"%d", d);
    
    int (^sumblock)(int, int) = ^(int a, int b){
        return a + b;
    };
    int c = sumblock(10, 11);
    NSLog(@"%d", c);
    
    void (^lineBlock)(int) =  ^(int n)
    {
        for (int i = 0; i<n; i++) {
            NSLog(@"----------------");
        }
    };
    lineBlock(5);

}

// 没有返回值、没有形参的block
void test()
{
    //inlineBlock
//    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };
    
   
    /**
    // 定义block变量
    void (^myblock)() = ^(){
        NSLog(@"----------------");
        NSLog(@"----------------");
    };*/
    
    // 没有形参可以省略后面的()
    void (^myblock)() = ^{
        NSLog(@"----------------");
        NSLog(@"----------------");
    };

    myblock();
    myblock();
}