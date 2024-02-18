//
//  FeedView.swift
//  FeedWorld
//

import SwiftUI
import AVFoundation

struct FeedView: View {
    
    @EnvironmentObject var favoritesManager: FavouritesDataManager
    
    @State private var player = AVPlayer()
    @State private var scrollPosition: UUID?
    
    @Binding var showWebView: Bool
    @Binding var webViewUrl: String
    
    var items: [ItemType]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items, id: \.id) { item in
                    switch item {
                    case .media(let mediaItem):
                        MediaCellView(mediaItem: mediaItem, 
                                      player: player, 
                                      isFavorite: favoritesManager.favourites.contains(mediaItem.id))
                        .environmentObject(favoritesManager)
                    case .promo(let promoItem):
                        PromoCellView(showWebView: $showWebView, 
                                      webViewUrl: $webViewUrl,
                                      item: promoItem)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .background(.black)
        .scrollIndicators(.never)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onAppear {
            scrollPositionChanged(for: items.first?.id)
            player.play()
        }
        .scrollPosition(id: $scrollPosition)
        .onChange(of: scrollPosition) { oldValue, newValue in
            scrollPositionChanged(for: newValue)
        }
    }
    
    private func scrollPositionChanged(for id: UUID?) {
        guard let currentItem = items.first(where: { $0.id == id }) else { return }
        
        switch currentItem {
        case .media(let mediaItem):
            if mediaItem.mediaType == .video {
                player.replaceCurrentItem(with: nil)
                guard let url = URL(string: mediaItem.mediaUrl) else { return }
                let playerItem = AVPlayerItem(url: url)
                player.replaceCurrentItem(with: playerItem)
            } else {
                player.replaceCurrentItem(with: nil)
            }
        case .promo(_):
            player.replaceCurrentItem(with: nil)
        }
    }
}
