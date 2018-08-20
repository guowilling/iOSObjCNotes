
#import "TMCalculatorView.h"
#import "ConstDefine.h"
#import "NSString+TMNSString.h"

@interface TMCalculatorView()

@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthDayLabel;

@property (nonatomic, copy) NSString *beforDotSting;
@property (nonatomic, copy) NSString *afterDotString;

@property (nonatomic, copy) NSString *currentString;

@property (nonatomic, copy) NSString *beforeOperationString;

@property (nonatomic, assign, getter=isSelectedPoint) BOOL selectedPoint;
@property (nonatomic, assign, getter=isSelectedPlusOperation) BOOL selectedPlusOperation;
@property (nonatomic, assign, getter=isSelectedOperation) BOOL selectedOperation;

@end

@implementation TMCalculatorView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self initializesWithPreparation];
}

- (void)initializesWithPreparation {
    
    self.beforDotSting = @"0";
    self.afterDotString = @"00";
    self.currentString = [NSString stringWithFormat:@"%@.%@", self.beforDotSting, self.afterDotString];
    self.selectedPoint = NO;
    self.selectedPlusOperation = NO;
    self.selectedOperation = NO;
    self.beforeOperationString = @"";
}

- (IBAction)didClickBtn:(UIButton *)sender {
    
    NSString *text = sender.currentTitle;
    if ([text isEqualToString:@"."]) {
        self.selectedPoint = YES;
        return;
    }
    
    if ([text isEqualToString:@"清零"]) {
        [self initializesWithPreparation];
        if (self.passValuesBlock) {
            self.passValuesBlock(self.currentString);
        }
        return;
    }
    
    if ([text isEqualToString:@"+"] || [text isEqualToString:@"-"] ) {
        if ([text isEqualToString:@"+"]) {
            self.selectedPlusOperation = YES;
            float sum = self.beforeOperationString.floatValue + self.currentString.floatValue;
            self.currentString = [NSString stringWithFormat:@"%.2f",sum];
        } else {
            if (self.beforeOperationString.floatValue != 0) {
                float poor = self.beforeOperationString.floatValue - self.currentString.floatValue;
                self.currentString = [NSString stringWithFormat:@"%.2f",poor];
            }
            self.selectedPlusOperation = NO;
        }
        if (self.passValuesBlock) {
            self.passValuesBlock(self.currentString);
        }
        self.beforeOperationString = self.currentString;
        self.beforDotSting = @"0";
        self.afterDotString = @"00";
        self.selectedPoint = NO;
        self.selectedOperation = YES;
        return;
    }
    
    if ([text isEqualToString:@"OK"]) {
        if (self.isSelectedOperation) {
            if (self.isSelectedPlusOperation) {
                float sum = self.beforeOperationString.floatValue + self.currentString.floatValue;
                self.currentString = [NSString stringWithFormat:@"%.2f",sum];
            } else {
                float poor = self.beforeOperationString.floatValue - self.currentString.floatValue;
                self.currentString = [NSString stringWithFormat:@"%.2f",poor];
            }
        }
        if (self.passValuesBlock) {
            self.passValuesBlock(self.currentString);
        }
        if (self.didClickSaveBtnBlock) {
            self.didClickSaveBtnBlock();
        }
        [self initializesWithPreparation];
        return;
    }
    
    if (self.isSelectedPoint) {
        self.afterDotString = [NSString stringWithFormat:@"%@0",text];
    } else {
        if ([self.beforDotSting isEqualToString:@"0"]) {
            self.beforDotSting = text;
        } else {
            self.beforDotSting = [NSString stringWithFormat:@"%@%@", self.beforDotSting,text];
        }
    }
    self.currentString = [NSString stringWithFormat:@"%@.%@", self.beforDotSting, self.afterDotString];
    if (self.passValuesBlock) {
        self.passValuesBlock(self.currentString);
    }
}

- (IBAction)clickSelectDateBtn:(UIButton *)sender {
    
    if (self.didClickDateBtnBlock) {
        self.didClickDateBtnBlock();
    }
}

- (IBAction)clickRemarkBtn:(UIButton *)sender {

    if (self.didClickRemarkBtnBlock) {
        self.didClickRemarkBtnBlock();
    }
}

- (void)setTimeWithTimeString:(NSString *)timeString {
    
    if (![timeString isEqualToString:[NSString currentDateStr]]) {
        NSString *year = [timeString substringToIndex:4];
        self.yearLabel.text = year;
        self.yearLabel.textColor = kSelectColor;
        NSRange monthRange = NSMakeRange(5, 2);
        NSString *month = [timeString substringWithRange:monthRange];
        NSString *day = [timeString substringFromIndex:8];
        NSString *month_day = [NSString stringWithFormat:@"%@月%@日", month, day];
        self.monthDayLabel.text = month_day;
        self.monthDayLabel.textColor = kSelectColor;
    } else {
        self.yearLabel.text = [[NSString currentDateStr] substringToIndex:4];
        self.yearLabel.textColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00];
        self.monthDayLabel.text = @"今天";
        self.monthDayLabel.textColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00];
    }
}

@end
