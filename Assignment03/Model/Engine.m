//
//  Engine.m
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "Engine.h"
#import "StateTransition.h"
#import "Token.h"

@interface Engine()

@property (nonatomic, readwrite) Expression* expression;
@property (nonatomic, readwrite) NSString* currentNumberString;
@property (nonatomic) StateTransition* stateTransition;
@property (nonatomic) NSNumber* firstNumber;
@property (nonatomic) NSNumber* secondNumber;
@property (nonatomic, readwrite) Operator* operator;

@property (nonatomic) NSString* firstNumberDigits;
@property (nonatomic) NSString* secondNumberDigits;
@property (assign) int firstNumberSign;
@property (assign) int secondNumberSign;

-(void) takeAction: (Token*) token;
//- (NSNumber *)firstNumberString;
//- (NSNumber *)secondNumberString;
-(NSNumber *) firstNumberFromString;
-(NSNumber *) secondNumberFromString;

-(double) calculate:(OperatorID)operatorID firstNumber:(NSNumber *)firstNumber secondNumber:(NSNumber*)secondNumber;

-(void) calculateUsingOneNumberWithoutOperator;
-(void) calculateUsingTwoNumbers;
-(void) percentUsingOneNumber;
-(void) percentUsingTwoNumbers;
-(void) completeFirstNumber;
-(void) completeFirstNumberAsZero;
-(void) completeSecondNumber;
-(void) completeSecondNumberAsFirstNumber;
-(void) clearOperator;
-(void) keepOperator: (Operator*) operator;

@end

#define PREDEFINED_ZERO 1.0E-15
#define DOUBLE_NUMBER_IS_ZERO(NUMBER) fabs(NUMBER)<PREDEFINED_ZERO

@implementation Engine

-(StateTransition *)stateTransition{
    if(_stateTransition == nil){
        _stateTransition = [[StateTransition alloc]init];
    }
    return _stateTransition;
}

-(Expression *)expression{
    if(_expression == nil){
        _expression = [[Expression alloc]init];
    }
    return _expression;
}

- (NSString *) numberString: (NSString *) digits withSign:(int) sign{
    NSString * numberString = digits;
    if((numberString != nil) && (sign < 0)){
        numberString = [@"-" stringByAppendingString:numberString];
    }
    return numberString;
}

- (NSString *)firstNumberString{
    return [self numberString:self.firstNumberDigits withSign:self.firstNumberSign];
}
- (NSString *)secondNumberString{
    return [self numberString:self.secondNumberDigits withSign:self.secondNumberSign];
}

- (NSNumber *)firstNumberFromString{
    if(self.firstNumberDigits == nil){
        return nil;
    }
    else{
        return [NSNumber numberWithDouble:[self.firstNumberDigits doubleValue]*self.firstNumberSign];
    }
};

- (NSNumber *) secondNumberFromString{
    if(self.secondNumberDigits == nil){
        return nil;
    }
    else{
        return [NSNumber numberWithDouble:[self.secondNumberDigits doubleValue]*self.secondNumberSign];
    }
}

- (double)calculate:(OperatorID)operatorID firstNumber:(NSNumber *)firstNumber secondNumber:(NSNumber *)secondNumber{
    double result;
    double firstDouble = firstNumber.doubleValue;
    double secondDouble = secondNumber.doubleValue;
    switch (operatorID) {
        case OP_ADD:
            result = (firstDouble + secondDouble);
            break;
        case OP_SUBTRACT:
            result = (firstDouble + secondDouble);
            break;
        case OP_MULTIPLY:
            result = (firstDouble * secondDouble);
            break;
        case OP_DIVIDE:
            if(DOUBLE_NUMBER_IS_ZERO(secondDouble)){
                if(firstDouble*secondDouble >= 0){
                    result = MAXFLOAT;
                }
                else{
                    result =- MAXFLOAT;
                }
            }else{
                result = (firstDouble /secondDouble);
            }
            break;
        default:
            result = 0;
    }
    return result;
}

- (void)calculateUsingOneNumberWithoutOperator{
    self.currentNumberString = [NSString stringWithFormat:@"%g", self.firstNumber.doubleValue];
    [self.expression clear];
    [self.expression addToLast:self.currentNumberString];
    [self.expression addToLast:@"="];

}

- (void)calculateUsingTwoNumbers{
    double result = [self calculate:self.operator.operatorID firstNumber:self.firstNumber secondNumber:self.secondNumber];
    [self.expression clear];
    [self.expression addToLast:[NSString stringWithFormat:@"%g", self.firstNumber.doubleValue]];
    [self.expression addToLast:self.operator.operatorTitle];
    [self.expression addToLast:[NSString stringWithFormat:@"%g", self.secondNumber.doubleValue]];
    [self.expression addToLast:@"="];
    
    self.firstNumber = [NSNumber numberWithDouble:result];
    self.currentNumberString = [NSString stringWithFormat:@"%g", result];
}

