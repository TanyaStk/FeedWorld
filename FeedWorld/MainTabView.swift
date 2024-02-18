//
//  MainTabView.swift
//  FeedWorld
//

import SwiftUI

struct MainTabView: View {
    
    @ObservedObject var feedDataManager = FeedDataManager()
    @ObservedObject var favoritesDataManager = FavoritesDataManager()
    
    @State private var selectedTab = 0
    @State private var showWebView = false
    @State private var webViewUrl: String = ""
    @State private var error: Error? = nil
    
    @State var url: String = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                FeedView(showWebView: $showWebView,
                         webViewUrl: $webViewUrl,
                         items: feedDataManager.items)
                .environmentObject(favoritesDataManager)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        Text(LocalizedStringKey("Feed"))
                    }
                }
                .sheet(isPresented: $showWebView) {
                    ZStack {
                        if let url = URL(string: url) {
                            WebView(url: url,
                                    showWebView: $showWebView,
                                    error: $error)
                        } else {
                            Text("Sorry, we could not load this url.")
                        }
                    }
                    .containerRelativeFrame([.horizontal, .vertical])
                    .background(.black)
                }
                .onChange(of: webViewUrl, { oldValue, newValue in
                    url = newValue
                })
                .onAppear { selectedTab = 0 }
                .tag(0)
                
                FavouritesView(items: feedDataManager.items
                    .filter { favoritesDataManager.favorites.contains($0.id) }
                    .compactMap { item in
                        switch item {
                        case .media(let mediaItem):
                            return mediaItem
                        case .promo(_):
                            return nil
                        }
                    }
                )
                .environmentObject(favoritesDataManager)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "heart.fill" : "heart")
                            .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                        Text(LocalizedStringKey("Favourites"))
                    }
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.black, for: .tabBar)
        }
        .tint(.white)
    }
}

//#Preview {
//    MainTabView()
//}
