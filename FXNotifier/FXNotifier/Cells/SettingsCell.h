//
//  SettingsCell.h
//  FXNotifier
//
//  Created by RashOosh on 2/7/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsCell : UITableViewCell
@property (strong ,nonatomic)IBOutlet UILabel *lbl_Title;
@property (strong ,nonatomic) IBOutlet UILabel *lbl_Details;
@property (strong ,nonatomic) IBOutlet UIImageView *img_checked;
@end
