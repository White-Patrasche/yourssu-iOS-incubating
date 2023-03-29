//
//  ContentView.swift
//  Task1
//
//  Created by 심상현 on 2023/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var firstNumber = ""
    @State private var secondNumber = ""
    @State private var resultString = "버튼을 눌러주세요!"
    
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
        if(!validInput()) {
            return
        }
        let first =  Int(firstNumber) ?? 0
        let second = Int(secondNumber) ?? 0
        resultString = "\(first) + \(second) = \(first + second)"
    }
    func sub() {
        if(!validInput()) {
            return
        }
        let first =  Int(firstNumber) ?? 0
        let second = Int(secondNumber) ?? 0
        resultString = "\(first) - \(second) = \(first - second)"
    }
    func multi() {
        if(!validInput()) {
            return
        }
        let first =  Int(firstNumber) ?? 0
        let second = Int(secondNumber) ?? 0
        resultString = "\(first) * \(second) = \(first * second)"
    }
    func div() {
        if(!validInput()) {
            return
        }
        let first =  Int(firstNumber) ?? 0
        let second = Int(secondNumber) ?? 0
        if(second == 0) {
            resultString = "0으로 나눌 수 없습니다!"
            return
        }
        resultString = "\(first) / \(second) = \(first/second)"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                TextField("첫번째 숫자를 입력해주세요", text: $firstNumber)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray.opacity(0.1)))
                    .frame(width: 300)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                TextField("두번째 숫자를 입력해주세요", text: $secondNumber)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).fill(Color.gray.opacity(0.1)))
                    .frame(width: 300)
            }
            Text(resultString)
            VStack(spacing: 10) {
                CalButton(text: "더하기", action: add)
                CalButton(text: "빼기", action: sub)
                CalButton(text: "곱하기", action: multi)
                CalButton(text: "나누기", action: div)
            }
        }
    }
}

struct CalButton:View {
    let text:String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.teal))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


