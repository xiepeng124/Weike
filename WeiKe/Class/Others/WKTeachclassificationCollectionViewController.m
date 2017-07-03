//
//  WKTeachclassificationCollectionViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeachclassificationCollectionViewController.h"
#import "WKVideoClassfiCollectionViewCell.h"

@interface WKTeachclassificationCollectionViewController ()<UIGestureRecognizerDelegate>
@property (strong ,nonatomic) UIView *backgroundView;
@property (strong,nonatomic)NSMutableArray *arrlist;
@property (strong, nonatomic)UIButton *button;
@property (assign,nonatomic) NSInteger myNumber;
@end

@implementation WKTeachclassificationCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((270/2-40), 17);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 5, 20);
    layout.footerReferenceSize = CGSizeMake(270, 55);
    layout.sectionFootersPinToVisibleBounds = YES;
    return [super initWithCollectionViewLayout:layout];
}
-(void)initStyle{
    self.backgroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.6;
   // self.backgroundView.hidden = YES;
     [self.view insertSubview:self.backgroundView atIndex:0];
    self.gradeNumber = -1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.layer.cornerRadius = 3;
    self.collectionView.layer.masksToBounds = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WKVideoClassfiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mycell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
  
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.collectionView.hidden = YES;
    __weak  typeof(self) weakself = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view);
        make.top.mas_equalTo(154);
        make.size.mas_equalTo(CGSizeMake(270, 165));
    }];

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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.arrlist.count == 0) {
        return 1;
    }
    return self.arrlist.count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    //    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem: self.gradeNumber inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    //    [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.gradeNumber inSection:0]];
    if (self.arrlist.count ==0) {
        return cell;
    }
    
    WKGrade *model = self.arrlist[indexPath.row];
    if (model.courseName==nil) {
        if (model.gradeName==nil) {
            if (model.sectionId==1) {
                cell.mylabel.text = @"初中部";
            }
            
            else if (model.sectionId==2) {
                cell.mylabel.text = @"高中部";
            }
            
        }
        else{
            cell.mylabel.text = model.gradeName;
        }
    }
    else{
        cell.mylabel.text = model.courseName;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];;
    foot.backgroundColor = [UIColor whiteColor];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    _button.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    _button.layer.cornerRadius = 3;
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    [button2 setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    [_button addTarget:self action:@selector(keepdata) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(canceldata) forControlEvents:UIControlEventTouchUpInside];
    _button.userInteractionEnabled = NO;
    [foot addSubview:_button];
    [foot addSubview:button2];
    //    for ( int i=0; i<self.arrlist.count; i++) {
    //        WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [self.mycollectView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    //        if (cell.selected) {
    //            self.button.userInteractionEnabled = YES;
    //            break;
    //        }
    //        NSLog(@"break");
    //        self.button.userInteractionEnabled = NO;
    //    }
    
    [_button  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(54, 30));
    }];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(54, 30));
        make.right.mas_equalTo(-(25+54));
    }];
    
    return foot;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    _button.userInteractionEnabled = YES;
    cell.myselected.selected = YES;
   // cell.selected  =YES;
//    WKGrade *model = self.arrlist [indexPath.row];
    self.myNumber = indexPath.row ;
        // [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    //_button.userInteractionEnabled = NO;
    //cell.selected  =NO;
    cell.myselected.selected = NO;
}


-(void)keepdata{
 self.view.hidden = YES;
self.gradeNumber = self.myNumber;
    _button.userInteractionEnabled = NO;
    WKGrade *model = self.arrlist [self.gradeNumber];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.gradeNumber inSection:0];
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:index];
    [self.delegate showGradeOrCourse:cell.mylabel.text withModel:model];
