//
//  DRHResultsView.m
//  Lab Dice
//
//  Created by Lee Walsh on 25/09/13.
//  Copyright (c) 2013 Lee Walsh. All rights reserved.
//

#import "DRHResultsView.h"
#import "DRHDiceResults.h"

#define ROWPADDING 5
#define CELLPADDING 10
#define MARGIN 10

@implementation DRHResultsView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    CGFloat textSize = 12;
	NSMutableDictionary* font_attributes = [NSMutableDictionary new];
	NSFont *font = [NSFont fontWithName:@"Arial" size:textSize];
	[font_attributes setObject:font forKey:NSFontAttributeName];
    
    NSString *cellText = [NSString stringWithFormat:@"Subject"];
    cellSize = [cellText sizeWithAttributes:font_attributes];
    cellSize.width += 2*CELLPADDING;
    cellSize.height += 2*ROWPADDING;
//    NSLog(@"cellSize: %f,%f",cellSize.width,cellSize.height);
    NSSize tableSize = NSMakeSize(([results numBlocks] + ([results numGroups]>0) +1) * cellSize.width, ([results numSubjects]+1) * cellSize.height);
//    NSLog(@"tableSize: %f,%f",tableSize.width,tableSize.height);
    [self setFrame:NSMakeRect(0.0, 0.0, tableSize.width+2*MARGIN, tableSize.height+2*MARGIN)];
//    NSLog(@"frame: %f,%f %f,%f",[self frame].origin.x,[self frame].origin.y,[self frame].size.width,[self frame].size.width);
//    NSLog(@"bounds: %f,%f %f,%f",[self bounds].origin.x,[self bounds].origin.y,[self bounds].size.width,[self bounds].size.width);
    
    //Draw table background
    [[NSColor whiteColor] set];
    NSBezierPath *background=[NSBezierPath bezierPathWithRect:[self frame]];
    [background fill];
    
    //Draw headings
    NSPoint rowPosition = NSMakePoint([self frame].origin.x+MARGIN+CELLPADDING,[self frame].origin.y+MARGIN);
    [cellText drawAtPoint:rowPosition withAttributes:font_attributes];     //headings is sets to @"Subject" above
    if ([results numGroups]>0) {
        rowPosition.x += cellSize.width;
        cellText = [NSString stringWithFormat:@"Group"];
        [cellText drawAtPoint:rowPosition withAttributes:font_attributes];
    }
    for (NSInteger i=0; i<[results numBlocks]; i++) {
        rowPosition.x += cellSize.width;
        cellText = [NSString stringWithFormat:@"Block %ld",i+1];
        [cellText drawAtPoint:rowPosition withAttributes:font_attributes];
    }
    
    //Draw background boxes
    rowPosition = NSMakePoint([self frame].origin.x+MARGIN,[self frame].origin.y+cellSize.height+MARGIN);
    for (NSInteger i=0 ; i<[results numSubjects] ; i++) {
        if ((i+1) % 2 == 1) {
            [[NSColor lightGrayColor] set];
            NSBezierPath *box = [NSBezierPath bezierPathWithRect:NSMakeRect(rowPosition.x, rowPosition.y+i*cellSize.height, tableSize.width, cellSize.height)];
            [box fill];
        }
    }
    
    //Draw table data
    [[NSColor blackColor] set];
    rowPosition = NSMakePoint([self frame].origin.x+MARGIN+CELLPADDING,[self frame].origin.y+MARGIN+cellSize.height);
    for (NSInteger i=0; i<[results numSubjects]; i++) {
        cellText = [NSString stringWithFormat:@"%ld.",i+1];
        [cellText drawAtPoint:rowPosition withAttributes:font_attributes];
        for (NSInteger j=0; j<[results numBlocks]; j++) {
            //NSLog(@"i: %ld, j: %ld",i,j);
            //NSLog(@"%@",[[[[results resultsArray] objectAtIndex:i] objectAtIndex:j] value]);
            cellText = [NSString stringWithFormat:@"%ld",[[[[[results resultsArray] objectAtIndex:i] objectAtIndex:j] value] integerValue]];
            //NSLog(@"Class: %@, value: %@",[[[[[results resultsArray] objectAtIndex:i] objectAtIndex:j] stringValue]class],[[[[results resultsArray] objectAtIndex:i] objectAtIndex:j] value]);
            [cellText drawAtPoint:NSMakePoint(rowPosition.x+(j+1)*cellSize.width, rowPosition.y) withAttributes:font_attributes];
        }
        rowPosition.y += cellSize.height;
    }
    
    //Draw table lines
    rowPosition = NSMakePoint([self frame].origin.x+MARGIN,[self frame].origin.y+cellSize.height+MARGIN);
