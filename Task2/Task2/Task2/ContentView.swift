//
//  ContentView.swift
//  Task2
//
//  Created by 심상현 on 2023/05/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var memoListViewModel: MemoListViewModel
    
    init(memoListViewModel: MemoListViewModel) {
        _memoListViewModel = StateObject(wrappedValue: memoListViewModel)
    }
    
    var body: some View {
        NavigationView {
            InitScreen()
                .environmentObject(memoListViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = InMemoryMemoRepository()
        let addMemoUseCase = AddMemoUseCaseImpl(memoRepository: repository)
        let memoListViewModel = MemoListViewModel(addMemoUseCase: addMemoUseCase, memoRepository: repository)
        
        ContentView(memoListViewModel: memoListViewModel)
    }
}
