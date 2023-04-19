//
//  Task1App.swift
//  Task1
//
//  Created by 심상현 on 2023/03/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct Task1App: App {
    let calculatorEnvironment = CalculatorEnvironment(calculatorService: CalculatorServiceImpl())
    let calculatorStore: Store<CalculatorState, CalculatorAction>
    
    init() {
        self.calculatorStore = Store(initialState: CalculatorState(), reducer: calculatorReducer, environment: calculatorEnvironment)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(environment: calculatorEnvironment)
        }
    }
}
