//
//  QGViewController.h
//  demo3
//
//  Created by PPKE-IMAC-4 on 2014.04.04..
//  Copyright (c) 2014 Quintz Gábor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QGViewController : UIViewController <NSURLConnectionDataDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imview;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end
