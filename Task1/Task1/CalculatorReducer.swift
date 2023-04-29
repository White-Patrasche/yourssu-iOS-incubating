//
//  Reduser.swift
//  Task1
//
//  Created by 심상현 on 2023/04/29.
//

import ComposableArchitecture

let calculatorReducer: AnyReducer<CalculatorState, CalculatorAction, CalculatorEnvironment> = AnyReducer { state, action, environment in switch action {
case let .firstNumberChanged(number):
    state.firstNumber = number
    return .none
    
case let .secondNumberChanged(number):
    state.secondNumber = number
    return .none
    
case .add:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        let result = environment.calculatorService.add(first, second)
        state.resultString = "\(first) + \(second) = \(result)"
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
case .sub:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        let result = environment.calculatorService.subtract(first, second)
        state.resultString = "\(first) - \(second) = \(result)"
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
case .multi:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        let result = environment.calculatorService.multiply(first, second)
        state.resultString = "\(first) * \(second) = \(result)"
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
case .div:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        if second == 0 {
            state.resultString = "0으로 나눌 수 없습니다!"
        } else {
            let result = environment.calculatorService.divide(first, second)
            state.resultString = "\(first) / \(second) = \(result)"
        }
        
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
}
}
