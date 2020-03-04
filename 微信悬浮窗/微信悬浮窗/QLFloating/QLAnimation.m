//
//  QLAnimation.m
//  微信悬浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import "QLAnimation.h"
#import "QLAnimatorImageView.h"
@implementation QLAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    //截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    QLAnimatorImageView *imageView = [[QLAnimatorImageView alloc]initWithFrame:toView.bounds];
    [containerView addSubview:imageView];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    toView.hidden = YES;
    
    //0.5s是 展开的动画时长
    [imageView startAnimatingWithView:toView fromRect:self.frame toRect:toView.frame];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:YES];
    });
    
    
}
@end
