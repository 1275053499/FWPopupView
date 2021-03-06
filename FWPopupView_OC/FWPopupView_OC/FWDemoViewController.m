//
//  FWDemoViewController.m
//  FWPopupView
//
//  Created by xfg on 2018/3/27.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWDemoViewController.h"
#import <FWPopupView/FWPopupView-Swift.h>
#import "FWCustomDemoVC.h"

#define kRGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]

@interface FWDemoViewController ()

@property (nonatomic, strong) NSArray       *titleArray;
@property (nonatomic, strong) FWAlertView   *alertWithImageView;

@end

@implementation FWDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"FWPopupView";
    
    self.titleArray = @[@"Alert - 单个按钮", @"Alert - 两个按钮", @"Alert - 两个按钮（修改参数）", @"Alert - 多个按钮", @"Alert - 带输入框", @"Alert - 带自定义视图", @"Sheet - 少量Item", @"Sheet - 大量Item", @"Date - 自定义日期选择", @"Custom - 自定义弹窗"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.estimatedRowHeight = 44.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    if (indexPath.row == 9) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            FWAlertView *alertView = [FWAlertView alertWithTitle:@"标题" detail:@"描述描述描述描述" confirmBlock:^(FWPopupView *popupView, NSInteger index) {
                
            }];
            [alertView show];
        }
            break;
        case 1:
        {
            FWAlertView *alertView = [FWAlertView alertWithTitle:@"标题" detail:@"描述描述描述描述描述描述描述描述描述描述" confirmBlock:^(FWPopupView *popupView, NSInteger index) {
                NSLog(@"点击了确定");
            } cancelBlock:^(FWPopupView *popupView, NSInteger index) {
                NSLog(@"点击了确定");
            }];
            
            [alertView showWithCompletionBlock:^(FWPopupView * popupView, BOOL isCompletion) {
                
            }];
        }
            break;
        case 2:
        {
            id block = ^(FWPopupView *popupView, NSInteger index){
                NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
            };
            
            // 注意：此时“确定”按钮是不让按钮自己隐藏的
            NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemTitleColor:kRGB(141, 151, 163) itemBackgroundColor:nil itemClickedBlock:block],
                               [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemTitleColor:kRGB(29, 150, 227) itemBackgroundColor:nil itemClickedBlock:block]];
            
            FWAlertViewProperty *vProperty = [[FWAlertViewProperty alloc] init];
            vProperty.alertViewWidth = MAX([UIScreen mainScreen].bounds.size.width * 0.65, 275);
            vProperty.titleFontSize = 17.0;
            vProperty.detailFontSize = 14.0;
            vProperty.detailColor = kRGB(141, 151, 163);
            vProperty.buttonFontSize = 14.0;
            // 还有很多参数可设置...
            
            FWAlertView *alertView = [FWAlertView alertWithTitle:@"标题" detail:@"描述描述描述描述描述描述描述描述描述描述" inputPlaceholder:nil keyboardType:UIKeyboardTypeDefault customView:nil items:items vProperty:vProperty];
            [alertView show];
        }
            break;
        case 3:
        {
            id block = ^(FWPopupView *popupView, NSInteger index){
                NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
            };
            
            NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                               [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block],
                               [[FWPopupItem alloc] initWithTitle:@"其他" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
            
            FWAlertView *alertView = [FWAlertView alertWithTitle:@"标题" detail:@"描述描述描述描述描述描述描述描述描述描述" inputPlaceholder:nil keyboardType:UIKeyboardTypeDefault customView:nil items:items];
            [alertView show];
        }
            break;
        case 4:
        {
            id block = ^(FWPopupView *popupView, NSInteger index){
                NSLog(@"AlertView：点击了第 %ld 个按钮", (long)index);
            };
            NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                               [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:YES itemClickedBlock:block]];
            
            FWAlertView *alertView = [FWAlertView alertWithTitle:@"标题" detail:@"带输入框" inputPlaceholder:@"请输入..." keyboardType:UIKeyboardTypeDefault customView:nil items:items];
            [alertView show];
        }
            break;
        case 5:
        {
            __weak typeof(self) weakSelf = self;
            id block = ^(FWPopupView *popupView, NSInteger index){
                if (index == 1)
                {
                    // 这边演示了如何手动去调用隐藏
                    [weakSelf.alertWithImageView hide];
                }
            };
            
            // 注意：此时“确定”按钮是不让按钮自己隐藏的
            NSArray *items = @[[[FWPopupItem alloc] initWithTitle:@"取消" itemType:FWItemTypeNormal isCancel:YES canAutoHide:YES itemClickedBlock:block],
                               [[FWPopupItem alloc] initWithTitle:@"确定" itemType:FWItemTypeNormal isCancel:NO canAutoHide:NO itemClickedBlock:block]];
            UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"audio_bgm_4"]];
            
            self.alertWithImageView = [FWAlertView alertWithTitle:@"标题" detail:@"带输入框" inputPlaceholder:nil keyboardType:UIKeyboardTypeDefault customView:customImageView items:items];
            [self.alertWithImageView show];
        }
            break;
        case 6:
        {
            NSArray *items = @[@"Sheet0", @"Sheet1", @"Sheet2", @"Sheet3"];
            
            FWSheetView *sheetView = [FWSheetView sheetWithTitle:@"标题" itemTitles:items itemBlock:^(FWPopupView *popupView, NSInteger index) {
                NSLog(@"Sheet：点击了第 %ld 个按钮", (long)index);
            } cancenlBlock:^{
                NSLog(@"点击了取消");
            }];
            [sheetView show];
        }
            break;
        case 7:
        {
            NSArray *items = @[@"Sheet0", @"Sheet1", @"Sheet2", @"Sheet4", @"Sheet5", @"Sheet6", @"Sheet7", @"Sheet8", @"Sheet9", @"Sheet10", @"Sheet11", @"Sheet12", @"Sheet13", @"Sheet14"];
            
            FWSheetView *sheetView = [FWSheetView sheetWithTitle:@"标题" itemTitles:items itemBlock:^(FWPopupView *popupView, NSInteger index) {
                NSLog(@"Sheet：点击了第 %ld 个按钮", (long)index);
            } cancenlBlock:^{
                NSLog(@"点击了取消");
            }];
            [sheetView show];
        }
            break;
        case 8:
        {
            FWDateView *dateView = [FWDateView dateWithConfirmBlock:^(UIDatePicker *datePicker) {
                NSLog(@"点击了 FWDateView 的确定");
            } cancelBlock:^{
                NSLog(@"点击了 FWDateView 的取消");
            }];
            [dateView show];
        }
            break;
        case 9:
        {
            [self.navigationController pushViewController:[[FWCustomDemoVC alloc] init] animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
