//
//  ExchangeRate.swift
//  LOTR Converter
//
//  Created by Tiago Pinheiro on 20/10/2023.
//

import SwiftUI

struct ExchangeRate: View {
    @State var leftImage: ImageResource
    @State var text: String
    @State var rightImage: ImageResource
    
    var body: some View {
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            Text(text)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpenny, text: "1 Gold Penny = 4 Silver Pieces", rightImage: .silverpiece)
        .previewLayout(.sizeThatFits)
}
