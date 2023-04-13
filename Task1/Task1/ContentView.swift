//
//  ContentView.swift
//  Task1
//
//  Created by 심상현 on 2023/03/26.
//

import SwiftUI
import Combine
import Foundation
import ComposableArchitecture

struct ContentView: View {
    let store: Store<CalculatorState, CalculatorAction>
    
    init() {
        self.store = Store(initialState: CalculatorState(), reducer: calculatorReducer, environment: CalculatorEnvironment())
    }
    
    var body: some View {
        CalculatorView(store: store)
    }
}

struct CalculatorState: Equatable {
    var firstNumber: String = ""
    var secondNumber: String = ""
    var resultString: String = "버튼을 눌러주세요!"
}

enum CalculatorAction: Equatable {
    case firstNumberChanged(String)
    case secondNumberChanged(String)
    case add
    case sub
    case multi
    case div
}

struct CalculatorEnvironment {}

let calculatorReducer = AnyReducer<CalculatorState, CalculatorAction, CalculatorEnvironment> {state, action, _ in switch action {
case let .firstNumberChanged(number):
    state.firstNumber = number
    return .none
    
case let .secondNumberChanged(number):
    state.secondNumber = number
    return .none
    
case .add:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        state.resultString = "\(first) + \(second) = \(first + second)"
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
case .sub:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        state.resultString = "\(first) - \(second) = \(first - second)"
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
case .multi:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        state.resultString = "\(first) * \(second) = \(first * second)"
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
case .div:
    if let first = Int(state.firstNumber), let second = Int(state.secondNumber) {
        if second == 0 {
            state.resultString = "0으로 나눌 수 없습니다!"
        } else {
            state.resultString = "\(first) / \(second) = \(first / second)"
        }
        
    } else {
        state.resultString = "잘못된 입력입니다"
    }
    return .none
}}


struct CalculatorView: View {
    let store: Store<CalculatorState, CalculatorAction>
    
    var body: some View {
        WithViewStore(self.store) {
            viewStore in VStack(spacing: 20) {
                VStack(spacing: 10) {
                    TextField("첫번째 숫자를 입력해주세요", text: viewStore.binding(
                        get:{$0.firstNumber},send:CalculatorAction.firstNumberChanged
                    )).customTextFieldStyle()
                    TextField("두번째 숫자를 입력해주세요", text: viewStore.binding(
                        get:{$0.secondNumber},send:CalculatorAction.secondNumberChanged
                    )).customTextFieldStyle()
                }
                Text(viewStore.resultString)
                VStack(spacing: 10) {
                    Button("더하기") {
                        viewStore.send(.add)
                    }.calButtonStyle()
                    Button("빼기") {
                        viewStore.send(.sub)
                    }.calButtonStyle()
                    Button("곱하기") {
                        viewStore.send(.multi)
                    }.calButtonStyle()
                    Button("나누기") {
                        viewStore.send(.div)
                    }.calButtonStyle()
                }
            }
        }
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(CustomTextFieldStyle())
    }
}

struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray.opacity(0.1)))
            .frame(width: 300)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

extension Button where Label == Text {
    fileprivate func calButtonStyle() -> some View {
        self
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300)
            .background(RoundedRectangle(cornerRadius: 30).fill(Color.teal))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


