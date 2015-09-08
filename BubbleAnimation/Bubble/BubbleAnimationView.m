//
//  BubbleAnimationView.m
//  BubbleAnimation
//
//  Created by Brammanand Soni on 9/8/15.
//  Copyright (c) 2015 Brammanand Soni. All rights reserved.
//

#import "BubbleAnimationView.h"
#import "BubbleConfig.h"
#import "BubbleInfo.h"

#define TITLE_TAG 100
#define SUBTITLE_TAG 101

#define ZOOM_ANIMATION_DURATION 0.3

@interface BubbleAnimationView ()
{
    NSInteger previousIndex;
}

@property(nonatomic, strong) NSArray *bubbleInfoArray;
@property(nonatomic, strong) NSMutableArray *bubbleViewsArray;
@property (nonatomic ,strong) NSTimer *animationTimer;

@property (nonatomic, strong) UIView *selectedBubbleView;
@property (nonatomic, strong) UIView *overlayBubbleView;

@property (strong, nonatomic) UIView *bubbleContainerView;

@property (nonatomic, strong) UITapGestureRecognizer *tapOutsideDismiss;

@end

@implementation BubbleAnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

#pragma mark
#pragma mark Private Methods

- (void)addGestureForTapOutside
{
    self.tapOutsideDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutSideDismiss:)];
    self.tapOutsideDismiss.numberOfTapsRequired = 1;
    [self.bubbleContainerView addGestureRecognizer:self.tapOutsideDismiss];
    [self.tapOutsideDismiss setEnabled:NO];
}

- (void)animateBuubleViews
{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.7;
    
    self.bubbleContainerView = [[UIView alloc] initWithFrame:self.frame];
    self.bubbleContainerView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bubbleContainerView];
    
    [self addGestureForTapOutside];
    
    self.bubbleInfoArray = [BubbleConfig getBubbleInfoArray];
    
    self.bubbleViewsArray = [NSMutableArray array];
    
    for (BubbleInfo *info in self.bubbleInfoArray) {
        UIView *bubbleView = [[UIView alloc] initWithFrame:info.frame];
        bubbleView.layer.cornerRadius = bubbleView.frame.size.width / 2;
        bubbleView.clipsToBounds = YES;
        bubbleView.backgroundColor = info.bgColor;
        bubbleView.tag = [self.bubbleInfoArray indexOfObject:info];
        
        // Title Label
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, bubbleView.frame.size.height/2-20, bubbleView.frame.size.width-10, 40)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 3;
        titleLabel.text = info.title;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:info.titleFontSize];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.tag = TITLE_TAG;
        
        [bubbleView addSubview:titleLabel];
        [self.bubbleContainerView addSubview:bubbleView];
        
        [BubbleConfig addTapGestureToView:bubbleView target:self selector:@selector(onTapBubbleViews:)];
        
        [self.bubbleViewsArray addObject:bubbleView];
    }
    
    for (UIView *view in self.bubbleViewsArray) {
        view.userInteractionEnabled = NO;
        view.hidden = YES;
    }
    
    [self performSelector:@selector(animateBubbleViews:) withObject:nil afterDelay:0.2];
}

- (void)animateBubbleViews:(id)sender
{
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animateSingleBubble:) userInfo:nil repeats:YES];
}

- (void)animateSingleBubble:(id)snder
{
    if (previousIndex < self.bubbleViewsArray.count) {
        UIView *view = [self.bubbleViewsArray objectAtIndex:previousIndex ++];
        view.hidden = NO;
        [self animateView:view];
    }
    else{
        [self.animationTimer invalidate];
        for (UIView *view in self.bubbleViewsArray) {
            view.userInteractionEnabled = YES;
        }
    }
}

