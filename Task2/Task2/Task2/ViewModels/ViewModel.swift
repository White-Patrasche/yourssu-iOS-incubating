//
//  ViewModel.swift
//  Task2
//
//  Created by 심상현 on 2023/05/18.
//

import Foundation

class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo] = []
    @Published var title: String = ""
    @Published var content: String = ""
    private let addMemoUseCase: AddMemoUseCase
    private let memoRepository: MemoRepository
    
    init(addMemoUseCase: AddMemoUseCase, memoRepository: MemoRepository) {
        self.addMemoUseCase = addMemoUseCase
        self.memoRepository = memoRepository
    }
    
    func addMemo() {
        addMemoUseCase.execute(title: title, content: content)
        title = ""
        content = ""
        self.memos = memoRepository.getMemos()
    }
}

