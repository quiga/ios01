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
+ (void)load:(NSURL *)url withValueForKeyPath:(NSString *)value AndHandler:(void (^)(NSArray *photos, NSError *error))completionHandler;

@end

@implementation MyFlickrFetch

+ (NSArray*) titleFromPlace:(NSDictionary *)place{
    return [[place valueForKeyPath:FLICKR_PLACE_NAME] componentsSeparatedByString:@", "];
}

+ (void)loadPlaces:(void (^)(NSArray *places, NSError *error))completionHandler
{
    [MyFlickrFetch load:[MyFlickrFetch URLforTopPlaces] withValueForKeyPath:FLICKR_RESULTS_PLACES AndHandler:completionHandler];
}

+ (void)load:(NSURL *)url withValueForKeyPath:(NSString *)value AndHandler:(void (^)(NSArray *photos, NSError *error))completionHandler
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                    NSArray *items;
                                                    if (!error) {
                                                        items = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location]
                                                                                                  options:0
                                                                                                    error:&error] valueForKeyPath:value];
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        completionHandler(items, error);
                                                    });
                                                }];
    [task resume];
}

+ (void)loadPhotos:(NSDictionary *)place
               maxResults:(NSUInteger)results
             onCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler
{
    [MyFlickrFetch load:[MyFlickrFetch URLforPhotosInPlace:[place valueForKeyPath:FLICKR_PLACE_ID] maxResults:(int)results] withValueForKeyPath:FLICKR_RESULTS_PHOTOS AndHandler:completionHandler];
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

+ (NSArray*) sortByPlace:(NSArray *)places
{
    return [places sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 valueForKeyPath:FLICKR_PLACE_NAME] localizedCompare:[obj2 valueForKeyPath:FLICKR_PLACE_NAME]];
    }];
}


+ (NSDictionary *) getPlacesByCountryList:(NSArray *)places{
    NSMutableDictionary *elements = [[NSMutableDictionary alloc] init];
    for(NSDictionary *place in places){
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

+ (NSArray *)getCountryListFromPlaces:(NSDictionary *)places
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
    NSString *title = [MyFlickrFetch getTitleFromPhoto:photo];
    if ([title isEqualToString:FLICKR_DEFAULT_PHOTO_TITLE]) return @"";
    
    NSString *subtitle = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title isEqualToString:subtitle]) return @"";
    
    return subtitle;
}

+ (NSURL *)URLforPhoto:(NSDictionary *)photo
{
    return [MyFlickrFetch URLforPhoto:photo format:FlickrPhotoFormatLarge];
}

+ (NSString *)IDforPhoto:(NSDictionary *)photo
{
    return [photo valueForKeyPath:FLICKR_PHOTO_ID];
}

@end
