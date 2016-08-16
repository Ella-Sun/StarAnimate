//
//  ScaleView.m
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ScaleView.h"

static const CGFloat kAnimateTime = 2.0f;

@interface ScaleView ()

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UILabel * msgLabel;

@end

@implementation ScaleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self generateImageView];
        [self generateMsgLabel];
    }
    return self;
}

- (void)generateImageView {
    
    if (_imageView) {
        return;
    }
    CGFloat width = 200;
    CGFloat height = 200;
    CGFloat yPixel = self.center.y - 200;
    CGFloat xPixel = (self.bounds.size.width - width) * 0.5;
    CGRect imageViewFrame = CGRectMake(xPixel, yPixel, width, height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    imageView.image = [UIImage imageNamed:@"004.jpg"];
    [self addSubview:imageView];
    
    _imageView = imageView;
}

- (void)generateMsgLabel {
    if (_msgLabel) {
        return;
    }
    CGFloat xPixel = 10;
    CGFloat width = self.bounds.size.width - 2*xPixel;
    CGFloat yPixel = CGRectGetMaxY(_imageView.frame) + 80;
    CGRect labelFrame = CGRectMake(xPixel, yPixel, width, 50);
    _msgLabel = [[UILabel alloc] initWithFrame:labelFrame];
    _msgLabel.text = @"这是一条提示信息/This is a message";
    _msgLabel.font = [UIFont systemFontOfSize:17.f];
    _msgLabel.textColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    _msgLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_msgLabel];
}

- (void)animateWithImageView {
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnima.toValue = [NSNumber numberWithFloat:1.5f];
    
    CABasicAnimation *alphaAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnima.toValue = [NSNumber numberWithFloat:0.5f];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[scaleAnima,alphaAnima];
    groupAnima.duration = kAnimateTime;
    
    [_imageView.layer addAnimation:groupAnima forKey:@"msgLabelAnimate"];
}

- (void)animateWithLabel {
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnima.fromValue = [NSNumber numberWithFloat:0.5f];
    scaleAnima.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *alphaAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnima.fromValue = [NSNumber numberWithFloat:0.01f];
    alphaAnima.toValue = [NSNumber numberWithFloat:1.0f];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[scaleAnima,alphaAnima];
    groupAnima.duration = kAnimateTime;
    
    [_msgLabel.layer addAnimation:groupAnima forKey:@"msgLabelAnimate"];
}

- (void)animate {
    [self animateWithLabel];
    [self animateWithImageView];
}


@end
