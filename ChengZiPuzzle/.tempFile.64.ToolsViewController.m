//
//  ToolsViewController.m
//  idiom
//
//  Created by chang on 2022/8/22.
//  Copyright © 2019 chang. All rights reserved.
//

#import "ToolsViewController.h"

@interface ToolsViewController ()

@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+(CGSize)getsizeWithString:(NSString *)string  font:(float)font maxSize:(CGSize)maxSize
{
    if ([string isEqual:[NSNull null]] || [string isEqualToString:@""] || [string isEqual:[NSNull null]] || [string isEqualToString:/*@"<null>"*/NEDecodeOcString(&_5DAB056B750147)]) {
        CGSize size = CGSizeMake(0, 0);
        return size;
    }else{
        // CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        NSDictionary *dictionary = @{NSFontAttributeName: [UIFont systemFontOfSize:font ]};
        CGSize textSize= [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dictionary context:nil].size;
        return textSize;
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
