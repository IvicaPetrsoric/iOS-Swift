//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI


struct StartView: View {
    
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showAlerSheet = false
    
    var body: some View {
        VStack {
            Image(systemName: monitor.isConnected ? "wifi" : "wifi.slash")
                .font(.system(size: 56))
            
            Text(monitor.isConnected ? "Connected" : "Not connected")
                .padding()
            
            Button("Perform Netwrok request") {
                self.showAlerSheet = true
            }
        }.alert(isPresented: $showAlerSheet, content: {
            if monitor.isConnected {
                return Alert(title: Text("Success"), message: Text("Toster"), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("NOT Success"), message: Text("Toster 2"), dismissButton: .default(Text("CANCEL")))
            }
        })
        
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}

