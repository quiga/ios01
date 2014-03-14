//
//  SetCard.h
//  Matchismo
//
//  Created by Trollface on 2014.03.13..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbol;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
