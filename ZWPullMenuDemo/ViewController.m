//
//  ViewController.m
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/28.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ViewController.h"
#import "ZWPullMenuView.h"
#import "DemoTableMenuCell.h"
@interface ViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configNav];
    [self configTable];
}
#pragma mark - config
- (void)configNav {
    self.title = @"下拉菜单";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"ap_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(actionCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    UIBarButtonItem *rightItemBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightItemBtn];
}
- (void)configTable {
    self.mTable.tableFooterView = UIView.new;
    [self.mTable registerNib:[UINib nibWithNibName:@"DemoTableMenuCell" bundle:nil]
      forCellReuseIdentifier:@"cell"];
}
#pragma mark - lifeCycle
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoTableMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
#pragma mark - actionFunction
- (void)actionCreateBtn:(id)sender{
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:sender titleArray:@[@"2017年09月",
                                                                                      @"2017年08月",
                                                                                      @"2017年07月",
                                                                                      @"2017年06月",
                                                                                      @"2017年05月",
                                                                                      @"2017年04月",
                                                                                      @"2017年03月",
                                                                                      @"2017年02月",
                                                                                      @"2017年01月"]];
    menuView.zwPullMenuStyle = PullMenuLightStyle;
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        NSLog(@"action----->%ld",(long)menuRow);
    };
}
#pragma mark - function
#pragma mark - layzing
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
