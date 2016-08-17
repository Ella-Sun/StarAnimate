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

//设置显示图片
@property (nonatomic, strong) UIImage * image;

//设置文字标题
@property (nonatomic, strong) NSString * partTitle;


//变大 清晰
- (void)animate;

//变小 模糊 出现时的样子
- (void)animateToIdentify;

@end
