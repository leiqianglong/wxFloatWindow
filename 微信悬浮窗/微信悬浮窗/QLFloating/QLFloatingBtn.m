//
//  QLFloatingBtn.m
//  微信浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import "QLFloatingBtn.h"
#import "QLFloatingView.h"
#import "BViewController.h"
#import "QLAnimation.h"
@interface QLFloatingBtn()<UINavigationControllerDelegate>{
    CGPoint lastPoint;
    CGPoint pointInSelf;
}

@end
#define fixedSpace 160.0f

@implementation QLFloatingBtn
static CGFloat floatingBtnRadius = 30.f;
static QLFloatingBtn *floatingBtn;
static QLFloatingView *floatingView;
+ (void)show{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatingBtn = [[QLFloatingBtn alloc]initWithFrame:CGRectMake(10.f, 200.f, floatingBtnRadius*2, floatingBtnRadius*2)];
        floatingView = [[QLFloatingView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace)];
    });
    //添加到window层
    //先添加floatingview
    if (!floatingView.superview) {
        [[self getMainWindow] addSubview:floatingView];
    }
    if (!floatingBtn.superview) {
        [[self getMainWindow] addSubview:floatingBtn];
        [[self getMainWindow] bringSubviewToFront:floatingBtn];
    }
   
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"floatingBtn"].CGImage;
    
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     UITouch *touch = [touches anyObject];
     CGPoint currentPoint = [touch locationInView:self.superview];
    
    //四分之一元动画展开
    if (CGRectEqualToRect(floatingView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace))) {
        [UIView animateWithDuration:0.3 animations:^{
            floatingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-fixedSpace, [UIScreen mainScreen].bounds.size.height-fixedSpace, fixedSpace, fixedSpace);
        }];
    }
    
    //计算控x中心点
    CGFloat centerX = currentPoint.x + (self.frame.size.width * 0.5 - pointInSelf.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height * 0.5 - pointInSelf.y);
    CGFloat x = MAX(floatingBtnRadius, MIN([UIScreen mainScreen].bounds.size.width-floatingBtnRadius, centerX));
    CGFloat y = MAX(floatingBtnRadius, MIN([UIScreen mainScreen].bounds.size.height-floatingBtnRadius, centerY));
    self.center = CGPointMake(x, y);
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {
        
        //点击效果
        UINavigationController *nav = (UINavigationController *)[QLFloatingBtn getMainWindow].rootViewController;
        BViewController *bvc = [[BViewController alloc]init];
        nav.delegate = self;
        [nav pushViewController:bvc animated:YES];
        return;
    }
   
    
    //四分之一元动画收起
    [UIView animateWithDuration:0.3 animations:^{
        //两个圆心的距离 <= 两个半径之差，说明了floatingBtn在 floatingview内部，就移除floatingBtn
        CGFloat distance = sqrt(pow([UIScreen mainScreen].bounds.size.width-self.center.x, 2) + pow([UIScreen mainScreen].bounds.size.height - self.center.y, 2));
        
        if (distance <= fixedSpace - floatingBtnRadius) {
            [self removeFromSuperview];
        }
        
      floatingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace);
    }];
   
    //吸边
    CGFloat leftMargin = self.center.x;
    CGFloat rightmargin = [UIScreen mainScreen].bounds.size.width - leftMargin;
    
    if (leftMargin < rightmargin) {
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake(40.0, self.center.y);
        }];
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width-40.0, self.center.y);
        }];
    }
}



+(UIWindow *)getMainWindow{
    UIWindow* window = nil;
           if (@available(iOS 13.0, *))
           {
               for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
               {
                   if (windowScene.activationState == UISceneActivationStateForegroundActive)
                   {
                       window = windowScene.windows.firstObject;
                       break;
                   }
               }
           }else{
               window = [UIApplication sharedApplication].keyWindow;
           }
    return window;
}



- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
animationControllerForOperation:(UINavigationControllerOperation)operation
             fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        QLAnimation *an = [[QLAnimation alloc]init];
        an.frame = self.frame;
        return an;
        
    }
    return nil;
}









@end
