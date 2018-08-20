
#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    // char *_name;
    NSString *_name;
}
@end

int main()
{
    /*
    // OC字符串
    NSString *str = @"gwl";
	
    // C字符串
    char *name = "gwl";
	
    NSLog(@"我叫%@", str);
    NSLog(@"我叫%s", name);
    */
    
    int age = 15;
    int no = 5;
    
    NSString *name = @"哈哈jack";
    int size = [name length];
    NSLog(@"%d", size); // 6
    
    NSString *newStr = [NSString stringWithFormat:@"My age is %d and no is %d and name is %@", age, no, name];
    
    NSLog(@"%@",newStr);
    
    NSLog(@"%ld", [newStr length]);
    
    return 0;
}