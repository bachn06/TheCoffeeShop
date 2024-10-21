//
//  LoginViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var userName: String = "Host"
    @Published var phoneNumber: String = "9876543210"
    
    @Published var isNameValid: Bool = true
    @Published var isPhoneNumberValid: Bool = true
    
    func login(router: Router, userManager: UserEnvironment) {
        router.push(.tabbarView)
        APIService.shared.login(userName: userName, phoneNumber: phoneNumber) { result in
            switch result {
            case .success(let user):
                self.updateUserStorage(user, userManager)
                router.push(.tabbarView)
            case .failure(let error):
                break
            }
        }
    }
    
    func updateUserStorage(_ user: User, _ userManager: UserEnvironment) {
        userManager.userName = user.name
        userManager.phoneNumber = user.phone
    }
}
