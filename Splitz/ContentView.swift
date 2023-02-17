//
//  ContentView.swift
//  Splitz
//
//  Created by Justin Hold on 2/16/23.
//

import SwiftUI

struct ContentView: View {
	
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = [10, 15, 18, 20, 75, 100, 0]
	
	let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(
		code: Locale.current.currency?.identifier ?? "USD"
	)
	
	var grandTotal: Double {
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection
		return checkAmount + tipValue
	}
	
	var totalPerPerson: Double {
		grandTotal / Double(numberOfPeople + 2)
	}
	
	var body: some View {
		
		ZStack {
			
			NavigationStack {
				
				Form {
					
					Section("Check Amount & Number of People") {
						TextField("Check Amount", value: $checkAmount, format: localCurrency)
							.keyboardType(.decimalPad)
							.focused($amountIsFocused)
						Picker("Number of people", selection: $numberOfPeople) {
							ForEach(2..<100, id: \.self) {
								Text("\($0) people")
							}
						}
					}
					
					
					Section("Good Karma") {
						Picker("Tip Percent", selection: $tipPercentage) {
							ForEach(tipPercentages, id: \.self) {
								Text($0, format: .percent)
							}
						}
						.pickerStyle(MenuPickerStyle())
					}
					
					
					Section("Total Amount") {
						Text(grandTotal, format: localCurrency)
							.foregroundColor(tipPercentage == 0 ? .red : .primary)
					}
					
					
					Section("Amount Per Person") {
						Text(totalPerPerson, format: localCurrency)
					}
				}
				
				.navigationTitle("Splitz")
				
				// MARK: DONE KEYBOARD BUTTON
				.toolbar {
					ToolbarItemGroup(placement: .keyboard) {
						Spacer()
						Button("Done") {
						amountIsFocused = false
						}
						.padding()
					}
				}
				// MARK: TRASH ICON, RESET ALL INPUT/OUTPUT
				.toolbar {
					Button {
						reset()
					} label: {
						Label("Reset", systemImage: "trash.fill")
					}
					.padding()
				}
			}
		}
	}
	
	func reset() {
		checkAmount = 0.0
		numberOfPeople = 2
		tipPercentage = 20
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

