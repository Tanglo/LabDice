//
//  DRHResultsView.h
//  Lab Dice
//
//  Created by Lee Walsh on 25/09/13.
//  Copyright (c) 2013 Lee Walsh. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DRHDiceResults;

@interface DRHResultsView : NSView {
    IBOutlet DRHDiceResults *results;
    
    //Drawing
    NSSize cellSize;
    
    //Printing
    NSInteger rowsPerPage;
    NSInteger columnsPerPage;
    NSInteger pagesLong;
}

@end
