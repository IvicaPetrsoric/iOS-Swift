//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct VideoListView: View {
    
    var videos: [Video] = VideoList.topTen
    
    var body: some View {
        NavigationView {
            List(videos, id: \.id) { video in
                NavigationLink(destination: VideoDetailView(video: video),
                   label: {
                        VideoCell(video: video)
                   })
            }
            .navigationBarTitle("Sean's Top 10")
        }
    }
    
}


struct VideoCell: View {
    
    var video: Video
    
    var body: some View {
        HStack {
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 78)
                .cornerRadius(4)
                .padding(.vertical, 4)
            
            VStack (alignment: .leading, spacing: 5 ){
                Text(video.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoListView()
        }
    }
}
