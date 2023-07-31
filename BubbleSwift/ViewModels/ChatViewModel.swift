//
//  ChatViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation
import Firebase

final class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        guard let receiverId = user.id else { return }
        
        let query = Constants.MESSAGES_COLLECTION
            .document(senderId)
            .collection(receiverId)
            .order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, error in
            if let error {
                print("Error when fetching messages: \(error.localizedDescription)")
                return
            }
            
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            var messages = changes.compactMap { try? $0.document.data(as: Message.self) }
            
            for (index, message) in messages.enumerated() where message.senderId != senderId {
                messages[index].user = self.user
            }
            
            self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage(_ message: String) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        
        guard let receiverId = user.id else { return }
        
        let senderRef = Constants.MESSAGES_COLLECTION.document(senderId).collection(receiverId).document()
        let messageId = senderRef.documentID
        let receiverRef = Constants.MESSAGES_COLLECTION.document(receiverId).collection(senderId)
        
        let recentSenderRef = Constants.MESSAGES_COLLECTION.document(senderId).collection("recent_messages").document(receiverId)
        let recentReceiverRef = Constants.MESSAGES_COLLECTION.document(receiverId).collection("recent_messages").document(senderId)
        
        let data: [String: Any] = ["text": message, "senderId": senderId, "receiverId": receiverId, "read": false, "timestamp": Timestamp(date: Date())]
        
        senderRef.setData(data)
        receiverRef.document(messageId).setData(data)
        
        recentSenderRef.setData(data)
        recentReceiverRef.setData(data)
    }
}
