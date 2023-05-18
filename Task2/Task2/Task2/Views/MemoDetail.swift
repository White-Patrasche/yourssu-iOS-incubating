//
//  MemoDetail.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

import SwiftUI

struct MemoDetailView: View {
    let memo: Memo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(memo.title)
                        .font(.title)
                        .padding(.bottom)
                    Text(memo.content)
                        .font(.body)
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
        .customNavigationTitle(title: "메모 상세")
    }
}
