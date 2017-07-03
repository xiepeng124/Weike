//
//  WKArchivesTeacherAddViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/30.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKArchivesTeacherAddViewController.h"
#import "WKTeacherImformation.h"
#import "WKCheackModel.h"
#import "WKUploadImage.h"

#import "WKVideoClassfiCollectionViewCell.h"
@interface WKArchivesTeacherAddViewController ()<UITextFieldDelegate,upImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) WKTeacherImformation *teachImf;
@property(nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) WKUploadImage *uploadImage;
@property (nonatomic,strong) NSString *imageS;
@property (nonatomic,strong) NSMutableArray *myList;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *classLst;
@property (nonatomic,strong) NSArray *selectClassList;
@property (nonatomic,strong) NSMutableArray *positionList;
@property (nonatomic,strong) NSArray *selectPositionList;
@property (nonatomic,strong) NSMutableArray *courseList;
@property (nonatomic,strong) NSArray *selectCourseList;
@property (nonatomic,strong) WKTeaArchivesData *teaModel;
@property (nonatomic,strong) UIView *backgroundView ;
@property (nonatomic,assign) NSInteger myNumber;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,assign) NSInteger selectNumber;
@property (nonatomic,assign) NSInteger gradeId;
@property (nonatomic,assign) NSInteger courseSection;
@property (nonatomic,strong) NSString *classIds;
@property (nonatomic,strong) NSString *courseIds;
@property (nonatomic,strong) NSString *positionIds;

@end

