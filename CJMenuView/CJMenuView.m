//
//  CJMenuView.m
//  CommonProject
//
//  Created by zhuChaojun的mac on 2017/2/27.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJMenuView.h"

static CGFloat const rowH = 44;
@interface CJMenuView ()<UITableViewDelegate,UITableViewDataSource> 

/// 菜单内容尺寸
@property(nonatomic, assign) CGSize menuContentSize;

@property(nonatomic, weak) CAShapeLayer *shapeLayer;

@end

@implementation CJMenuView

-(instancetype)initWithFrame:(CGRect)frame arrowPositon:(CGPoint)arrowPositon contents:(NSArray<NSString *> *)contents {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self initDefaultParameters];
    
    self.contents      = contents;
    self.arrowPosition = arrowPositon;
    self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.4];
    [self setupContentKit];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame
                  arrowPositon:CGPointMake(frame.size.width*0.5, frame.size.height*0.5) contents:@[]];
}


-(void)setupContentKit {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineCap  = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineWidth   = _menuContentBorderWidth;
    shapeLayer.strokeColor = _menuContentBorderColor.CGColor;
    shapeLayer.fillColor   = _menuContentColor.CGColor;
    [self.layer addSublayer:shapeLayer];
    _shapeLayer = shapeLayer;
    
    self.contentTableView.backgroundColor = _menuContentColor;
    [self addSubview:self.contentTableView];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint left_top, left_Bottom, right_top, right_Bottom;
    CGPoint first_arrow, last_arrow;
    UIBezierPath *path      = [UIBezierPath bezierPath];
    switch (_arrowDirection) {
        case CJMenuArrowDirectionTop:
        {
            left_top     = CGPointMake(_arrowPosition.x - _menuContentSize.width*_arrowProportion, _arrowPosition.y + _arrowHeight);
            left_Bottom  = CGPointMake(left_top.x, left_top.y + _menuContentSize.height);
            right_top    = CGPointMake(left_top.x + _menuContentSize.width, left_top.y);
            right_Bottom = CGPointMake(right_top.x, left_Bottom.y);
            
            first_arrow  = CGPointMake((_arrowPosition.x - _arrowHeight*0.7)>left_top.x?(_arrowPosition.x - _arrowHeight*0.7):left_top.x, left_top.y);
            last_arrow   = CGPointMake((_arrowPosition.x + _arrowHeight*0.7)<right_top.x?(_arrowPosition.x + _arrowHeight*0.7):right_top.x, left_top.y);
            
            [path moveToPoint:left_top];
            [path addLineToPoint:first_arrow];
            [path addLineToPoint:_arrowPosition];
            [path addLineToPoint:last_arrow];
            [path addLineToPoint:right_top];
            [path addLineToPoint:right_Bottom];
            [path addLineToPoint:left_Bottom];
        }
            break;
        case CJMenuArrowDirectionLeft:
        {
            left_top     = CGPointMake(_arrowPosition.x + _arrowHeight, _arrowPosition.y - _menuContentSize.height*_arrowProportion);
            left_Bottom  = CGPointMake(left_top.x, left_top.y + _menuContentSize.height);
            right_top    = CGPointMake(left_top.x + _menuContentSize.width, left_top.y);
            right_Bottom = CGPointMake(right_top.x, left_Bottom.y);
            
            first_arrow  = CGPointMake(left_top.x,(_arrowPosition.y + _arrowHeight*0.7)<left_Bottom.y?(_arrowPosition.y + _arrowHeight*0.7):left_Bottom.y);
            last_arrow   = CGPointMake(first_arrow.x, (first_arrow.y-_arrowHeight)>left_top.y?(first_arrow.y-_arrowHeight):left_top.y);
            
            [path moveToPoint:left_top];
            [path addLineToPoint:right_top];
            [path addLineToPoint:right_Bottom];
            [path addLineToPoint:left_Bottom];
            [path addLineToPoint:first_arrow];
            [path addLineToPoint:_arrowPosition];
            [path addLineToPoint:last_arrow];
        }
            break;
        case CJMenuArrowDirectionRight:
        {
            left_top     = CGPointMake(_arrowPosition.x - _arrowHeight-_menuContentSize.width, _arrowPosition.y - _menuContentSize.height*_arrowProportion);
            left_Bottom  = CGPointMake(left_top.x, left_top.y + _menuContentSize.height);
            right_top    = CGPointMake(left_top.x + _menuContentSize.width, left_top.y);
            right_Bottom = CGPointMake(right_top.x, left_Bottom.y);
            
            first_arrow  = CGPointMake(right_top.x,(_arrowPosition.y + _arrowHeight*0.7)<right_Bottom.y?(_arrowPosition.y + _arrowHeight*0.7):right_Bottom.y);
            last_arrow   = CGPointMake(first_arrow.x, (first_arrow.y-_arrowHeight)>right_top.y?(first_arrow.y-_arrowHeight):right_top.y);
            
            [path moveToPoint:left_top];
            [path addLineToPoint:right_top];
            [path addLineToPoint:last_arrow];
            [path addLineToPoint:_arrowPosition];
            [path addLineToPoint:first_arrow];
            [path addLineToPoint:right_Bottom];
            [path addLineToPoint:left_Bottom];
            
        }
            break;
        case CJMenuArrowDirectionBottom:
        {
            left_top     = CGPointMake(_arrowPosition.x - _menuContentSize.width*_arrowProportion, _arrowPosition.y - _arrowHeight - _menuContentSize.height);
            left_Bottom  = CGPointMake(left_top.x, left_top.y + _menuContentSize.height);
            right_top    = CGPointMake(left_top.x + _menuContentSize.width, left_top.y);
            right_Bottom = CGPointMake(right_top.x, left_Bottom.y);
            
            first_arrow  = CGPointMake((_arrowPosition.x - _arrowHeight*0.7)>left_Bottom.x?(_arrowPosition.x - _arrowHeight*0.7):left_Bottom.x, left_Bottom.y);
            last_arrow   = CGPointMake((_arrowPosition.x + _arrowHeight*0.7)<right_Bottom.x?(_arrowPosition.x + _arrowHeight*0.7):right_Bottom.x, right_Bottom.y);
            
            [path moveToPoint:left_top];
            [path addLineToPoint:right_top];
            [path addLineToPoint:right_Bottom];
            [path addLineToPoint:last_arrow];
            [path addLineToPoint:_arrowPosition];
            [path addLineToPoint:first_arrow];
            [path addLineToPoint:left_Bottom];
            
        }
            break;
        default:
            break;
    }
    
    [path closePath];
    self.shapeLayer.path = path.CGPath;
    self.contentTableView.frame = CGRectMake(left_top.x, left_top.y, _menuContentSize.width, _menuContentSize.height);
    [self.contentTableView reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

-(void)show {
    self.hidden = NO;
}


-(void)dismiss {
    self.hidden = YES;
}


#pragma mark ---- private method
-(void)initDefaultParameters {
    _arrowHeight = 8.f;
    _arrowProportion  = 0.5f;
    _arrowDirection   = CJMenuArrowDirectionTop;
    _menuContentColor = [UIColor whiteColor];
    _menuContentBorderColor = [UIColor greenColor];
    _menuContentBorderWidth = 3.f;
    _fontSize         = 15.f;
    _fontColor        = [UIColor grayColor];
}


-(CGFloat)fetchMaxLenthFromAry:(NSArray <NSString *> *)contents {
    NSMutableArray *lengthAry = @[].mutableCopy;
    for (NSString *contentString in contents) {
        CGFloat length = [self stringWidthFontSize:_fontSize height:_fontSize string:contentString];
        [lengthAry addObject:@(length)];
    }
    [lengthAry sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    return [lengthAry.lastObject floatValue];
}

-(CGFloat)stringWidthFontSize:(CGFloat)fontSize height:(CGFloat)height string:(NSString *)string {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGRect stringRect = [string boundingRectWithSize:size
                                           options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return stringRect.size.width;
}



#pragma mark --- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contents.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kTableViewCellID = @"kTableViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellID];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor         = _menuContentColor;
        cell.textLabel.textColor     = _fontColor;
        cell.textLabel.font          = [UIFont systemFontOfSize:_fontSize];
    }
    cell.textLabel.text   = _contents[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectRowAtIndex:content:)]) {
        [self.delegate menuView:self didSelectRowAtIndex:indexPath.row content:_contents[indexPath.row]];
    }
}

#pragma mark -- setter
-(void)setArrowProportion:(CGFloat)arrowProportion {
    arrowProportion = arrowProportion > 0.f? arrowProportion:0.f;
    arrowProportion = arrowProportion < 1.f? arrowProportion:1.f;
    _arrowProportion = arrowProportion;
}

-(void)setContents:(NSArray<NSString *> *)contents {
    _contents = contents;
    
    CGFloat maxContentLength = [self fetchMaxLenthFromAry:contents] + 40;
    CGFloat maxContentHeight = contents.count * 44 - 1;
    _menuContentSize = CGSizeMake(maxContentLength, maxContentHeight);
}

#pragma mark ---- lazy method
-(UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] init];
        _contentTableView.delegate   = self;
        _contentTableView.dataSource = self;
        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.separatorInset  = UIEdgeInsetsMake(-50, 0, 0, 0);
        _contentTableView.rowHeight       = rowH;
        _contentTableView.layer.cornerRadius = 2;
        _contentTableView.layer.masksToBounds= YES;
    }
    return _contentTableView;
}


@end
