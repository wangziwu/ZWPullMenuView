//
//  ViewController.m
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/28.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ViewController.h"
#import "ZWPullMenuView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)actionWeChatMenu:(id)sender {
    NSArray *titleArray = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收付款"];
    NSArray *imageArray = @[@"contacts_add_newmessage_30x30_",
                            @"contacts_add_friend_30x30_",
                            @"contacts_add_scan_30x30_",
                            @"contacts_add_scan_30x30_"];
    [ZWPullMenuView pullMenuAnchorView:sender
                            titleArray:titleArray
                            imageArray:imageArray];
}
- (IBAction)actionAlipayMenu:(id)sender {
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
- (IBAction)actionTimePull:(id)sender {
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:sender titleArray:@[@"2017年09月",
                                                                                      @"2017年08月",
                                                                                      @"2017年07月",
                                                                                      @"2017年06月",
                                                                                      @"2017年05月"]];
    menuView.zwPullMenuStyle = PullMenuLightStyle;
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        NSLog(@"action----->%ld",(long)menuRow);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
