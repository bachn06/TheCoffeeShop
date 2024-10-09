//
//  OrderStatusDetailsView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 29/9/24.
//

import SwiftUI

struct OrderStatusDetailsView: View {
    let statusHistory: [OrderStatusRecord] = [
        OrderStatusRecord(status: .confirmed, timestamp: Date()),
        OrderStatusRecord(status: .processed, timestamp: Date()),
        OrderStatusRecord(status: .delivery, timestamp: Date()),
        OrderStatusRecord(status: .completed, timestamp: Date())
    ]
    var isActive: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                
                HStack(alignment: .top) {
                    VStack(spacing: 70) {
                        ForEach(statusHistory, id: \.status) { statusRecord in
                            Image(systemName: iconForStatus(statusRecord.status))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 8)
                                .foregroundStyle(isActive || statusRecord.status == .confirmed ? Color(hex: "#CB8A58") : .black)
                        }
                    }
                    .padding(.top, 15)
                    
                    VStack {
                        ForEach(statusHistory, id: \.status) { statusRecord in
                            VStack(spacing: 0) {
                                Circle()
                                    .foregroundStyle(.clear)
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        Circle()
                                            .stroke(isActive || statusRecord.status == .confirmed ? Color(hex: "#CB8A58") : Color(hex: "#D9D9D9"), lineWidth: 3)
                                    )
                                    .padding(.top, -5)
                                
                                if statusRecord.status != .completed {
                                    Rectangle()
                                        .fill(isActive || statusRecord.status == .confirmed ? Color(hex: "#CB8A58") : Color(hex: "#D9D9D9"))
                                        .frame(width: 3, height: 80)
                                        .padding(.top, 1)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 0) {
                        ForEach(statusHistory, id: \.status) { statusRecord in
                            OrderStatusRowView(statusRecord: statusRecord, timeStamp: statusRecord.timestamp)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationBarTitle("Order Status Details", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(Color.black)
                        .clipShape(Circle())
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
    
    func iconForStatus(_ status: OrderStatus) -> String {
        switch status {
        case .confirmed:
            return "shippingbox.fill"
        case .processed:
            return "eye.circle.fill"
        case .delivery:
            return "box.truck.fill"
        case .completed:
            return "hand.thumbsup.fill"
        }
    }
}

#Preview {
    OrderStatusDetailsView()
}
