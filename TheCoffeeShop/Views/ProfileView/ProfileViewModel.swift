//
//  ProfileViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation

enum ProfileField {
    case name
    case phoneNumber
    case address
}

final class ProfileViewModel: ObservableObject {
    @Published var avatarUrl: String = "https://avatars.githubusercontent.com/u/64175324"
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var address: String = ""
    
    @Published var isNameValid: Bool = true
    @Published var isPhoneNumberValid: Bool = true
    @Published var isAddressValid: Bool = true
    
    func logout(router: Router) {
        router.setRoot(.loginView)
    }
    
    func fetchProfile(_ userEnvironment: UserEnvironment) {
        avatarUrl = userEnvironment.imageUrl
        name = userEnvironment.userName
        phoneNumber = userEnvironment.phoneNumber
        address = userEnvironment.address
    }
    
    func updateProfileField(_ field: ProfileField, _ userEnvironment: UserEnvironment) {
        guard validateField(field) else { return }
        switch field {
        case .name:
            updateName(name, userEnvironment)
        case .phoneNumber:
            updatePhoneNumber(phoneNumber, userEnvironment)
        case .address:
            updateAddress(address, userEnvironment)
        }
    }
    
    private func validateField(_ field: ProfileField) -> Bool {
        switch field {
        case .name:
            isNameValid = !name.isEmpty
            return isNameValid
        case .phoneNumber:
            isPhoneNumberValid = phoneNumber.allSatisfy { $0.isNumber } && phoneNumber.count >= 10 && phoneNumber.prefix(1).contains("0")
            return isPhoneNumberValid
        case .address:
            isAddressValid = !address.isEmpty
            return isAddressValid
        }
    }
    
    private func updateName(_ name: String, _ userEnvironment: UserEnvironment) {
        self.name = name
        userEnvironment.userName = name
    }
    
    private func updatePhoneNumber(_ phoneNumber: String, _ userEnvironment: UserEnvironment) {
        self.phoneNumber = phoneNumber
        userEnvironment.phoneNumber = phoneNumber
    }
    
    private func updateAddress(_ address: String, _ userEnvironment: UserEnvironment) {
        self.address = address
        userEnvironment.address = address
    }
}
