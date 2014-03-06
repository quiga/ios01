//
//  Card.m
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize chosen = _chosen;
@synthesize matched = _matched;

-(int)match:(NSArray *)otherCards{
    int score = 0;
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score=1;
        }
    }
    return score;
}

@end
