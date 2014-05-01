//
//  MyFlickrFetch.m
//  assignmentFive
//
//  Created by Trollface on 2014.04.30..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "MyFlickrFetch.h"

#define FLICKR_DEFAULT_PHOTO_TITLE @"UNKNOWN"


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

+ (NSDictionary *) getPlacesByCountryList:(NSArray *)places{
    NSMutableDictionary *elements = [[NSMutableDictionary alloc] init];
    for(NSArray *place in places){
        NSString *country = [MyFlickrFetch getCountryFromPlace:place];
        NSMutableArray *items = elements[country];
        if(!items){
            items = [[NSMutableArray alloc] init];
            elements[country] = items;
        }
        [items addObject:place];
    }
    return elements;
}

+ (NSArray *)getCountriesFromPlaces:(NSDictionary *)places
{
    NSArray *countryList = [places allKeys];
    countryList = [countryList sortedArrayUsingComparator:^(id a, id b) {
        return [a compare:b options:NSCaseInsensitiveSearch];
    }];
    return countryList;
}

+ (NSString *)getTitleFromPhoto:(NSDictionary *)photo
{
    NSString *title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
    if ([title length]) return title;
    
    title = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title length]) return title;
    
    return FLICKR_DEFAULT_PHOTO_TITLE;
}

+ (NSString *)getSubTitleFromPhoto:(NSDictionary *)photo
{
    NSString *title = [FlickrHelper titleOfPhoto:photo];
    if ([title isEqualToString:FLICKR_DEFAULT_PHOTO_TITLE]) return @"";
    
    NSString *subtitle = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title isEqualToString:subtitle]) return @"";
    
    return subtitle;
}

+ (NSURL *)URLforPhoto:(NSDictionary *)photo
{
    return [FlickrHelper URLforPhoto:photo format:FlickrPhotoFormatLarge];
}

+ (NSString *)IDforPhoto:(NSDictionary *)photo
{
    return [photo valueForKeyPath:FLICKR_PHOTO_ID];
}

@end
