//
//  WKJobSureScoreViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobSureScoreViewController.h"
#import "WKScoreHeaderView.h"
#import "WKJobImageTableViewCell.h"
#import "WKSelectedScore.h"
#import "MWPhotoBrowser.h"
@interface WKJobSureScoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,MWPhotoBrowserDelegate>
@property (nonatomic,strong)WKScoreHeaderView *headerView;
@property (nonatomic,strong)UITableView *ImageTableView;
@property (nonatomic,strong)WKSelectedScore *selectedView;
@property (nonatomic,strong)  UIView *blackView;
@property (nonatomic,strong) NSMutableArray *arrlist;
@property (nonatomic,strong) NSMutableArray *arrImage;

@end

@implementation WKJobSureScoreViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSMutableArray*)arrImage{
    if (!_arrImage) {
        _arrImage = [NSMutableArray array];
    }
    return _arrImage;
}
-(void)InitStyle{
    self.headerView = [[WKScoreHeaderView alloc]init];
    self.headerView = [[[NSBundle mainBundle]loadNibNamed:@"scoreHeaderView" owner:nil options:nil]lastObject];
    self.headerView.frame = CGRectMake(10, 74, SCREEN_WIDTH-20, 37);
    self.headerView.stuName.text = [NSString stringWithFormat:@"姓名:%@", self.model.stuName];
     self.headerView.stuClass.text = [NSString stringWithFormat:@"班级:%@", self.model.stuClass];
    [self.headerView.checkButton addTarget:self action:@selector(selectedScoreAction:) forControlEvents:UIControlEventTouchUpInside];
   
   // self.headerView.backgroundColor = [UIColor redColor];
 [self.view addSubview:self.headerView];
 _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 111, SCREEN_WIDTH, SCREEN_HEIGHT-111)];
    _blackView.backgroundColor = [UIColor blackColor];
   _blackView.alpha = 0.65;
   [self.view addSubview:_blackView];
    _blackView.hidden =YES;
    self.selectedView = [[WKSelectedScore alloc]init];
    self.selectedView = [[[NSBundle mainBundle]loadNibNamed:@"selectScore" owner:nil options:nil]lastObject];
    [self.view addSubview:self.selectedView];
    self.selectedView.hidden = YES;
    self.selectedView.pikerView.delegate = self;
    self.selectedView.pikerView.dataSource = self;
    [self.selectedView.pikerView selectRow:60 inComponent:0 animated:YES];
     [self.selectedView.cancelButton addTarget:self action:@selector(cancelScoreAction) forControlEvents:UIControlEventTouchUpInside];
      [self.selectedView.sureButton addTarget:self action:@selector(sureScoreAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo (151);
        make.size.mas_equalTo(CGSizeMake(220, 180));
    }];
    
}
-(void)initTableView{
    self.ImageTableView= [[UITableView alloc]initWithFrame:CGRectMake(10, 111 ,SCREEN_WIDTH-20, SCREEN_HEIGHT-111) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.ImageTableView.delegate = self;
    self.ImageTableView.dataSource = self;
    
    self.ImageTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.ImageTableView.showsVerticalScrollIndicator = NO;
    [self.ImageTableView registerClass:[WKJobImageTableViewCell class] forCellReuseIdentifier:@"imageCell"];
   // self.ImageTableView.tableHeaderView = self.headerView;
       [self.view addSubview:self.ImageTableView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i=0; i<101; i++) {
        [self.arrlist addObject:[NSString stringWithFormat:@"%d",i]];
    }

    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
      [self initTableView];
    [self InitStyle];
    
 
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser showNextPhotoAnimated:YES];
    [self.arrImage removeAllObjects];
    for (int i=0; i<self.model.urlList.count; i++) {
        NSString *sting =[self.model.urlList[i] objectForKey:@"url"];
        MWPhoto *photo =[MWPhoto photoWithURL:[NSURL URLWithString:sting]];
        [self.arrImage addObject:photo];
    }
    [browser reloadData];
    [self.navigationController pushViewController:browser animated:YES];
  

}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.arrImage.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.arrImage.count) {
        NSLog(@"...%@",[self.arrImage objectAtIndex:index ]);
        return  [self.arrImage objectAtIndex:index];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKJobImageTableViewCell *cell = (WKJobImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    NSString *urlstring = [self.model.urlList[indexPath.section] objectForKey:@"url"];
    NSLog(@"url = %@",urlstring);
  UIImageView* JobimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, (SCREEN_WIDTH-20)/16*9 )];
    JobimageView.image = [UIImage imageNamed:@"water"];
   
    [ JobimageView sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority ];
    [cell.contentView addSubview:JobimageView];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.urlList.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //NSLog(@"111");
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_WIDTH-20)/16*9;
}
-(void)selectedScoreAction:(UIButton*)sender{
    self.blackView.hidden = !self.blackView.hidden;
    self.selectedView.hidden = !self.selectedView.hidden;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arrlist.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 50;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 88/3;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.arrlist objectAtIndex:row];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    for (UIView *singleline in pickerView.subviews) {
        if (singleline.frame.size.height<1) {
            singleline.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
        }
    }
    UILabel *mylabel = [UILabel new];
    mylabel.textAlignment = NSTextAlignmentCenter;
   mylabel.text = self.arrlist[row];
    mylabel.textColor = [WKColor colorWithHexString:@"333333"];
    mylabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    return mylabel;
}
-(void)cancelScoreAction{
    self.blackView.hidden = YES;
    self.selectedView.hidden = YES;
}
-(void)sureScoreAction{
    NSInteger row = [self.selectedView.pikerView selectedRowInComponent:0];
    NSString *string = [self.arrlist objectAtIndex:row];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"taskScore":string,@"stuTaskId":[NSNumber numberWithInteger:self.model.stuTaskId]};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageJobScoreWithParameter:dic success:^(id object) {
             dispatch_async(dispatch_get_main_queue(), ^{
               if ([[object objectForKey:@"flag"]intValue]) {
                   [weakSelf.navigationController popViewControllerAnimated:YES];
                 weakSelf.blackView.hidden = YES;
                  weakSelf.selectedView.hidden = YES;
                 }
             });
        } failed:^(id object) {
            
        }];
    });
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
