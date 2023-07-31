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

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var status: AuthenticationStatus = .loading
    @Published var showSuccessAlert: Bool = false
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var currentName: String = ""
    
    init() {
        Task {
            userSession = Auth.auth().currentUser
            await fetchUser()
            updateCurrentName()
        }
    }
    
    func fetchUser() async {
        guard let uid = userSession?.uid else { return }
        
        do {
            let snapshot = try await Constants.USERS_COLLECTION.document(uid).getDocument()
            
            guard let user = try? snapshot.data(as: User.self) else { return }
            
            self.currentUser = user
        } catch {
            print("Error when fetching user: \(error.localizedDescription)")
        }
    }
    
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            status = .ok
            await fetchUser()
            updateCurrentName()
        } catch {
            status = .error(message: "Failed to sign in: \(error.localizedDescription)")
        }
    }
    
    func register(email: String, username: String, fullName: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let data: [String: Any] = ["email": email, "username": username, "fullName": fullName, "profileImageURL": Constants.PROFILE_DEFAULT_THUMBNAIL]
            
            do {
                try await Constants.USERS_COLLECTION.document(result.user.uid).setData(data)
                status = .ok
                showSuccessAlert = true
                isAuthenticated = true
            } catch {
                status = .error(message: "Failed to create user profile: \(error.localizedDescription)")
            }
        } catch {
            status = .error(message: "Failed to register: \(error.localizedDescription)")
        }
    }
    
    func uploadProfileImage(_ image: UIImage) async {
        guard let uid = userSession?.uid else { return }
        
        do {
            let imageURL = try await ImageUploader.uploadImage(image: image)
            try await Constants.USERS_COLLECTION.document(uid).updateData(["profileImageURL": imageURL])
            updateCurrentUser()
        } catch {
            print("Error occurred during image upload: \(error)")
        }
    }
    
    func signOut() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    private func updateCurrentName() {
        currentName = currentUser?.fullName ?? ""
    }
    
    private func updateCurrentUser() {
        Task {
            do {
                guard let uid = userSession?.uid else { return }
                
                let documentSnapshot = try await Constants.USERS_COLLECTION.document(uid).getDocument()
                let user = try documentSnapshot.data(as: User.self)
                
                self.currentUser = user
            } catch {
                print("Error fetching current user: \(error)")
            }
        }
    }
}
