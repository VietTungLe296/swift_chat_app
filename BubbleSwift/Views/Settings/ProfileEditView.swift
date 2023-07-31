//
//  ProfileEditView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI
import PhotosUI

struct ProfileEditView: View {
    @State var showStatusEdit = false
    
    @ObservedObject var imagePicker = ImagePicker()
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 44) {
                VStack {
                    HStack {
                        VStack {
                            if let avatarImage = imagePicker.image {
                                Image(uiImage: avatarImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                                
                            } else {
                                if let urlString = authViewModel.currentUser?.profileImageURL, let imageURL = URL(string: urlString) {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 64, height: 64)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 64, height: 64)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            DefaultThumbnail()
                                                .frame(width: 64, height: 64)
                                        @unknown default:
                                            DefaultThumbnail()
                                                .frame(width: 64, height: 64)
                                        }
                                    }
                                } else {
                                    DefaultThumbnail()
                                        .frame(width: 64, height: 64)
                                }
                            }
                            
                            PhotosPicker("Edit", selection: $imagePicker.imageSelection, matching: .images)
                        }
                        
                        Spacer()
                        
                        Text("Enter your name or change your profile photo")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding([.bottom, .horizontal])
                        
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    TextField("Name", text: $authViewModel.currentName)
                        .padding(10)
                        .autocorrectionDisabled()
                }
                .background(.white)
                .padding(.vertical, 5)
                
                VStack(alignment: .leading) {
                    Text("Status")
                        .padding()
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text(UserStatus.available.rawValue)
                            .foregroundColor(.cyan)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(.white)
                    .onTapGesture {
                        showStatusEdit = true
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if let avatarImage = imagePicker.image {
                        Task {
                            await authViewModel.uploadProfileImage(avatarImage)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showStatusEdit) {
            StatusEditView()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileEditView()
                .environmentObject(AuthViewModel())
        }
    }
}
