
#import <Foundation/Foundation.h>

@interface Score : NSObject
{
    int _cScore;
    int _ocScore;
    
    int _totalScore;
    int _averageScoe;
}

- (void)setCScore:(int)cScore;
- (int)cScore;

- (void)setOcScore:(int)ocScore;
- (int)ocScore;

- (int)totalScore;

- (int)averageScore;

@end

@implementation Score

- (void)setCScore:(int)cScore
{
    _cScore = cScore;
    
    _totalScore = _cScore + _ocScore;
    _averageScoe = _totalScore/2;
}
- (int)cScore
{
    return _cScore;
}

- (void)setOcScore:(int)ocScore
{
    _ocScore = ocScore;
    
    _totalScore = _cScore + _ocScore;
    _averageScoe = _totalScore/2;
}
- (int)ocScore
{
    return _ocScore;
}

- (int)totalScore
{
    return _totalScore;
}

- (int)averageScore
{
    return _averageScoe;
}

@end


int main()
{
    Score *s = [Score new];
    
    [s setCScore:90];
    [s setOcScore:100];
    [s setCScore:80];
    
    int a = [s totalScore];
    
    NSLog(@"总分：%d", a);
    
    return 0;
}