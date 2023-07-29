//
//  BubbleSwiftApp.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 26/07/2023.
//

import SwiftUI
import Firebase

@main
struct BubbleSwiftApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(AuthViewModel())
        }
    }
}
