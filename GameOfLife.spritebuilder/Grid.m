//
//  Grid.m
//  GameOfLife
//
//  Created by Karn on 7/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    //accept touches on the grid
    self.userInteractionEnabled = YES;
    
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as a blank NSMutableArray
    _gridArray = [NSMutableArray array];
    
    // initalize Creatures
    for (int i = 0; i < GRID_ROWS; i++) {
    // this is how you create two dimensional arrays in Objective-C. You put arrays in arrays.
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            // this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            x+=_cellWidth;
        }
        
        y+=_cellHeight;
        
        }
    }

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // get the x, y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    // get the creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    // invert it's state, kill it if it's alive, bring it to life if dead
    creature.isAlive = !creature.isAlive;
    }
- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    // get the row and column that was touched, return the creature inside the corresponding cell
    int _row = touchPosition.y/_cellHeight;
    int _column = touchPosition.x/_cellWidth;
    
    return _gridArray[_row][_column];
    
}

@end
