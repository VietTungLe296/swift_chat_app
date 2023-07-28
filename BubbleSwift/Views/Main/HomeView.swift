//
//  HomeView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedIndex = 0
    
    private var tabTitle: String {
        switch selectedIndex {
        case 0: return "Chats"
        case 1: return "Channels"
        case 2: return "Settings"
        default: return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                ConversationView()
                    .tabItem {
                        Image(systemName: "bubble.left")
                    }
                    .tag(0)
                
                ChannelsView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                    }
                    .tag(2)
            }
            .navigationTitle(tabTitle)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
