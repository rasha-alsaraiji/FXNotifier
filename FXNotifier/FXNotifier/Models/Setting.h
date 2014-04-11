//
//  Setting.h
//  FXNotifier
//
//  Created by RashOosh on 2/8/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject
{
    int idsetting;
    NSString *title;
    NSString *detailTitle;
    BOOL checked;
    
}
@property (nonatomic)int idsetting;
@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)    NSString *detailTitle;
@property (nonatomic) BOOL checked;

-(id)initSetting :(int)IdSetting title:(NSString *)Title detailTitle :(NSString *)DetailTitle checked :(BOOL)Checked;
@end
