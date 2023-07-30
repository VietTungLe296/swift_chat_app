//
//  UserViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 30/07/2023.
//

import Foundation
import Firebase

@MainActor
final class UserViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    private func fetchUsers() async {
        do {
            let snapshot = try await Constants.USERS_COLLECTION.getDocuments()
            let documents = snapshot.documents
            
            self.users = documents.compactMap { try? $0.data(as: User.self) }.filter { $0.id != Auth.auth().currentUser?.uid }
        } catch {
            print("Error when fetching user: \(error.localizedDescription)")
        }
    }
}




