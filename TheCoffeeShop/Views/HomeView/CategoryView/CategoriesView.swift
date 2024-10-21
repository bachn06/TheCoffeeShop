//
//  CategoriesView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [ProductCategory]
    @Binding var selectedCategories: Set<ProductCategory>
    let action: (ProductCategory) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Categories")
                .font(.headline)
                .padding(.horizontal)
            
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    self.generateContent(in: geometry)
                }
            }
            .padding(.horizontal, 5)
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(categories, id: \.self) { category in
                CategoryButtonView(
                    title: category.title,
                    icon: category.imageUrl,
                    action: {
                        action(category)
                    },
                    isSelected: selectedCategories.contains(category)
                )
                .padding([.horizontal, .vertical], 5)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if let lastCategory = self.categories.last,
                       category == lastCategory {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { d in
                    let result = height
                    if let lastCategory = self.categories.last,
                       category == lastCategory {
                        height = 0 // last item
                    }
                    return result
                })
            }
        }
    }
}



struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categories: [], selectedCategories: .constant([]), action: {_ in})
    }
}
