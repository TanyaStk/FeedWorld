//
//  FeedView.swift
//  FeedWorld
//

import SwiftUI

struct FeedView: View {
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach((0..<10)) { number in
                    FeedCellView(number: number)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.never)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
    }
}

#Preview {
    FeedView()
}
