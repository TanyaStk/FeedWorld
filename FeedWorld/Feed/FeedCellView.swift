//
//  FeedCellView.swift
//  FeedWorld
//

import SwiftUI

struct FeedCellView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    let number: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.cyan)
                .containerRelativeFrame([.horizontal, .vertical])
                .overlay {
                    Text("Post \(number)")
                        .foregroundColor(.white)
                }
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
//                            Image(systemName: "person")
//                                .resizable()
//                                .scaledToFit()
//                                .overlay {
                                    Circle().fill(.gray)
//                                }
                                .frame(width: 30, height: 30)
//                                .foregroundStyle(.white)
                            
                            Text("Profile name")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                        Text("Content name")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        Text("17.02.2023")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    
                    VStack(spacing: 24) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.white)
                        }
                        
                        Label(title: {
                            Text("123.4k")
                                .font(.callout)
                        }, icon: {
                            Image(systemName: "eye")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                        })
                        .foregroundStyle(.white)
                        .labelStyle(VerticalStyle())
                    }
                }
                .padding(.bottom, safeAreaInsets.bottom > 0 ? 80 : 50)
            }
            .padding()
        }
    }
}

#Preview {
    FeedCellView(number: 5)
}

struct VerticalStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 4) {
            configuration.icon
            configuration.title
        }
    }
}
