//
//  LoginViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var userName: String = "Bach"
    @Published var phoneNumber: String = "0123456789"
    @Published var isShowError: Bool = false
    
    func login(router: Router) {
        APIService.shared.login(userName: userName, phoneNumber: phoneNumber) { result in
            switch result {
            case .success(let data):
                UserDefaultsStorage.shared.saveUserId(data.userId?.uuidString ?? "")
                UserStorage.shared.saveAccessToken(data.accessToken)
                router.push(.tabbarView)
            case .failure(let error):
                self.isShowError = true
                print(error)
            }
        }
    }
}
