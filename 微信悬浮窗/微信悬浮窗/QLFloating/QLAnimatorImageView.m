//
//  QLAnimatorImageView.m
//  微信悬浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import "QLAnimatorImageView.h"
@interface QLAnimatorImageView()<CAAnimationDelegate>{
    CAShapeLayer *shapLayer;
    UIView *toView;
}

@end
@implementation QLAnimatorImageView

-(void)startAnimatingWithView:(UIView *)toview fromRect:(CGRect)fromRect toRect:(CGRect)toRect{
    toView = toview;
    shapLayer = [CAShapeLayer layer];
    shapLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30].CGPath;
    self.layer.mask = shapLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30].CGPath;
    anim.duration = 0.5f;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [shapLayer addAnimation:anim forKey:nil];
    
}

@end
