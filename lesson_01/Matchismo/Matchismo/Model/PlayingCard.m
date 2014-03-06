//
//  PlayingCard.m
//  Matchismo
//
//  Created by Trollface on 2014.03.04..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


+ (NSArray *)validSuits{
    return  @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank{
    return [[self rankStrings] count]-1;
}

@synthesize suit = _suit;

- (NSString *)suit{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score = 4;
        } else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    } else {
        for (PlayingCard *card3 in otherCards) {
            for(PlayingCard *otherCard in otherCards){
                if(card3 != otherCard){
                    if(otherCard.rank == self.rank || otherCard.rank == card3.rank || card3.rank == self.rank){
                        score += 4;
                    } else if([otherCard.suit isEqualToString:self.suit] || [card3.suit isEqualToString:self.suit] || [otherCard.suit isEqualToString:card3.suit]){
                        score += 1;
                    }
                }
            }
            
        }
        
        
    }
    return score;
}

- (NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
