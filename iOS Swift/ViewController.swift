//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    @State private var showPhotoLibrary = false
    @State var image: Image?
    
    var body: some View {
        ZStack {
            image?
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
//                Button()
                Button(action:  {
                    showPhotoLibrary = true
                }) {
                    HStack {
                        Image(systemName: "photo")
                            .font(.system(size: 20))
                        Text("Choose Photo")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }.sheet(isPresented: $showPhotoLibrary, content: {
            PhotoPicker(isPresented: $showPhotoLibrary, selectedImage: $image)
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
