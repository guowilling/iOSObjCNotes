
#ifndef AnecdotesDemo_CommenDefines_h
#define AnecdotesDemo_CommenDefines_h

#ifdef DEBUG
    #define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
    #define NSLog(FORMAT, ...) nil
#endif

#define KColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define NAV_BAR_HEIGHT  64
#define TAB_BAR_HEIGHT  49

#define HMStatusCellMargin 15

#define TheThemeColor KColor(55, 100, 56)
#define TheNavBarBackgroundColor KColor(155, 100, 56)
#define KBackgroundColor KColor(222, 222, 222)

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[[UIDevice currentDevice]systemVersion]doubleValue] >= 8.0)
#define iPHone6 ([UIScreen mainScreen].bounds.size.height > 568) ? YES : NO

#define HotCityButtonWith ([UIScreen mainScreen].bounds.size.height > 568 ? 100.f : 80.f)
#define HotCityButtonHeight   36.f
#define HotCityButtonMargin   10.f
#define SearchBarHeight       44.f
#define KActivityDetailHeadH  280.f
#define KMovieDetailHeadH     250.f
#define MovieMenuHeight       45.f

#pragma mark - User Information

#define     USER_status          @"useraltstatus"
#define     USER_alt             @"useralt"
#define     USER_avatar          @"useravatar"
#define     USER_created         @"usercreated"
#define     USER_desc            @"userdesc"
#define     USER_is_banned       @"useris_banned"
#define     USER_is_suicide      @"useris_suicide"
#define     USER_large_avatar    @"userlarge_avatar"
#define     USER_loc_id          @"userloc_id"
#define     USER_loc_name        @"userloc_name"
#define     USER_name            @"username"
#define     USER_signature       @"usersignature"
#define     USER_type            @"usertype"
#define     USER_uid             @"useruid"

#endif
