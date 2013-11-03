//
//  paperListViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-11-3.
//
//

#import "paperListViewController.h"
#import "paperCellViewController.h"
@interface paperListViewController ()

@end

@implementation paperListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 下拉刷新
    self._header = [[MJRefreshHeaderView alloc] init];
    self._header.delegate = self;
    self._header.scrollView = self.tableview;
    
    // 上拉加载更多
    self._footer = [[MJRefreshFooterView alloc] init];
    self._footer.delegate = self;
    self._footer.scrollView = self.tableview;
    
    // 假数据
    self._data = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (self._header == refreshView) {
        for (int i = 0; i<5; i++) {
            [self._data insertObject:[formatter stringFromDate:[NSDate date]] atIndex:0];
        }
        
    } else {
        for (int i = 0; i<5; i++) {
            [self._data addObject:[formatter stringFromDate:[NSDate date]]];
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self.tableview selector:@selector(reloadData) userInfo:nil repeats:NO];
}

- (void)dealloc
{
    // 释放资源
    [self._footer free];
    [self._header free];
}

#pragma mark 数据源-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 让刷新控件恢复默认的状态
    [self._header endRefreshing];
    [self._footer endRefreshing];
    
    return self._data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [@"PushInformationCell" stringByAppendingFormat:@"%d", indexPath.row];
    paperCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *aNib = [[NSBundle mainBundle]loadNibNamed:@"paperCellViewController" owner:self options:nil];
        cell = [aNib objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    }

    
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