-(void)percentUsingOneNumber{
    double result = self.firstNumber.doubleValue / 100;
    [self.expression clear];
    [self.expression addToLast:[NSString stringWithFormat:@"%g", self.firstNumber.doubleValue]];
    [self.expression addToLast:@"%"];
    self.secondNumber = self.firstNumber;
    self.firstNumber = [NSNumber numberWithDouble:result];
    self.currentNumberString = [NSString stringWithFormat:@"%g",result];
}

- (void)percentUsingTwoNumbers{
    double result = [self calculate:OP_MULTIPLY firstNumber:self.firstNumber secondNumber:self.secondNumber] / 100.0;
    [self.expression clear];
    [self.expression addToLast:[NSString stringWithFormat:@"%g", self.firstNumber.doubleValue]];
    [self.expression addToLast:@"✗"];
    [self.expression addToLast:[NSString stringWithFormat:@"%g", self.secondNumber.doubleValue]];
    [self.expression addToLast:@"%"];
    
    self.firstNumber = [NSNumber numberWithDouble:result];
    self.currentNumberString = [NSString stringWithFormat:@"%g", result];
}

-(void)completeFirstNumber{
    self.firstNumber = self.firstNumberFromString;
}

-(void)completeFirstNumberAsZero{
    self.firstNumber = 0;
}

- (void)completeSecondNumber{
    self.secondNumber = self.secondNumberFromString;
}

- (void)completeSecondNumberAsFirstNumber{
    self.secondNumber = self.firstNumber;
}

- (void)keepOperator:(Operator *)operator{
    self.operator = operator;
}

- (void) clearOperator{
    self.operator = nil;
}

