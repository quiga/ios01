//
//  SetCardDeck.m
//  Matchismo
//
//  Created by PPKE-IMAC-4 on 2014.03.27..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck


- (instancetype)init{
    self = [super init];
    
    if(self){
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShape]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shape = shape;
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
