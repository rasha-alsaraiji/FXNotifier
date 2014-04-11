//
//  MarketCell.m
//  FXNotifier
//
//  Created by RashOosh on 2/1/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "MarketCell.h"

@interface MarketCell ()

@end

@implementation MarketCell
@synthesize lbl_Details,lbl_AmorPm,lbl_Current,lbl_Next,lbl_Previous,lbl_Time,lbl_Title,imgview,lbl_unit,img_important,lblDate;
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
