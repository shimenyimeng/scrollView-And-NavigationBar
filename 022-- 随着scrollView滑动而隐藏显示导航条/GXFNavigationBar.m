//
//  GXFNavigationBar.m
//  022-- 随着scrollView滑动而隐藏显示导航条
//
//  Created by mac on 16/11/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GXFNavigationBar.h"

@implementation GXFNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
//        self.tintColor = [UIColor blueColor];
        self.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
        self.barTintColor = [UIColor yellowColor];
    }
    
    return self;
}

- (void)setY:(CGFloat)y {
    
    self.transform = CGAffineTransformMakeTranslation(0, y);
    
}

- (void)setNavigationVarAlpha:(CGFloat)alpha {
    
    // 遍历子控件
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.alpha = alpha;
        
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.alpha = alpha;
        
    }];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
    
    UIView *titleView = [self valueForKeyPath:@"_titleView"];
    titleView.alpha = alpha;
}

@end
