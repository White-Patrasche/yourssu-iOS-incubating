//
//  EditMemo.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

import SwiftUI

class EditMemoScreenViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    
    func addMemo(to memoListViewModel: MemoListViewModel) {
        memoListViewModel.addMemo(title: title, content: content)
        title = ""
        content = ""
    }
}

struct EditMemoScreen: View {
    @StateObject var viewModel: EditMemoScreenViewModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack (alignment: .leading){
                TextField("", text: $viewModel.title)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                
                if viewModel.title.isEmpty {
                    Text("제목을 작성해주세요")
                        .padding(.leading, 10)
                        .foregroundColor(TEXTCOLOR)
                        .allowsHitTesting(false)
                }
            }
            
            ZStack(alignment: .topLeading) {
                Color.gray.opacity(0.2)
                TextEditor(text: $viewModel.content)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .padding()
                if viewModel.content.isEmpty {
                    Text("내용을 작성해주세요")
                        .foregroundColor(TEXTCOLOR)
                        .padding(.all, 25)
                        .allowsHitTesting(false)
                }
            }
            .cornerRadius(10)
        }
        .padding(.horizontal, 27)
        .padding(.vertical, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.addMemo(to: memoListViewModel)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("등록")
                }
            }
        }
        .customNavigationTitle(title: "메모 작성")
    }
}
