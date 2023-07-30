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
    @Published var showSuccessAlert: Bool = false
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else {
            return
        }
        
        Constants.USERS_COLLECTION.document(uid).getDocument { snapshot, error in
            if let error {
                print("Error when fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else {
                return
            }
            self.currentUser = user
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.status = .error(message: "Failed to sign in: \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
            self.status = .ok
            self.fetchUser()
        }
    }
    
    func register(email: String, username: String, fullName: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                self.status = .error(message: "Failed to register: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {
                self.status = .error(message: "Cannot find user")
                return
            }
            
            let data: [String: Any] = ["email": email, "username": username, "fullName": fullName, "profileImageURL": Constants.PROFILE_DEFAULT_THUMBNAIL]
            
            Constants.USERS_COLLECTION.document(user.uid).setData(data) { error in
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
        guard let uid = userSession?.uid else {
            return
        }
        
        ImageUploader.uploadImage(image: image) { imageURL in
            Constants.USERS_COLLECTION.document(uid).updateData(["profileURL": imageURL])
        }
    }
    
    func signOut() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
}
