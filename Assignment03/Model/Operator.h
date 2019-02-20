//
//  Operator.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    OP_NONE,
    OP_ADD,
    OP_SUBTRACT,
    OP_MULTIPLY,
    OP_DIVIDE,
    OP_SIGN,
    OP_EQUAL,
    OP_PERCENT,
} OperatorID;

NS_ASSUME_NONNULL_BEGIN

@interface Operator : NSObject

-(Operator *) initWith: (OperatorID) operatorID;

@property (assign) OperatorID operatorID;

-(NSString *) operatorTitle;

@end

NS_ASSUME_NONNULL_END
