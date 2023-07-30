//
//  EntryView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
            .environmentObject(AuthViewModel())
    }
}
