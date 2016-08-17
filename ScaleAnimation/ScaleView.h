//
//  ScaleView.h
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleView : UIView

@property (nonatomic, assign) BOOL isMax;

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UILabel * msgLabel;


//变大 清晰
- (void)animate;

//变小 模糊 出现时的样子
- (void)animateToIdentify;

@end
