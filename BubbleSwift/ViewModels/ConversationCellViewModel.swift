//
//  ConversationCellViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 31/07/2023.
//

import Foundation
import Firebase

@MainActor
final class ConversationCellViewModel: ObservableObject {
    @Published var message: Message
    
    init(_ message: Message) {
        self.message = message
        
        Task {
            await fetchUser()
        }
    }
    
    var chatPartnerId: String {
        return message.senderId == Auth.auth().currentUser?.uid ? message.receiverId : message.senderId
    }
    
    var chatPartnerProfileImageURL: URL? {
        guard let user = message.user else { return nil }
        
        return URL(string: user.profileImageURL)
    }
    
    var chatPartnerFullName: String {
        guard let fullName = message.user?.fullName else { return "" }
        
        return fullName
    }
    
    func fetchUser() async {
        do {
            let snapshot = try await Constants.USERS_COLLECTION.document(chatPartnerId).getDocument()
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            
            self.message.user = user
        } catch {
            print("Error when fetching user: \(error.localizedDescription)")
        }
    }
}
