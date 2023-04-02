//
//  ContentView.swift
//  Task1
//
//  Created by 심상현 on 2023/03/26.
//

import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    var body: some View {
        let calculatorUseCase = CalculatorUseCase()
        let viewModel = CalculatorViewModel(calculatorUseCase: calculatorUseCase)
        CalculatorView(viewModel : viewModel)
    }
}

struct CalculatorView: View {
    @ObservedObject var viewModel: CalculatorViewModel
    
    func CalButton( text:String,  action:@escaping () -> Void) -> some View{
        return Button(action: action) {
            Text(text)
                .font(.body)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.teal))
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                TextField("첫번째 숫자를 입력해주세요", text: $viewModel.firstNumber)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray.opacity(0.1)))
                    .frame(width: 300)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                TextField("두번째 숫자를 입력해주세요", text: $viewModel.secondNumber)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray.opacity(0.1)))
                    .frame(width: 300)
            }
            Text(viewModel.resultString)
            VStack(spacing: 10) {
                CalButton(text: "더하기", action: viewModel.add)
                CalButton(text: "빼기", action: viewModel.sub)
                CalButton(text: "곱하기", action: viewModel.multi)
                CalButton(text: "나누기", action: viewModel.div)
            }
        }
    }
}

class CalculatorUseCase {
    func add(first: Int, second: Int) -> Int {
        return first + second
    }
    
    func sub(first: Int, second: Int) -> Int {
        return first - second
    }
    
    func multi(first: Int, second: Int) -> Int {
        return first * second
    }
    
    func div(first: Int, second: Int) -> Int {
        return first / second
    }
}


class CalculatorViewModel: ObservableObject {
    @Published var firstNumber = ""
    @Published var secondNumber = ""
    @Published var resultString = "버튼을 눌러주세요!"
    
    var calculatorUseCase: CalculatorUseCase
    
    init(calculatorUseCase: CalculatorUseCase) {
        self.calculatorUseCase = calculatorUseCase
    }
    
    func validInput()-> Bool {
        if(firstNumber == "" || secondNumber == "") {
            resultString = "값을 먼저 입력해주세요"
            return false
        }
        if (Int(firstNumber) == nil || Int(secondNumber) == nil) {
            resultString = "잘못된 입력입니다"
            return false
        }
        return true
    }
    
    func add() {
        if validInput() {
            let first =  Int(firstNumber) ?? 0
            let second = Int(secondNumber) ?? 0
            let result = calculatorUseCase.add(first: first, second: second)
            resultString = "\(first) + \(second) = \(result)"
        }
    }
    
    func sub() {
        if validInput() {
            let first =  Int(firstNumber) ?? 0
            let second = Int(secondNumber) ?? 0
            let result = calculatorUseCase.sub(first: first, second: second)
            resultString = "\(first) - \(second) = \(result)"
        }
        
    }
    func multi() {
        if validInput() {
            let first =  Int(firstNumber) ?? 0
            let second = Int(secondNumber) ?? 0
            let result = calculatorUseCase.multi(first: first, second: second)
            resultString = "\(first) * \(second) = \(result)"
        }
    }
    func div() {
        if validInput() {
            let first =  Int(firstNumber) ?? 0
            let second = Int(secondNumber) ?? 0
            if(second == 0) {
                resultString = "0으로 나눌 수 없습니다!"
                return
            }
            let result = calculatorUseCase.div(first: first, second: second)
            resultString = "\(first) / \(second) = \(result)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


