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
    @Published var name: String = "Bach"
    @Published var phoneNumber: String = "+84123456789"
    @Published var address: String = "Hanoi, Hanoi, VN"
    
    @Published var isNameValid: Bool = true
    @Published var isPhoneNumberValid: Bool = true
    @Published var isAddressValid: Bool = true
    
    func logout(router: Router) {
        router.push(.loginView)
    }
    
    func fetchProfile() {
        
    }
    
    func updateProfileField(_ field: ProfileField) {
        guard validateField(field) else { return }
        switch field {
        case .name:
            updateName(name)
        case .phoneNumber:
            updatePhoneNumber(phoneNumber)
        case .address:
            updateAddress(address)
        }
    }
    
    private func validateField(_ field: ProfileField) -> Bool {
        switch field {
        case .name:
            isNameValid = !name.isEmpty
            return isNameValid
        case .phoneNumber:
            isPhoneNumberValid = phoneNumber.allSatisfy { $0.isNumber } && phoneNumber.count >= 10
            return isPhoneNumberValid
        case .address:
            isAddressValid = !address.isEmpty
            return isAddressValid
        }
    }
    
    private func updateName(_ name: String) {
        print("update name")
    }
    
    private func updatePhoneNumber(_ phoneNumber: String) {
        
    }
    
    private func updateAddress(_ address: String) {
        
    }
}
