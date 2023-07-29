//
//  ChatViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation

final class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    init() {
        messages = MockData.mockMessages
    }
    
    func sendMessage(_ message: String) {
        let message = Message(isFromCurrentUser: true, messageText: message)
        messages.append(message)
    }
}
