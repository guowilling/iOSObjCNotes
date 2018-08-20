
#ifndef AnecdotesDemo_URLDefines_h
#define AnecdotesDemo_URLDefines_h

#define APIKey       @"0552046e035d7b8b0ff60d4a0a1872a1"
#define APISecret    @"bcdf6eaa0bd75fff"
#define Redirect_uri @"http://www.baidu.com"

#define OAuth_URL [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code", APIKey, Redirect_uri]

#define Access_TokenUrl @"https://www.douban.com/service/auth2/token"

#define DoubanWorld_BaseURL @"https://api.douban.com"

// 最近一周某城市的活动
#define Recommend_URL [NSString stringWithFormat:@"%@/v2/event/list", DoubanWorld_BaseURL]

// 热门城市列表
#define HotCities_URL [NSString stringWithFormat:@"%@/v2/loc/list", DoubanWorld_BaseURL]

// 活动详细信息
#define ActivityInfo_URL [NSString stringWithFormat:@"%@/v2/event/", DoubanWorld_BaseURL]

// 用户信息
#define UserInfo_URL [NSString stringWithFormat:@"%@/v2/user/", DoubanWorld_BaseURL]

// 热门电影
#define HotMovie_URL [NSString stringWithFormat:@"%@/v2/movie/in_theaters", DoubanWorld_BaseURL]

// 即将上映电影
#define ComingsoonMovie_URL [NSString stringWithFormat:@"%@/v2/movie/coming_soon", DoubanWorld_BaseURL]

// 电影详细信息
#define MovieInfo_URL [NSString stringWithFormat:@"%@/v2/movie/subject/", DoubanWorld_BaseURL]

#endif
