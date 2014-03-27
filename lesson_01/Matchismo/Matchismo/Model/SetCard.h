//
//  SetCard.h
//  Matchismo
//
//  Created by PPKE-IMAC-4 on 2014.03.27..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic) NSString *shape;
@property (nonatomic) NSString *shading;
@property (nonatomic) NSString *color;

+ (NSArray *)validColors;
+ (NSArray *)validShape;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

+ (NSDictionary *)validShapeSymbols;
+ (NSDictionary *)validColorObjects;

@end
