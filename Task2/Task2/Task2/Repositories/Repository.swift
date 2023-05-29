//
//  Repository.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

import Foundation

protocol MemoRepository {
    func addMemo(title: String, content: String)
    func getMemos() -> [Memo]
}

class InMemoryMemoRepository: MemoRepository {
    private var memos: [Memo] = []
    
    func addMemo(title: String, content: String) {
        let newMemo = Memo(title: title, content: content)
        memos.append(newMemo)
    }
    
    func getMemos() -> [Memo] {
        return memos
    }
}
