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
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurency: Currency = .goldPiece
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
                    VStack {
                        HStack {
                            Image(CurrencyImage.allCases[Currency.allCases.firstIndex(of: leftCurrency)!].rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            Text(CurrencyText.allCases[Currency.allCases.firstIndex(of: leftCurrency)!].rawValue)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(leftCurrency: $leftCurrency, rightCurency: $rightCurency)
                        }
                        
                        TextField("Amount", text: $leftAmount, onEditingChanged: { typing in
                            leftTyping = typing
                            leftAmountTemp = leftAmount
                        })
                            .padding(7)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(7)
                            .keyboardType(.numberPad)
                            .onChange(of: leftTyping ? leftAmount : leftAmountTemp, { oldValue, newValue in
                                rightAmount = leftCurrency.convert(amountString: leftAmount, to: rightCurency)
                            })
                            .onChange(of: leftCurrency, { oldValue, newValue in
                                leftAmount = rightCurency.convert(amountString: rightAmount, to: leftCurrency)
                            })
                    }
                    
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    
                    // Right
                    VStack {
                        HStack {
                            Text(CurrencyText.allCases[Currency.allCases.firstIndex(of: rightCurency)!].rawValue)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Image(CurrencyImage.allCases[Currency.allCases.firstIndex(of: rightCurency)!].rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(leftCurrency: $leftCurrency, rightCurency: $rightCurency)
                        }
                        
                        TextField("Amount", text: $rightAmount, onEditingChanged: { typing in
                            rightTyping = typing
                            rightAmountTemp = rightAmount
                        })
                            .padding(7)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(7)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .onChange(of: rightTyping ? rightAmount : rightAmountTemp, { oldValue, newValue in
                                rightAmount = rightCurency.convert(amountString: rightAmount, to: leftCurrency)
                            })
                            .onChange(of: rightCurency, { oldValue, newValue in
                                rightAmount = leftCurrency.convert(amountString: leftAmount, to: rightCurency)
                            })
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
