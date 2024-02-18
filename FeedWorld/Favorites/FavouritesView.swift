//
//  FavouritesView.swift
//  FeedWorld
//

import SwiftUI
import AVKit

struct FavouritesView: View {
    
    @EnvironmentObject var favoritesManager: FavoritesDataManager
    
    @State private var player = AVPlayer()
    @State private var scrollPosition: UUID?
    
    var items: [MediaItem]
    
    var body: some View {
        if items.isEmpty {
            Label(title: {
                Text(NSLocalizedString("No favourites yet", comment: ""))
                    .frame(alignment: .center)
                    .font(.headline)
                Text(NSLocalizedString("You can add an item to your\nfavourites by clicking '❤️' in feed tab", comment: ""))
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
            }, icon: {
                Image(systemName: "heart.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
            })
            .containerRelativeFrame([.horizontal, .vertical])
            .background(.black)
            .foregroundStyle(.white)
            .labelStyle(VerticalStyle())
        } else {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(items, id: \.id) { item in
                        MediaCellView(mediaItem: item,
                                      player: player,
                                      isFavorite: true)
                        .environmentObject(favoritesManager)
                    }
                }
                .scrollTargetLayout()
            }
            .background(.black)
            .scrollIndicators(.never)
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
            .scrollPosition(id: $scrollPosition)
            .onChange(of: scrollPosition) { oldValue, newValue in
                scrollPositionChanged(for: newValue)
            }
        }
    }
    
    private func scrollPositionChanged(for id: UUID?) {
        guard let currentItem = items.first(where: { $0.id == id }) else { return }
        
        if currentItem.mediaType == .video {
            player.replaceCurrentItem(with: nil)
            guard let url = URL(string: currentItem.mediaUrl) else { return }
            let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
        } else {
            player.replaceCurrentItem(with: nil)
        }
    }
}
