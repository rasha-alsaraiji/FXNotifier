//
//  MarketCell.h
//  FXNotifier
//
//  Created by RashOosh on 2/1/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketCell : UITableViewCell
{
    IBOutlet UILabel *lbl_Details;
}
@property (nonatomic,strong)IBOutlet UILabel *lbl_Details;
@property (nonatomic,strong)IBOutlet UILabel *lbl_Title;
@property (nonatomic,strong)IBOutlet UILabel *lbl_Time;
@property (nonatomic,strong)IBOutlet UILabel *lbl_AmorPm;
@property (nonatomic,strong)IBOutlet UILabel *lbl_Previous;
@property (nonatomic,strong)IBOutlet UILabel *lbl_Next;
@property (nonatomic,strong)IBOutlet UILabel *lbl_Current;
@property (nonatomic,strong)IBOutlet UIImageView *imgview;
@property (nonatomic,strong)IBOutlet UILabel * lbl_unit;
@property (nonatomic,strong)IBOutlet UIImageView *img_important;
@property (nonatomic,strong)IBOutlet UILabel *lblDate;
@end
