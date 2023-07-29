//
//  AuthViewModel.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation
import Firebase

enum AuthenticationStatus: Equatable {
    case loading
    case error(message: String)
    case ok
}

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var status: AuthenticationStatus = .loading
    @Published var userSession: FirebaseAuth.User?
    @Published var showSuccessAlert: Bool = false
    
    private var currentUser: FirebaseAuth.User?
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                self.status = .error(message: "Failed to sign in: \(error.localizedDescription)")
                return
            }
            
            self.status = .ok
            self.userSession = result?.user
        }
    }
    
    func register(email: String, username: String, fullName: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                self.status = .error(message: "Failed to register: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {
                self.status = .error(message: "User is nil")
                return
            }
            
            let data: [String: Any] = ["email": email, "username": username, "fullName": fullName]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                if let error {
                    self.status = .error(message: "Failed to update user: \(error.localizedDescription)")
                    return
                }
                self.status = .ok
                self.showSuccessAlert = true
                self.isAuthenticated = true
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageURL in
            Firestore.firestore().collection("users").document(uid).updateData(["profileURL": imageURL])
        }
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
}
