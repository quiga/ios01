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
//    return @[@"red", @"red", @"red"];
    return @[@"red", @"green", @"purple"];
}

+ (NSDictionary *)validColorObjects{
    return @{@"red": [UIColor redColor], @"green": [UIColor greenColor], @"purple": [UIColor purpleColor]};
}

+ (NSArray *)validShape{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSDictionary *)validShapeSymbols{
    return @{@"oval": @"●", @"squiggle": @"▲", @"diamond": @"■"};
}

+ (NSArray *)validShadings{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber{
    return 3;
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCards - 1)
    {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *shape = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        
        [colors addObject:self.color];
        [shape addObject:self.shape];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        
        for (id _card in otherCards) {
            if ([_card isKindOfClass:[SetCard class]]) {
                
                SetCard *otherCard = (SetCard *)_card;
                if (![colors containsObject:otherCard.color])
                    [colors addObject:otherCard.color];
                
                if (![shape containsObject:otherCard.shape])
                    [shape addObject:otherCard.shape];
                
                if (![shadings containsObject:otherCard.shading])
                    [shadings addObject:otherCard.shading];
                
                if (![numbers containsObject:@(otherCard.number)])
                    [numbers addObject:@(otherCard.number)];
                
                if ([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
                {
                    if ([shape count] == 1 || [shape count] == self.numberOfMatchingCards)
                    {
                        if ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)
                        {
                            if ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)
                            {
                                score = 4;
                            }
                        }
                    }
                }
            }
        }
    }

    return score;
}

@end
