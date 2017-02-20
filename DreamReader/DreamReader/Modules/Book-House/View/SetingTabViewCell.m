//
//  SetingTabViewCell.m
//  DreamReader
//
//  Created by macmini on 2017/2/20.
//  Copyright © 2017年 cqz. All rights reserved.
//

#import "SetingTabViewCell.h"

@implementation SetingTabViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    
    return self;
}
- (void)initUI {
    
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.headImg];
    [self.contentView addSubview:self.switchButton];

}
- (void)settingUIWithSection:(NSUInteger)section {
    
    NSArray *titleArrays = @[@"夜间模式",@"清空缓存",@"推荐给朋友"];
    NSArray *imageArrays = @[@"set_Night",@"set_CCleaner",@"set_good"];
    _nameLab.text = titleArrays[section];
    [_headImg setImage:UIImageMake(imageArrays[section])];
    
    _switchButton.hidden  = (section == 0) ? YES : NO;
    self.accessoryType = (section == 0) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}
#pragma mark -UIButtonEvent
- (void)switchAction:(id)sender{
    
    UISwitch *switchButton = (UISwitch *)sender;
    BOOL isButton = [switchButton isOn];
    
    if (isButton) {
        DLog(@"open");
        
    } else {
        DLog(@"close");
    }
}

#pragma mark - setters and getters
- (UILabel *)nameLab {
    
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(45, 12, 120, 20)];
        _nameLab.font = Font_15;
        _nameLab.textColor = UIColorMakeWithHex(@"#333333");
    }
    return _nameLab;
}
- (UIImageView *)headImg{
    
    if (!_headImg) {
        _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 25, 25)];
        _headImg.userInteractionEnabled = YES;
    }
    return _headImg;
}
- (UISwitch *)switchButton{
    
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65.f, 7.f, 0, 30)];
        [_switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        _switchButton.onTintColor = NavBarTintColor;
    }
    return _switchButton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
