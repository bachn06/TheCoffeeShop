//
//  OrderConfirmationView.swift
//  TheCoffeeShop
//
//  Created by BachNX8.WDC on 22/10/24.
//

import SwiftUI

struct OrderConfirmationView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color(hex: "2c2c2c")
            VStack {
                Image("carbon_delivery")
                    .resizable()
                    .frame(width: 68, height: 68)
                
                Text("Thank You For Your Order!")
                    .foregroundStyle(Color(hex: "#D2AE82"))
                Text("Wait For The Call")
                    .foregroundStyle(Color(hex: "#D2AE82"))
            }
            
            VStack {
                Spacer()
                Text("Track Your Order")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "#CB8A58"), Color(hex: "#562B1A")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(32)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                    .onTapGesture {
                        router.push(.orderTrackingDetail)
                    }
            }
            
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    OrderConfirmationView()
}
