//
//  Engine.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"
#import "Operator.h"
#import "ButtonClear_Transition.h"
#import "Expression.h"

NS_ASSUME_NONNULL_BEGIN

@interface Engine : NSObject

@property (nonatomic, readonly) Operator * operator;
@property (nonatomic, readonly) NSString* currentNumberString;
@property (nonatomic, readonly) Expression* expression;
@property (assign, readonly) ButtonClear_Transition buttonAC;

-(void) run:(Token*) token;
-(void) reset;

@end

NS_ASSUME_NONNULL_END
