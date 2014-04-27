//
//  FollowButton.h
//  ubercam
//
//  Created by Yixiong on 14-4-27.
//  Copyright (c) 2014年 Fang YiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FollowButton;
@protocol FollowButtonDelegate
- (void) followButton:(FollowButton *)button didTapWithSectionIndex:(NSInteger)index;
@end


@interface FollowButton : UIButton
@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, weak) id<FollowButtonDelegate> delegate;
@end
