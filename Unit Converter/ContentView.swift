//
//  ContentView.swift
//  Unit Converter
//
//  Created by David Ilenwabor on 12/10/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import SwiftUI

enum UnitTypes : String{
    case time = "Time"
    case length = "Length"
}

enum Time : String{
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    
    case metre = "Metre"
    case kilometer = "Kilometer"
    case centimetre = "Centimeter"
}

struct UnitModel : Identifiable{
    var id: ObjectIdentifier{
        return ObjectIdentifier(AnyClass.self)
    }
    
    var name : [String]
    var conversionToBaseRate : Double
    init(name : [String], conversionToBaseRate : Double) {
        self.name = name
        self.conversionToBaseRate = conversionToBaseRate
    }
}

struct ContentView: View {
    var units : [UnitTypes] = [.time, .length]
    @State private var currentIndex : Int = 0
    @State private var currentUnitIndex : Int = 0
    @State private var currentTargetIndex : Int = 0
    @State private var quantity = ""
    
    private var convertedAmount : String{
        let amountToBeConverted = Double(quantity) ?? 0.0
        let source = unitsToConvert[currentUnitIndex]
        let target = unitsToConvert[currentTargetIndex]
        switch units[currentIndex]{
        case .time:
            switch (source, target){
            case (.seconds, .seconds):
                return "\(amountToBeConverted)"
            case (.seconds, .minutes):
                return "\(amountToBeConverted/60)"
            case (.seconds, .hours):
                return "\(amountToBeConverted/3600)"
            case (.minutes, .seconds):
                return "\(amountToBeConverted * 60)"
            case (.minutes, .minutes):
                return "\(amountToBeConverted)"
            case (.minutes, .hours):
                return "\(amountToBeConverted/60)"
            case (.hours, .seconds):
                return "\(amountToBeConverted * 3600)"
            case (.hours, .minutes):
                return "\(amountToBeConverted * 60)"
            case (.hours, .hours):
                return "\(amountToBeConverted)"
            default:
                print("Nothing")
            }
        case .length:
            switch (source, target){
            case (.metre, .metre):
                return "\(amountToBeConverted)"
            case (.metre, .centimetre):
                return "\(amountToBeConverted * 100)"
            case (.metre, .kilometer):
                return "\(amountToBeConverted/1000)"
            case (.kilometer, .metre):
                return "\(amountToBeConverted * 1000)"
            case (.kilometer, .kilometer):
                return "\(amountToBeConverted)"
            case (.kilometer, .centimetre):
                return "\(amountToBeConverted * 100_000)"
            case (.centimetre, .metre):
                return "\(amountToBeConverted / 100)"
            case (.centimetre, .kilometer):
                return "\(amountToBeConverted / 100_000)"
            case (.centimetre, .centimetre):
                return "\(amountToBeConverted)"
            default:
                print("Nothing")
            }
        }
        return ""
    }
    
    private var unitsToConvert : [Time]{
        let time : [[Time]] = [[.seconds, .minutes, .hours], [.centimetre, .metre, .kilometer]]
//        let temp = [("Celsius",Time.seconds), ("Fahrenheit",Time.seconds), ("Kelvin",Time.seconds)]
        return time[currentIndex]
    }
    
    var body: some View {
        NavigationView{
            Form{
//                Section(header: Text("Please select a unit").foregroundColor(.blue)){
                Section{
                    Picker("Select Unit To Convert", selection: $currentIndex){
                        ForEach (0 ..< units.count){
                            Text("\(self.units[$0].rawValue)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    
                    TextField("Enter conversion", text: $quantity).keyboardType(.decimalPad)
                    
                    Picker("Convert \(quantity)", selection: $currentUnitIndex){
                        ForEach (0 ..< self.unitsToConvert.count){
                            Text("\(self.unitsToConvert[$0].rawValue)")
                        }
                    }
                }
                
                Section{
                    Picker("To", selection: $currentTargetIndex){
                        ForEach (0 ..< self.unitsToConvert.count){
                            Text("\(self.unitsToConvert[$0].rawValue)")
                        }
                    }
                }
                
                Section(header : Text("Result").foregroundColor(.red)){
                    Text("\(convertedAmount)")
                }
                
            }.navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
