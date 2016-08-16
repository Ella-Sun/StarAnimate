//
//  ViewController.m
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ViewController.h"

#import "ScaleView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray * scaleArrays;

@property (nonatomic, strong) UIVisualEffectView *blurView;



@end

@implementation ViewController

- (NSMutableArray *)scaleArrays {
    if (!_scaleArrays) {
        _scaleArrays = [NSMutableArray array];
    }
    return _scaleArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *bgImge = [UIImage imageNamed:@"1"];
    self.view.layer.contents = (__bridge id)bgImge.CGImage;
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
    
    [self setupScaleViews];

    [self generateVisualEffectView];
}

#pragma mark - genetate

- (void)setupScaleViews {

    CGFloat widht = 100;
    
    CGRect scaleFrame = CGRectMake(50, 80, widht, widht);
    ScaleView *scaleView  = [self generateScaleViewWithFrame:scaleFrame];
    scaleView.tag = 130;
    [self.view addSubview:scaleView];
    
    CGRect scale1Frame = CGRectMake(80+widht, 80, widht, widht);
    ScaleView *scaleView1  = [self generateScaleViewWithFrame:scale1Frame];
    scaleView1.tag = 131;
    [self.view addSubview:scaleView1];
    
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
    blurView.frame = self.view.bounds;
    // 解除blurView自适应遮罩大小限制的变化，然后将它至于视图堆栈里的最下面。如果你把它加入了最上方，它会把所有的控制器都遮在下面。
//    [blurView setTranslatesAutoresizingMaskIntoConstraints:false];
//    [self.view insertSubview:blurView belowSubview:_scaleView];
    [self.view addSubview:blurView];
    
    // Vibrancy effect 生动效果
//    UIVibrancyEffect *vibrancyEffect =  [UIVibrancyEffect effectForBlurEffect:visualEffect];
//    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
//    vibrancyView.frame = self.view.bounds;

//    [vibrancyView setTranslatesAutoresizingMaskIntoConstraints:false];
    
//    [vibrancyView.contentView addSubview:_scaleArrays[0]];
    [blurView.contentView addSubview:self.scaleArrays[0]];
    [blurView.contentView addSubview:self.scaleArrays[1]];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:_blurView];
//    NSLog(@"pointX:%.2f______pointY:%.2f",point.x,point.y);
//    
//    for (ScaleView *scaleView in self.scaleArrays) {
//        if (scaleView == touch.view) {
//            NSLog(@"____success");
////            [_blurView.contentView addSubview:scaleView];
//        }
//    }
//}




@end
