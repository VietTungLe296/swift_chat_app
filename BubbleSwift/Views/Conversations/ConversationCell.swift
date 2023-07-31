//
//  ConversationCell.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct ConversationCell: View {
    @ObservedObject var viewModel: ConversationCellViewModel
    
    var body: some View {
        if let user = viewModel.message.user {
            NavigationLink {
                ChatView(user: user)
            } label: {
                VStack {
                    HStack {
                        AsyncImage(url: viewModel.chatPartnerProfileImageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 48, height: 48)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 48, height: 48)
                                    .clipShape(Circle())
                            case .failure(_):
                                DefaultThumbnail()
                                    .frame(width: 48, height: 48)
                            @unknown default:
                                DefaultThumbnail()
                                    .frame(width: 48, height: 48)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(viewModel.chatPartnerFullName)
                                .font(.system(size: 14, weight: .semibold))
                            
                            Text(viewModel.message.text)
                                .font(.system(size: 15))
                        }
                        .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(8)
                    
                    Divider()
                }
            }
        }
    }
}

struct Conversation_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCell(viewModel: ConversationCellViewModel(Message(senderId: "", receiverId: "", read: false, text: "Testing message", timestamp: .init(date: Date()))))
    }
}
