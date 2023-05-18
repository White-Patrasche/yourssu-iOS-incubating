//
//  EditMemo.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

import SwiftUI

struct EditMemoScreen: View {
    @StateObject var memoListViewModel: MemoListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack (alignment: .leading){
                TextField("", text: $memoListViewModel.title)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                
                if memoListViewModel.title.isEmpty {
                    Text("제목을 작성해주세요")
                        .padding(.leading, 10)
                        .foregroundColor(TEXTCOLOR)
                        .allowsHitTesting(false)
                }
            }
            
            ZStack(alignment: .topLeading) {
                Color.gray.opacity(0.2)
                TextEditor(text: $memoListViewModel.content)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .padding()
                if memoListViewModel.content.isEmpty {
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
                    memoListViewModel.addMemo()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("등록")
                }
            }
        }
        .customNavigationTitle(title: "메모 작성")
    }
}
