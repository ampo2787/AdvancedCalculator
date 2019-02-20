//
//  AdvancedCalculatorViewController.m
//  Assignment03
//
//  Created by JihoonPark on 14/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "AdvancedCalculatorViewController.h"

#import "Operator.h"
#import "TokenType.h"
#import "ButtonClear_Transition.h"
#import "Token.h"
#import "Engine.h"
#import "Expression.h"

#pragma mark - Declaration of Private variables & methods

@interface AdvancedCalculatorViewController ()
@property (nonatomic) Engine* engine;
@property (nonatomic) Token* token;
-(void) calculatorAndShow:(Token*) token;

-(void) changeButtonAC:(ButtonClear_Transition) buttonAC_Transition;
-(void) showNumber:(NSString*)numberString;
-(void) showExpression:(Expression*) expression;
@end

@implementation AdvancedCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self.numberField setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self.engine reset];
}


#pragma mark - Lazy Instantiation of Objects

-(Token*) token{
    if(_token == nil){
        _token = [[Token alloc]init];
    }
    return _token;
}

-(Engine*) engine{
    if(_engine == nil){
        _engine = [[Engine alloc]init];
    }
    return _engine;
}

#pragma mark - Private methods
-(void) changeButtonAC:(ButtonClear_Transition)buttonAC_Transition{
    switch (buttonAC_Transition) {
        case NoChange:
            break;
        case AC:
            [self.buttonAC setTitle:@"AC" forState:UIControlStateNormal];
            break;
        case C:
            [self.buttonAC setTitle:@"C" forState:UIControlStateNormal];
            break;
    }
}

-(void)calculatorAndShow:(Token *)token{
    [self.engine run:token];
    [self changeButtonAC:self.engine.buttonAC];
    [self showNumber:self.engine.currentNumberString];
    [self showExpression:self.engine.expression];
}

-(void) showNumber:(NSString *)numberString{
    [self.numberField setText:numberString];
}

-(void)showExpression:(Expression *)expression{
    NSString* expressionString = @"";
    for(int i=0; i<expression.size; i++){
        expressionString = [expressionString stringByAppendingString:[expression elementAt:i]];
        expressionString = [expressionString stringByAppendingString:@" "];
    }
    [self.expressionField setText:expressionString];
}


#pragma mark - Implementation of IBActions
- (IBAction)buttonClear_clicked:(ExtendedOperatorButton *)sender {
    self.token.tokenType = Token_Clear;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = NULL;
    [self calculatorAndShow:self.token];
}


- (IBAction)buttonSign_clicked:(ExtendedOperatorButton *)sender {
    self.token.tokenType = Token_Sign;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = NULL;
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonPercent_clicked:(ExtendedOperatorButton *)sender {
    self.token.tokenType = Token_Percent;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = NULL;
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonDivide_clicked:(ArithmeticOperatorButton *)sender {
    self.token.tokenType = Token_ArithmeticOperator;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = [[Operator alloc]initWith:OP_DIVIDE];
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonMultiply_clicked:(ArithmeticOperatorButton *)sender {
    self.token.tokenType = Token_ArithmeticOperator;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = [[Operator alloc]initWith:OP_MULTIPLY];
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonSubstract_clicked:(ArithmeticOperatorButton *)sender {
    self.token.tokenType = Token_ArithmeticOperator;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = [[Operator alloc]initWith:OP_SUBTRACT];
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonAdd_clicked:(ArithmeticOperatorButton *)sender {
    self.token.tokenType = Token_ArithmeticOperator;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = [[Operator alloc]initWith:OP_ADD];
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonEqual_clicked:(ArithmeticOperatorButton *)sender {
    //수정한부분.
    self.token.tokenType = Token_Equal;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = [[Operator alloc]initWith:OP_EQUAL];
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonDigit_clicked:(DigitButton *)sender {
    self.token.tokenType = Token_Digit;
    self.token.tokenTitle = sender.titleLabel.text;
    self.token.tokenValue = [NSNumber numberWithInteger:[sender.titleLabel.text intValue]];
    [self calculatorAndShow:self.token];
}

- (IBAction)buttonPoint_clicked:(DigitButton *)sender {
    [self.token setTokenTitle:@"."];
    [self.token setTokenType:Token_DecimalPoint];
    self.token.tokenValue = NULL;
    [self calculatorAndShow:self.token];
}
@end
