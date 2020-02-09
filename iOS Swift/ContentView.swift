//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.

import SwiftUI

struct ContentView: View {
    
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            
            NavigationView {
                VStack {
                    Button(action: {
                        withAnimation {
                            self.isPresented.toggle()
                        }
                    }, label: {
                        Text("Show standard model")
                    })
                }.navigationBarTitle("Standard")
//                .sheet(isPresented: $isPresented, content: {
//                    Button(action: {
//                        self.isPresented.toggle()
//                    }, label: {
//                        Text("Here is my modal")
//                    })
//                })
                
            }
            
            ZStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.isPresented.toggle()
                                }
                            }, label: {
                                Text("Dissmiss")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            })
                                
                            Spacer()
                            Text("X")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    withAnimation{
                                        self.isPresented.toggle()
                                    }
                            }
                                
                            }.padding(.top, UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top)
                        
                        Spacer()
                    }
                    Spacer()
                }
                
            }.background(Color.yellow)
                .edgesIgnoringSafeArea(.all)
                .offset(x: 0, y: self.isPresented ? 0 : UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.frame.height ?? 0)

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
