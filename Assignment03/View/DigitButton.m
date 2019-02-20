//
//  DigitButton.m
//  Assignment03
//
//  Created by JihoonPark on 14/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "DigitButton.h"

@implementation DigitButton

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor lightGrayColor]];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[UIColor grayColor].CGColor];
}

@end