- (void)animateView:(UIView *)view
{
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.30 initialSpringVelocity:5.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

- (CGFloat)getScalingfactor
{
    CGFloat viewWidth = self.selectedBubbleView.frame.size.width;
    
    return 200.0/viewWidth;
}

-(void)springAnimationOnBubble:(CGFloat)matrixVal
                       zoomVal:(CGFloat)zoomVal
                      movement:(BOOL)movement
                     iteration:(NSInteger)iteration
{
    if(zoomVal >= ZOOM_ANIMATION_DURATION / 10)
    {
        [UIView animateWithDuration:zoomVal animations:^{
            self.selectedBubbleView.transform = CGAffineTransformMakeScale(self.selectedBubbleView.transform.a-matrixVal, self.selectedBubbleView.transform.d-matrixVal);
        } completion:^(BOOL finished) {
            
            CGFloat matrixValue = !movement ? -(matrixVal * 0.5) : -(matrixVal);
            NSInteger iter =  iteration + 1;
            [self springAnimationOnBubble:matrixValue
                                  zoomVal:ZOOM_ANIMATION_DURATION /(iter+1)
                                 movement:!movement
                                iteration:iter];
        }];
        
    }
    else
    {
        [self.tapOutsideDismiss setEnabled:YES];
    }
}

- (void)onTapBubbleViews:(UITapGestureRecognizer *)recognizer
{
    self.selectedBubbleView = recognizer.view;
    
    for (UIView *view in self.bubbleViewsArray) {
        if (view.tag != self.selectedBubbleView.tag) {
            view.hidden = YES;
        }
    }
    
    [self.bubbleContainerView bringSubviewToFront:self.selectedBubbleView];
    
    [UIView animateWithDuration:ZOOM_ANIMATION_DURATION animations:^{
        self.selectedBubbleView.transform = CGAffineTransformMakeScale([self getScalingfactor]+1, [self getScalingfactor]+1);
        self.selectedBubbleView.center = self.bubbleContainerView.center;
        UILabel *label = (UILabel *)[self.selectedBubbleView viewWithTag:TITLE_TAG];
        label.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [self springAnimationOnBubble:1
                              zoomVal:ZOOM_ANIMATION_DURATION / 2
                             movement:FALSE
                            iteration:1];
        
        self.overlayBubbleView = [[UIView alloc] initWithFrame:self.selectedBubbleView.frame];
        self.overlayBubbleView.layer.cornerRadius = self.overlayBubbleView.frame.size.width / 2;
        self.overlayBubbleView.clipsToBounds = YES;
        self.overlayBubbleView.backgroundColor = self.selectedBubbleView.backgroundColor;
        
        BubbleInfo *data = [self.bubbleInfoArray objectAtIndex:self.selectedBubbleView.tag];
        
        // title label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = data.title;
        titleLabel.numberOfLines = 2;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.tag = TITLE_TAG;
        titleLabel.frame = CGRectMake(25, 40, self.overlayBubbleView.frame.size.width-50, 40);
        
        [self.overlayBubbleView addSubview:titleLabel];
        
        // Subtitle Label
        
        UILabel *subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.text = data.desc;
        subTitleLabel.numberOfLines = 10;
        subTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.textColor = [UIColor whiteColor];
        subTitleLabel.tag = SUBTITLE_TAG;
        subTitleLabel.alpha = 0.6;
        subTitleLabel.frame = CGRectMake(15, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, self.overlayBubbleView.frame.size.width- 30, 70);
        [subTitleLabel sizeToFit];
        
        [self.overlayBubbleView addSubview:subTitleLabel];
        
        [self.bubbleContainerView addSubview:self.overlayBubbleView];
        self.overlayBubbleView.alpha = 0.0;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.overlayBubbleView.alpha = 1.0;
        }completion:^(BOOL finished) {
        }];
    }];
}

- (void)tapOutSideDismiss:(UITapGestureRecognizer *)recognizer
{
    [self.tapOutsideDismiss setEnabled:NO];
    for (UIView *view in self.bubbleViewsArray) {
        view.hidden = NO;
    }
    [self.overlayBubbleView removeFromSuperview];
    
    [UIView animateWithDuration:ZOOM_ANIMATION_DURATION animations:^{
        self.selectedBubbleView.transform = CGAffineTransformIdentity;
        UILabel *label = (UILabel *)[self.selectedBubbleView viewWithTag:TITLE_TAG];
        label.alpha = 1.0;
        
        BubbleInfo *info = [self.bubbleInfoArray objectAtIndex:self.selectedBubbleView.tag];
        self.selectedBubbleView.frame = info.frame;
        
    }completion:^(BOOL finished) {
        
    }];
}

@end
