//
//  WKBackstageCollectionViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBackstageCollectionViewController.h"
#import "WKBackstageCollectionViewCell.h"
#import "WKBackmenu.h"
#import "WKRolesViewController.h"
#import "WKVideoManagerViewController.h"
#import "WKApprovalViewController.h"
#import "WKIndicatorSetViewController.h"
#import "WKJobManagerViewController.h"
#import "WKVideoStatisticsViewController.h"
#import "WKUserManagerViewController.h"
@interface WKBackstageCollectionViewController ()
@property (strong,nonatomic) WKBackmenu *menulist;
@end

@implementation WKBackstageCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 40 ;
    layout.minimumInteritemSpacing = 30;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-80-60)*0.33, 64);
    layout.sectionInset = UIEdgeInsetsMake(40, 40, 35, 40);
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"WKBackstageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.menulist = [[WKBackmenu alloc]init];
    //[self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

   
    return self.menulist.menuImage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    
    // Configure the cell
    WKBackstageCollectionViewCell *cell = (WKBackstageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.MenuImage.image = [UIImage imageNamed:self.menulist.menuImage[indexPath.row]];
    cell.MenuLabel.text = self.menulist.menuTitle[indexPath.row];
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        WKRolesViewController *roles = [[WKRolesViewController alloc]init];
        [self.navigationController pushViewController:roles animated:YES];
    }
    if (indexPath.row ==6) {
        WKVideoManagerViewController *videomanager = [[WKVideoManagerViewController alloc]init];
        [self.navigationController pushViewController:videomanager animated:YES];
    }
       if (indexPath.row ==7) {
        WKVideoStatisticsViewController *videosta = [[WKVideoStatisticsViewController alloc]init];
        [self.navigationController pushViewController:videosta animated:YES];
    }
    if (indexPath.row ==8) {
        WKUserManagerViewController *user = [[WKUserManagerViewController alloc]init];
        [self.navigationController pushViewController:user animated:YES];
    }
    if (indexPath.row == 9) {
        WKIndicatorSetViewController *indicator = [[WKIndicatorSetViewController alloc]init];
        [self.navigationController pushViewController:indicator animated:YES];
    }

    if (indexPath.row == 10) {
        WKApprovalViewController *approval = [[WKApprovalViewController alloc]init];
        [self.navigationController pushViewController:approval animated:YES];
    }
    if (indexPath.row == 11) {
        WKJobManagerViewController *jobl = [[WKJobManagerViewController alloc]init];
        [self.navigationController pushViewController:jobl animated:YES];
    }


}
 //Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
