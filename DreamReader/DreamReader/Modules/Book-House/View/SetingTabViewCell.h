//
//  SetingTabViewCell.h
//  DreamReader
//
//  Created by macmini on 2017/2/20.
//  Copyright © 2017年 cqz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetingTabViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UIImageView *headImg;
@property (strong, nonatomic) UISwitch *switchButton;

- (void)settingUIWithSection:(NSUInteger)section;

@end
