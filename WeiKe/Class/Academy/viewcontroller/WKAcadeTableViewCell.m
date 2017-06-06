//
//  WKAcadeTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/21.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAcadeTableViewCell.h"

@implementation WKAcadeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.StyleLabel.textColor = [WKColor colorWithHexString:<#(NSString *)#>]
    self.StyleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];

    //self.alpha =1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
      if (selected) {
        self.selectedBackgroundView.backgroundColor = [WKColor colorWithHexString:@"e4e4e4"];
        //self.backgroundColor = [WKColor colorWithHexString:@"e4e4e4"];
        //self.StyleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
        self.StyleLabel.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    }
    else{
        self.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
        self.StyleLabel.textColor = [WKColor colorWithHexString:@"666666"];
    }

    // Configure the view for the selected state
}
//-(void)changecell:(BOOL)select{
//    NSLog(@"12390----");
//    select = self.isyes;
//    if (select) {
//        NSLog(@"4444");
//       
//        self.selectedBackgroundView.backgroundColor = [WKColor colorWithHexString:@"f2f2f2"];
//        //self.backgroundColor = [UIColor redColor];
//        //self.StyleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
//        self.StyleLabel.textColor = [WKColor colorWithHexString:GREEN_COLOR];
//    }
//    else{
//        NSLog(@"4444");
//        self.backgroundColor = [WKColor colorWithHexString:@"f2f2f2"];
//        self.StyleLabel.textColor = [WKColor colorWithHexString:@"666666"];
//    }
//}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cellChange" object:nil];
}

@end
