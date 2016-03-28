//
//  SearchBarViewController.m
//  CLWsdht
//
//  Created by tom on 16/1/18.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "SearchBarViewController.h"
#import "ShopVC.h"
@interface SearchBarViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _searchBar.backgroundColor= [UIColor blackColor];
    self.searchBar.delegate=self;
}
- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:^{

    }];

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
