//
//  OrderStatusDetailsView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 29/9/24.
//

import SwiftUI

struct OrderStatusDetailsView: View {
    @EnvironmentObject var router: Router
    
    let statusHistory: [OrderStatusRecord] = [
        OrderStatusRecord(status: .confirmed, timestamp: Date()),
        OrderStatusRecord(status: .processed, timestamp: nil),
        OrderStatusRecord(status: .delivery, timestamp: nil),
        OrderStatusRecord(status: .completed, timestamp: nil)
    ]
    var isActive: Bool = false
    
    var body: some View {
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
                        OrderStatusRowView(statusRecord: statusRecord)
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
                        router.popToView(.tabbarView)
                    }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func iconForStatus(_ status: OrderStatus) -> String {
        switch status {
        case .confirmed:
            return "cube"
        case .processed:
            return "recordCircle"
        case .delivery:
            return "truck"
        case .completed:
            return "thumpsup"
        }
    }
}

#Preview {
    OrderStatusDetailsView()
        .environmentObject(Router())
}
