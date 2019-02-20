//
//  ArithmeticOperatorButton.m
//  Assignment03
//
//  Created by JihoonPark on 14/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "ArithmeticOperatorButton.h"

@implementation ArithmeticOperatorButton

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor orangeColor]];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[UIColor grayColor].CGColor];
}

@end
