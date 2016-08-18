//
//  ScaleView.m
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ScaleView.h"

static const CGFloat kAnimateTime = 1.0f;

static const CGFloat kLabelScale= 0.4;

static const CGFloat kImageScale = 0.7;

//static const CGFloat kPercent = 0.6;//文字所占百分比

@interface ScaleView ()

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UILabel * msgLabel;

@end

@implementation ScaleView

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

- (void)setPartTitle:(NSString *)partTitle {
    _partTitle = partTitle;
    _msgLabel.text = partTitle;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self generateMsgLabel];
        [self generateImageView];
        
//        [self addTapGestureAtView:self withMethod:@selector(tapAction)];
    }
    return self;
}

/**
 *  生成文字
 */
- (void)generateMsgLabel {
    if (_msgLabel) {
        return;
    }
    CGFloat xPixel = 0;
    CGFloat yPixel = 0;
    CGFloat height = 50;
    CGFloat width = self.bounds.size.width - 2*xPixel;
    CGRect labelFrame = CGRectMake(xPixel, yPixel, width, height);
    _msgLabel = [[UILabel alloc] initWithFrame:labelFrame];
    _msgLabel.text = @"信息统计";
    _msgLabel.font = [UIFont systemFontOfSize:40.f];
    _msgLabel.textColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_msgLabel];
    
    _msgLabel.transform = CGAffineTransformMakeScale(kLabelScale, kLabelScale);
    _msgLabel.alpha = 0.5;
}

/**
 *  生成图片
 */
- (void)generateImageView {
    
    if (_imageView) {
        return;
    }
    CGFloat width = 40;
    CGFloat height = 40;
    CGFloat yPixel = CGRectGetMaxY(_msgLabel.frame) + 7;
    CGFloat xPixel = (self.bounds.size.width - width) * 0.5;
    CGRect imageViewFrame = CGRectMake(xPixel, yPixel, width, height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
    UIImage *image = [UIImage imageNamed:@"7"];
    imageView.image = image;
    
    [self addSubview:imageView];
    
    _imageView = imageView;
    _imageView.transform = CGAffineTransformMakeScale(kImageScale, kImageScale);
    _imageView.alpha = 0.5;
}

/**
 *  动画  放大 透明度1
 *
 *  @param view
 */
- (void)animateMaxWithView:(UIView *)view {
    
    [UIView animateWithDuration:kAnimateTime
                     animations:^{
                         view.alpha = 1.0f;
                         view.transform = CGAffineTransformIdentity;
                     }];
}

/**
 *  动画 缩小 透明度0.5
 *
 *  @param view 操作view
 */
- (void)animateMinWithView:(UIView *)view withAlpha:(CGFloat)alpha andScale:(CGFloat)scale{
    
    [UIView animateWithDuration:kAnimateTime
                     animations:^{
                         view.alpha = alpha;
                         view.transform = CGAffineTransformMakeScale(scale, scale);
                     }];
}

- (void)animate {
    self.isMax = YES;
    [self animateMaxWithView:_imageView];
    [self animateMaxWithView:_msgLabel];
}

- (void)animateToIdentify {
    self.isMax = NO;
    [self animateMinWithView:_imageView withAlpha:0.5 andScale:kImageScale];
    [self animateMinWithView:_msgLabel withAlpha:0.5 andScale:kLabelScale];
}

//添加手势
//- (void)addTapGestureAtView:(UIView *)atView withMethod:(SEL)method {
//    
//    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]
//                                           initWithTarget:self
//                                           action:method];
//    [atView addGestureRecognizer:tapGuesture];
//}

//手势事件
//- (void)tapAction {
//    if (self.TapBlock) {
//        self.TapBlock();
//    }
//    [self animate];
//}


@end
