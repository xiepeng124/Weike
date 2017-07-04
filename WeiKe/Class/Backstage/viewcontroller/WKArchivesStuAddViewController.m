//
//  WKArchivesStuAddViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/7/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKArchivesStuAddViewController.h"
#import "WKCheackModel.h"
#import "WKStudentImforHeaderView.h"
#import "WKUploadImage.h"
#import "WKVideoClassfiCollectionViewCell.h"
@interface WKArchivesStuAddViewController ()<UITextFieldDelegate,upImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong) WKStudentImforHeaderView *stuImf;
@property (nonatomic,strong) WKUploadImage *uploadImage;
@property (nonatomic,strong) NSString *imageS;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) NSMutableArray *arrList;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *backgroundView ;
@property (nonatomic,assign) NSInteger myNumber;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,assign) NSInteger selectNumber;
@property (nonatomic,assign) NSInteger sureNumber;
@property (nonatomic,assign) NSInteger selectClassNumber;
@property (nonatomic,assign) NSInteger sureClassNumber;
@property (nonatomic,strong) NSMutableArray *classList;
@property (nonatomic,strong) NSArray *selectClassList;
@property (nonatomic,assign) NSInteger gradeId;
@property (nonatomic,assign) NSInteger classId;
@property  (nonatomic,strong) WKStudentData *stuGraCls;
@property (nonatomic,strong) NSNumber *userId;
@end

@implementation WKArchivesStuAddViewController
#pragma mark - init
-(NSMutableArray*)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
    }
    return _arrList;
}
-(NSMutableArray*)classList{
    if (!_classList) {
        _classList = [NSMutableArray array];
    }
    return _classList;
}
-(NSArray*)selectClassList{
    if (!_selectClassList) {
        _selectClassList = [NSArray array];
    }
    return _selectClassList;
}
-(void)initStyle{
    self.stuImf = [[WKStudentImforHeaderView alloc]init];
    self.stuImf= [[[NSBundle mainBundle]loadNibNamed:@"StudentImformationView" owner:nil options:nil]lastObject];
    self.stuImf.frame = CGRectMake(0, 0, SCREEN_WIDTH, 577);
    self.stuImf.cardIdText.delegate =self;
    self.stuImf.phoneNumText.delegate = self;
    self.stuImf.emailText.delegate =self;
    self.stuImf.cardIdText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.stuImf.phoneNumText.keyboardType = UIKeyboardTypePhonePad;
    self.stuImf.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.stuImf.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.tableHeaderView = self.stuImf;
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    UITapGestureRecognizer *onetap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectGradeAction)];
    [self.stuImf.StuGradeText addGestureRecognizer:onetap];
    self.stuImf.StuGradeText.userInteractionEnabled = YES;
    [self.stuImf.gradeButton addTarget:self action:@selector(selectGradeAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *twoTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClassAction)];
    [self.stuImf.stuClassText addGestureRecognizer:twoTap];
    self.stuImf.stuClassText.userInteractionEnabled = YES;
    [self.stuImf.classButton addTarget:self action:@selector(selectClassAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mytableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.stuImf.nametext];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.stuImf.cardIdText];
 
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchImageAction)];
    self.stuImf.headImageView.userInteractionEnabled = YES;
    [self.stuImf.headImageView addGestureRecognizer:ges];
    [self.stuImf.keepButton addTarget:self action:@selector(keepMydataAction) forControlEvents:UIControlEventTouchUpInside ];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"正在保存";
    [self.view addSubview:self.hud];
    
//    [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
//    self.stuImf.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    if (_isAdd) {
        [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
         self.stuImf.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
        self.stuImf.keepButton.userInteractionEnabled = NO;
        self.imageS =@"";
    }
    else{
        [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.stuImf.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
        self.stuImf.keepButton.userInteractionEnabled = YES;
        [self.stuImf.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
        self.stuImf.nametext.text = _model.studentName;
        self.stuImf.cardIdText.text = _model.idCode;
        self.stuImf.phoneNumText.text = _model.moblePhone;
        self.stuImf.emailText.text = _model.email;
        self.stuImf.sexSegment.selectedSegmentIndex = _model.gender-1;
    
        if (_model.imgFileUrl.length>2) {
                self.imageS = _model.imgFileUrl;
        }
        else{
            self.imageS =@"";

        }
        self.stuImf.stuNumberText.text = _model.studyNo;
        self.stuImf.schoolRollText.text = _model.schoolNo;
        self.stuImf.stuClassText.text =_model.className;
        self.stuImf.StuGradeText.text = _model.gradeName;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];

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
   
    __weak typeof(self) weakself = self;
    if (_isAdd) {
         NSDictionary *dic = @{@"schoolId":SCOOLID};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuAddListWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKStuArchivesData *model in object) {
                        [weakself.arrList addObject:model];
                    }
                    
                });
            } failed:^(id object) {
                
            }];
        });

    }
    else{
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:_model.id]};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuEditListWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *arr = [WKStuArchivesData mj_objectArrayWithKeyValuesArray:object[@"graClsList"]];
                    weakself.arrList = [arr mutableCopy];
                    weakself.stuGraCls = [WKStudentData mj_objectWithKeyValues:object[@"stuGraCls"]];
                    weakself.userId = [object objectForKey:@"userId"];
                    weakself.gradeId = weakself.stuGraCls.gradeId;
                    weakself.classId = weakself.stuGraCls.classId;
                    for (int i= 0; i<arr.count; i++) {
                        WKStuArchivesData *stu = arr[i];
                        if (weakself.gradeId == stu.gradeId) {
                            weakself.sureNumber = i;
                            break;
                        }
                    }
                    WKStuArchivesData *twoStu = arr[weakself.sureNumber];
                    for (int j=0; j<twoStu.classList.count; j++) {
                        if (weakself.classId == [[twoStu.classList[j] objectForKey:@"classId"]integerValue]) {
                            weakself.sureClassNumber =j;
                            break;
                        }
                    }
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
        [self initData];
     [self initcollectionView];
    self.sureNumber = -1;
    self.sureClassNumber = -1;
    self.uploadImage = [WKUploadImage shareManager];
    self.uploadImage.url =MY_HEAD;
    NSDictionary *dic = @{@"userType":@2};
    self.uploadImage.diction = dic;

    // Do any additional setup after loading the view.
}

