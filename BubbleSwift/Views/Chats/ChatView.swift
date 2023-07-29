//
//  ChatView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct ChatView: View {
    @State private var inputMessage = ""
    
    @ObservedObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageView(isFromCurrentUser: message.isFromCurrentUser, messageText: message.messageText)
                    }
                }
            }
            
            CustomInputField(text: $inputMessage, action: sendMessage)
        }
        .padding(.vertical)
        .navigationTitle("VTS")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        viewModel.sendMessage(inputMessage)
        inputMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
