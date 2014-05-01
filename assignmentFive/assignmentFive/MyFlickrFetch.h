//
//  MyFlickrFetch.h
//  assignmentFive
//
//  Created by Trollface on 2014.04.30..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "FlickrFetcher.h"

@interface MyFlickrFetch : FlickrFetcher

+ (void)loadPlaces:(void (^)(NSArray *places, NSError *error))completionHandler;
+ (void)loadPhotos:(NSDictionary *)place
               maxResults:(NSUInteger)results
             onCompletion:(void (^)(NSArray *photos, NSError *error))completionHandler;

+ (NSString *)getTitleFromPlace:(NSDictionary*)place;
+ (NSString *)getSubTitleFromPlace:(NSDictionary*)place;
+ (NSString *)getCountryFromPlace:(NSDictionary*)place;

+ (NSString *)getTitleFromPhoto:(NSDictionary *)photo;
+ (NSString *)getSubTitleFromPhoto:(NSDictionary *)photo;
+ (NSString *)IDforPhoto:(NSDictionary *)photo;

+ (NSDictionary *)getPlacesByCountryList:(NSArray *)places;

+ (NSArray *)getCountryListFromPlaces:(NSDictionary *)places;
+ (NSArray *)sortByPlace:(NSArray *)places;

+ (NSURL *)URLforPhoto:(NSDictionary *)photo;
@end
