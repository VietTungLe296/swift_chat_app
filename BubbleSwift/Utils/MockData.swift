//
//  MockData.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation

final class MockData {
    static var mockMessages: [Message] {
        [
            .init(isFromCurrentUser: true, messageText: "Hello my friend"),
            .init(isFromCurrentUser: false, messageText: "Long time no see"),
            .init(isFromCurrentUser: true, messageText: "Wanna have fun right now?"),
            .init(isFromCurrentUser: false, messageText: "Nah. I'm good with this stuff"),
            .init(isFromCurrentUser: true, messageText: "Damn, homie. Where did you get that?"),
            .init(isFromCurrentUser: false, messageText: "Hustle for life, my boy"),
            .init(isFromCurrentUser: true, messageText: "It must be crazy"),
            .init(isFromCurrentUser: true, messageText: "Still doing well, dawg")]
    }
}
