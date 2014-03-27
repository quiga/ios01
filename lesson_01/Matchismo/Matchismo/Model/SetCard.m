//
//  SetCard.m
//  Matchismo
//
//  Created by PPKE-IMAC-4 on 2014.03.27..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color, shape = _shape, shading = _shading;

- (instancetype)init{
    self = [super init];
    if(self){
        self.numberOfMatchingCards = 3;
    }
    return self;
}

- (NSString *)color{
    return _color ? _color : @"?";
}

- (NSString *)shape{
    return _shape ? _shape : @"?";
}

- (NSString *)shading{
    return _shading ? _shading : @"?";
}


- (void)setColor:(NSString *)color{
    if([[SetCard validColors] containsObject:color]) _color = color;
}

- (void)setShape:(NSString *)shape{
    if([[SetCard validShape] containsObject:shape]) _shape = shape;
}

- (void)setShading:(NSString *)shading{
    if([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number{
    if(number <= [SetCard maxNumber]) _number = number;
}

- (NSString *)contents{
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.shape, self.color, self.shading, self.number];
}

+ (NSArray *)validColors{
    return @[@"red", @"green", @"purple"];
}

+ (NSDictionary *)validColorObjects{
    return @{@"red": [UIColor redColor], @"green": [UIColor greenColor], @"purple": [UIColor purpleColor]};
}

+ (NSArray *)validShape{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSDictionary *)validShapeSymbols{
    return @{@"oval": @"●", @"squigle": @"▲", @"diamond": @"■"};
}

+ (NSArray *)validShadings{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber{
    return 3;
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    return score;
}

@end
