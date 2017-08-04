//
//  UIView+Frame.m
//  GPCLottery
//
//  Created by ___hxs___ on 2017/4/12.
//  Copyright © 2017年 小四. All rights reserved.
//

#import "UIView+Frame.h"
#define UIColorFromRGB(rgbValue) [[UIColor alloc] initWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIView (Frame)
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (UIView *)getParsentView:(UIView *)view{
    if ([[view nextResponder] isKindOfClass:[UIViewController class]] || view == nil) {
        return view;
    }
    return [self getParsentView:view.superview];
}

- (NSMutableAttributedString *)addLineSpacing:(NSString *)title lineSize:(CGFloat)lineSize{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSize;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    return attStr;
}

- (NSMutableAttributedString *)addContent:(NSString *)title changeTitle:(NSString *)changeTitle changeTitleColor:(UIColor *)changeTitleColor{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
    [attStr addAttribute:NSForegroundColorAttributeName value:changeTitleColor range:[title rangeOfString:changeTitle]];
    return attStr;
}
- (void)addAttribute:(NSMutableAttributedString*)attStr ContentColor:(NSString *)title changeTitle:(NSString *)changeTitle changeTitleColor:(UIColor *)changeTitleColor{
    [attStr addAttribute:NSForegroundColorAttributeName value:changeTitleColor range:[title rangeOfString:changeTitle]];
}

- (void)addTopLine:(UIColor *)color lineHeight:(CGFloat)lineHeight{
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, lineHeight)];
    topLine.backgroundColor = color;
    [self addSubview:topLine];
}

- (void)addRightLine:(UIColor *)color lineHeight:(CGFloat)lineHeight;{
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - lineHeight, 0, lineHeight, self.frame.size.height)];
    rightLine.backgroundColor = color;
    [self addSubview:rightLine];
}

- (void)addBottomLine:(UIColor *)color lineHeight:(CGFloat)lineHeight{
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - lineHeight, self.frame.size.width, lineHeight)];
    bottomLine.backgroundColor = color;
    [self addSubview:bottomLine];
}

- (void)addLine:(CGFloat)y color:(UIColor *)color lineHeight:(CGFloat)lineHeight{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y , self.frame.size.width , lineHeight)];
    line.backgroundColor = color;
    [self addSubview:line];
}

- (void)addLineView:(CGFloat)y height:(CGFloat)height{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-1, y , self.frame.size.width + 2 , height)];
    line.backgroundColor = UIColorFromRGB(0xf5f5f5);
    line.layer.borderWidth = 1;
    line.layer.borderColor = [UIColorFromRGB(0xCCCCCC) CGColor];
    [self addSubview:line];
}
@end
