//
//  CityListVC.m
//  CLW
//
//  Created by majinyu on 16/1/10.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import "CityListVC.h"
#import "AddressGroupJSONModel.h"
#import "AddressJSONModel.h"
#import "MJYUtils.h"
#import "MacroUtil.h"
#import "MacroNotification.h"

@interface CityListVC ()<
UITableViewDataSource,
UITableViewDelegate
>{
    NSMutableArray *maCitys;
}

@end

@implementation CityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    maCitys = [MJYUtils mjy_JSONAddressInfos];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = cancel;
}

/**
 *  取消城市选择
 *
 *  @param item
 */
- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return maCitys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    AddressGroupJSONModel *groups = maCitys[section];
    return groups.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    AddressGroupJSONModel *group = maCitys[indexPath.section];
    AddressJSONModel *addressModel = group.cities[indexPath.row];
    cell.textLabel.text =addressModel.city_name;
    
    return cell;
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AddressGroupJSONModel *group = maCitys[section];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    lbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [UIColor darkGrayColor];
    lbl.text = [NSString stringWithFormat:@"    %@",group.AZ];
    
    return lbl;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressGroupJSONModel *group = maCitys[indexPath.section];
    AddressJSONModel *addressModel = group.cities[indexPath.row];
    if (self.vcType == 1) {
        //注册
        [[NSNotificationCenter defaultCenter] postNotificationName:k_Notification_UpdateUserAddressInfo_Register
                                                            object:addressModel];
        [self cancelAction];
        
    } else if (self.vcType == 2) {
        //首页
        [[NSNotificationCenter defaultCenter] postNotificationName:k_Notification_UpdateUserAddressInfo_Home
                                                            object:addressModel];
        [self cancelAction];
        
    }
    
    
    
}


@end
