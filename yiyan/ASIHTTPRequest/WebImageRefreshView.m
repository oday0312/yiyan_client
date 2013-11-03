//
//  WebImageRefreshView.m
//  meizhou_client
//
//  Created by apple on 13-5-6.
//
//

#import "WebImageRefreshView.h"

@implementation WebImageRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setRefreshImageWithURL:(NSURL *)url {
    [self setRefreshImageWithURL:url placeHolderImage:nil];
}

- (void)setRefreshImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeHolderImage {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
