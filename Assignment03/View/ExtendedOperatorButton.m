//
//  ExtendedOperatorButton.m
//  Assignment03
//
//  Created by JihoonPark on 14/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "ExtendedOperatorButton.h"

@implementation ExtendedOperatorButton

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor colorWithDisplayP3Red:44 green:50 blue:56 alpha:0.2]];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[UIColor darkGrayColor].CGColor];
}

@end