//    NSLog(@"rowPosition: %f,%f",rowPosition.x,rowPosition.y);
    NSBezierPath *tableLines = [NSBezierPath bezierPath];
    [tableLines moveToPoint:rowPosition];
    [tableLines lineToPoint:NSMakePoint(rowPosition.x+tableSize.width, rowPosition.y)];
    [tableLines moveToPoint:NSMakePoint(rowPosition.x+cellSize.width, rowPosition.y-cellSize.height)];
    [tableLines lineToPoint:NSMakePoint(rowPosition.x+cellSize.width, rowPosition.y-cellSize.height+tableSize.height)];
    if ([results numGroups]>0) {
        [tableLines moveToPoint:NSMakePoint(rowPosition.x+2*cellSize.width, rowPosition.y-cellSize.height)];
        [tableLines lineToPoint:NSMakePoint(rowPosition.x+2*cellSize.width, rowPosition.y-cellSize.height+tableSize.height)];
    }
    [[NSColor blackColor] set];
    [tableLines stroke];
    
    
}

-(BOOL)isFlipped {
    return YES;
}

#pragma Printing pagination overrides
-(BOOL)knowsPageRange:(NSRangePointer)range{
    NSPrintOperation *po = [NSPrintOperation currentOperation];
    NSPrintInfo *printInfo = [po printInfo];
    //Where can I draw? - I'm not sure I need this.
    pageRect = [printInfo imageablePageBounds];
/*    NSRect newFrame;
    newFrame.origin = NSZeroPoint;
    newFrame.size = [printInfo paperSize];
    [self setFrame:newFrame];
*/    
    rowsPerPage = (NSInteger)(pageRect.size.height/cellSize.height);
    columnsPerPage = (NSInteger)(pageRect.size.width/cellSize.width);
//    NSLog(@"rpp: %ld, cpp: %ld",rowsPerPage,columnsPerPage);
    
    //Pages are 1-based     //what does this mean?
    range->location = 1;
    
    //How many pages?
    pagesLong = ([results numSubjects]+1) / rowsPerPage;
    if (([results numSubjects]+1) % rowsPerPage > 0) {
        pagesLong++;
    }
    NSInteger numCols = [results numBlocks]+1;
    if ([results numGroups]>0) {
        numCols++;
    }
    NSInteger pagesWide = numCols / columnsPerPage;
    if (numCols % columnsPerPage > 0) {
        pagesWide++;
    }
//    NSLog(@"pgsLong: %ld, pgsWide: %ld",pagesLong,pagesWide);
    range->length = pagesLong * pagesWide;
//    NSLog(@"pages: %ld",range->length);
    
    return YES;
}

-(NSRect)rectForPage:(NSInteger)page{
    NSInteger pageRow = (page-1) % pagesLong;
    NSInteger pageCol = (page-1) / pagesLong;
//    NSLog(@"pgRow: %ld, pgCol: %ld",pageRow,pageCol);
    pageRect.size.width = columnsPerPage * cellSize.width;
    pageRect.size.height = rowsPerPage * cellSize.height;
    pageRect.origin.x = pageCol * columnsPerPage * cellSize.width + (pageCol>0)*MARGIN;
    pageRect.origin.y = pageRow * rowsPerPage *cellSize.height + (pageRow>0)*MARGIN;
    
    return pageRect;
}

@end