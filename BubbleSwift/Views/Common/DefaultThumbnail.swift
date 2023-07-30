//
//  DefaultThumbnail.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 30/07/2023.
//

import SwiftUI

struct DefaultThumbnail: View {
    var body: some View {
        Image("default.thumbnail")
            .resizable()
            .scaledToFill()
            .frame(width: 64, height: 64)
            .clipShape(Circle())
            .padding(.leading)
    }
}

struct DefaultThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        DefaultThumbnail()
    }
}
