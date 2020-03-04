//
//  QLFloatingView.m
//  微信悬浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import "QLFloatingView.h"

@implementation QLFloatingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
   self.layer.contents = (__bridge id)[UIImage imageNamed:@"shaper"].CGImage;
    
    return self;
}
@end
