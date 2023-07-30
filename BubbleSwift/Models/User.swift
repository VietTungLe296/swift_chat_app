//
//  User.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 30/07/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    
    var email: String
    var username: String
    var fullName: String
    var profileImageURL: String
}

extension User {
    static let mockUser = User(email: "ladykillah07@gmail.com", username: "VTS", fullName: "Le Viet Tung", profileImageURL: "https://media.cnn.com/api/v1/images/stellar/prod/230621042149-01-cristiano-ronaldo-euro-200-apps-062023-restricted.jpg?c=1x1")
}
