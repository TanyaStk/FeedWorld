//
//  ImageView.swift
//  FeedWorld
//

import SwiftUI

struct ImageView: View {
    
    let url: String
    
    @State private var showToast: Bool = false
    @State private var image: Image?
    
    var body: some View {
        Group {
            VStack {
                if let image = image {
                    image.resizable().scaledToFill()
                } else {
                    ProgressView()
                }
                
                if showToast {
                    ErrorToastView(showToast: $showToast, 
                                   message: NSLocalizedString("Failed to load image", comment: ""))
                }
            }
        }
        .onChange(of: showToast, { oldValue, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showToast = false
                    }
                }
            }
        })
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data,
                let uiImage = UIImage(data: data) {
                image = Image(uiImage: uiImage)
            } else {
                showToast = true
            }
        }.resume()
    }
}
