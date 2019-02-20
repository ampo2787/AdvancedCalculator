//
//  Action.h
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#ifndef Action_h
#define Action_h

typedef enum {
    Action_Ignore,
    Action_Reset,
    Action_BeginFirstIntegerString,
    Action_BeginFirstDoubleString,
    Action_ConvertToFirstDoubleString,
    Action_AddToFirstIntegerString,
    Action_AddToFirstDoubleString,
    Action_BeginSecondIntegerString,
    Action_BeginSecondDoubleString,
    Action_ConvertToSecondDoubleString,
    Action_AddToSecondIntegerString,
    Action_AddToSecondDoubleString,
    Action_CompleteFirstNumber_KeepOperator,
    Action_CompleteFirstNumberAsZero_KeepOperator,
    Action_KeepOperator,
    Action_ClearOperator,
    Action_ChangeSignOfFirstNumberString,
    Action_ChangeSignOfSecondNumberString,
    Action_ChangeSignOfCompletedFirstNumber,
    Action_ClearSecondNumberString,
    Action_CompleteFirstNumber_CalculateUsingOneNumberWithoutOperator,
    Action_CalculateUsingOneNumberWithoutOperator,
    Action_CalculateDependingOnOperatorAvailability,
    Action_CompleteSecondNumberAsFirstNumber_CalculateUsingTwoNumbers,
    Action_CompleteSecondNumber_CalculateUsingTwoNumbers,
    Action_CompleteSecondNumber_CalculateUsingTwoNumbers_KeepOperator,
    Action_PercentUsingOneNumber,
    Action_CompleteFirstNumber_PercentUsingOneNumber,
    Action_PercentUsingTwoNumbers,
    Action_CompleteSecondNumber_PercentUsingTwoNumbers,
    Action_PercentDependingOnOperatorAvailability,
    Action_CompleteSecondNumberAsFirstNumber_PercentUsingTwoNumbers,
}Action;

#endif /* Action_h */
