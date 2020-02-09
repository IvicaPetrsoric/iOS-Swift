//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("LBTA").padding(.all, 16).background(Color.purple)
                    Spacer().frame(height: 5).background(Color.red).padding(.leading, 8)
                }
                Spacer().frame(width: 5).background(Color.blue)
                HStack {
                    Spacer().frame(height: 5).background(Color.red).padding(.trailing, 8)
                    Text("LBTA").padding(.all, 16).background(Color.purple)
                }
                
            }.background(Color.yellow)
        }

        
        
//        HStack {
//            Text("LBTA")
//            Spacer()
//                .frame(height: 5).background(Color.green)
//            Text("LBTA")
//                .background(Color.red)
//        }.background(Color.blue)
                
//        VStack {
//            Text("LBTA").background(Color.red)
//            Spacer().frame(width: 10).background(Color.orange)
//            Text("LBTA LBTA").background(Color.red)
//        }.background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
