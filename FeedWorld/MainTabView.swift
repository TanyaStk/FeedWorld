//
//  MainTabView.swift
//  FeedWorld
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        Text(LocalizedStringKey("Feed"))
                    }
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            FavouritesView()
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
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
