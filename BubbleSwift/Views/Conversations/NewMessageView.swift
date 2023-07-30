//
//  NewMessageView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct NewMessageView: View {
    @Binding var user: User?
    @Binding var showChatView: Bool
    
    @State var searchText = ""
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return userViewModel.users
        } else {
            return userViewModel.users.filter { $0.username.lowercased().contains(searchText.lowercased()) || $0.fullName.lowercased().contains(searchText.lowercased())} 
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(filteredUsers) { user in
                        Button {
                            showChatView = true
                            self.user = user
                            dismiss()
                        } label: {
                            UserCell(user: user)
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(10)
                }
            }
            .searchable(text: $searchText, prompt: Text("Find your friend here"))
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(user: .constant(User.mockUser), showChatView: .constant(true))
            .environmentObject(AuthViewModel())
    }
}
