//
//  NewsCell.m
//  FXNotifier
//
//  Created by RashOosh on 2/4/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell ()

@end

@implementation NewsCell

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
