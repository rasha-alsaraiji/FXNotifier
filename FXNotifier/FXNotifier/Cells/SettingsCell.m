//
//  SettingsCell.m
//  FXNotifier
//
//  Created by RashOosh on 2/7/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "SettingsCell.h"

@interface SettingsCell ()

@end

@implementation SettingsCell
@synthesize lbl_Details,lbl_Title,img_checked;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.activityFlag=false;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
