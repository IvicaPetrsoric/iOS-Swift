//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var pickesSelectedItem = 0
    
    @State var dataPoints: [[CGFloat]] = [
        [50, 100, 150, 50, 100, 50, 80, 80],
        [150, 200, 75, 88, 150, 5, 99, 44],
        [10, 170, 30, 45, 200, 96, 50, 188],
    ]
    
    var body: some View {
        ZStack {
            
//            #colorLiteral(red: 0.4604585767, green: 0.9579809308, blue: 0.7676670551, alpha: 1)
            Color("appBackground").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Calory Intake")
                    .font(.system(size: 34))
                    .fontWeight(.heavy)
                
                Picker(selection: $pickesSelectedItem, label: Text("")) {
                    Text("Weekday").tag(0)
                    Text("Afternoon").tag(1)
                    Text("Evening").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 24)
                
                HStack (spacing: 16) {
                    BarView(value: dataPoints[pickesSelectedItem][0])
                    BarView(value: dataPoints[pickesSelectedItem][1])
                    BarView(value: dataPoints[pickesSelectedItem][2])
                    BarView(value: dataPoints[pickesSelectedItem][4])
                    BarView(value: dataPoints[pickesSelectedItem][5])
                    BarView(value: dataPoints[pickesSelectedItem][6])
                    BarView(value: dataPoints[pickesSelectedItem][7])
                }.padding(.top, 24)
                    .animation(.default)
            }
        }

    }
}

struct BarView: View {
    
    var value: CGFloat
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                Capsule().frame(width: 30, height: 200)
                    .foregroundColor(Color(#colorLiteral(red: 0.3883108497, green: 0.8996652961, blue: 0.7139849067, alpha: 1)))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(.white)
            }
            
            Text("D").padding(.top, 8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

