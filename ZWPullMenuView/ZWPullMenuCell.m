//
//  ZWPullMenuCell.m
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/30.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPullMenuCell.h"
@interface ZWPullMenuCell ()
@property (nonatomic, strong) UIView *selectedBgView;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@end
@implementation ZWPullMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        self.selectedBgView     = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView = self.selectedBgView;
        [self addSubview:self.menuImageView];
        [self addSubview:self.menuTitleLab];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
-(void)setMenuModel:(ZWPullMenuModel *)menuModel{
    _menuModel = menuModel;
    if (!menuModel.imageName.length) {
        self.menuImageView.hidden = YES;
        self.menuTitleLab.frame = CGRectMake(self.zw_menuConfg.zw_menuContentMargin, 0, CGRectGetWidth(self.bounds) - self.zw_menuConfg.zw_menuContentMargin * 2, CGRectGetHeight(self.bounds));
    }else{
        self.menuImageView.hidden = NO;
        self.menuImageView.image = [UIImage imageNamed:menuModel.imageName];
        self.menuImageView.frame = CGRectMake(self.zw_menuConfg.zw_menuContentMargin, (CGRectGetHeight(self.bounds) - self.zw_menuConfg.zw_menuImageWidth) * 0.5, self.zw_menuConfg.zw_menuImageWidth, self.zw_menuConfg.zw_menuImageWidth);
        self.menuTitleLab.frame = CGRectMake(self.zw_menuConfg.zw_menuContentMargin * 2 + self.zw_menuConfg.zw_menuImageWidth, 0, CGRectGetWidth(self.bounds) - (self.zw_menuConfg.zw_menuContentMargin * 3 + self.zw_menuConfg.zw_menuImageWidth), CGRectGetHeight(self.bounds));
    }
    self.menuTitleLab.text = menuModel.title;
    self.menuTitleLab.font = [UIFont systemFontOfSize:self.zw_menuConfg.zw_menuTitleFontSize];
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
    }else {
        [self.lineLayer removeFromSuperlayer];
    }
}
- (void)drawLineSep{
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    lineLayer.strokeColor = self.lineColor.CGColor;
    lineLayer.frame = self.bounds;
    lineLayer.lineWidth = 0.5;
    UIBezierPath *sepline = [UIBezierPath bezierPath];
    [sepline moveToPoint:CGPointMake(self.zw_menuConfg.zw_menuContentMargin, self.bounds.size.height - lineLayer.lineWidth)];
    [sepline addLineToPoint:CGPointMake(self.bounds.size.width - self.zw_menuConfg.zw_menuContentMargin, self.bounds.size.height - lineLayer.lineWidth)];
    lineLayer.path = sepline.CGPath;
    [self.layer addSublayer:lineLayer];
    self.lineLayer = lineLayer;
}
- (void)setLineColor:(UIColor *)lineColor{
    if (lineColor) {
        _lineColor = lineColor;
    }
}
- (UIImageView *)menuImageView {
    if (!_menuImageView) {
        _menuImageView = [[UIImageView alloc] init];
    }
    return _menuImageView;
}
- (UILabel *)menuTitleLab {
    if (!_menuTitleLab) {
        _menuTitleLab = [[UILabel alloc] init];
    }
    return _menuTitleLab;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
