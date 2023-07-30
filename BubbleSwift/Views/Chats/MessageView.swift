//
//  MessageView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import SwiftUI

struct MessageView: View {
    @StateObject var viewModel: MessageViewModel
    
    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                
                Text(viewModel.message.text)
                    .padding(12)
                    .background(.blue)
                    .font(.system(size: 15))
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 50)
                
            } else {
                HStack(alignment: .bottom) {
                    AsyncImage(url: viewModel.profileImageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        case .failure(_):
                            DefaultThumbnail()
                                .frame(width: 32, height: 32)
                        @unknown default:
                            DefaultThumbnail()
                                .frame(width: 32, height: 32)
                        }
                    }
                    
                    Text(viewModel.message.text)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .font(.system(size: 15))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .padding(.trailing, 50)
                
                Spacer()
            }
        }
    }
}
