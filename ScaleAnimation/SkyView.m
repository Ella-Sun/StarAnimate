//
//  SkyView.m
//  ScaleAnimation
//
//  Created by sunhong on 16/8/17.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "SkyView.h"

#import "ScaleView.h"

static const CGFloat kWidth = 200;
static const CGFloat kHeight = 100;

static const CGFloat kAnimateTime = 1.0f;
static const CGFloat kBlurAlpha = 0.7;

@interface SkyView ()

@property (nonatomic, strong) NSMutableArray * scaleArrays;

@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation SkyView

#pragma mark - 预加载

- (NSMutableArray *)scaleArrays {
    if (!_scaleArrays) {
        _scaleArrays = [NSMutableArray array];
    }
    return _scaleArrays;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupScaleViews];
        
        [self generateVisualEffectView];
    }
    return self;
}

//创建两个ScaleView
- (void)setupScaleViews {
    
    //    CGFloat widht = 200;
    //    CGFloat height = 100;
    
    CGRect scaleFrame = CGRectMake(50, 80, kWidth, kHeight);
    ScaleView *scaleView  = [self generateScaleViewWithFrame:scaleFrame];
    scaleView.tag = 130;
    [self addSubview:scaleView];
    
    CGRect scale1Frame = CGRectMake(100, 200, kWidth, kHeight);
    ScaleView *scaleView1  = [self generateScaleViewWithFrame:scale1Frame];
    scaleView1.image = [UIImage imageNamed:@"8"];
    scaleView1.partTitle = @"其他信息";
    scaleView1.tag = 131;
    [self addSubview:scaleView1];
    
//        scaleView.backgroundColor = [UIColor cyanColor];
//        scaleView1.backgroundColor = [UIColor magentaColor];
    
    [self.scaleArrays addObject:scaleView];
    [self.scaleArrays addObject:scaleView1];
}

//点击其中一个 对其他view的消隐操作
- (void)tapActionAtView:(NSInteger)index {
    
    for (int i = 0; i < self.scaleArrays.count; i++) {
        
        ScaleView *scaleView = self.scaleArrays[i];
        if (i != index && scaleView.isMax) {
            
            [scaleView animateToIdentify];
            
        }
    }
}

#pragma mark - genetate

//生成ScaleView的模板
- (ScaleView *)generateScaleViewWithFrame:(CGRect)frame {
    
    ScaleView *scaleView  = [[ScaleView alloc] initWithFrame:frame];
    scaleView.backgroundColor = [UIColor clearColor];
    
    return scaleView;
}

/**
 *  添加毛玻璃
 */
- (void)generateVisualEffectView {
    
    // Blur effect 模糊效果
    UIBlurEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
    blurView.alpha = 0.1;//kBlurAlpha;
    blurView.frame = self.bounds;
    
    [self addSubview:blurView];
    
//    [blurView.contentView addSubview:self.scaleArrays[0]];
//    [blurView.contentView addSubview:self.scaleArrays[1]];
    
    _blurView = blurView;
}

/**
 *  覆写父类触摸
 *
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *hitView = [super hitTest:point withEvent:event];
    
//    NSLog(@"pointX:%f,pointY:%f",point.x,point.y);
//    NSLog(@"vvvvv:%@",hitView);
    
    if (hitView == _blurView || hitView == _blurView.contentView) {
        [self operateTouchActionWithTouchPoint:point];
        return nil;
    } else {
        return hitView;
    }
}

/**
 *  操作：判断是否点击星星
 *
 *  如果点击星星：判断其他星星是否不是原状，即放大，使其恢复
 *  如果点击不是：判断所有星星是否不是原状，使其恢复
 *
 *  @param point 点击point
 */
- (void)operateTouchActionWithTouchPoint:(CGPoint)point {
    
    NSInteger touchIndex = [self judgePointInView:point];
    
    //判断模糊需不需要消失
    BOOL isScaleView = touchIndex < self.scaleArrays.count?YES:NO;
    [UIView animateWithDuration:kAnimateTime animations:^{
        if (!isScaleView) {//没有点击scaleView 渐隐藏
            _blurView.alpha = 0.1;
        } else {
             _blurView.alpha = kBlurAlpha;
        }
    }];
    
    
    [self bringSubviewToFront:_blurView];
    
//    NSLog(@"touchIndex%ld",touchIndex);
    
    for (int i = 0; i < self.scaleArrays.count; i++) {
        
        ScaleView *scaleView = self.scaleArrays[i];
        if (i == touchIndex) {//判断是否放大，否则使其放大

            [self insertSubview:scaleView aboveSubview:_blurView];
            if (scaleView.isMax) {
                continue;
            } else {
                [scaleView animate];
            }
        } else {//所有归位
            if (scaleView.isMax) {
                [scaleView animateToIdentify];
            }
        }
    }
}

/**
 *  判断是否点击星星
 *
 *  @param touchPoint 点击point
 *
 *  @return 星星下标
 */
- (NSInteger)judgePointInView:(CGPoint)touchPoint {
    
    CGFloat touchX = touchPoint.x;
    CGFloat touchY = touchPoint.y;
    
    NSInteger touchIndex = self.scaleArrays.count;
    
    for (int i = 0; i < self.scaleArrays.count; i++) {
        ScaleView *scaleView = self.scaleArrays[i];
        CGFloat minX = CGRectGetMinX(scaleView.frame);
        CGFloat maxX = CGRectGetMaxX(scaleView.frame);
        CGFloat minY = CGRectGetMinY(scaleView.frame);
        CGFloat maxY = CGRectGetMaxY(scaleView.frame);
        
        if ((touchX > minX && touchX < maxX) && (touchY > minY && touchY < maxY)) {
            touchIndex = i;
            return touchIndex;
        }
    }
    return touchIndex;
}


@end