#pragma mark - collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_myNumber==1) {
            return self.arrList.count;
    }
    if (_myNumber==2) {
        WKStuArchivesData *data =self.arrList[_selectNumber];
        return data.classList.count;
    }
    return 0;

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    WKVideoClassfiCollectionViewCell *cell = [[WKVideoClassfiCollectionViewCell alloc]init];
    //    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKVideoClassfiCollectionViewCell" owner:nil options:nil]lastObject];
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    cell.myselected.selected = NO;
    if (self.arrList.count) {
            if (_myNumber==1) {
                if (self.sureNumber == indexPath.row) {
                    cell.myselected.selected = YES;
                    self.selectNumber = indexPath.row;
                }
                        WKStuArchivesData *model = self.arrList[indexPath.row];
                      cell.mylabel.text = model.gradeName;
                return cell;

        }
        if (_myNumber==2) {
            if (self.sureClassNumber == indexPath.row) {
                cell.myselected.selected = YES;
                self.selectClassNumber = indexPath.row;
            }
            WKStuArchivesData *model = self.arrList[self.sureNumber];
            NSDictionary *dic = model.classList[indexPath.row];
            cell.mylabel.text = [dic objectForKey:@"className"];
            return cell;
        }
    }
 
    //NSLog(@"model.grade= %@",model.gradeName);
    
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
#pragma mark - collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    // NSLog(@"@@@@@");

        for (int i=0; i<self.arrList.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
            WKVideoClassfiCollectionViewCell *cell2 =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:index];
            cell2.myselected.selected = NO;
        }
    
        cell.myselected.selected = YES;
        if (self.myNumber==1) {
        self.selectNumber = indexPath.row ;
        }
        else{
            self.selectClassNumber =indexPath.row;
        }
    _button.userInteractionEnabled = YES;

}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
//    if (self.myNumber==1) {
        cell.myselected.selected = NO;
    //}
    
    
}


