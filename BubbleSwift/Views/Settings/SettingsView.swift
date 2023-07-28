//
//  SettingsView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                VStack(spacing: 32) {
                    NavigationLink {
                        EditProfileView()
                    } label: {
                        SettingsHeaderView()
                    }
                    
                    VStack(spacing: 1) {
                        ForEach(SettingsOption.allCases, id: \.self) { option in
                            SettingsCell(option: option)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Log Out")
                            .foregroundColor(.red)
                            .font(.system(size: 18))
                            .frame(width: geometry.size.width, height: 50)
                            .background(.white)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .navigationTitle("Settings")
        }
    }
}
