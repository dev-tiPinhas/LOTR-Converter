//
//  IconGrid.swift
//  LOTR Converter
//
//  Created by Tiago Pinheiro on 20/10/2023.
//

import SwiftUI

struct IconGrid: View {
    @State var gridLayout = [GridItem(), GridItem(), GridItem()]
    @Binding var currency: Currency
    
    var body: some View {
        LazyVGrid(columns: gridLayout) {
            ForEach(0..<6) { index in
                if Currency.allCases[index] == currency {
                    CurrencyIcon(currencyImage: CurrencyImage.allCases[index].rawValue, currencyText: CurrencyText.allCases[index].rawValue)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3)
                            .opacity(0.5))
                        .shadow(color: .black, radius: 9)
                } else {
                    CurrencyIcon(currencyImage: CurrencyImage.allCases[index].rawValue, currencyText: CurrencyText.allCases[index].rawValue)
                        .onTapGesture {
                            currency = Currency.allCases[index]
                        }
                }
            }
        }
        .padding([.bottom, .leading, .trailing])
    }
}

#Preview {
    IconGrid(currency: .constant(.silverPiece))
}
