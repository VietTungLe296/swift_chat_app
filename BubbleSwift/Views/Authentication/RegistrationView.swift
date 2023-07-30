//
//  RegistrationView.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 27/07/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var showStatus = false
    @State private var allowsInteraction = true
    @State private var forwardLogin = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Create account.")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Start your journey now!")
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()
                
                VStack(spacing: 30) {
                    CustomTextField(imageName: "envelope", placeholder: "Email", isSecureField: false, text: $email)
                    CustomTextField(imageName: "person.crop.circle", placeholder: "Username", isSecureField: false, text: $username)
                    CustomTextField(imageName: "person", placeholder: "Full Name", isSecureField: false, text: $fullName)
                    CustomTextField(imageName: "lock", placeholder: "Password", isSecureField: true, text: $password)
                }
                .padding(32)
                
                Button {
                    showStatus = true
                    
                    Task {
                        await viewModel.register(email: email, username: username, fullName: fullName, password: password)
                    }
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                
                Spacer()
                
                NavigationLink {
                    LoginView()
                } label: {
                    HStack(spacing: 5) {
                        Spacer()
                        
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign in now")
                            .font(.system(size: 14, weight: .bold))
                        
                        Spacer()
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationDestination(isPresented: $forwardLogin) {
                LoginView()
            }
            .alert("Successfully registered", isPresented: $viewModel.showSuccessAlert) {
                Button("OK", role: .cancel) {
                    forwardLogin = true
                }
            }
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
                                    allowsInteraction = true
                                }
                            }
                            .onDisappear {
                                viewModel.status = .loading
                            }
                    }
                }
            }
        }
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
