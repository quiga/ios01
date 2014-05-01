//
//  QGImageControllerViewController.m
//  assignmentFive
//
//  Created by Trollface on 2014.05.01..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "QGImageController.h"

@interface QGImageController ()

@property (nonatomic, weak) IBOutlet UIScrollView *sView;
@property (nonatomic, strong) UIImageView *iV;
@property (nonatomic, strong) UIImage *img;

+ (CGSize)getImgSize:(UIImage *)img;

@end

@implementation QGImageController

+ (CGSize)getImgSize:(UIImage *)img
{
    return img?img.size:CGSizeZero;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setSView:(UIScrollView *)view{
    _sView = view;
    _sView.minimumZoomScale = 0.1;
    _sView.maximumZoomScale = 2.0;
    _sView.delegate = self;
    _sView.contentSize = [QGImageController getImgSize:self.img];
}

- (UIImageView *)iV
{
    if (!_iV) {
        _iV = [[UIImageView alloc] init];
    }
    return _iV;
}

- (UIImage* )img
{
    return  self.iV.image;
}

- (void)setImg:(UIImage *)img
{
    self.sView.zoomScale = 1.0;
    self.iV.image = img;
    self.iV.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    self.sView.contentSize = [QGImageController getImgSize:img];
    [self.iV sizeToFit];

    self.sView.zoomScale = self.sView.bounds.size.width / self.iV.image.size.width;
}

- (void)setImageUrl:(NSURL *)imageUrl{
    _imageUrl = imageUrl;
    [self fetch];
}

- (void)fetch
{
    self.img = nil;
    if (!self.imageUrl) {
        return;
    }

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:self.imageUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if(!error){
            if([response.URL isEqual:self.imageUrl]){
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.img = img;
                });
            }
        }
    }];
    [task resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sView addSubview:self.iV];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
