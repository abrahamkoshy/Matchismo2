//
//  Deck.h
//  Matchismo
//
//  Created by Abraham Koshy on 12/24/13.
//  Copyright (c) 2013 Ubikwity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card*) card atTop:(BOOL)atTop;
-(void)addCard:(Card*) card;

-(Card*)drawRandomCard;
@end
