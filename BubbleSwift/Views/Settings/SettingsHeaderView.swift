//
//  SettingsHeaderView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct SettingsHeaderView: View {
    var body: some View {
        HStack {
            Image("vts")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.leading)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Viet Tung Le")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                
                Text("Avaliable")
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
        SettingsHeaderView()
    }
}
