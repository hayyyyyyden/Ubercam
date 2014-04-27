//
//  FollowButton.m
//  ubercam
//
//  Created by Yixiong on 14-4-27.
//  Copyright (c) 2014年 Fang YiXiong. All rights reserved.
//

#import "FollowButton.h"

@implementation FollowButton

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonPressed{
    [self.delegate followButton:self didTapWithSectionIndex:self.sectionIndex];
}

@end
