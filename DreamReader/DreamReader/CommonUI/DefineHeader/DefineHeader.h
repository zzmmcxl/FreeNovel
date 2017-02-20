//
//  DefineHeader.h
//  DreamReader
//
//  Created by macmini on 2017/2/20.
//  Copyright © 2017年 cqz. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h



/**
 *
 * color macros
 *
 **/

#define LRRGBAColor(r,g,b,a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define LRRGBColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

#define hexColor(colorV) [UIColor colorWithHexString:@#colorV]

#define hexColorAlpha(colorV,a) [UIColor colorWithHexString:@#colorV alpha:a];

#define LRRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0f green:arc4random_uniform(255)/255.0f blue:arc4random_uniform(255)/255.0f alpha:1.0f]


#define QMUI_DONE       @"QMUI_tips_done"
#define QMUI_ERROE      @"QMUI_tips_error"
#define QMUI_INFO       @"QMUI_tips_info"

//底部工具栏高度
#define kTabBarHeight                                     49

#define GET(str)                                          (str ? str : @"")

/**
 *
 * font
 macros
 *
 **/
#define Font_11        [UIFont  systemFontOfSize:11.f]
#define Font_12        [UIFont  systemFontOfSize:12.f]
#define Font_13        [UIFont  systemFontOfSize:13.f]
#define Font_14        [UIFont  systemFontOfSize:14.f]
#define Font_15        [UIFont  systemFontOfSize:15.f]
#define Font_16        [UIFont  systemFontOfSize:16.f]
#define Font_17        [UIFont  systemFontOfSize:17.f]
#define Font_18        [UIFont  systemFontOfSize:18.f]
#define Font_20        [UIFont  systemFontOfSize:20.f]
#define Font_21        [UIFont  systemFontOfSize:21.f]
#define Font_24        [UIFont  systemFontOfSize:24.f]


/**
 *  由角度转换弧度 由弧度转换角度
 */
#define REES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)



#define Orgin_y(container)   (container.frame.origin.y+container.frame.size.height)
#define Orgin_x(container)   (container.frame.origin.x+container.frame.size.width)
/**
 *  设置 view 圆角和边框
 */
#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/**
 *  GCD 的宏定义
 */
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#define line_w 0.5

#define DATE_FORMAT_YMDHMS             @"yyyy-MM-dd HH:mm:ss"
#define DATE_FORMAT_YMDHM               @"yyyy-MM-dd HH:mm"

/**
 *  3.判断当前环境(ARC/MRC)
 */
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif


/**
 *  判断是真机还是模拟器
 */
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


/**
 *  把是NSNull 类型的值替换成nil
 *  使用方法：contact.contactPhone = VerifyValue(contactDic[@"send_ContactPhone"]);
 */
#define VerifyValue(value)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = nil;\
else\
tmp = value;\
tmp;\
})\



#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
__REF = nil;\
}\
}

//view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
__REF = nil;\
}\
}

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}


/**
 * NSLog宏，限定仅在Debug时才打印,release不打印，防止拖慢程序运行
 */

//#ifdef DEBUG
//#define DLog(fmt, ...) NSLog((@" %s  " fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent]   UTF8String], __LINE__, __PRETTY_FUNCTION__,  ##__VA_ARGS__);
//#else
//#define DLog(...)
//#endif

#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DLog(...) printf("%s 第%d行: %s\n\n", [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define DLog(...)
#endif



//宏定义方法
#define SHOW_ALERT(msg) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert show];\


#define WEAKSELF typeof(self) __weak weakSelf = self;

#define USER_D [NSUserDefaults standardUserDefaults]

//iOS版本
#define CurrentSystemVersion                    ([[[UIDevice currentDevice] systemVersion] floatValue])


typedef void(^ReaderBlock)(void);
typedef void(^ReaderBlockBlock)(ReaderBlock block);
typedef void(^ReaderObjectBlock)(id obj);
typedef void(^ReaderArrayBlock)(NSArray *array);
typedef void(^ReaderMutableArrayBlock)(NSMutableArray *array);
typedef void(^ReaderDictionaryBlock)(NSDictionary *dic);
typedef void(^ReaderErrorBlock)(NSError *error);
typedef void(^ReaderIndexBlock)(NSInteger index);
typedef void(^ReaderFloatBlock)(CGFloat afloat);
typedef void(^ReaderStringBlock)(NSString *string);
typedef void(^ReaderCancelBlock)(id viewController);
typedef void(^ReaderFinishedBlock)(id viewController, id object);
typedef void(^ReaderSendRequestAndResendRequestBlock)(id sendBlock, id resendBlock);

#define WIDTH(view) view.frame.size.width
#define HEIGHT(view) view.frame.size.height
#define X(view) view.frame.origin.x
#define Y(view) view.frame.origin.y
#define LEFT(view) view.frame.origin.x
#define TOP(view) view.frame.origin.y
#define BOTTOM(view) (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view) (view.frame.origin.x + view.frame.size.width)



#endif /* DefineHeader_h */





