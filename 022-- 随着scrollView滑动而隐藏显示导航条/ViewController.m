//
//  ViewController.m
//  022-- 随着scrollView滑动而隐藏显示导航条
//
//  Created by mac on 16/11/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "GXFNavigationBar.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

NSString *const reuseIdentifier = @"reuseIdentifier";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"555555";
    
    // 添加tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
    
}

// UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    return cell;
}

// UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    GXFLog(@"%f", scrollView.contentOffset.y);
    CGFloat y = scrollView.contentOffset.y;
    static CGFloat _y = 64;
    static CGFloat navigationBarY = 0;
    
    if (_y > y) {
        
        GXFLog(@"上");
        
        if (navigationBarY < 0) {
            navigationBarY += _y - y;
            
        }
        _y = y;
    
    } else if (_y < y) {
        
        GXFLog(@"下");
        
        if (navigationBarY > - 64) {
            navigationBarY -= y - (_y);
            
        }
        _y = y;
    }
    
    // 如果滚动到顶部，让navigationBarY = 0；
    if (y <= -64) {
        navigationBarY = 0;
    }
    
    // 如果NavigationBarY超过0，就设置为0
    if (navigationBarY > 0) {
        navigationBarY = 0;
    }
    
//    GXFLog(@"%f", navigationBarY);
    // 计算alpha
    CGFloat alpha =1 - (- navigationBarY) / 64;
    
    GXFNavigationBar *navigationBar = (GXFNavigationBar *)self.navigationController.navigationBar;
    
    [navigationBar setY:navigationBarY];
    [navigationBar setNavigationVarAlpha:alpha];
    
}

@end
