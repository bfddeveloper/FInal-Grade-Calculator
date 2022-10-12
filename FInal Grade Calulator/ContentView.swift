//
//  ContentView.swift
//  FInal Grade Calulator
//
//  Created by Brody Dickson on 9/23/22.
//

import SwiftUI

struct ContentView: View {
    @State var currentGradeTextField = ""
    @State var finalWeightTextField = ""
    @State var desiredGrade = 0.0
    @State var requiredGrade = 0.0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .fill(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0))
                .frame(width: 700, height: 1100, alignment: .center)
            VStack {
                Spacer()
                Customtext(text: "Final Grade Calculator")
                    .padding()
                CustomTextField(placeholder: "Current Grade", variable: $currentGradeTextField)
                    .frame(width: 250, height: 75, alignment: .center)
                CustomTextField(placeholder: "Final Wieght", variable: $finalWeightTextField)
                    .frame(width: 250, height: 75, alignment: .center)
                    .padding()
                Customtext(text: "Required Grade on Final")
                    
                Customtext(text: String(round(requiredGrade * 100) / 100.0))
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .frame(width: 200, height: 30, alignment: .center)
                Picker("Desire Semester Grade", selection:  $desiredGrade){
                    Text("A").tag(90.0)
                    Text("B").tag(80.0)
                    Text("C").tag(70.0)
                    Text("D").tag(60.0)
                }
                .frame(minWidth: 150, idealWidth: 300, maxWidth: 400, minHeight: 50, idealHeight: 100, maxHeight: 175, alignment: .center)
                .onChange(of: desiredGrade, perform: { newValue in calculateGrade()
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Spacer()
            }
        }
    }
    
    func calculateGrade() {
        if let currentGRade = Double(currentGradeTextField){
            if let finalweight = Double(finalWeightTextField){
                
                if finalweight < 100 && finalweight > 0 {
                    let finalpercentage = finalweight / 100.0
                    requiredGrade = max(0.0, (desiredGrade - (currentGRade * (1.0 - finalpercentage))) / finalpercentage )
                }
            }
        }
    }
}
    struct CustomTextField: View {
        let placeholder : String
        let variable : Binding<String>
        var body: some View {
            TextField(placeholder, text: variable)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 60, alignment: .center)
                .font(.body)
                .padding()  
        }
        
    }

struct Customtext: View {
    let text : String
    var body: some View {
        Text(text)
            .font(.title)
            .frame(width: 450, height: 50, alignment: .top)
            .multilineTextAlignment(.center)
    }
}
    





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
