//
//  ChatView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct ChatView: View {
    @State private var inputMessage = ""
    
    @ObservedObject var chatViewModel: ChatViewModel
    
    private let user: User
    
    init(user: User) {
        self.user = user
        self.chatViewModel = ChatViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(chatViewModel.messages) { message in
                        MessageView(viewModel: MessageViewModel(message))
                    }
                }
            }
            
            CustomInputField(text: $inputMessage, action: sendMessage)
        }
        .padding(.vertical)
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        chatViewModel.sendMessage(inputMessage)
        inputMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User.mockUser)
    }
}
