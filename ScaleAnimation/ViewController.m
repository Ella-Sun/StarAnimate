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

@property (nonatomic, strong) ScaleView * scaleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self generateScaleView];
    [self addTapGesture];
}

- (void)generateScaleView {
    if (_scaleView) {
        return;
    }
    _scaleView  = [[ScaleView alloc] initWithFrame:self.view.bounds];
    _scaleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scaleView];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapAction)];
    [self.scaleView addGestureRecognizer:tapGuesture];
}

- (void)tapAction {
    [self.scaleView animate];
}

@end
