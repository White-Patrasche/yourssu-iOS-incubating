//
//  ContentView.swift
//  Task1
//
//  Created by 심상현 on 2023/03/26.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: Store<CalculatorState, CalculatorAction>
    
    init() {
        self.store = Store(initialState: CalculatorState(), reducer: calculatorReducer, environment: CalculatorEnvironment(calculatorService: CalculatorServiceImpl()))
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

struct CalculatorEnvironment {
    let calculatorService: CalculatorService
}

protocol CalculatorService {
    func add(_ first: Int, _ second: Int) -> Int
    func subtract(_ first: Int, _ second: Int) -> Int
    func multiply(_ first: Int, _ second: Int) -> Int
    func divide(_ first: Int, _ second: Int) -> Int
}

struct CalculatorServiceImpl: CalculatorService {
    func add(_ first: Int, _ second: Int) -> Int {
        return first + second
    }
    func subtract(_ first: Int, _ second: Int) -> Int {
        return first - second
    }
    func multiply(_ first: Int, _ second: Int) -> Int {
        return first * second
    }
    func divide(_ first: Int, _ second: Int) -> Int {
        return first / second
    }
}

let calculatorReducer = AnyReducer<CalculatorState, CalculatorAction, CalculatorEnvironment> {state, action, environment in switch action {
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
}}


struct CalculatorView: View {
    let store: Store<CalculatorState, CalculatorAction>
    
    func actionButton(action:@escaping () -> Void, title:String) -> some View {
        return Button(action: action) {
            Text(title)
                .font(.body)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 40)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.teal))
        }
    }
    
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
                    actionButton(action: {
                        viewStore.send(.add)
                    } , title:"더하기")
                    actionButton(action: {
                        viewStore.send(.sub)
                    } , title:"빼기")
                    actionButton(action: {
                        viewStore.send(.multi)
                    } , title:"곱하기")
                    actionButton(action: {
                        viewStore.send(.div)
                    } , title:"나누기")
                }
            }
        }
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        self.textFieldStyle(PlainTextFieldStyle())
            .padding(.leading, 10)
            .frame(width: 300, height: 35)
            .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray.opacity(0.1)))
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

extension Button where Label == Text {
    fileprivate func calButtonStyle() -> some View {
        self
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 40)
            .background(RoundedRectangle(cornerRadius: 30).fill(Color.teal))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


