//
//  Message.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    @DocumentID var id: String?
    let senderId: String
    let receiverId: String
    let read: Bool
    let text: String
    let timestamp: Timestamp
    
    var user: User?
}
