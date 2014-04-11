//
//  Setting.m
//  FXNotifier
//
//  Created by RashOosh on 2/8/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "Setting.h"

@implementation Setting
@synthesize checked,detailTitle,idsetting,title;
-(id)initSetting :(int)IdSetting title:(NSString *)Title detailTitle :(NSString *)DetailTitle checked :(BOOL)Checked
{
    self.idsetting=IdSetting;
    self.title=Title;
    self.detailTitle=DetailTitle;
    self.checked=Checked;
    return self;
    
}
@end
