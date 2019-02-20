//
//  Token.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenType.h"


@interface Token : NSObject

@property (assign) TokenType tokenType;

@property (nonatomic) NSString* tokenTitle;

@property (nonatomic) NSObject* tokenValue;

@end

