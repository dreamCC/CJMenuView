//
//  CJMenuView.h
//  CommonProject
//
//  Created by zhuChaojun的mac on 2017/2/27.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJMenuView;

typedef NS_ENUM(NSUInteger, CJMenuArrowDirection) {
    CJMenuArrowDirectionTop    = 0,
    CJMenuArrowDirectionLeft   = 1 << 0,
    CJMenuArrowDirectionRight  = 1 << 1,
    CJMenuArrowDirectionBottom = 1 << 2
};

@protocol CJMenuViewDelegate <NSObject>

-(void)menuView:(CJMenuView *)menuView didSelectRowAtIndex:(NSInteger)index content:(NSString *)content;

@end
@interface CJMenuView : UIView


@property(nonatomic, weak) id<CJMenuViewDelegate> delegate;

/// 箭头高度，默认8.0f
@property(nonatomic, assign) CGFloat arrowHeight;

/// 箭头位置，是一个比例，0~1，默认是0.5f
@property(nonatomic, assign) CGFloat arrowProportion;

/// 箭头方向，默认CJMenuArrowDirectionTop
@property(nonatomic, assign) CJMenuArrowDirection arrowDirection;


/// 箭头位置,默认CJMenuView的center
@property(nonatomic, assign) CGPoint arrowPosition;


/// 菜单内容颜色，默认whiteColor
@property(nonatomic, strong) UIColor *menuContentColor;

/// 菜单内容，边界线宽度，默认1.0f
@property(nonatomic, assign) CGFloat menuContentBorderWidth;

/// 菜单内容，边界线颜色，默认lightGrayColor
@property(nonatomic, strong) UIColor *menuContentBorderColor;

/// 菜单内容
@property(nonatomic, strong) NSArray<NSString *> *contents;

/// 菜单内容view
@property(nonatomic,strong) UITableView *contentTableView;

/// 字体大小，默认15
@property(nonatomic, assign) CGFloat fontSize;

/// 字体颜色，默认grayColor
@property(nonatomic, strong) UIColor *fontColor;

/**
 初始化方法

 @param frame 尺寸
 @param arrowPositon 箭头位置
 @param contents 内容
 @return 初始化对象
 */
-(instancetype)initWithFrame:(CGRect)frame
                arrowPositon:(CGPoint)arrowPositon
                    contents:(NSArray <NSString *>*)contents;

/// 显示
-(void)show;
/// 隐藏
-(void)dismiss;

@end


