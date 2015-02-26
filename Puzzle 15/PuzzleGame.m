//
//  PuzzleGame.m
//  Puzzle 15
//
//  Created by Brad Taylor on 2/18/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PuzzleGame.h"

@interface PuzzleGame () {
    NSInteger prevMove;
}

@property (nonatomic, assign) NSInteger numberOfTiles;
@property (nonatomic, assign) NSInteger blankIndex;

@end


@implementation PuzzleGame

-(void) startGameWithTiles:(NSMutableArray *) gameTiles
{
    self.gameTiles = gameTiles;
    self.numberOfTiles = [self.gameTiles count];
    self.blankIndex = self.numberOfTiles - 1;
}

-(NSMutableArray *) shuffleTiles
{
    NSMutableArray *tilesToSwap = [NSMutableArray arrayWithObject:[self.gameTiles objectAtIndex:self.blankIndex]];
    NSInteger moves[4] = {-4, -1, 1, 4};
    long unsigned index;
    NSInteger move;
    prevMove = 0;
    do {
        index = random() % 4;
        move = moves[index];
    } while ( prevMove + move == 0 || (move + self.blankIndex > 15 || move + self.blankIndex < 0) );
    NSInteger newPosition = move + self.blankIndex;
    if ( move == -4 ) { // move up
        if ( newPosition > 11 ) {
            // do nothing
        } else {
            prevMove = move;
            [tilesToSwap addObject:[self.gameTiles objectAtIndex:newPosition]];
            self.blankIndex = newPosition;
        }
    }
    if ( move == -1 ) { // move left
        if ( newPosition % 4 == 3 ) {
            // do nothing
        } else {
            prevMove = move;
            [tilesToSwap addObject:[self.gameTiles objectAtIndex:newPosition]];
            self.blankIndex = newPosition;
        }
    }
    if ( move == 1 ) { // move right
        if ( newPosition % 4 == 0 ) {
            // do nothing
        } else {
            prevMove = move;
            [tilesToSwap addObject:[self.gameTiles objectAtIndex:newPosition]];
            self.blankIndex = newPosition;
        }
    }
    if ( move == 4 ) { // move down
        if ( newPosition < 4 ) {
            // do nothing
        } else {
            prevMove = move;
            [tilesToSwap addObject:[self.gameTiles objectAtIndex:newPosition]];
            self.blankIndex = newPosition;
        }
    }
    if ( [tilesToSwap count] == 2 ) {
        [self.gameTiles exchangeObjectAtIndex:[self.gameTiles indexOfObject:[tilesToSwap objectAtIndex:0]]
                        withObjectAtIndex:[self.gameTiles indexOfObject:[tilesToSwap objectAtIndex:1]]];
        return tilesToSwap;
    }
    tilesToSwap = nil;
    return [self shuffleTiles];
}

-(NSMutableArray *) getOutOfPositionTiles
{
    NSMutableArray *swapTiles = [NSMutableArray array];
    long position = 0;
    for ( UIButton *tile in self.gameTiles ) {
        if ( ! [self isTileInCorrectPosition:tile] ) {
            [swapTiles addObject:tile];
            position = [self.gameTiles indexOfObject:tile];
            break;
        }
    }
    for ( UIButton *tile in self.gameTiles ) {
        if ( [tile.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%ld", position + 1]] ) {
            [swapTiles addObject:tile];
            break;
        }
    }
    [self.gameTiles exchangeObjectAtIndex:[self.gameTiles indexOfObject:[swapTiles objectAtIndex:0]]
                        withObjectAtIndex:[self.gameTiles indexOfObject:[swapTiles objectAtIndex:1]]];
    self.blankIndex = [self.gameTiles indexOfObject:[swapTiles objectAtIndex:0]];
    return swapTiles;
}

-(BOOL) isTileInCorrectPosition:(UIButton *) tile
{
    if ( [tile.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%ld", [self.gameTiles indexOfObject:tile] + 1]] )
        return YES;
    return NO;        
}

-(NSMutableArray *) revertTiles
{
    return [self getOutOfPositionTiles];
}

-(BOOL) canSwipeInDirection:(UISwipeGestureRecognizerDirection) direction
{
    if ( direction == UISwipeGestureRecognizerDirectionUp ) {
        if ( self.blankIndex >= 12 )
            return NO;
    } else if ( direction == UISwipeGestureRecognizerDirectionDown ) {
        if ( self.blankIndex <= 3 )
            return NO;
    } else if ( direction == UISwipeGestureRecognizerDirectionLeft ) {
        if ( self.blankIndex % 4 == 3 ) // 3 or 7 or 11 or 15
            return NO;
    } else if ( direction == UISwipeGestureRecognizerDirectionRight ) {
        if ( self.blankIndex % 4 == 0 ) // 0 or 4 or 8 or 12
            return NO;
    }
    return YES;
}

- (NSArray *)buttonsToSwapWithDirection:(UISwipeGestureRecognizerDirection)direction
{
    UIButton *buttonToSwap;
    long switchIndex = 0;
    
    if (direction == UISwipeGestureRecognizerDirectionLeft) {
        switchIndex = self.blankIndex + 1;
        buttonToSwap = [self.gameTiles objectAtIndex:switchIndex];
    }
    else if (direction == UISwipeGestureRecognizerDirectionDown) {
        switchIndex = self.blankIndex - 4;
        buttonToSwap = [self.gameTiles objectAtIndex:switchIndex];
    }
    else if (direction == UISwipeGestureRecognizerDirectionRight) {
        switchIndex = self.blankIndex - 1;
        buttonToSwap = [self.gameTiles objectAtIndex:switchIndex];
    }
    else if (direction == UISwipeGestureRecognizerDirectionUp) {
        switchIndex = self.blankIndex + 4;
        buttonToSwap = [self.gameTiles objectAtIndex:switchIndex];
    }
    [self.gameTiles exchangeObjectAtIndex:switchIndex withObjectAtIndex:self.blankIndex];
    NSArray *array = @[[NSNumber numberWithInt:(int)switchIndex], [NSNumber numberWithInteger:self.blankIndex]];
    self.blankIndex = switchIndex;
    return array;
}

-(BOOL) isSolved
{
    int i = 0;
    for ( UIButton *tile in self.gameTiles ) {
        if ( ! [tile.titleLabel.text  isEqualToString:[[NSNumber numberWithInt:++i] stringValue]] )
            return NO;
    }
    return YES;
}

@end
