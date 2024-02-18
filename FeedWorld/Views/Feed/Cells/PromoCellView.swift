//
//  PromoCellView.swift
//  FeedWorld
//


import SwiftUI

struct PromoCellView: View {
    
    @Binding var showWebView: Bool
    @Binding var webViewUrl: String
    
    var item: PromoItem
    
    var body: some View {
        ZStack {
            Color(item.backgroundColor)
                .ignoresSafeArea()
            Button {
                webViewUrl = item.buttonUrl
                showWebView = true
            } label: {
                Text(item.buttonText)
                    .font(.largeTitle)
                    .tint(.white)
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
    }
}
