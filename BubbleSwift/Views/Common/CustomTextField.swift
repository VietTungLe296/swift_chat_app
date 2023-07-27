//
//  CustomTextField.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 26/07/2023.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholder: String
    let isSecureField: Bool
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                
                if isSecureField {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            
            Divider().background(.gray)
        }
        .padding(.bottom)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(imageName: "envelope", placeholder: "Email", isSecureField: false, text: .constant("Lmao"))
    }
}
