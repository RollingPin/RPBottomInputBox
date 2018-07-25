
//
//  WTRootViewController.m
//  WTBottomInputBox
//
//  Created by Tao on 2018/7/23.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "WTRootViewController.h"
#import "WTBottomInputView.h"

#define WTWidth [UIScreen mainScreen].bounds.size.width
#define WTHeight [UIScreen mainScreen].bounds.size.height
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

@interface WTRootViewController ()<UITableViewDelegate,UITableViewDataSource,WTBottomInputViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource;
    
    WTBottomInputView * bottomView;
}

@end

@implementation WTRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"雪泥鸿爪";
    _dataSource = [NSMutableArray array];
    [self configData];
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [bottomView showView];  //此句用于在跳回时让bottomBox显示
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [bottomView hideView];   //此句用于在跳出其他页时让bottomBox消失
    
}

- (void)configData
{
    NSArray * contentArr = [NSArray arrayWithObjects:@"人生到处知何似，恰似飞鸿踏雪泥；",@"泥上偶然留指爪，鸿飞那复计东西。",@"老僧已死成新塔，坏壁无由见旧题；",@"人生到处知何似，恰似飞鸿踏雪泥；",@"往日崎岖还记否，路长人困蹇驴嘶。", nil];
    for (int i = 0; i<4; i++) {
        
        NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
        paramDic[@"content"] = contentArr[i];
        paramDic[@"subContent"] = @"王加水_RollingPin";
        [_dataSource addObject:paramDic];
    }
}
- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WTWidth, WTHeight-TAB_BAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    bottomView = [[WTBottomInputView alloc]init];
    //    [self.view addSubview:bottomView];
    bottomView.delegate = self;
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:bottomView];
}

#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * cellDic = _dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [cellDic objectForKey:@"content"];
    cell.detailTextLabel.text = [cellDic objectForKey:@"subContent"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}

- (void)WTBottomInputViewSendTextMessage:(NSString *)message
{
    NSLog(@"=======>>%@",message);
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"content"] = message;
    paramDic[@"subContent"] = @"王加水_RollingPin";
    
    [_dataSource insertObject:paramDic atIndex:0];
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    bottomView.textView.text = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
