//
//  AddMemoUseCase.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

import Foundation

protocol AddMemoUseCase {
    func execute(title: String, content: String)
}

class AddMemoUseCaseImpl: AddMemoUseCase {
    private let memoRepository: MemoRepository
    
    init(memoRepository: MemoRepository) {
        self.memoRepository = memoRepository
    }
    
    func execute(title: String, content: String) {
        memoRepository.addMemo(title: title, content: content)
    }
}
