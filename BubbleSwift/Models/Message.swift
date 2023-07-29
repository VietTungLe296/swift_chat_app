//
//  Message.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation

struct Message: Identifiable {
    let id = NSUUID().uuidString
    let isFromCurrentUser: Bool
    let messageText: String
}
