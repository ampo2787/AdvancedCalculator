//
//  Operator.m
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "Operator.h"

NSString* operatorStrings[] = {
    @"", @"+", @"-", @"✗", @"÷", @"+/-", @"=", @"%"
};

@implementation Operator

-(Operator*) initWith:(OperatorID)operatorID{
    self = [self init];
    if (self != NULL){
        _operatorID = operatorID;
    }
    return self;
}

-(NSString *) operatorTitle{
    return operatorStrings[self.operatorID];
}

@end
