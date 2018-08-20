
#import <UIKit/UIKit.h>

@class MovieModel, DetailMovieModel;

@interface MovieDetailHeadView : UIView

@property (nonatomic, strong) MovieModel *model;

@property (nonatomic, strong) DetailMovieModel *infoModel;

@end
