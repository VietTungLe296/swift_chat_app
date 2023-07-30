//
//  MessageViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 30/07/2023.
//

import Foundation
import Firebase

final class MessageViewModel: ObservableObject{
    let message: Message
    
    init(message: Message) {
        self.message = message
    }
    
    var senderId: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    var isFromCurrentUser: Bool {
        return message.senderId == senderId
    }
    
    var profileImageURL: URL? {
        guard let profileImageURL = message.user?.profileImageURL else { return nil }
        return URL(string: profileImageURL)
    }
}
