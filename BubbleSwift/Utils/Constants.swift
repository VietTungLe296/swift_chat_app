//
//  Constants.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 30/07/2023.
//

import Foundation
import Firebase

struct Constants {
    static let PROFILE_DEFAULT_THUMBNAIL = "https://firebasestorage.googleapis.com/v0/b/bubble-swift.appspot.com/o/profile-default-thumbnail.png?alt=media&token=93e2d71d-30ca-4b03-a95b-4c344beda045"
    
    static let USERS_COLLECTION = Firestore.firestore().collection("users")
}
