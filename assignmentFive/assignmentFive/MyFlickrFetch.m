//
//  MyFlickrFetch.m
//  assignmentFive
//
//  Created by Trollface on 2014.04.30..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "MyFlickrFetch.h"

@interface MyFlickrFetch()
+ (NSArray*) titleFromPlace:(NSDictionary*)place;

@end

@implementation MyFlickrFetch

+ (NSArray*) titleFromPlace:(NSDictionary *)place{
    return [[place valueForKeyPath:FLICKR_PLACE_NAME] componentsSeparatedByString:@", "];
}

+ (void)loadPlacesOnCompletion:(void (^)(NSArray *places, NSError *error))completionHandler
{
    NSLog(@"asd");
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[MyFlickrFetch URLforTopPlaces]
                                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                    NSArray *places;
                                                    NSLog(@"szeva");
                                                    if (!error) {
                                                        places = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location]
                                                                                                  options:0
                                                                                                    error:&error] valueForKeyPath:FLICKR_RESULTS_PLACES];
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        completionHandler(places, error);
                                                    });
                                                }];
    [task resume];
}

+ (NSString*) getTitleFromPlace:(NSDictionary*)place{
    return [[MyFlickrFetch titleFromPlace:place] firstObject];
}

+ (NSString*) getSubTitleFromPlace:(NSDictionary*)place{
    NSArray *items = [MyFlickrFetch titleFromPlace:place];
    return [[items subarrayWithRange:NSMakeRange(1, [items count]-2)] componentsJoinedByString:@", "];
}
+ (NSString*) getCountryFromPlace:(NSDictionary*)place{
    return [[MyFlickrFetch titleFromPlace:place] lastObject];
}

@end
