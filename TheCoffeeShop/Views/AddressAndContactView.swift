//
//  AddressAndContactView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct AddressAndContactView: View {
    @State var address: String = "This is address for testing"
    var addressTapped: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
            Text(address)
                .font(.subheadline)
                .fontWeight(.semibold)
                .onTapGesture {
                    addressTapped()
                }
            Spacer()
            Image(systemName: "phone.fill")
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddressAndContactView(addressTapped: {})
}
