//
//  EditProfileView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State var name: String = ""
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 44) {
                VStack {
                    HStack {
                        VStack {
                            if let avatarImage {
                                avatarImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                                
                            } else {
                                Image("vts")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                            }
                            
                            PhotosPicker("Edit", selection: $avatarItem, matching: .images)
                        }
                        .onChange(of: avatarItem) { _ in
                            Task {
                                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        avatarImage = Image(uiImage: uiImage)
                                        return
                                    }
                                }
                                
                                print("Failed")
                            }
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
                    
                    TextField("Name", text: $name)
                        .padding(10)
                }
                .background(.white)
                .padding(.vertical, 5)
                
                VStack(alignment: .leading) {
                    Text("Status")
                        .padding()
                        .foregroundColor(.gray)
                    
                    NavigationLink {
                        StatusEditView()
                    } label: {
                        HStack {
                            Text(UserStatus.available.rawValue)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(.white)
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileView(name: "Viet Tung Le")
        }
    }
}
