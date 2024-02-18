//
//  MediaCellView.swift
//  FeedWorld
//

import SwiftUI
import AVFoundation

struct MediaCellView: View {
    
    @EnvironmentObject var favoritesManager: FavoritesDataManager
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var isFavorite: Bool
    
    let mediaItem: MediaItem
    let player: AVPlayer
    
    init(mediaItem: MediaItem,
         player: AVPlayer,
         isFavorite: Bool) {
        self.mediaItem = mediaItem
        self.player = player
        self._isFavorite = State(initialValue: isFavorite)
    }
    
    var body: some View {
        ZStack {
            switch mediaItem.mediaType {
            case .image:
                ImageView(url: mediaItem.mediaUrl)
                    .containerRelativeFrame([.horizontal, .vertical])
            case .video:
                VideoPlayer(player: player)
                    .containerRelativeFrame([.horizontal, .vertical])
            }
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            ImageView(url: mediaItem.creator.profileImageUrl)
                                .clipShape(Circle())
                                .frame(width: 30, height: 30)
                            
                            Text(mediaItem.creator.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                        Text(mediaItem.title)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        
                        Text(mediaItem.creationDate.formattedString)
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    
                    VStack(spacing: 24) {
                        Button {
                            !isFavorite ?
                            favoritesManager.save(mediaItem.id) :
                            favoritesManager.delete(mediaItem.id)
                            
                            isFavorite.toggle()
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(isFavorite ? .red : .white)
                        }
                        
                        Label(title: {
                            Text("\(mediaItem.viewCount)")
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
        .background(.clear)
    }
}
