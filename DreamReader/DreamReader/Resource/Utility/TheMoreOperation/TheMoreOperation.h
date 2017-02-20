//
//  TheMoreOperation.h
//  FaDaMi
//
//  Created by cqz on 17/2/15.
//  Copyright © 2017年 CQZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIActivity.h>

//@protocol TheMoreOperationPro;

typedef enum {
    MoreOperationTagShareWechat,
    MoreOperationTagShareMoment,
    MoreOperationTagShareQQ,
    MoreOperationTagShareQzone,
    MoreOperationTagShareWeibo,
    MoreOperationTagSearch,//搜索
    MoreOperationTagSafari,//浏览器
    MoreOperationTagReport, //复制链接
    MoreOperationTagSystemShare //更多  系统分享

} MoreOperationTag;

@interface TheMoreOperation : NSObject

@property (nonatomic, strong) QMUIMoreOperationController *moreOperationController;
//@property (nonatomic, weak) id<TheMoreOperationPro>delegate;

- (instancetype)initWithMoreOperation;

- (void)showWithContent:(NSDictionary *)dictionary;
@end

//@protocol TheMoreOperationPro <NSObject>
//
//- (void)searchPageContent;
//
//@end