- (void)takeAction:(Token *)token{
    switch (self.stateTransition.action) {
            
        case Action_Ignore:
            break;
            
        case Action_Reset:
            [self reset];
            break;
            
        case Action_BeginFirstIntegerString:
            self.firstNumberDigits = token.tokenTitle;
            self.firstNumberSign = +1;
            self.currentNumberString = self.firstNumberString;
            [self.expression clear];
            [self.expression addToLast:self.currentNumberString];
            break;
            
        case Action_BeginFirstDoubleString:
            if(self.firstNumberDigits == nil){
                self.firstNumberDigits = @"0";
                self.firstNumberSign = +1;
            }
            
        case Action_ConvertToFirstDoubleString:
            self.firstNumberDigits = [self.firstNumberDigits stringByAppendingString:@"."];
            self.currentNumberString = [self firstNumberString];
            [self.expression clear];
            [self.expression addToLast:self.currentNumberString];
            break;
            
        case Action_AddToFirstIntegerString:
        case Action_AddToFirstDoubleString:
            self.firstNumberDigits = [self.firstNumberDigits stringByAppendingString:token.tokenTitle];
            self.currentNumberString = self.firstNumberString;
            [self.expression clear];
            [self.expression addToLast:self.currentNumberString];
            break;
            
        case Action_BeginSecondIntegerString:
            self.secondNumberDigits = token.tokenTitle;
            self.secondNumberSign = +1;
            self.currentNumberString = self.secondNumberString;
            [self.expression clear];
            [self.expression addToLast:[NSString stringWithFormat:@"%g", self.firstNumber.doubleValue]];
            [self.expression addToLast:self.operator.operatorTitle];
            [self.expression addToLast:self.secondNumberString];
            break;
            
        case Action_BeginSecondDoubleString:
            if(self.secondNumberDigits == nil){
                self.secondNumberDigits = @"0";
                self.secondNumberSign = +1;
            }
        case Action_ConvertToSecondDoubleString:
            self.secondNumberDigits = [self.secondNumberDigits stringByAppendingString:@"."];
            self.currentNumberString = self.secondNumberString;
            [self.expression clear];
            [self.expression addToLast:[NSString stringWithFormat:@"%g", self.firstNumber.doubleValue]];
            [self.expression addToLast:self.operator.operatorTitle];
            [self.expression addToLast:self.secondNumberString];
            break;
            
        case Action_AddToSecondIntegerString:
        case Action_AddToSecondDoubleString:
            self.secondNumberDigits = [self.secondNumberDigits stringByAppendingString:token.tokenTitle];
            self.currentNumberString = self.secondNumberString;
            [self.expression clear];
            [self.expression addToLast:[NSString stringWithFormat:@"%g", self.firstNumber.doubleValue]];
            [self.expression addToLast:self.operator.operatorTitle];
            [self.expression addToLast:self.secondNumberString];
            break;
            
        case Action_CompleteFirstNumber_KeepOperator:
            [self completeFirstNumber];
            [self keepOperator:(Operator*) token.tokenValue];
            self.currentNumberString = self.firstNumberString;
            [self.expression clear];
            [self.expression addToLast:self.firstNumberString];
            [self.expression addToLast:self.operator.operatorTitle];
            break;
            
        case Action_CompleteFirstNumberAsZero_KeepOperator:
            [self completeFirstNumberAsZero];
            [self keepOperator:(Operator*) token.tokenValue];
            self.currentNumberString = [self firstNumberString];
            [self.expression clear];
            [self.expression addToLast:self.firstNumberString];
            [self.expression addToLast:self.operator.operatorTitle];
            break;
            
        case Action_KeepOperator:
            [self keepOperator:(Operator *) token.tokenValue];
            self.currentNumberString = [NSString stringWithFormat:@"%g", self.firstNumber.doubleValue];
            [self.expression clear];
            [self.expression addToLast:self.currentNumberString];
            [self.expression addToLast:self.operator.operatorTitle];
            break;
            
        case Action_ClearOperator:
            self.operator =nil;
            self.currentNumberString = [NSString stringWithFormat:@"%g", self.firstNumber.doubleValue];
            [self.expression clear];
            [self.expression addToLast:self.currentNumberString];
            break;
            
        case Action_ChangeSignOfFirstNumberString:
            self.firstNumberSign = - self.firstNumberSign;
            self.currentNumberString = self.firstNumberString;
            [self.expression replaceAt:0 withElement:self.currentNumberString];
            break;
            
        case Action_ChangeSignOfSecondNumberString:
            self.secondNumberSign = - self.secondNumberSign;
            self.currentNumberString = self.secondNumberString;
            [self.expression replaceAt:2 withElement:self.currentNumberString];
            break;
            
        case Action_ChangeSignOfCompletedFirstNumber:
            self.firstNumber = [NSNumber numberWithDouble:-self.firstNumber.doubleValue];
            self.currentNumberString = [NSString stringWithFormat:@"%g", self.firstNumber.doubleValue];
            [self.expression replaceAt:0 withElement:self.currentNumberString];
            break;
            
        case Action_ClearSecondNumberString:
            self.secondNumberDigits = nil;
            self.currentNumberString = @"0";
            [self.expression removeLast];
            break;
            
        case Action_CalculateUsingOneNumberWithoutOperator:
            [self calculateUsingOneNumberWithoutOperator];
            break;
            
        case Action_CalculateDependingOnOperatorAvailability:
            if(self.operator == nil){
                [self calculateUsingOneNumberWithoutOperator];
            }else{
                [self calculateUsingTwoNumbers];
            }
            break;
            
        case Action_CompleteFirstNumber_CalculateUsingOneNumberWithoutOperator:
            [self clearOperator];
            [self completeFirstNumber];
            [self calculateUsingOneNumberWithoutOperator];
            break;
            
        case Action_CompleteSecondNumber_CalculateUsingTwoNumbers:
            self.secondNumber = [self secondNumberFromString];
            [self calculateUsingTwoNumbers];
            break;
            
        case Action_CompleteSecondNumber_CalculateUsingTwoNumbers_KeepOperator:
            [self completeSecondNumber];
            [self calculateUsingTwoNumbers];
            [self keepOperator:(Operator *)token.tokenValue];
            break;
            
        case Action_CompleteSecondNumberAsFirstNumber_CalculateUsingTwoNumbers:
            [self completeSecondNumberAsFirstNumber];
            [self calculateUsingTwoNumbers];
            break;
            
        case Action_PercentUsingOneNumber:
            [self percentUsingOneNumber];
            break;
            
        case Action_PercentUsingTwoNumbers:
            [self percentUsingTwoNumbers];
            break;
            
        case Action_CompleteFirstNumber_PercentUsingOneNumber:
            [self completeFirstNumber];
            [self percentUsingOneNumber];
            break;
            
            
        case Action_CompleteSecondNumber_PercentUsingTwoNumbers:
            [self completeSecondNumber];
            [self percentUsingTwoNumbers];
            break;
            
        case Action_CompleteSecondNumberAsFirstNumber_PercentUsingTwoNumbers:
            [self completeSecondNumber];
            [self percentUsingTwoNumbers];
            break;
            
        case Action_PercentDependingOnOperatorAvailability:
            if(self.operator == nil){
                [self percentUsingOneNumber];
            }else{
                [self percentUsingTwoNumbers];
            }
            break;
        
    }
}

-(ButtonClear_Transition) buttonAC{
    return self.stateTransition.buttonClear;
}

- (void)reset{
    [self.stateTransition reset];
    [self.expression clear];
    self.firstNumberDigits = nil;
    self.secondNumberDigits = nil;
    self.operator = nil;
    self.currentNumberString = @"0";
}

- (void)run:(Token *)token{
    [self.stateTransition transitState:token.tokenType];
    [self takeAction:token];
}

@end
