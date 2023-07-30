//
//  ConversationView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct ConversationView: View {
    @State private var showNewMessage = false
    @State private var showChatView = false
    @State var selectedUser: User?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0...10, id: \.self) { _ in
                        NavigationLink {
                            ChatView(user: User.mockUser)
                        } label: {
                            ConversationCell()
                        }
                    }
                }
            }
            
            HStack {
                Spacer()
                
                Button {
                    showNewMessage = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                }
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
            }
        }
        .padding(.top)
        .sheet(isPresented: $showNewMessage) {
            NewMessageView(user: $selectedUser, showChatView: $showChatView)
        }
        .navigationDestination(isPresented: $showChatView) {
            if let user = selectedUser {
                ChatView(user: user)
            }
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConversationView()
                .navigationTitle("Chats")
        }
    }
}
