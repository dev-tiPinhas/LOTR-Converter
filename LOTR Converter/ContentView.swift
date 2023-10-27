//
//  ContentView.swift
//  LOTR Converter
//
//  Created by Tiago Pinheiro on 20/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var leftAmount = ""
    @State var rightAmount = ""
    @State var leftAmountTemp = ""
    @State var rightAmountTemp = ""
    @State var leftTyping = false
    @State var rightTyping = false
    @State var leftCurrency: Currency = Currency(rawValue: UserDefaults.standard.double(forKey: SelectedCurrencyType.leftCurrency.rawValue)) ?? .silverPiece
    @State var rightCurrency: Currency = Currency(rawValue: UserDefaults.standard.double(forKey: SelectedCurrencyType.rightCurrency.rawValue)) ?? .goldPiece
    @State var showSelectCurrency = false
    @State var showExchangeInfo = false
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                HStack {
                    // Left
                    CurrentSection(
                        showSelectCurrency: $showSelectCurrency,
                        currency: $leftCurrency,
                        amount: $leftAmount,
                        amountTemp: $leftAmountTemp,
                        istyping: $leftTyping,
                        oppositeCurrency: $rightCurrency,
                        oppositeAmount: $rightAmount) { currency in
                            UserDefaults.standard.set(currency.rawValue, forKey: SelectedCurrencyType.leftCurrency.rawValue)
                        }
                    
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    
                    // Right
                    CurrentSection(
                        showSelectCurrency: $showSelectCurrency,
                        currency: $rightCurrency,
                        amount: $rightAmount,
                        amountTemp: $rightAmountTemp,
                        istyping: $rightTyping,
                        oppositeCurrency: $leftCurrency,
                        oppositeAmount: $leftAmount) { currency in
                            UserDefaults.standard.set(currency.rawValue, forKey: SelectedCurrencyType.rightCurrency.rawValue)
                        }
                }
                .padding()
                .background(.black.opacity(0.5))
                .cornerRadius(40)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.trailing)
                    .sheet(isPresented: $showExchangeInfo) {
                        ExchangeInfo()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
