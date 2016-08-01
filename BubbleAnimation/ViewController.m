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

@property (nonatomic, strong) BubbleAnimationView *bubbleAnimationView;

- (IBAction)startButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self performSelector:@selector(addBuubleAnimationView) withObject:nil afterDelay:10.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Private Methods

- (void)addBuubleAnimationView
{
    [self.bubbleAnimationView removeFromSuperview];
    self.bubbleAnimationView = nil;
    
    self.bubbleAnimationView = [[BubbleAnimationView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.bubbleAnimationView];
    [self.bubbleAnimationView animateBuubleViews];
}

#pragma mark
#pragma mark IBAction

- (IBAction)startButtonPressed:(UIBarButtonItem *)sender {
    [self addBuubleAnimationView];
}

@end
