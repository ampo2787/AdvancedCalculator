//
//  StateTransition.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TokenType.h"
#import "ButtonClear_Transition.h"
#import "Action.h"

NS_ASSUME_NONNULL_BEGIN

@interface StateTransition : NSObject

-(void) reset;
-(void) transitState: (TokenType) tokenType;

@property (readonly) Action action;
@property (readonly) ButtonClear_Transition buttonClear;

@end

NS_ASSUME_NONNULL_END
