//
//  ErrorToastView.swift
//  FeedWorld
//
//  Created by Tanya Samastroyenka on 18.02.2024.
//

import SwiftUI

struct ErrorToastView: View {
    
    @Binding var showToast: Bool
    
    let message: String

    var body: some View {
        Text(message)
            .padding()
            .frame(width: UIScreen.main.bounds.width, alignment: .center)
            .foregroundColor(.white)
    }
}
