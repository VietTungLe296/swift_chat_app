//
//  ConversationViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 31/07/2023.
//

import Foundation
import Firebase

final class ConversationViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = Constants.MESSAGES_COLLECTION.document(uid)
            .collection("recent_messages")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.recentMessages = documents.compactMap({ try? $0.data(as: Message.self) })
        }
    }
}
