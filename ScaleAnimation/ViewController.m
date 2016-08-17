//
//  ViewController.m
//  ScaleAnimation
//
//  Created by sunhong on 16/8/16.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ViewController.h"

#import "SkyView.h"

@interface ViewController ()

@property (nonatomic, strong) SkyView * skyView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *bgImge = [UIImage imageNamed:@"1"];
    self.view.layer.contents = (__bridge id)bgImge.CGImage;
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
    
    [self setupSkyView];
}

- (void)setupSkyView {
    if (_skyView) {
        return;
    }
    SkyView *skyView = [[SkyView alloc] initWithFrame:self.view.bounds];
    skyView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:skyView];
    
    _skyView = skyView;
}



@end
