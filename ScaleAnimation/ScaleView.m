//
//  ScaleView.m
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ScaleView.h"

static const CGFloat kAnimateTime = 1.0f;

@interface ScaleView ()



@end

@implementation ScaleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self generateImageView];
        [self generateMsgLabel];
        
        [self addTapGestureAtView:self withMethod:@selector(tapAction)];
    }
    return self;
}
/**
 *  生成图片
 */
- (void)generateImageView {
    
    if (_imageView) {
        return;
    }
    CGFloat width = 100;
    CGFloat height = 100;
    CGFloat yPixel = self.center.y - 100;
    CGFloat xPixel = (self.bounds.size.width - width) * 0.5;
    CGRect imageViewFrame = CGRectMake(xPixel, yPixel, width, height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
    UIImage *image = [UIImage imageNamed:@"004.jpg"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    imageView.image = image;
    
    [self addSubview:imageView];
    
    _imageView = imageView;
    _imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    _imageView.alpha = 0.5;
}

/**
 *  生成文字
 */
- (void)generateMsgLabel {
    if (_msgLabel) {
        return;
    }
    CGFloat xPixel = 10;
    CGFloat height = 30;
    CGFloat width = self.bounds.size.width - 2*xPixel;
    CGFloat yPixel = CGRectGetMinY(_imageView.frame) - 10 - height;
    CGRect labelFrame = CGRectMake(xPixel, yPixel, width, height);
    _msgLabel = [[UILabel alloc] initWithFrame:labelFrame];
    _msgLabel.text = @"message";
    _msgLabel.font = [UIFont systemFontOfSize:17.f];
    _msgLabel.textColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_msgLabel];
    
    _msgLabel.transform = CGAffineTransformMakeScale(0.8, 0.8);
    _msgLabel.alpha = 0.5;
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
- (void)animateMinWithView:(UIView *)view {
    
    [UIView animateWithDuration:kAnimateTime
                     animations:^{
                         view.alpha = 0.5f;
                         view.transform = CGAffineTransformMakeScale(0.8, 0.8);;
                     }];
}

- (void)animate {
    
    [self animateMaxWithView:_imageView];
    [self animateMaxWithView:_msgLabel];
}

- (void)animateToIdentify {
    
    [self animateMinWithView:_imageView];
    [self animateMinWithView:_msgLabel];
}

//添加手势
- (void)addTapGestureAtView:(UIView *)atView withMethod:(SEL)method {
    
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:method];
    [atView addGestureRecognizer:tapGuesture];
}

//手势事件
- (void)tapAction {
    if (self.TapBlock) {
        self.TapBlock();
    }
    [self animate];
}


@end
