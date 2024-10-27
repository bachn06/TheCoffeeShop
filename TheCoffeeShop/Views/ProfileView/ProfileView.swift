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
                profileView
                settingsSection
            }
            .padding(.horizontal, 30)
            
            logoutButton
                .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding(.top, 50)
        .onAppear {
            viewModel.fetchProfile(userEnvironment)
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Validation Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private var profileView: some View {
        VStack {
            ZStack {
                Spacer()
                    .frame(width: 100, height: 100)
                AsyncCachedImage(url: URL(string: userEnvironment.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            
            HStack {
                if isEditingName {
                    TextField("Enter Name", text: $viewModel.tempName)
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
                        AppImage.checkMark
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.gray)
                    } else {
                        AppImage.pencil
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.headline)
                .padding(.bottom, 5)
            
            EditableField(
                text: $viewModel.tempPhoneNumber,
                isEditing: $isEditingPhone,
                placeholder: "Enter Phone Number",
                icon: AppImage.phone,
                updateAction: { viewModel.updateProfileField(.phoneNumber, userEnvironment) }
            )
            
            EditableField(
                text: $viewModel.tempAddress,
                isEditing: $isEditingAddress,
                placeholder: "Enter Address",
                icon: AppImage.marker,
                updateAction: { viewModel.updateProfileField(.address, userEnvironment) }
            )
        }
    }
    
    private var logoutButton: some View {
        HStack {
            Spacer()
            Button(action: { viewModel.logout(router: router) }) {
                HStack {
                    Text("Logout")
                        .foregroundColor(.brown)
                    AppImage.logout
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.brown)
                }
            }
        }
    }
}

// MARK: - EditableField Subview
struct EditableField: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    var placeholder: String
    var font: Font = .body
    var icon: Image? = nil
    var updateAction: () -> Void
    
    var body: some View {
        HStack {
            if let icon = icon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
            
            if isEditing {
                TextField(placeholder, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
            } else {
                Text(text)
                    .font(font)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action: {
                isEditing.toggle()
                if !isEditing {
                    updateAction()
                }
            }) {
                if isEditing {
                    AppImage.checkMark
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                } else {
                    AppImage.pencil
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserEnvironment())
        .environmentObject(Router())
}
