//
//  DRHResultCell.h
//  Lab Dice
//
//  Created by Lee Walsh on 25/09/13.
//  Copyright (c) 2013 Lee Walsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRHResultCell : NSObject {
    NSNumber *value;
    NSNumber *order;
}
@property NSNumber *value;
@property NSNumber *order;

-(id)initWithValue: (NSInteger) newValue;
+(id)resultCellWithValue: (NSInteger) newValue;

@end
