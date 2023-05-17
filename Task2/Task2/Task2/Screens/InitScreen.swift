//
//  InitScreen.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

import SwiftUI

class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo] = []
    private let addMemoUseCase: AddMemoUseCase
    private let memoRepository: MemoRepository
    
    init(addMemoUseCase: AddMemoUseCase, memoRepository: MemoRepository) {
        self.addMemoUseCase = addMemoUseCase
        self.memoRepository = memoRepository
    }
    
    func addMemo(title: String, content: String) {
        addMemoUseCase.execute(title: title, content: content)
        self.memos = memoRepository.getMemos()
    }
}


struct InitScreen: View {
    @EnvironmentObject private var memoList: MemoListViewModel
    
    var body: some View {
        VStack {
            if memoList.memos.isEmpty {
                VStack {
                    Text("메모가 없습니다.")
                        .foregroundColor(TEXTCOLOR)
                    Text("메모를 추가해주세요!")
                        .foregroundColor(TEXTCOLOR)
                }
            } else {
                List(memoList.memos) { memo in
                    NavigationLink(destination: MemoDetailView(
                        memo: memo)) {
                            VStack(alignment: .leading) {
                                Text(memo.title)
                                    .font(.headline)
                                Text(memo.content)
                                    .font(.subheadline)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    //SwiftUI에서 제공하는 오른쪽 화살표 버튼 뷰 제거가 없음
                        .padding(.trailing, -32)
                }
                .listStyle(PlainListStyle())
            }
        }
        .customNavigationTitle(title: "메모 목록")
        .navigationBarItems(
            trailing:
                NavigationLink(destination: EditMemoScreen(viewModel: EditMemoScreenViewModel()).environmentObject(memoList)) {
                    Image(systemName: "plus")
                }
        )
    }
}
