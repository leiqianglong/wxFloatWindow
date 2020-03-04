//
//  QLAnimatorImageView.h
//  微信悬浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface QLAnimatorImageView : UIImageView
-(void)startAnimatingWithView:(UIView *)toview fromRect:(CGRect)fromRect toRect:(CGRect)toRect;
-(void)startPopAnimatingWithView:(UIView *)toview fromRect:(CGRect)fromRect toRect:(CGRect)toRect;
@end

NS_ASSUME_NONNULL_END