//    if (model.courseName ==nil) {
//        self.selectedgrade.text  =cell.mylabel.text;
//    }
//    else{
//        self.selectedcourse.text = cell.mylabel.text;
//        self.selectedcourse.textColor = [WKColor colorWithHexString:@"333333"];
//    }
    
    [self.collectionView deselectItemAtIndexPath:index animated:YES];
    cell.myselected.selected = NO;
    
    
    
}
-(void)canceldata{
    self.view.hidden = YES;
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.gradeNumber inSection:0];
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:index];
    [self.collectionView deselectItemAtIndexPath:index animated:YES];
    cell.myselected.selected = NO;
    
}
-(void)selectgradeAction:(NSInteger)segmentIndex{
    self.view.hidden = NO;
//    self.selectedcourse.text = @"请选择学科";
//    self.selectedcourse.textColor = [WKColor colorWithHexString:@"999999"];
    for (int i= 0; i<self.arrlist.count; i++) {
        NSIndexPath *index2 = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView deselectItemAtIndexPath:index2 animated:YES];
        [self.collectionView cellForItemAtIndexPath:index2].selected = NO;
    }
    
    // [self.arrcount addObject:[NSNumber numberWithInteger:self.classify.selectedSegmentIndex]];
    //WKGrade *model = self.arrlist[0];
    
    //    if (self.arrcount.count==2) {
    //        if ([self.arrcount[0]intValue]==[self.arrcount[1]intValue]&&model.courseName==nil) {
    //            [self.arrcount removeObjectAtIndex:0];
    //        }
    //
    //    }
    
    //        else  {
    [self.arrlist removeAllObjects];
    if (segmentIndex ==0) {
        //NSLog(@"2222");
        NSDictionary *dic = @{@"typeId":@1,@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKAcedemyHandler executeGetAcademyGradeWithParameter:dic success:^(id object) {
                NSLog(@"object = %@",object);
                for (WKGrade * grade in object) {
                    
                    [weakself.arrlist addObject:grade];
                };
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.collectionView reloadData];
                    
                    [weakself.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(weakself.view);
                        make.top.mas_equalTo(154);
                        make.size.mas_equalTo(CGSizeMake(270, 165));
                    }];
                });
            } failed:^(id object) {
                NSLog(@"123");
            }];
            
        });
    }
    else {
        NSDictionary *dic = @{@"typeId":[NSNumber numberWithInteger:segmentIndex+1],@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKAcedemyHandler executeGetAcademySectionWithParameter:dic success:^(id object) {
                for (WKGrade * grade in object) {
                    [weakself.arrlist addObject:grade];
                };
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.collectionView reloadData];
                    [weakself.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(weakself.view);
                        make.top.mas_equalTo(154);
                        make.size.mas_equalTo(CGSizeMake(270, 91));
                    }];
                    
                });
            } failed:^(id object) {
            }];
            
        });
        
        
    }
    
        
}
-(void)selectcourseAction:(NSInteger)gradeIds{
     self.view.hidden = NO;
    WKGrade *grade = [[WKGrade alloc]init];
    if (self.gradeNumber==-1) {
//        if (gradeIds == -1) {
//              NSLog(@"654321");
//        }
//        else{
//        //       grade.id = self.gradeId;
//        //      NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:grade.id],@"schoolId":SCOOLID};
      
        [self.arrlist removeAllObjects];
        
        __weak typeof(self) weakself = self;
        NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:gradeIds],@"schoolId":SCOOLID};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKAcedemyHandler executeGetAcademyCourse2WithParameter:dic success:^(id object) {
                for (WKGrade * course in object) {
                    [weakself.arrlist addObject:course];
                };
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.collectionView reloadData];
                    [weakself.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(weakself.view);
                        make.top.mas_equalTo(154);
                        make.size.mas_equalTo(CGSizeMake(270, 250));
                    }];
                });
            } failed:^(id object) {
            }];
            
        });
        
        
//    }
}
    else{
        grade= self.arrlist[self.gradeNumber];
        
         NSLog(@"65^^21");
        if (grade.gradeName!=nil) {
            [self.arrlist removeAllObjects];
            gradeIds = grade.id;
            __weak typeof(self) weakself = self;
            NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:gradeIds],@"schoolId":SCOOLID};
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [WKAcedemyHandler executeGetAcademyCourse2WithParameter:dic success:^(id object) {
                    for (WKGrade * course in object) {
                        [weakself.arrlist addObject:course];
                    };
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.collectionView reloadData];
                        [weakself.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(weakself.view);
                            make.top.mas_equalTo(154);
                            make.size.mas_equalTo(CGSizeMake(270, 250));
                        }];
                    });
                } failed:^(id object) {
                }];
                
            });
        }
        else{
            [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.top.mas_equalTo(154);
                make.size.mas_equalTo(CGSizeMake(270, 250));
            }];
            
        }
    }
}

@end
