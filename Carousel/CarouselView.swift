//
//  CarouselView.swift
//  Carousel
//
//  Created by Azharuddin 1 on 17/05/25.
//

import SwiftUI

struct CarouselView: View {
    let colors:[Color] = [.red, .green, .cyan, .yellow, .orange]
    @State private var selectedColor:Color? = nil
    @State private var position:ScrollPosition = .init()
    var body: some View {
        VStack(spacing: 24) {
            ScrollView(.horizontal) {
                HStack(spacing:0) {
                    ForEach(colors, id: \.self) { color in
                        Rectangle()
                            .fill(color)
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .id(color)
                    }
                    .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }


            HStack {
                ForEach(colors, id:\.self) { color in
                    Circle()
                        .fill(selectedColor  == color ? Color.primary : Color.secondary)
                        .frame(width: selectedColor  == color ? 20 : 15)
                        .onTapGesture {
                            withAnimation {
                                position.scrollTo(id: color)
                            }
                        }
                }
            }
            .padding(5)
            .background(.thickMaterial, in:Capsule())
        }
        .scrollPosition($position)
        .scrollTargetBehavior(.paging)
        .onScrollTargetVisibilityChange(idType: Color.self) { visibleColors  in
            self.selectedColor = visibleColors.first
        }
    }
}

#Preview {
    CarouselView()
}
