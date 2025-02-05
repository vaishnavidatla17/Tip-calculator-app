//
//  ContentView.swift
//  tip calculator app
//
//  Created by Datla, Vaishnavi on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    
    // State variables for user inputs
    @State private var billAmount: Double = 305.0
    @State private var tipPercentage: Double = 17.0
    @State private var numberOfPeople: Int = 1
    @State private var selectedCurrency: String = "USD"
    @State private var showResults = false
    
    // Currency options
    let currencies = ["USD", "EUR", "GBP", "AUD", "INR"]
    
    // Computed properties to calculate tip, total, and amount per person
    var tipAmount: Double {
        return billAmount * (tipPercentage / 100)
    }
    
    var totalAmount: Double {
        return billAmount + tipAmount
    }
    
    var amountPerPerson: Double {
        return totalAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        VStack {
            Text("Modern Tip Calculator")
                .font(.largeTitle)
                .bold()
            
            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.black)
                .padding(.top)
            
            // Currency selector
            Picker("Select Currency", selection: $selectedCurrency) {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency)
                        .tag(currency)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Bill amount slider
            VStack {
                Text("Bill Amount")
                    .font(.headline)
                Text("\(selectedCurrency) \(billAmount, specifier: "%.2f")")
                    .font(.subheadline)
                    .padding(.bottom)
                Slider(value: $billAmount, in: 0...1000, step: 1)
                    .accentColor(.purple)
            }
            .padding()
            
            // Tip percentage slider
            VStack {
                Text("Tip Percentage")
                    .font(.headline)
                Text("\(Int(tipPercentage))%")
                    .font(.subheadline)
                    .padding(.bottom)
                Slider(value: $tipPercentage, in: 0...30, step: 1)
                    .accentColor(.green)
            }
            .padding()
            
            // Number of people slider
            VStack {
                Text("Number of People")
                    .font(.headline)
                Text("\(numberOfPeople)")
                    .font(.subheadline)
                    .padding(.bottom)
                Slider(value: Binding(
                    get: { Double(numberOfPeople) },
                    set: { numberOfPeople = Int($0) }
                ), in: 1...10, step: 1)
                    .accentColor(.orange)
            }
            .padding()
            
            // Calculate button
            Button(action: {
                withAnimation {
                    showResults.toggle()
                }
            }) {
                Text("Calculate")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            // Results View (animated)
            if showResults {
                VStack {
                    Text("Tip: \(selectedCurrency) \(tipAmount, specifier: "%.2f")")
                        .font(.headline)
                    Text("Total: \(selectedCurrency) \(totalAmount, specifier: "%.2f")")
                        .font(.headline)
                    Text("Amount per Person: \(selectedCurrency) \(amountPerPerson, specifier: "%.2f")")
                        .font(.headline)
                }
                .transition(.scale)
                .padding(.top)
            }
        }
        .padding()
        .animation(.easeInOut(duration: 0.5), value: showResults)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
