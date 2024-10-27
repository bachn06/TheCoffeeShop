//
//  ProfileView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userEnvironment: UserEnvironment
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var isEditingName = false
    @State private var isEditingPhone = false
    @State private var isEditingAddress = false
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                ZStack {
                    Spacer()
                        .frame(width: 100, height: 100)
                    AsyncCachedImage(url: URL(string: userEnvironment.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 1)
                            )
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                HStack {
                    if isEditingName {
                        TextField("Enter Name", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    } else {
                        Text(viewModel.name)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    Button(action: {
                        isEditingName.toggle()
                        if !isEditingName {
                            viewModel.updateProfileField(.name, userEnvironment)
                        }
                    }) {
                        if isEditingName {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.gray)
                        } else {
                            Image("pencil")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Settings")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                HStack {
                    Image("phone")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                    
                    if isEditingPhone {
                        TextField("Enter Phone Number", text: $viewModel.phoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                    } else {
                        Text(viewModel.phoneNumber)
                            .font(.body)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isEditingPhone.toggle()
                        if !isEditingName {
                            viewModel.updateProfileField(.phoneNumber, userEnvironment)
                        }
                    }) {
                        if isEditingPhone {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.gray)
                        } else {
                            Image("pencil")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                
                HStack {
                    Image("marker")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                    
                    if isEditingAddress {
                        TextField("Enter Address", text: $viewModel.address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                    } else {
                        Text(viewModel.address)
                            .font(.body)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isEditingAddress.toggle()
                        if !isEditingName {
                            viewModel.updateProfileField(.address, userEnvironment)
                        }
                    }) {
                        if isEditingAddress {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.gray)
                        } else {
                            Image("pencil")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.logout(router: router)
                }) {
                    HStack {
                        Text("Logout")
                            .foregroundColor(Color.brown)
                        
                        Image("logout")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.brown)
                    }
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding(.top, 50)
        .onAppear {
            viewModel.fetchProfile(userEnvironment)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserEnvironment())
}
