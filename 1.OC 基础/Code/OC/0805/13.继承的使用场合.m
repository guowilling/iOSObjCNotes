/**
 继承的使用场合
 1.两个类拥有相同属性和方法, 可以将相同的东西抽取到一个父类中
 2.A类的属性和方法完全属于B类的部分属性和方法, 可以让B类继承A类
 
 // 继承：xx 是is xxx
 // 组合：xx 拥有has xxx
 
 1.继承
 A
 {
    int _age;
    int _no;
 }
 B : A
 {
    int _weight;
 }
 
 2.组合
 A
 {
     int _age;
     int _no;
 }
 B
 {
     A *_a;
     int _weight;
 }
 */

@interface Score : NSObject
{
    int _cScore;
    int _ocScore;
}
@end

@implementation Score
@end

@interface Student : NSObject
{
    // 组合
    Score *_score;
    int _age;
}
@end

@implementation Student

@end