//
//  CurrentSection.swift
//  LOTR Converter
//
//  Created by Tiago Pinheiro on 27/10/2023.
//

import SwiftUI

struct CurrentSection: View {
    @Binding var showSelectCurrency: Bool
    
    @Binding var currency: Currency
    @Binding var amount: String
    @Binding var amountTemp: String
    
    @Binding var istyping: Bool
    
    @Binding var oppositeCurrency: Currency
    @Binding var oppositeAmount: String
    
    var completion: ((Currency) -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Image(CurrencyImage.allCases[Currency.allCases.firstIndex(of: currency)!].rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                
                Text(CurrencyText.allCases[Currency.allCases.firstIndex(of: currency)!].rawValue)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, -5)
            .onTapGesture {
                showSelectCurrency.toggle()
            }
            .sheet(isPresented: $showSelectCurrency) {
                SelectCurrency(leftCurrency: $currency, rightCurency: $oppositeCurrency)
            }
            
            TextField("Amount", text: $amount, onEditingChanged: { typing in
                istyping = typing
                amountTemp = amount
            })
                .padding(7)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(7)
                .keyboardType(.numberPad)
                .onChange(of: istyping ? amount : amountTemp, { oldValue, newValue in
                    oppositeAmount = currency.convert(amountString: newValue, to: oppositeCurrency)
                })
                .onChange(of: currency, { oldValue, newValue in
                    amount = oppositeCurrency.convert(amountString: oppositeAmount, to: currency)
                    // Change the current value stored on the UserDefaults
                    completion?(newValue)
                })
        }
    }
}

#Preview {
    CurrentSection(
        showSelectCurrency: .constant(true),
        currency: .constant(.silverPiece),
        amount: .constant(""),
        amountTemp: .constant(""),
        istyping: .constant(false),
        oppositeCurrency: .constant(.goldPenny),
        oppositeAmount: .constant(""),
        completion: nil
    )
    .previewLayout(.sizeThatFits)
    .preferredColorScheme(.dark)
}
