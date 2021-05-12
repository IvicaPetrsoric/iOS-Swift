//
//  VideoDetailView.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 12/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct VideoDetailView: View {
    
    var video: Video
    
    var body: some View {
        VStack (spacing: 20) {
            Spacer()

            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(12)
            
            Text(video.title)
                .font(.title)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                if #available(iOS 14.0, *) {
                    Label("\(video.viewCount)", systemImage: "eye.fill")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(video.title)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(video.description)
                .font(.body)
                .padding()
            
            Spacer()
            
            if #available(iOS 14.0, *) {
                Link(destination: video.url, label: {
                    StandardButton(title: "Watch now")
                })
            }
            
            Spacer()            
        }
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(video: VideoList.topTen.first!)
    }
}

struct StandardButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .bold()
            .font(.title)
            .frame(width: 280, height: 50)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
