//
//  OrderStatusRowView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 29/9/24.
//

import SwiftUI

struct OrderStatusRowView: View {
    let statusRecord: OrderStatusRecord
    var isActive: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(statusRecord.status.getDisplayValue())
                    .font(.headline)
                
                Text(formattedDate(statusRecord.timestamp))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 0))
            
            Spacer()
            
            Text(formattedTime(statusRecord.timestamp))
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.init(top: 35, leading: 0, bottom: 10, trailing: 20))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        )
        .background(Color(hex: "#D9D9D91F"))
        .padding()
        .cornerRadius(12)
    }
    
    func formattedDate(_ date: Date?) -> String {
        guard let date else {
            return "*******"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func formattedTime(_ date: Date?) -> String {
        guard let date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
}

#Preview {
    OrderStatusRowView(statusRecord: OrderStatusRecord(status: .delivery, timestamp: Date()))
}
