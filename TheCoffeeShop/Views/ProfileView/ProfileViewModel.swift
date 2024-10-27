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
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var address: String = ""
    
    @Published var tempName: String = ""
    @Published var tempPhoneNumber: String = ""
    @Published var tempAddress: String = ""
    
    @Published var validationStatus: [ProfileField: Bool] = [
        .name: true,
        .phoneNumber: true,
        .address: true
    ]
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func logout(router: Router) {
        UserDefaultsStorage.shared.removeUserId()
        UserStorage.shared.deleteAccessToken()
        router.setRoot(.loginView)
    }
    
    func fetchProfile(_ userEnvironment: UserEnvironment) {
        name = userEnvironment.userName
        phoneNumber = userEnvironment.phoneNumber
        address = userEnvironment.address
        
        // Set initial temp values
        tempName = name
        tempPhoneNumber = phoneNumber
        tempAddress = address
    }
    
    func updateProfileField(_ field: ProfileField, _ userEnvironment: UserEnvironment) {
        guard validate(field) else {
            resetTempField(field)
            return
        }
        
        let fieldValue = getFieldValue(for: field)
        updateEnvironment(field, with: fieldValue, in: userEnvironment)
        syncFieldToTemp(field)
    }
    
    private func validate(_ field: ProfileField) -> Bool {
        let isValid: Bool
        switch field {
        case .name:
            isValid = !tempName.isEmpty
            errorMessage = isValid ? "" : "Name cannot be empty."
        case .phoneNumber:
            isValid = tempPhoneNumber.allSatisfy(\.isNumber) && tempPhoneNumber.count >= 10 && tempPhoneNumber.hasPrefix("0")
            errorMessage = isValid ? "" : "Phone number must start with 0, be 10 digits long, and contain only numbers."
        case .address:
            isValid = !tempAddress.isEmpty
            errorMessage = isValid ? "" : "Address cannot be empty."
        }
        
        validationStatus[field] = isValid
        if !isValid {
            showError = true
        }
        
        return isValid
    }
    
    private func getFieldValue(for field: ProfileField) -> String {
        switch field {
        case .name: return tempName
        case .phoneNumber: return tempPhoneNumber
        case .address: return tempAddress
        }
    }
    
    private func updateEnvironment(_ field: ProfileField, with value: String, in userEnvironment: UserEnvironment) {
        switch field {
        case .name: userEnvironment.userName = value
        case .phoneNumber: userEnvironment.phoneNumber = value
        case .address: userEnvironment.address = value
        }
        userEnvironment.updateProfile()
    }
    
    private func syncFieldToTemp(_ field: ProfileField) {
        switch field {
        case .name: name = tempName
        case .phoneNumber: phoneNumber = tempPhoneNumber
        case .address: address = tempAddress
        }
    }
    
    private func resetTempField(_ field: ProfileField) {
        switch field {
        case .name: tempName = name
        case .phoneNumber: tempPhoneNumber = phoneNumber
        case .address: tempAddress = address
        }
    }
}
