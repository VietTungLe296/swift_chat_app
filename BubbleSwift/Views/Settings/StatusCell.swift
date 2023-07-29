//
//  StatusCell.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct StatusCell: View {
    var status: UserStatus
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(status.rawValue)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .padding()
        .background(.white)
    }
}


struct StatusCell_Previews: PreviewProvider {
    static var previews: some View {
        StatusCell(status: .meeting, isSelected: true)
    }
}
