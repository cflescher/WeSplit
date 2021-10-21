// ContentView.swift 
// WeSplit-LBST
// Created on 10/18/21 by Conrad Flescher.
// Copyright 2021 Conrad Flescher. All rights reserved.

import SwiftUI

struct ContentView: View {
    //default values
    @State private var checkAmount: Double = 0.0
    @State private var personCount = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var individualTotal: Double {
        //the `+ 2` is required because the button *values* start at 2, but the
        //button *indexes* start at 0.
        let peopleCount = Double(personCount + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              //tells system to not accept inputs that cannot be
                              //converted to the user's locale's currency
                              format: .currency(
                                code: Locale.current.currencyCode ?? "USD"
                              ))
                        .keyboardType(.decimalPad)
                    
                    Text(individualTotal,
                              format: .currency(
                                code: Locale.current.currencyCode ?? "USD"
                              ))
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                
                
                Section {
                    Picker("Number of people", selection: $personCount) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
            }
            .navigationTitle("LBST App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
