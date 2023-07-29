//
//  CustomInputField.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Divider()
            
            HStack {
                TextField("Message", text: $text)
                    .textFieldStyle(.plain)
                    .font(.body)
                    .frame(minHeight: 30)
                
                Button {
                    action()
                } label: {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
}
