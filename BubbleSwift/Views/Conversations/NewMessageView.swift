//
//  NewMessageView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 28/07/2023.
//

import SwiftUI

struct NewMessageView: View {
    @Binding var showChatView: Bool
    
    @Environment(\.dismiss) var dismiss
    
    @State var searchText = ""
    
    //    var searchResults: [String] {
    //        if searchText.isEmpty {
    //            return names
    //        } else {
    //            return names.filter { $0.contains(query) }
    //        }
    //    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0...10, id: \.self) { index in
                        Button {
                            showChatView = true
                            dismiss()
                        } label: {
                            UserCell()
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(10)
                }
            }
            .searchable(text: $searchText, prompt: Text("Find your friend here"))
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(showChatView: .constant(true))
    }
}
