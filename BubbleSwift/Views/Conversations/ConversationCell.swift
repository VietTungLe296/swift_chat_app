//
//  ConversationCell.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct ConversationCell: View {
    var body: some View {
        VStack {
            HStack {
                Image("vts")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Viet Tung Le")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Temporary message for now...")
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

struct Conversation_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCell()
    }
}
