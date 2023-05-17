//
//  Task2App.swift
//  Task2
//
//  Created by 심상현 on 2023/05/04.
//

import SwiftUI

@main
struct Task2App: App {
    var body: some Scene {
        let repository = InMemoryMemoRepository()
        let addMemoUseCase = AddMemoUseCaseImpl(memoRepository: repository)
        let memoListViewModel = MemoListViewModel(addMemoUseCase: addMemoUseCase, memoRepository: repository)

        WindowGroup {
            ContentView(memoListViewModel: memoListViewModel)
        }
    }
}
