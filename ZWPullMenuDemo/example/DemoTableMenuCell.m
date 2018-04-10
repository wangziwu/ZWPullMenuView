//
//  DemoTableMenuCell.m
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2018/4/10.
//  Copyright © 2018年 wang_ziwu. All rights reserved.
//

#import "DemoTableMenuCell.h"
#import "ZWPullMenuView.h"
@implementation DemoTableMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)actionBlueBtn:(id)sender {
    ZWPullMenuModel *model1 = [[ZWPullMenuModel alloc] init];
    model1.title = @"德玛西亚大保健";
    ZWPullMenuModel *model2 = [[ZWPullMenuModel alloc] init];
    model2.title = @"艾欧尼亚女护士";
    [ZWPullMenuView pullMenuAnchorView:sender menuArray:@[model1,model2]];
}
- (IBAction)actionWechatBtn:(id)sender {
    NSArray *titleArray = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收钱"];
    NSArray *imageArray = @[@"ap_group_talk",
                            @"ap_add_friend",
                            @"ap_scan",
                            @"ap_qrcode"];
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:sender
                                                       titleArray:titleArray
                                                       imageArray:imageArray];
    menuView.zwPullMenuStyle = PullMenuLightStyle;
}
- (IBAction)actionAlipayBtn:(id)sender {
    NSArray *titleArray = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收付款"];
    NSArray *imageArray = @[@"contacts_add_newmessage_30x30_",
                            @"contacts_add_friend_30x30_",
                            @"contacts_add_scan_30x30_",
                            @"contacts_add_scan_30x30_"];
    [ZWPullMenuView pullMenuAnchorView:sender
                            titleArray:titleArray
                            imageArray:imageArray];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
