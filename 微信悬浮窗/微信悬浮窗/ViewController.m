//
//  ViewController.m
//  微信悬浮窗
//
//  Created by 龙强雷 on 2019/12/15.
//  Copyright © 2019 龙强雷. All rights reserved.
//

#import "ViewController.h"
#import "QLFloatingBtn.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}
- (IBAction)addFloatingBtn:(id)sender {
    [QLFloatingBtn show];
}


@end
