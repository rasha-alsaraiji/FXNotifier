
#import "StyledPullableView.h"

/**
 @author Fabio Rodella fabio@crocodella.com.br
 */

@implementation StyledPullableView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Options.png"]];
//        imgView.backgroundColor=[UIColor clearColor];
//        imgView.frame = CGRectMake(0, 0, 320, 189);
//        [self insertSubview:imgView atIndex:0];
        self.backgroundColor=[UIColor grayColor];
        [imgView release];
    }
    return self;
}

@end
