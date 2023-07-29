//
//  MessageView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import SwiftUI

struct MessageView: View {
    var isFromCurrentUser: Bool
    var messageText: String
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text(messageText)
                    .padding(12)
                    .background(.blue)
                    .font(.system(size: 15))
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 50)
                
            } else {
                HStack(alignment: .bottom) {
                    Image("vts")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    
                    Text(messageText)
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

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageView(isFromCurrentUser: false, messageText: "Play for fun")
            MessageView(isFromCurrentUser: true, messageText: "Play for fun")
        }
    }
}
