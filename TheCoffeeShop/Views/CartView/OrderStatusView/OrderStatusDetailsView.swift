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
                        iconForStatus(statusRecord.status)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 8)
                            .foregroundStyle(color(for: statusRecord.status))
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
                                        .stroke(color(for: statusRecord.status), lineWidth: 3)
                                )
                                .padding(.top, -5)
                            
                            if statusRecord.status != .completed {
                                Rectangle()
                                    .fill(color(for: statusRecord.status))
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
    
    private func color(for status: OrderStatus) -> Color {
        isActive || status == .confirmed ? Color(hex: "#CB8A58") : Color(hex: "#D9D9D9")
    }
    
    func iconForStatus(_ status: OrderStatus) -> Image {
        switch status {
        case .confirmed:
            AppImage.cube
        case .processed:
            AppImage.recordCircle
        case .delivery:
            AppImage.truck
        case .completed:
            AppImage.thumpsUp
        }
    }
}

#Preview {
    OrderStatusDetailsView()
        .environmentObject(Router())
}
