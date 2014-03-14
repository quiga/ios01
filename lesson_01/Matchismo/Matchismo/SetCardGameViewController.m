//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Trollface on 2014.03.13..
//  Copyright (c) 2014 Quiga. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController



- (Deck *)createDeck{
    return [[SetCardDeck alloc] init];
}

@end
