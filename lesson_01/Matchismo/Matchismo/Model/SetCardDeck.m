//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Trollface on 2014.03.13..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"


@implementation SetCardDeck

- (instancetype)init{
    self = [super init];
    
    if(self){
        for (NSString *color in [SetCard validColors]) {
            for (NSString *symbol in [SetCard validSymbol]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}


@end