@implementation WKArchivesTeacherAddViewController
#pragma mark - init
-(NSMutableArray*)myList{
    if (!_myList) {
        _myList = [NSMutableArray array];
    }
    return _myList;
}
-(NSMutableArray*)classLst{
    if (!_classLst) {
        _classLst = [NSMutableArray array];
    }
    return _classLst;
}
-(NSMutableArray*)courseList{
    if (!_courseList) {
        _courseList = [NSMutableArray array];
    }
    return _courseList;
}
-(NSMutableArray*)positionList{
    if (!_positionList) {
        _positionList = [NSMutableArray array];
    }
    return _positionList;
}
-(NSArray*)selectClassList{
    if (!_selectClassList) {
        _selectClassList = [NSArray array];
    }
    return _selectClassList;
}
-(NSArray*)selectPositionList{
    if (!_selectPositionList ){
        _selectPositionList = [NSArray array];
    }
    return _selectPositionList;
}
-(NSArray*)selectCourseList{
    if (!_selectCourseList ){
        _selectCourseList= [NSArray array];
    }
    return _selectCourseList;
}
-(void)initStyle{
    self.teachImf = [[WKTeacherImformation alloc]init];
    self.teachImf = [[[NSBundle mainBundle]loadNibNamed:@"TeacherImformationHeaderView" owner:nil options:nil]lastObject];
    self.teachImf.frame = CGRectMake(0, 0, SCREEN_WIDTH, 595);
    self.teachImf.cardIdText.delegate =self;
    self.teachImf.phoneNumText.delegate = self;
    self.teachImf.emailText.delegate =self;
    self.teachImf.cardIdText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.teachImf.phoneNumText.keyboardType = UIKeyboardTypePhonePad;
    self.teachImf.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.teachImf.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.tableHeaderView = self.teachImf;
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.mytableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.nametext];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.cardIdText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.emailText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.phoneNumText];
    [self.teachImf.keepButton addTarget:self action:@selector(keepMydataAction) forControlEvents:UIControlEventTouchUpInside ];
    UITapGestureRecognizer *onetap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectGradeAction)];
    [self.teachImf.teachGradeText addGestureRecognizer:onetap];
    self.teachImf.teachGradeText.userInteractionEnabled = YES;
    [self.teachImf.gradeButton addTarget:self action:@selector(selectGradeAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *twoTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClassAction)];
    [self.teachImf.teachClassText addGestureRecognizer:twoTap];
    self.teachImf.teachClassText.userInteractionEnabled = YES;
    [self.teachImf.classButton addTarget:self action:@selector(selectClassAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *threeTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPositionAction)];
    [self.teachImf.jobText addGestureRecognizer:threeTap];
    self.teachImf.jobText.userInteractionEnabled = YES;
    [self.teachImf.jobButton addTarget:self action:@selector(selectPositionAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *fourTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCourseAction)];
    [self.teachImf.subjectText addGestureRecognizer:fourTap];
    self.teachImf.subjectText.userInteractionEnabled = YES;
    [self.teachImf.subjectbutton addTarget:self action:@selector(selectCourseAction) forControlEvents:UIControlEventTouchUpInside];

    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    //self.hud.label.text = @"正在保存";
    [self.view addSubview:self.hud];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchImageAction)];
        self.teachImf.headImageView.userInteractionEnabled = YES;
        [self.teachImf.headImageView addGestureRecognizer:ges];
    if (!_isAdd) {
        NSLog(@"??^^%@",_model.imgFileUrl);
        [self.teachImf.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
        self.teachImf.nametext.text = _model.teacherName;
        self.teachImf.cardIdText.text = _model.idCode;
        self.teachImf.phoneNumText.text = _model.moblePhone;
        self.teachImf.emailText.text = _model.email;
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.teachImf.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
        self.teachImf.keepButton.userInteractionEnabled = YES;
        self.teachImf.sexSegment.selectedSegmentIndex = _model.gender-1;
        self.imageS = _model.imgFileUrl;
       
    }
    else{
        self.teachImf.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = NO;
        self.imageS = @"";
    }
        
    

}
-(void)initcollectionView{
    self.backgroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.6;
    // self.backgroundView.hidden = YES;
    _backgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenCollectionView)];
    [_backgroundView addGestureRecognizer:hiddenTap];
    
    [self.view addSubview:self.backgroundView];
    _backgroundView.hidden = YES;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((280/2-30), 18);
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 5, 15);
   
    layout.footerReferenceSize = CGSizeMake(280, 55);
    layout.sectionFootersPinToVisibleBounds = YES;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.cornerRadius = 3;
    self.collectionView.layer.masksToBounds = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WKVideoClassfiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mycell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.collectionView.hidden = YES;
    _collectionView.hidden = YES;
    [self.view addSubview:self.collectionView];
    __weak  typeof(self) weakself = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
        //make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(280, 164));
    }];

}
-(void)initData{
    if (_isAdd) {
        NSDictionary *dic = @{@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachListWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.teaModel = (WKTeaArchivesData*)object;
                    
                });
            } failed:^(id object) {
                
            }];
        });

    }
    else{
    NSDictionary *dics = @{@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:_model.id]};
    __weak typeof(self) weakself = self;
        NSLog(@".....");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKBackstage executeGetBackstageArchivesTeachEditListWithParameter:dics success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.teaModel = (WKTeaArchivesData*)object;
                for (NSDictionary *dic in weakself.teaModel.gradeList) {
                   // NSLog(@"bool = %d",[[dic objectForKey:@"delFlag"] boolValue]);
                    if ([[dic objectForKey:@"delFlag"] boolValue]) {
                        weakself.gradeId =[[dic objectForKey:@"id"]integerValue];
                        weakself.teachImf.teachGradeText.text = [dic objectForKey:@"gradeName"];
                        NSString *stings = [dic objectForKey:@"gradeCode"];
                        if ([stings hasPrefix:@"C"]) {
                            weakself.courseSection = 1;
                        }
                        else{
                            weakself.courseSection =2;
                        }

                        break;
                    }
                  
                }
                NSString *classNames = nil;
                NSMutableArray *classArr =[NSMutableArray array];
                for (NSDictionary *dic in weakself.teaModel.classList) {
                   // NSLog(@"grde=%lu",weakself.gradeId);
                    NSLog(@"gradefor dic = %lu",[[dic objectForKey:@"gradeId"] integerValue]);
                    if (weakself.gradeId == [[dic objectForKey:@"gradeId"] integerValue]) {
                      //  NSLog(@"1111");
                        [classArr addObject:dic];
                    }
                    if ([[dic objectForKey:@"delFlag"] boolValue]) {
                        if (!weakself.classIds) {
                            weakself.classIds = [dic objectForKey:@"id"];
                        }
                        else{
                            weakself.classIds = [NSString stringWithFormat:@"%@,%@",weakself.classIds,[dic objectForKey:@"id"]];
                        }
                        if (!classNames.length) {
                               classNames = [dic objectForKey:@"className"];
                        }
                        else{
                            classNames =   [NSString stringWithFormat:@"%@ , %@",classNames,[dic objectForKey:@"className"]];

                        }
                        }

                }
                weakself.teachImf.teachClassText.text = classNames;
                
                for (int i=0; i<classArr.count; i++) {
                    if ([[classArr[i] objectForKey:@"delFlag"] boolValue]) {
                        [weakself.classLst addObject:[NSNumber numberWithInteger:i]];
                }
                }
                weakself.selectClassList = [weakself.classLst copy];
                
                NSString *positionNames = nil;
                for (NSDictionary *dic in weakself.teaModel.positionList) {
                    if ([[dic objectForKey:@"delFlag"] boolValue]) {
                     
                        if (!weakself.positionIds) {
                            weakself.positionIds = [dic objectForKey:@"id"];
                        }
                        else{
                            weakself.positionIds = [NSString stringWithFormat:@"%@,%@",weakself.positionIds,[dic objectForKey:@"id"]];
                        }
                        if (!positionNames.length) {
                            positionNames = [dic objectForKey:@"positionName"];
                        }
                        else{
                           positionNames =   [NSString stringWithFormat:@"%@ , %@",positionNames,[dic objectForKey:@"positionName"]];
                            
                        }
                       
                    }
                    
                }
                for (int i=0; i<weakself.teaModel.positionList.count; i++) {
                    if ([[weakself.teaModel.positionList[i] objectForKey:@"delFlag"] boolValue]) {
                        [weakself.positionList addObject:[NSNumber numberWithInt:i]];
                    }
                }
                 weakself.teachImf.jobText.text = positionNames;
               // NSLog(@"posi.count=%lu",weakself.positionList.count);
                weakself.selectPositionList = [weakself.positionList copy];
                //NSLog(@"select.count=%lu",weakself.positionList.count);
                
                NSString *courseNames = nil;
                NSMutableArray *courseArr = [NSMutableArray array];
                for (NSDictionary *dic in weakself.teaModel.courseList) {
                    if (self.courseSection == [[dic objectForKey:@"courseSection"] integerValue]) {
                        [courseArr addObject:dic];
                    }
                    if ([[dic objectForKey:@"delFlag"] boolValue]) {
                        if (!weakself.courseIds) {
                            weakself.courseIds = [dic objectForKey:@"id"];
                        }
                        else{
                            weakself.courseIds = [NSString stringWithFormat:@"%@,%@",weakself.courseIds,[dic objectForKey:@"id"]];
                        }
                        if (!courseNames.length) {
                            courseNames = [dic objectForKey:@"courseName"];
                        }
                        else{
                            courseNames =   [NSString stringWithFormat:@"%@ , %@",courseNames,[dic objectForKey:@"courseName"]];
                            
                        }
                    }
                    
                }
                weakself.teachImf.subjectText.text = courseNames;
                for (int i=0; i<courseArr.count; i++) {
                    if ([[courseArr[i] objectForKey:@"delFlag"] boolValue]) {
                        [weakself.courseList addObject:[NSNumber numberWithInteger:i]];
                    }
                }
                weakself.selectCourseList = [weakself.courseList copy];

            });
        } failed:^(id object) {
            
        }];
    });
    }
    
}
#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
      self.uploadImage = [WKUploadImage shareManager];
    self.uploadImage.url =MY_HEAD;
    NSDictionary *dic = @{@"userType":@1};
    self.uploadImage.diction = dic;
   
    [self initData];
    [self initcollectionView];
    // Do any additional setup after loading the view.
}
#pragma mark - collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myList.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    WKVideoClassfiCollectionViewCell *cell = [[WKVideoClassfiCollectionViewCell alloc]init];
//    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKVideoClassfiCollectionViewCell" owner:nil options:nil]lastObject];
   WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    cell.myselected.selected = NO;
    NSDictionary *modelDic = self.myList[indexPath.row];
    if (_myNumber==1) {
     
        cell.mylabel.text = [modelDic objectForKey:@"gradeName"];
        return cell;

    }
    if (_myNumber==2) {
        if ([self.selectClassList containsObject:[NSNumber numberWithInteger:indexPath.row ]]) {
            cell.myselected.selected = YES;
        }
        cell.mylabel.text = [modelDic objectForKey:@"className"];
        return cell;
    }
    if (_myNumber == 3) {
        if ([self.selectPositionList containsObject:[NSNumber numberWithInteger:indexPath.row ]]) {
            cell.myselected.selected = YES;
        }

        if ([[modelDic objectForKey:@"positionName"] length]>5) {
            NSString *string = [[modelDic objectForKey:@"positionName"]  substringToIndex:5];
            cell.mylabel.text =string;
        }
        else{
        cell.mylabel.text = [modelDic objectForKey:@"positionName"];
        }
        return cell;
    }
    else{
        if ([self.selectCourseList containsObject:[NSNumber numberWithInteger:indexPath.row ]]) {
        cell.myselected.selected = YES;
        }
         cell.mylabel.text = [modelDic objectForKey:@"courseName"];
        return cell;
    }
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
    [button2 addTarget:self action:@selector(hiddenCollectionView) forControlEvents:UIControlEventTouchUpInside];
    _button.userInteractionEnabled = NO;
    [foot addSubview:_button];
    [foot addSubview:button2];
    
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

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
   // NSLog(@"@@@@@");
    if (self.myNumber==1) {
     
        cell.myselected.selected = YES;
        
        self.selectNumber = indexPath.row ;
    }
    else if(self.myNumber==2){
        cell.myselected.selected =!cell.myselected.selected;
     

        if (cell.myselected.selected) {
           if (![self.classLst containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.classLst addObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        }
        else{
           if ([self.classLst containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.classLst removeObject:[NSNumber numberWithInteger:indexPath.row]];
           }
        }
//        if (self.classLst.count) {
//            _button.userInteractionEnabled = YES;
//            
//        }
//        else{
//            _button.userInteractionEnabled = NO;
//            
//        }
    }
    else if(self.myNumber==4){
        cell.myselected.selected =!cell.myselected.selected;
      

        if (cell.myselected.selected) {
            if (![self.courseList containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.courseList addObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        }
        else{
            if ([self.courseList containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.courseList removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        }
//        if (self.courseList.count) {
//            _button.userInteractionEnabled = YES;
//            
//        }
//        else{
//            _button.userInteractionEnabled = NO;
//            
//        }
    }
    else{
        cell.myselected.selected =!cell.myselected.selected;
               if (cell.myselected.selected) {
            if (![self.positionList containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.positionList addObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        }
        else{
            if ([self.positionList containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.positionList removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        }
//        if (self.courseList.count) {
//            _button.userInteractionEnabled = YES;
//            
//        }
//        else{
//            _button.userInteractionEnabled = NO;
//            
//        }

    }
   _button.userInteractionEnabled = YES;
   
 }
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    if (self.myNumber==1) {
          cell.myselected.selected = NO;
    }
  
    
}



#pragma mark - 通知
-(void)textchangge:(NSNotification*)notifi{
    if (!self.teachImf.nametext.text.length||!self.teachImf.phoneNumText.text.length) {
        [self.teachImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.teachImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = YES ;
        
    }
    
}
#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // NSLog(@"string = %@",string);
    
    if (range.length==1&&string.length==0) {
        return YES;
    }
    
    if (textField== self.teachImf.cardIdText) {
        if (self.teachImf.cardIdText.text.length<18) {
            return [self validateNumber:string];
        }
        
        
        return NO ;
        
    }
    if (textField == self.teachImf.phoneNumText) {
        if (self.teachImf.phoneNumText.text.length<11) {
            return [self validateNumber:string];
        }
        return NO;
        
    }
    
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789xX"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
#pragma mark - uploadImage delegate
-(void)selctedImage:(NSDictionary*)Imgestring{
    [self.teachImf.headImageView sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"imgFileUrl"] ] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.imageS = [Imgestring objectForKey:@"imgFileUrl"];
    
}

-(void)sendImagesource:(NSString *)sourceName{
   
}

#pragma mark - Action
//上传头像
-(void)switchImageAction{
    [self.uploadImage selectUserpicSourceWithViewController:self];
    self.uploadImage.delegate = self;
}
//选择年级
-(void)selectGradeAction{
     [self.myList removeAllObjects];
    self.myList = [_teaModel.gradeList mutableCopy];
    _collectionView.hidden = NO;
    _backgroundView.hidden = NO;
    _myNumber = 1;
    __weak typeof(self) weakself = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
        if (weakself.myList.count>20) {
            make.size.mas_equalTo(CGSizeMake(280, 70+10*33));
        }
        else{
            if (weakself.myList.count%2) {
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2+1)*33));
            }
            else{
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2)*33));
            }
        }
        
    }];
    [self.collectionView reloadData];
}
//选择班级
-(void)selectClassAction{
    [self.myList removeAllObjects];
    if (!self.teachImf.teachGradeText.text.length) {
        self.hud.mode  = MBProgressHUDModeText;
        self.hud.label.text = @"请优先选择年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    NSArray *classArr = _teaModel.classList;
    for (NSDictionary *dic in classArr) {
        if (self.gradeId == [[dic objectForKey:@"gradeId"] integerValue]) {
            [self.myList addObject:dic];
//            if (!_isAdd&&[[dic objectForKey:@"delFlag"] integerValue]) {
//                <#statements#>
//            }
        }
    }
//    self.myList = [_teaModel.classList mutableCopy];
    _collectionView.hidden = NO;
    _backgroundView.hidden = NO;
    _myNumber = 2;
    __weak typeof(self) weakself = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
        if (weakself.myList.count>20) {
             make.size.mas_equalTo(CGSizeMake(280, 70+10*33));
        }
        else{
        if (weakself.myList.count%2) {
            make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2+1)*33));
        }
        else{
            make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2)*33));
        }
        }
        
    }];

    [self.collectionView reloadData];
    
}
//选择职务
-(void)selectPositionAction{
        [self.myList removeAllObjects];
    self.myList = [_teaModel.positionList mutableCopy];
    _collectionView.hidden = NO;
    _backgroundView.hidden = NO;
    _myNumber = 3;
    __weak typeof(self) weakself = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
        if (weakself.myList.count>20) {
            make.size.mas_equalTo(CGSizeMake(280, 70+10*33));
        }
        else{
            if (weakself.myList.count%2) {
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2+1)*33));
            }
            else{
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2)*33));
            }
        }
        
    }];
    
    [self.collectionView reloadData];

}
//选择学科
-(void)selectCourseAction{
        [self.myList removeAllObjects];
    if (!self.teachImf.teachGradeText.text.length) {
        self.hud.mode  = MBProgressHUDModeText;
        self.hud.label.text = @"请优先选择年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    NSArray *courseArr = _teaModel.courseList;
    for (NSDictionary *dic in courseArr) {
        if (self.courseSection == [[dic objectForKey:@"courseSection"] integerValue]) {
            [self.myList addObject:dic];
        }
    }

       _collectionView.hidden = NO;
    _backgroundView.hidden = NO;
    _myNumber = 4;
    __weak typeof(self) weakself = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
        if (weakself.myList.count>20) {
            make.size.mas_equalTo(CGSizeMake(280, 70+10*33));
        }
        else{
            if (weakself.myList.count%2) {
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2+1)*33));
            }
            else{
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.myList.count/2)*33));
            }
        }
        
    }];
    
    [self.collectionView reloadData];

}
//隐藏选择器
-(void)hiddenCollectionView{
    _collectionView.hidden = YES;
    _backgroundView.hidden = YES;
}
//确定选择
-(void)keepdata{
    if (self.myNumber==1) {
        NSDictionary *dic = self.myList[self.selectNumber];
        self.teachImf.teachGradeText.text = [dic objectForKey:@"gradeName"];
        self.teachImf.teachClassText.text = nil;
        self.teachImf.subjectText.text = nil;
        [self.classLst removeAllObjects];
        [self.courseList removeAllObjects];
        self.selectClassList = nil;
        self.selectCourseList  = nil;
        self.gradeId = [[dic objectForKey:@"id"] integerValue];
        NSString *stings = [dic objectForKey:@"gradeCode"];
        if ([stings hasPrefix:@"C"]) {
            self.courseSection = 1;
        }
        else{
            self.courseSection =2;
        }
    }
    else if(self.myNumber==2){
        NSString *classText;
        for (int i=0; i<self.classLst.count; i++) {
            NSDictionary *dic = self.myList[[self.classLst[i] integerValue]];
            if (i==0){
                classText = [dic objectForKey:@"className"];
                self.classIds = [dic objectForKey:@"id"];
            }
            else{
                classText = [NSString stringWithFormat:@"%@ , %@",classText,[dic objectForKey:@"className"]];
                self.classIds = [NSString stringWithFormat:@"%@,%@",_classIds,[dic objectForKey:@"id"]];
            }
        }
        self.selectClassList = [self.classLst copy];
        self.teachImf.teachClassText.text = classText;
    }
    else if(self.myNumber==4){
        NSString *courseText;
        for (int i=0; i<self.courseList.count; i++) {
            NSDictionary *dic = self.myList[[self.courseList[i] integerValue]];
            if (i==0) {
                courseText = [dic objectForKey:@"courseName"];
                    self.courseIds = [dic objectForKey:@"id"];
            }
            else{
                  courseText = [NSString stringWithFormat:@"%@ , %@", courseText,[dic objectForKey:@"courseName"]];
                  self.courseIds = [NSString stringWithFormat:@"%@,%@",_courseIds,[dic objectForKey:@"id"]];
            }
        }
        self.teachImf.subjectText.text = courseText;
        self.selectCourseList = [self.selectCourseList copy];
    }
    else{
        NSString *positionText;
        for (int i=0; i<self.positionList.count; i++) {
            NSDictionary *dic = self.myList[[self.positionList[i] integerValue]];
            if (i==0) {
                positionText = [dic objectForKey:@"positionName"];
                  self.positionIds =   [dic objectForKey:@"id"];
            }
            else{
                positionText = [NSString stringWithFormat:@"%@ , %@", positionText,[dic objectForKey:@"positionName"]];
                  self.positionIds = [NSString stringWithFormat:@"%@,%@",_positionIds,[dic objectForKey:@"id"]];
            }
        }
        self.teachImf.jobText.text =  positionText;
        self.selectPositionList = [self.positionList copy];
    }
    _collectionView.hidden = YES;
    _backgroundView.hidden = YES;
}
-(void)keepMydataAction{
    if (![WKCheackModel checkUserIdCard:self.teachImf.cardIdText.text]&&self.teachImf.cardIdText.text.length) {
        self.hud.label.text = @"身份证输入有误";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
    }
    if (![WKCheackModel checkTelNumber:self.teachImf.phoneNumText.text]) {
        self.hud.label.text = @"手机号码输入有误";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
    }
    if (![WKCheackModel IsEmailAdress:self.teachImf.emailText.text]&&self.teachImf.emailText.text.length) {
        self.hud.label.text = @"邮箱输入有误";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }
    if (!self.teachImf.teachGradeText.text.length) {
        self.hud.label.text = @"请选择任课年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;

    }
    if (!self.teachImf.teachClassText.text.length) {
        self.hud.label.text = @"请选择任课班级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }
    if (!self.teachImf.jobText.text.length) {
        self.hud.label.text = @"请选择职务";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }

    if (!self.teachImf.subjectText.text.length) {
        self.hud.label.text = @"请选择学科";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }

    __weak typeof(self) weakself = self;
    self.hud.label.text = @"正在保存";
    [self.hud showAnimated:YES];
    if (_isAdd) {
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"gradeId":[NSNumber numberWithInteger:_gradeId],@"classIds":_classIds,@"courseIds":_courseIds,@"positionIds":_positionIds,@"imgFileUrl":_imageS,@"gender":[NSNumber numberWithInteger:self.teachImf.sexSegment.selectedSegmentIndex+1],@"idCode":self.teachImf.cardIdText.text,@"moblePhone":self.teachImf.phoneNumText.text,@"teacherName":self.teachImf.nametext.text,@"email":self.teachImf.emailText.text};
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachAddWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = [object objectForKey:@"msg"];
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    if ([[object objectForKey:@"flag"]integerValue]) {
                        [weakself.navigationController popViewControllerAnimated:YES];
                    }
                });
            } failed:^(id object) {
                
            }];
        });

    }
    else{
        NSLog(@"%lu....",_model.id);
        NSLog(@"classids =%@",_classIds);
         NSLog(@"_courseIds =%@",_courseIds);
         NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"gradeId":[NSNumber numberWithInteger:_gradeId],@"addClassIds":_classIds,@"addCourseIds":_courseIds,@"addPositionIds":_positionIds,@"delPositIds":_teaModel.delPositIds ,@"delTeachingIds":_teaModel.delTeachingIds ,@"delCouIds":_teaModel.delCouIds ,@"id":[NSNumber numberWithInteger:_model.id],@"imgFileUrl":_imageS,@"gender":[NSNumber numberWithInteger:self.teachImf.sexSegment.selectedSegmentIndex+1],@"idCode":self.teachImf.cardIdText.text,@"moblePhone":self.teachImf.phoneNumText.text,@"teacherName":self.teachImf.nametext.text,@"email":self.teachImf.emailText.text,@"userId":[NSNumber numberWithInteger:_teaModel.userId]};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachEditWithParameter:dic success:^(id object) {
                weakself.hud.label.text = [object objectForKey:@"msg"];
                [weakself.hud hideAnimated:YES afterDelay:1];
                if ([[object objectForKey:@"flag"]integerValue]) {
                    [weakself.navigationController popViewControllerAnimated:YES];
                }

            } failed:^(id object) {
                
            }];
        });
    }
    
}
#pragma mark - 手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
//     if (touch.view == self.collectionView ) {
//        return NO;
//    }
    if (self.collectionView.hidden == NO) {
        return NO;
    }
        return YES;
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