#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // NSLog(@"string = %@",string);
    
    if (range.length==1&&string.length==0) {
        return YES;
    }
    
    if (textField== self.stuImf.cardIdText) {
        if (self.stuImf.cardIdText.text.length<18) {
            return [self validateNumber:string];
        }
        
        
        return NO ;
        
    }
    if (textField == self.stuImf.phoneNumText) {
        if (self.stuImf.phoneNumText.text.length<11) {
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
    [self.stuImf.headImageView sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"imgFileUrl"] ] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
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
    _collectionView.hidden = NO;
    _backgroundView.hidden = NO;
    _myNumber = 1;

    __weak typeof(self) weakself = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
//        if (weakself.myList.count>20) {
//            make.size.mas_equalTo(CGSizeMake(280, 70+10*33));
//        }
            if (weakself.arrList.count%2) {
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.arrList.count/2+1)*33));
            }
            else{
                make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.arrList.count/2)*33));
            }

        
    }];
    [self.collectionView reloadData];

}
//选择班级
-(void)selectClassAction{
    if (!self.stuImf.StuGradeText.text.length) {
        self.hud.mode  = MBProgressHUDModeText;
        self.hud.label.text = @"请优先选择年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }

    _collectionView.hidden = NO;
    _backgroundView.hidden = NO;
    _myNumber = 2;
    __weak typeof(self) weakself = self;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.backgroundView);
        //        if (weakself.myList.count>20) {
        //            make.size.mas_equalTo(CGSizeMake(280, 70+10*33));
        //        }
        WKStuArchivesData *model = weakself.arrList[self.sureNumber];
        if (model.classList.count%2) {
            make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.arrList.count/2+1)*33));
        }
        else{
            make.size.mas_equalTo(CGSizeMake(280, 70+(weakself.arrList.count/2)*33));
        }
        
        
    }];
    [self.collectionView reloadData];


}
//隐藏选择器
-(void)hiddenCollectionView{
    _collectionView.hidden = YES;
    _backgroundView.hidden = YES;
//    if (_myNumber==1) {
//        self.selectNumber = -1;
//
//    }
//    else{
//      self.selectClassNumber = -1;
//    }
}
//确认选择
-(void)keepdata{
    _collectionView.hidden = YES;
    _backgroundView.hidden = YES;
    if (_myNumber==1) {
        if (self.sureNumber == self.selectNumber) {
            
        }
        else{
        self.sureNumber = self.selectNumber;
        self.selectClassNumber = -1;
        self.sureClassNumber = -1;
        self.stuImf.stuClassText.text = nil;
        WKStuArchivesData *model = self.arrList[self.sureNumber];
        self.stuImf.StuGradeText.text = model.gradeName;
        self.gradeId = model.gradeId;
        }
    }
    else{
        if (self.selectClassNumber==-1) {
            
        }else{
        self.sureClassNumber = self.selectClassNumber;
                WKStuArchivesData *model = self.arrList[_sureNumber];
            NSDictionary *dic = model.classList[_sureClassNumber];
            self.stuImf.stuClassText.text = [dic objectForKey:@"className"];
          self.classId = [[dic objectForKey:@"classId"]integerValue];
    }
    }
   
}
-(void)keepMydataAction{
    if (![WKCheackModel checkUserIdCard:self.stuImf.cardIdText.text]) {
        self.hud.label.text = @"身份证输入有误";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
    }
    if (![WKCheackModel checkTelNumber:self.stuImf.phoneNumText.text]&&self.stuImf.phoneNumText.text.length) {
        self.hud.label.text = @"手机号码输入有误";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
    }
    if (![WKCheackModel IsEmailAdress:self.stuImf.emailText.text]&&self.stuImf.emailText.text.length) {
        self.hud.label.text = @"邮箱格式有误";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }
    if (!self.stuImf.StuGradeText.text.length) {
        self.hud.label.text = @"请选择年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }
    if (!self.stuImf.stuClassText.text.length) {
        self.hud.label.text = @"请选择班级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        
        return;
        
    }

    __weak typeof(self) weakself = self;
    self.hud.label.text = @"正在保存";
    [self.hud showAnimated:YES];
    if (_isAdd) {
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"gradeId":[NSNumber numberWithInteger:_gradeId],@"classId":[NSNumber numberWithInteger:_classId],@"imgFileUrl":_imageS,@"gender":[NSNumber numberWithInteger:self.stuImf.sexSegment.selectedSegmentIndex+1],@"idCode":self.stuImf.cardIdText.text,@"moblePhone":self.stuImf.phoneNumText.text,@"studentName":self.stuImf.nametext.text,@"email":self.stuImf.emailText.text,@"studyNo":self.stuImf.stuNumberText.text,@"schoolNo":self.stuImf.schoolRollText.text};
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuAddWithParameter:dic success:^(id object) {
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
       //,
        //NSString *stuGraCla = [NSString stringWithFormat:@"%lu,%lu",self.stuGraCls.gradeId,self.stuGraCls.classId];
        NSLog(@"***%@",self.userId);
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"gradeId":[NSNumber numberWithInteger:_gradeId],@"classId":[NSNumber numberWithInteger:_classId],@"delId":[NSNumber numberWithInteger:self.stuGraCls.id],@"id":[NSNumber numberWithInteger:_model.id],@"imgFileUrl":_imageS,@"gender":[NSNumber numberWithInteger:self.stuImf.sexSegment.selectedSegmentIndex+1],@"idCode":self.stuImf.cardIdText.text,@"moblePhone":self.stuImf.phoneNumText.text,@"studentName":self.stuImf.nametext.text,@"email":self.stuImf.emailText.text,@"studyNo":self.stuImf.stuNumberText.text,@"schoolNo":self.stuImf.schoolRollText.text,@"userId":self.userId};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuEditWithParameter:dic success:^(id object) {
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
#pragma mark - 通知
//text field 内容变化
-(void)textchangge:(NSNotification*)notifi{
    if (!self.stuImf.nametext.text.length||!self.stuImf.cardIdText.text.length) {
        [self.stuImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.stuImf.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.stuImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.stuImf.keepButton.userInteractionEnabled = YES ;
        
    }
    
}
//键盘显示与隐藏
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"111");
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (self.stuImf.schoolRollText.frame.origin.y+self.stuImf.schoolRollText.frame.size.height+5) - (self.view.frame.size.height-64 - kbHeight);
    NSLog(@"offset =%f",offset);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    if (textfield==self.stuImf.emailText||textfield == self.stuImf.stuNumberText||textfield == self.stuImf.schoolRollText) {
    //        //将视图上移计算好的偏移
    NSLog(@"222");
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    // }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    // if (textfield==self.stuImf.emailText||textfield == self.stuImf.stuNumberText||textfield == self.stuImf.schoolRollText){
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSLog(@"333");
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    // }
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
