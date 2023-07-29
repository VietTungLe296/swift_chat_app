//
//  UserCell.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        VStack {
            HStack {
                Image("vts")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Viet Tung Le")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("@VTS")
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
        UserCell()
    }
}
