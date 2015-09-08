//
//  BubbleInfo.h
//  BubbleAnimation
//
//  Created by Brammanand Soni on 9/2/15.
//  Copyright (c) 2015 Brammanand Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BubbleInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic) CGFloat titleFontSize;
@property (nonatomic) CGRect frame;

@end
