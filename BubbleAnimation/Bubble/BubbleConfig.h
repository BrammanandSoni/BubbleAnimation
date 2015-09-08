//
//  BubbleConfig.h
//  BubbleAnimation
//
//  Created by Brammanand Soni on 9/2/15.
//  Copyright (c) 2015 Brammanand Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BubbleInfo.h"

@interface BubbleConfig : NSObject

// Returns an Array of "BubbleInfo" objects
+(NSArray *)getBubbleInfoArray;

// Adds Tap gesture to view
+(void)addTapGestureToView:(UIView *)view
                    target:(id)target
                  selector:(SEL)selector;

@end
