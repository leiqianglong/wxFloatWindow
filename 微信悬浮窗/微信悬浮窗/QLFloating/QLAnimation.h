//
//  QLAnimation.h
//  微信悬浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface QLAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)CGRect frame;
@end

NS_ASSUME_NONNULL_END
