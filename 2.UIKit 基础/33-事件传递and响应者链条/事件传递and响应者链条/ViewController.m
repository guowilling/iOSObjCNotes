//
//  ViewController.m
//  事件传递and响应者链条
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

/**
 * 通过touches方法监听view触摸事件有很明显的几个缺点
 * 1.必须自定义view重写view的touches方法
 * 2.无法让外界对象监听view的触摸事件
 * 3.不容易区分手势
 * 所以苹果后来提供了手势识别器UIGestureRecognizer
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

/** 
 * 注意: 如果父控件禁止交互那么子控件也不能交互(UIImageView, UILabel 默认不能交互)
 * 触摸事件的传递过程: UIAppliction -> UIWiondw -> 找到最适合处理事件的控件(递归方式)
 * 如何找到最合适的控件: 1.自己是否能交互 2.触摸位置是否在自己范围内 3.如果上面两个条件满足遍历子控件(重复1,2步骤直到没有符合条件的子控件确认自己最适合处理)
 * 触摸事件的响应过程: 1.默认沿着响应者链条反向传递 2.判断是否实现touches方法 3.没有实现将事件传递给上一个响应者 3.重复前面步骤
 * 响应原则: 如果view被控制器管理就传递给控制器; 如果控制器不存在则传递给它的父视图(直到UIWindow 或者 UIApplication 或者丢弃)
 
 * 响应者链条是什么: 多个响应者组成的链条
 * 什么是响应者: 继承自 UIResponder 类的对象称为响应者对象
 * 如何判断上一个响应者是谁: 1.如果当前响应者是控制器的 View 上一个响应者就是控制器 2.如果当前响应者不是控制器的 View 上一个响应者是父控件
 * 响应者链条有什么用: 可以让多个响应者同时响应一个事件
 */
