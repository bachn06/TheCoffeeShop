//
// LoginView.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userEnvironment: UserEnvironment
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            ZStack {
                Color(hex: "#B29F91")
                VStack {
                    Image("loginBackground1", bundle: nil)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    Spacer()
                    
                    Image("loginBackground2", bundle: nil)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                }
                Image("loginBackground3", bundle: nil)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Spacer()
                VStack {
                    Text("Welcome back!")
                        .font(.system(size: 36, weight: .bold))
                        .padding(.top, 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    Text("Login to your account.")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 40)
                
                VStack(spacing: 20) {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Username")
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        TextField("", text: $viewModel.userName)
                            .frame(height: 60)
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray)
                            )
                    }
                    .padding(.horizontal, 40)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Phone Number")
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                        TextField("", text: $viewModel.phoneNumber)
                            .frame(height: 60)
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.gray)
                            )
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal, 40)
                }
                
                VStack {
                    Button(action: {
                        viewModel.login(router: router, userManager: userEnvironment)
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(hex: "#CB8A58"), Color(hex: "#562B1A")]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                            .padding(.horizontal, 40)
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
        .environmentObject(Router())
        .environmentObject(UserEnvironment())
}
