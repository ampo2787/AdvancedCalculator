//
//  AdvancedCalculatorViewController.h
//  Assignment03
//
//  Created by JihoonPark on 14/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DigitButton.h"
#import "ExtendedOperatorButton.h"
#import "ArithmeticOperatorButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvancedCalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *numberField;
@property (weak, nonatomic) IBOutlet UITextField *expressionField;

@property (weak, nonatomic) IBOutlet ExtendedOperatorButton *buttonAC;
@property (weak, nonatomic) IBOutlet ArithmeticOperatorButton *buttonDivide;
@property (weak, nonatomic) IBOutlet ArithmeticOperatorButton *buttonMultiply;
@property (weak, nonatomic) IBOutlet ArithmeticOperatorButton *buttonSubtract;
@property (weak, nonatomic) IBOutlet ArithmeticOperatorButton *buttonAdd;
@property (weak, nonatomic) IBOutlet ArithmeticOperatorButton *buttonEqual;

- (IBAction)buttonClear_clicked:(ExtendedOperatorButton *)sender;
- (IBAction)buttonSign_clicked:(ExtendedOperatorButton *)sender;
- (IBAction)buttonPercent_clicked:(ExtendedOperatorButton *)sender;
- (IBAction)buttonDivide_clicked:(ArithmeticOperatorButton *)sender;
- (IBAction)buttonMultiply_clicked:(ArithmeticOperatorButton *)sender;
- (IBAction)buttonSubstract_clicked:(ArithmeticOperatorButton *)sender;
- (IBAction)buttonAdd_clicked:(ArithmeticOperatorButton *)sender;
- (IBAction)buttonEqual_clicked:(ArithmeticOperatorButton *)sender;
- (IBAction)buttonPoint_clicked:(DigitButton *)sender;
- (IBAction)buttonDigit_clicked:(DigitButton *)sender;



@end

NS_ASSUME_NONNULL_END
