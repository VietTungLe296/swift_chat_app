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
