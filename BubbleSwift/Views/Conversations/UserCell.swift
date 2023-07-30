//
//  UserCell.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                if let imageURL = URL(string: user.profileImageURL) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .padding(.leading)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .padding(.leading)
                        case .failure(_):
                            DefaultThumbnail()
                        @unknown default:
                            DefaultThumbnail()
                        }
                    }
                } else {
                    DefaultThumbnail()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.fullName)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("@\(user.username)")
                        .font(.system(size: 15))
                }
                
                Spacer()
            }
            .padding(8)
            .foregroundColor(.black)
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: User(email: "test@gmail.com", username: "VTS", fullName: "Viet Tung Le", profileImageURL: ""))
    }
}
