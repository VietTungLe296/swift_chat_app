//
//  LoginView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 26/07/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State var showStatus = false
    @State var allowsInteraction = true
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Hola amigo.")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Welcome to Bubble!")
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()
                
                VStack(spacing: 20) {
                    CustomTextField(imageName: "envelope", placeholder: "Email", isSecureField: false, text: $email)
                    CustomTextField(imageName: "lock", placeholder: "Password", isSecureField: true, text: $password)
                }
                .padding([.top, .horizontal], 32)
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        Text("Forgot password?")
                    } label: {
                        Text("Forgot password?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                Button {
                    showStatus = true
                    
                    Task {
                        await viewModel.login(email: email, password: password)
                    }
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(showStatus ? .white : .blue)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 5) {
                        Spacer()
                        
                        Text("Don't have an account yet?")
                            .font(.system(size: 14))
                        
                        Text("Sign up now")
                            .font(.system(size: 14, weight: .bold))
                        
                        Spacer()
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
            .allowsHitTesting(allowsInteraction)
            .blur(radius: showStatus ? 8 : 0)
            .overlay {
                if showStatus {
                    if case .loading = viewModel.status {
                        ProgressView()
                            .onAppear {
                                allowsInteraction = false
                            }
                            .onDisappear {
                                allowsInteraction = true
                            }
                    } else if case .error(let message) = viewModel.status {
                        Text(message)
                            .foregroundColor(.red)
                            .padding()
                            .onAppear {
                                allowsInteraction = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showStatus = false
                                    viewModel.status = .loading
                                    allowsInteraction = true
                                }
                            }
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
