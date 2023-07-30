//
//  SettingsHeaderView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct SettingsHeaderView: View {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack(spacing: 10) {
            if let imageURL = URL(string: user.profileImageURL) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 64, height: 64)
                            .padding(.leading)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .padding(.leading)
                    case .failure(_):
                        DefaultThumbnail()
                            .frame(width: 64, height: 64)
                            .padding(.leading)
                    @unknown default:
                        DefaultThumbnail()
                            .frame(width: 64, height: 64)
                            .padding(.leading)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(user.username)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                
                Text("Available")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .semibold))
            }
            
            Spacer()
        }
        .frame(height: 90)
        .background(.white)
        .padding(.vertical)
    }
}

struct SettingsHeader_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHeaderView(user: User.mockUser)
    }
}
