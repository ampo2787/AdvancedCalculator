//
//  StateTransition.m
//  AdvancedCalculatorForMac
//
//  Created by JihoonPark on 29/10/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "StateTransition.h"

typedef enum _State {
    State_Start,
    State_FirstInteger,
    State_FirstDouble,
    State_OperatorAppeared,
    State_OperatorCleared,
    State_SecondInteger,
    State_SecondDouble,
    State_Calculation,
} State;

#define NUMBER_OF_STATES 8

State stateTransitionTable[NUMBER_OF_STATES][NUMBER_OF_TOKENTYPES] = {
    //[0]
    {   State_Start,
        State_FirstInteger,
        State_FirstDouble,
        State_Start,
        State_OperatorAppeared,
        State_Start,
        State_Start},
    //[1]
    {   State_Start,
        State_FirstInteger,
        State_FirstDouble,
        State_FirstInteger,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
    //[2]
    {   State_Start,
        State_FirstDouble,
        State_FirstDouble,
        State_FirstDouble,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
    //[3]
    {   State_OperatorCleared,
        State_SecondInteger,
        State_SecondDouble,
        State_OperatorAppeared,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
    
    //[4]
    {   State_Start,
        State_FirstInteger,
        State_FirstDouble,
        State_OperatorCleared,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
    //[5]
    {   State_OperatorAppeared,
        State_SecondInteger,
        State_SecondDouble,
        State_SecondInteger,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
    //[6]
    {   State_OperatorAppeared,
        State_SecondDouble,
        State_SecondDouble,
        State_SecondDouble,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
    //[7]
    {   State_Start,
        State_FirstInteger,
        State_FirstDouble,
        State_Calculation,
        State_OperatorAppeared,
        State_Calculation,
        State_Calculation},
};

Action actionTable[NUMBER_OF_STATES][NUMBER_OF_TOKENTYPES] = {
    //[0]
    {   Action_Ignore,
        Action_BeginFirstIntegerString,
        Action_BeginFirstDoubleString,
        Action_Ignore,
        Action_CompleteFirstNumberAsZero_KeepOperator,
        Action_Ignore,
        Action_Ignore},
    //[1]
    {   Action_Reset,
        Action_AddToFirstIntegerString,
        Action_ConvertToFirstDoubleString,
        Action_ChangeSignOfFirstNumberString,
        Action_CompleteFirstNumber_KeepOperator,
        Action_CompleteFirstNumber_CalculateUsingOneNumberWithoutOperator,
        Action_CompleteFirstNumber_PercentUsingOneNumber},
    //[2]
    {   Action_Reset,
        Action_AddToFirstDoubleString,
        Action_Ignore,
        Action_ChangeSignOfFirstNumberString,
        Action_CompleteFirstNumber_KeepOperator,
        Action_CompleteFirstNumber_CalculateUsingOneNumberWithoutOperator,
        Action_CompleteFirstNumber_PercentUsingOneNumber},
    //[3]
    {   Action_ClearOperator,
        Action_BeginSecondIntegerString,
        Action_BeginSecondDoubleString,
        Action_ChangeSignOfCompletedFirstNumber,
        Action_KeepOperator,
        Action_CompleteSecondNumberAsFirstNumber_CalculateUsingTwoNumbers,
        Action_CompleteSecondNumberAsFirstNumber_PercentUsingTwoNumbers},
    //[4]
    {   Action_Reset,
        Action_BeginFirstIntegerString,
        Action_BeginFirstDoubleString,
        Action_ChangeSignOfCompletedFirstNumber,
        Action_KeepOperator,
        Action_CalculateUsingOneNumberWithoutOperator,
        Action_PercentUsingOneNumber},
    //[5]
    {   Action_ClearSecondNumberString,
        Action_AddToSecondIntegerString,
        Action_ConvertToSecondDoubleString,
        Action_ChangeSignOfSecondNumberString,
        Action_CompleteSecondNumber_CalculateUsingTwoNumbers_KeepOperator,
        Action_CompleteSecondNumber_CalculateUsingTwoNumbers,
        Action_CompleteSecondNumber_PercentUsingTwoNumbers},
    //[6]
    {   Action_ClearSecondNumberString,
        Action_AddToSecondDoubleString,
        Action_Ignore,
        Action_ChangeSignOfSecondNumberString,
        Action_CompleteSecondNumber_CalculateUsingTwoNumbers_KeepOperator,
        Action_CompleteSecondNumber_CalculateUsingTwoNumbers,
        Action_CompleteSecondNumber_PercentUsingTwoNumbers},
    //[7]
    {   Action_Reset,
        Action_BeginFirstIntegerString,
        Action_BeginFirstDoubleString,
        Action_ChangeSignOfCompletedFirstNumber,
        Action_KeepOperator,
        Action_CalculateDependingOnOperatorAvailability,
        Action_PercentDependingOnOperatorAvailability,
    }
    
};

ButtonClear_Transition buttonClear_TransitionTable[NUMBER_OF_STATES][NUMBER_OF_TOKENTYPES] =
{
    {NoChange, C,        C,        NoChange, C,        NoChange, NoChange},
    {AC,       NoChange, NoChange, NoChange, NoChange, AC,       AC      },
    {AC,       NoChange, NoChange, NoChange, NoChange, AC,       AC      },
    {NoChange, NoChange, NoChange, NoChange, NoChange, AC,       AC      },
    {NoChange, C,        C,        NoChange, C,        NoChange, NoChange},
    {NoChange, NoChange, NoChange, NoChange, NoChange, AC,       AC,     },
    {NoChange, NoChange, NoChange, NoChange, NoChange, AC,       AC,     },
    {NoChange, C,        C,        NoChange, C,        NoChange, NoChange},
};

@interface StateTransition()

@property (assign) State currentState;
@property (assign, readwrite) Action action;
@property (assign, readwrite) ButtonClear_Transition buttonClear;

@end

@implementation StateTransition

- (StateTransition *)init{
    [self reset];
    return self;
}

- (void)reset{
    [self setCurrentState:State_Start];
    [self setAction:Action_Reset];
    [self setButtonClear:AC];
}

- (void)transitState:(TokenType)tokenType{
    self.action = actionTable[self.currentState][tokenType];
    self.buttonClear = buttonClear_TransitionTable[self.currentState][tokenType];
    self.currentState = stateTransitionTable[self.currentState][tokenType];
}

@end
