//
//  QGViewController.m
//  demo
//
//  Created by PPKE-IMAC-4 on 2014.03.21..
//  Copyright (c) 2014 Quintz Gábor. All rights reserved.
//

#import "QGViewController.h"

@interface QGViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation QGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSAttributedString *astring = self.textView.attributedText;
    
    NSMutableAttributedString *mastring = [astring mutableCopy];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, [UIColor greenColor], NSForegroundColorAttributeName, nil];
    
    [mastring setAttributes:dict range:NSMakeRange(15, [mastring length]-15)];
    
    self.textView.attributedText = mastring;
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
