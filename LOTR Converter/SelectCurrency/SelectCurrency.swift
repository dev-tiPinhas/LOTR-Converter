//
//  SelectCurrency.swift
//  LOTR Converter
//
//  Created by Tiago Pinheiro on 20/10/2023.
//

import SwiftUI

struct SelectCurrency: View {
    
    @Binding var leftCurrency: Currency
    @Binding var rightCurency: Currency
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .background(.brown)
            
            VStack {
                Text("Select the currency you are starting with:")
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                
                IconGrid(currency: $leftCurrency)
                
                Text("Select the currency you would like to convert to:")
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.center)
                
                IconGrid(currency: $rightCurency)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                .background(.brown)
                .cornerRadius(15)
            }
        }
    }
}

#Preview {
    SelectCurrency(
        leftCurrency: .constant(.silverPiece),
        rightCurency: .constant(.goldPiece)
    )
}
