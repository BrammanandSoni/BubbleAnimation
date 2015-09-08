//
//  BubbleConfig.m
//  BubbleAnimation
//
//  Created by Brammanand Soni on 9/2/15.
//  Copyright (c) 2015 Brammanand Soni. All rights reserved.
//

#import "BubbleConfig.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define X_PROP SCREEN_WIDTH / 320
#define Y_PROP SCREEN_HEIGHT / 480

#define SIZE_PROP SCREEN_WIDTH / 320

#define SMALL_FONT_SIZE 12.0 * SIZE_PROP
#define LARGE_FONT_SIZE 14.0 * SIZE_PROP

#define LARGE_BUBBLE_SIZE 70
#define SMALL_BUBBLE_SIZE 50

@implementation BubbleConfig

+(NSArray *)getBubbleInfoArray
{
    NSMutableArray *createProDataArray = [NSMutableArray array];
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 1";
        info.desc = @"This is the Description of Title 1 From BubbleInfo file.";
        info.bgColor = [UIColor redColor];
        info.frame = CGRectMake(110*X_PROP, 110*Y_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = LARGE_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 2";
        info.desc = @"This is the Description of Title 2. From BubbleInfo file.";
        info.bgColor = [UIColor greenColor];
        info.frame = CGRectMake(200*X_PROP, 155*Y_PROP, SMALL_BUBBLE_SIZE*SIZE_PROP, SMALL_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = SMALL_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 3";
        info.desc = @"This is the Description of Title 3. From BubbleInfo file.";
        info.bgColor = [UIColor blueColor];
        info.frame = CGRectMake(35*X_PROP, 190*Y_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = LARGE_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 4";
        info.desc = @"This is the Description of Title 4. From BubbleInfo file.";
        info.bgColor = [UIColor brownColor];
        info.frame = CGRectMake(119*X_PROP, 187*Y_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = LARGE_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 5";
        info.desc = @"This is the Description of Title 5. From BubbleInfo file.";
        info.bgColor = [UIColor grayColor];
        info.frame = CGRectMake(175*X_PROP, 245*Y_PROP, SMALL_BUBBLE_SIZE*SIZE_PROP, SMALL_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = SMALL_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 6";
        info.desc = @"This is the Description of Title 6. From BubbleInfo file.";
        info.bgColor = [UIColor magentaColor];
        info.frame = CGRectMake(227*X_PROP, 209*Y_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = LARGE_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 7";
        info.desc = @"This is the Description of Title 7. From BubbleInfo file.";
        info.bgColor = [UIColor orangeColor];
        info.frame = CGRectMake(55*X_PROP, 266*Y_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = LARGE_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    {
        BubbleInfo *info = [[BubbleInfo alloc] init];
        info.title = @"Title 8";
        info.desc = @"This is the Description of Title 8. From BubbleInfo file.";
        info.bgColor = [UIColor purpleColor];
        info.frame = CGRectMake(132*X_PROP, 295*Y_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP, LARGE_BUBBLE_SIZE*SIZE_PROP);
        info.titleFontSize = LARGE_FONT_SIZE;
        
        [createProDataArray addObject:info];
    }
    
    return createProDataArray;
}

+(void)addTapGestureToView:(UIView *)view
                    target:(id)target
                  selector:(SEL)selector
{
    view.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    tap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tap];
}

@end
