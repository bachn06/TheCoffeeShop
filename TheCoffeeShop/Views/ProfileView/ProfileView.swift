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
                    AsyncCachedImage(url: URL(string: viewModel.avatarUrl)) { image in
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
                            viewModel.updateProfileField(.name)
                        }
                    }) {
                        Image(systemName: isEditingName ? "checkmark" : "pencil")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Settings")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                HStack {
                    Image(systemName: "phone.fill")
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
                            viewModel.updateProfileField(.phoneNumber)
                        }
                    }) {
                        Image(systemName: isEditingPhone ? "checkmark" : "pencil")
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
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
                            viewModel.updateProfileField(.address)
                        }
                    }) {
                        Image(systemName: isEditingAddress ? "checkmark" : "pencil")
                            .foregroundColor(.gray)
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
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.brown)
                    }
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding(.top, 50)
        .onAppear {
            viewModel.fetchProfile()
        }
    }
}

#Preview {
    ProfileView()
}
