//
//  ZWPullMenuCell.m
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/30.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPullMenuCell.h"
@interface ZWPullMenuCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuImageWidth;
@property (nonatomic, strong) UIView *selectedBgView;
/**
 *  line color
 */
@property (nonatomic, strong) UIColor *lineColor;
@end
@implementation ZWPullMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor whiteColor];
    self.selectedBgView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView = self.selectedBgView;
}
-(void)setMenuModel:(ZWPullMenuModel *)menuModel{
    _menuModel = menuModel;
    if (!menuModel.imageName.length) {
        self.menuImageWidth.constant = 0;
    }else{
        self.menuImageWidth.constant = 30;
    }
    self.menuImageView.image = [UIImage imageNamed:menuModel.imageName];
    self.menuTitleLab.text = menuModel.title;
}
-(void)setZwPullMenuStyle:(ZWPullMenuStyle)zwPullMenuStyle{
    _zwPullMenuStyle = zwPullMenuStyle;
    switch (zwPullMenuStyle) {
        case PullMenuDarkStyle:
        {
            self.selectedBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
            self.menuTitleLab.textColor = [UIColor whiteColor];
            self.lineColor = [UIColor whiteColor];
        }
            break;
        case PullMenuLightStyle:
        {
            self.selectedBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.menuTitleLab.textColor = [UIColor blackColor];
            self.lineColor = [UIColor lightGrayColor];
        }
            break;
        default:
            break;
    }
}
-(void)setIsFinalCell:(BOOL)isFinalCell{
    _isFinalCell = isFinalCell;
    if (!isFinalCell) {
        [self drawLineSep];
    }
}
- (void)drawLineSep{
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    lineLayer.strokeColor = self.lineColor.CGColor;
    lineLayer.frame = self.bounds;
    lineLayer.lineWidth = 0.5;
    UIBezierPath *sepline = [UIBezierPath bezierPath];
    [sepline moveToPoint:CGPointMake(15, self.bounds.size.height-0.5)];
    [sepline addLineToPoint:CGPointMake(self.bounds.size.width-15, self.bounds.size.height-0.5)];
    lineLayer.path = sepline.CGPath;
    [self.layer addSublayer:lineLayer];
}
- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
