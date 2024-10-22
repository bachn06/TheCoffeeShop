//
//  CreateOrderView.swift
//  TheCoffeeShop
//
//  Created by BachNX8.WDC on 22/10/24.
//

import SwiftUI

struct CreateOrderView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var cartItems: [CartItem]
    let createOrder: () -> Void
    
    @State private var selectedPaymentMethod: PaymentMethod = .applePay
    @State private var isExpanded = false
    
    let paymentMethods: [PaymentMethod] = [.applePay, .visaOrMastercard, .cash]
    @State private var paymentMethodContentSize: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Text("YOUR ORDERS:")
                    .font(.headline)
                    .bold()
                    .padding(.horizontal, 20)
                
                ScrollView {
                    ForEach($cartItems, id: \.product.id) { item in
                        ListItemView(
                            product: item.product,
                            toggleFavourite: { _ in },
                            addToCart: { _ in },
                            showQuantityOption: true
                        )
                    }
                }
                .frame(maxHeight: 300)
                
                VStack {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Select address")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Payment method:")
                            .font(.headline)
                        
                        VStack(spacing: 0) {
                            Button(action: {
                                isExpanded.toggle()
                            }) {
                                HStack {
                                    Image(selectedPaymentMethod.image, bundle: nil)
                                    Text(selectedPaymentMethod.displayText)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                    Spacer()
                                    
                                    if !isExpanded {
                                        Image(systemName: "chevron.down")
                                            .foregroundStyle(.black)
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                            }
                            
                            if isExpanded {
                                ForEach(paymentMethods.filter({ $0 != selectedPaymentMethod }), id: \.self) { paymentMethod in
                                    Button(action: {
                                        selectedPaymentMethod = paymentMethod
                                        isExpanded = false
                                    }) {
                                        HStack {
                                            Image(paymentMethod.image, bundle: nil)
                                            Text(paymentMethod.displayText)
                                                .fontWeight(.bold)
                                            
                                            Spacer()
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .border(.gray, width: 0.2)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            } else {
                                Spacer()
                            }
                        }
                        .cornerRadius(5)
                        .animation(.easeInOut, value: isExpanded)
                        .overlay(
                            GeometryReader { geo in
                                Color.clear.onAppear {
                                    paymentMethodContentSize = geo.size
                                }
                            }
                        )
                        .frame(height: paymentMethodContentSize.height * 3)
                    }
                    .padding()
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("Total: \(String(format: "%.1f$", 0))")
                            .font(.headline)
                            .bold()
                    }
                    .padding(.horizontal, 30)
                    
                    NavigationLink{
                        OrderConfirmationView()
                    } label: {
                        VStack {
                            HStack {
                                Text("Create Order")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.leading, 30)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 30)
                            }
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .background(.black)
                            .cornerRadius(6)
                            Spacer()
                        }
                    }
                    
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateOrderView(cartItems: .constant([]), createOrder: {})
}