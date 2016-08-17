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

@interface SkyView ()

@property (nonatomic, strong) NSMutableArray * scaleArrays;

@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation SkyView

- (NSMutableArray *)scaleArrays {
    if (!_scaleArrays) {
        _scaleArrays = [NSMutableArray array];
    }
    return _scaleArrays;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupScaleViews];
        
        [self generateVisualEffectView];
    }
    return self;
}

#pragma mark - genetate

- (void)setupScaleViews {
    
    //    CGFloat widht = 200;
    //    CGFloat height = 100;
    
    CGRect scaleFrame = CGRectMake(50, 80, kWidth, kHeight);
    ScaleView *scaleView  = [self generateScaleViewWithFrame:scaleFrame];
    scaleView.tag = 130;
    [self addSubview:scaleView];
    
    CGRect scale1Frame = CGRectMake(100, 200, kWidth, kHeight);
    ScaleView *scaleView1  = [self generateScaleViewWithFrame:scale1Frame];
    scaleView1.tag = 131;
    [self addSubview:scaleView1];
    
    //    scaleView.backgroundColor = [UIColor cyanColor];
    //    scaleView1.backgroundColor = [UIColor magentaColor];
    
    __block typeof(self)blockSelf = self;
    scaleView.TapBlock = ^(){
        [blockSelf tapActionAtView:0];
    };
    
    scaleView1.TapBlock = ^(){
        [blockSelf tapActionAtView:1];
    };
    
    [self.scaleArrays addObject:scaleView];
    [self.scaleArrays addObject:scaleView1];
}

- (void)tapActionAtView:(NSInteger)index {
    
    for (int i = 0; i < self.scaleArrays.count; i++) {
        if (i != index) {
            
            ScaleView *scaleView = self.scaleArrays[i];
            [scaleView animateToIdentify];
        }
    }
}

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
    blurView.alpha = 0.8;
    blurView.frame = self.bounds;
    
    [self addSubview:blurView];
    
    [blurView.contentView addSubview:self.scaleArrays[0]];
    [blurView.contentView addSubview:self.scaleArrays[1]];
}

@end
