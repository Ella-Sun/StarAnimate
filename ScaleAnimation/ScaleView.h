//
//  ScaleView.h
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleView : UIView

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UILabel * msgLabel;

@property (nonatomic, copy) void(^TapBlock)();

- (void)animate;

- (void)animateToIdentify;

@end
