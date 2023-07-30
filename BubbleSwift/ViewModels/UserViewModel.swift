//
//  UserViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 30/07/2023.
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        Constants.USERS_COLLECTION.getDocuments { snapshot, error in
            if let error {
                print("Error when fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
        }
    }
}
