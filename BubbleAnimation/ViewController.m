//
//  ViewController.m
//  BubbleAnimation
//
//  Created by Brammanand Soni on 9/2/15.
//  Copyright (c) 2015 Brammanand Soni. All rights reserved.
//

#import "ViewController.h"
#import "BubbleAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addBuubleAnimationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Private Methods

- (void)addBuubleAnimationView
{
    BubbleAnimationView *bubbleAnimationView = [[BubbleAnimationView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:bubbleAnimationView];
    [bubbleAnimationView animateBuubleViews];
}

@end
