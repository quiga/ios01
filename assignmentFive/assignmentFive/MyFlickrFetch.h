//
//  MyFlickrFetch.h
//  assignmentFive
//
//  Created by Trollface on 2014.04.30..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "FlickrFetcher.h"

@interface MyFlickrFetch : FlickrFetcher

+ (void)loadPlacesOnCompletion:(void (^)(NSArray *places, NSError *error))completionHandler;

+ (NSString*) getTitleFromPlace:(NSDictionary*)place;
+ (NSString*) getSubTitleFromPlace:(NSDictionary*)place;
+ (NSString*) getCountryFromPlace:(NSDictionary*)place;

+ (NSDictionary *) getPlacesByCountryList:(NSArray *)places;
+ (NSArray *)getCountriesFromPlaces:(NSDictionary *)places;


+ (NSString *)getTitleFromPhoto:(NSDictionary *)photo;
+ (NSString *)getSubTitleFromPhoto:(NSDictionary *)photo;

+ (NSURL *)URLforPhoto:(NSDictionary *)photo;
+ (NSString *)IDforPhoto:(NSDictionary *)photo;

@end
