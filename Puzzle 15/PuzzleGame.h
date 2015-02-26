//
//  PuzzleGame.h
//  Puzzle 15
//
//  Created by Brad Taylor on 2/18/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PuzzleGame : NSObject

@property (nonatomic, strong) NSMutableArray *gameTiles; // tiles

-(void) startGameWithTiles:(NSArray *) gameTiles;
-(NSMutableArray *) shuffleTiles;
-(NSMutableArray *) revertTiles;
-(BOOL) isSolved;
-(BOOL) canSwipeInDirection:(UISwipeGestureRecognizerDirection) direction;
-(NSArray *) buttonsToSwapWithDirection:(UISwipeGestureRecognizerDirection)direction;

@end
