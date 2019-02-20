//
//  TokenType.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#ifndef TokenType_h
#define TokenType_h

typedef enum{
    Token_Clear,
    Token_Digit,
    Token_DecimalPoint,
    Token_Sign,
    Token_ArithmeticOperator,
    Token_Equal,
    Token_Percent
} TokenType;

#define NUMBER_OF_TOKENTYPES 7

#endif /* TokenType_h */
