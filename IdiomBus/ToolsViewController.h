//
//  ToolsViewController.h
//  idiom
//
//  Created by chang on 2022/8/22.
//  Copyright © 2019 chang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolsViewController : UIViewController
+(CGSize)getsizeWithString:(NSString *)string  font:(float)font maxSize:(CGSize)maxSize;
@end

NS_ASSUME_NONNULL_END
