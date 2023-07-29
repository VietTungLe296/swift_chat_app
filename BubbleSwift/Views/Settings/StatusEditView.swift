//
//  StatusEditView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct StatusEditView: View {
    @ObservedObject var viewModel = StatusViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 48) {
                    VStack(alignment: .leading) {
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .padding([.top, .horizontal])
                            }
                        }
                        
                        Text("CURRENTLY SET TO")
                            .foregroundColor(.gray)
                            .padding()
                        
                        StatusCell(status: viewModel.status, isSelected: true)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("SELECT YOUR STATUS")
                            .foregroundColor(.gray)
                            .padding()
                        
                        VStack(spacing: 1) {
                            ForEach(UserStatus.allCases.filter { $0 != .notConfigured }, id: \.self) { status in
                                StatusCell(status: status, isSelected: status == viewModel.status)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        viewModel.updateStatus(status)
                                    }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}


struct StatusEditView_Previews: PreviewProvider {
    static var previews: some View {
        StatusEditView(viewModel: StatusViewModel())
    }
}


