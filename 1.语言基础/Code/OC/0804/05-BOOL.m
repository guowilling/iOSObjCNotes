
#import <Foundation/Foundation.h>

BOOL test(BOOL myBool)
{
    return NO;
}

int main()
{
    BOOL b = YES;
    
    BOOL b2 = NO;
    
    BOOL b3 = 1; // YES
    
    BOOL b4 = 0; // NO
    
    
    NSLog(@"%i", b);
    
    NSLog(@"%d", test(YES));
    
    return 0;
}