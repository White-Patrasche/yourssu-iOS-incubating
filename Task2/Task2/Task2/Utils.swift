//
//  utils.swift
//  Task2
//
//  Created by 심상현 on 2023/05/17.
//

//import UIKit
import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

let TEXTCOLOR = Color(0xBABABA)

extension View {
    func customNavigationTitle(title:String) -> some View {
        self.navigationBarTitle(title, displayMode: .inline)
            .toolbarBackground(Color.gray.opacity(0.2), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
