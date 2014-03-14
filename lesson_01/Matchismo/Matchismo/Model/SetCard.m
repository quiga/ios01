//
//  SetCard.m
//  Matchismo
//
//  Created by Trollface on 2014.03.13..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)color{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color{
    if([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol{
    if([[SetCard validSymbol] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading{
    if([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number{
    if(number <= [SetCard maxNumber]) _number = number;
}

- (NSString *)contents{
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.symbol, self.color, self.shading, self.number];
}

+ (NSArray *)validColors{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbol{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSArray *)validShadings{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber{
    return 3;
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    
    if([otherCards count] == self.numberOfMatchingCards - 1){
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        
        for(id othercard in otherCards){
            if([othercard isKindOfClass:[SetCard class]]){
                SetCard *card = (SetCard *)othercard;
                if(![colors containsObject:card.color])
                    [colors addObject:card.color];
                if(![symbols containsObject:card.symbol])
                    [symbols addObject:card.symbol];
                if(![shadings containsObject:card.shading])
                    [shadings addObject:card.shading];
                if(![numbers containsObject:@(card.number)])
                    [numbers addObject:@(card.number)];
                
                if(([colors count] == 1 || [colors count] ==self.numberOfMatchingCards) 
                   && ([symbols count] == 1 || [symbols count] ==self.numberOfMatchingCards) 
                   && ([shadings count] == 1 || [shadings count] ==self.numberOfMatchingCards)
                   && ([numbers count] == 1 || [numbers count] ==self.numberOfMatchingCards)){
                    score = 4;
                }
            }
        }
    }
    
    return score;
}

- (instancetype)init{
    self = [super init];
    if(self){
        self.numberOfMatchingCards = 3;
    }
    return self;
}


@end
