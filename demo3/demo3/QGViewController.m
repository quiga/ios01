//
//  QGViewController.m
//  demo3
//
//  Created by PPKE-IMAC-4 on 2014.04.04..
//  Copyright (c) 2014 Quintz Gábor. All rights reserved.
//

#import "QGViewController.h"

@interface QGViewController ()

@property (strong, nonatomic) NSMutableData *data;

@end

@implementation QGViewController

- (void)downloadImage{
    NSURL *url = [NSURL URLWithString:@"http://cdn.superbwallpapers.com/wallpapers/animals/leopard-11388-1920x1200.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)downloadImageWithBlocks{
    NSURL *url = [NSURL URLWithString:@"http://cdn.superbwallpapers.com/wallpapers/animals/leopard-11388-1920x1200.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    NSOperationQueue *bgQueue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:bgQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:connectionError.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Retry", nil];
            [alert show];
        } else {
            UIImage *img = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imview.image = img;
                self.scroll.contentSize = CGSizeMake(img.size.width, img.size.height);
                self.imview.frame= CGRectMake(0, 0, img.size.width, img.size.height);
            });
            
        }
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self downloadImageWithBlocks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dataRecived{
    NSLog(@"data recived %@", dataRecived);
    if(!self.data) self.data = [NSMutableData data];
    [self.data appendData:dataRecived];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"finish");
    self.imview.image = [UIImage imageWithData:self.data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error: %@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Retry", nil];
    [alert show];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        NSLog(@"ez van");
    } else {
        [self downloadImage];
    }
}

@end
