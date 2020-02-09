//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct Post {
    let id: Int
    let username, text, imageName: String
}

struct ContentView: View {
    
    let posts: [Post] = [
    .init(id: 0, username: "Hillary Clinton", text: "Good old Bill up to his usual wazs and dirty tricks", imageName: "burger"),
    .init(id: 1, username: "Hillary Clinton", text: "Good old Bill up to his usual wazs and dirty tricks", imageName: "burger")
    ]
    
    var body: some View {
        NavigationView {
            List {
                VStack (alignment: .leading) {
                    Text("Trending")
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                NavigationLink(destination: GroupDetailView()) {
                                    GroupView()
                                }
                                                                
                                GroupView()
                                GroupView()
                                GroupView()
                                GroupView()
                            }
                        }
                    }.frame(height: 200)
                }

                // post rows
                ForEach(posts, id: \.id) { post in
                    PostView(post: post)
                }
            }.navigationBarTitle("Groups")
        }
    }
}

struct GroupDetailView: View {
    var body: some View {
        Text("Gruop Detail View")
    }
}

struct GroupView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Image("hike").renderingMode(.original).cornerRadius(8)
            Text("Co-ED Hikes to Colorado")
                .padding(.leading, 8)
        }.frame(width: 110, height: 170)
    }
}

struct PostView: View {
    
    let post: Post
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack {
                Image(post.imageName)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .clipped()
                VStack (alignment: .leading) {
                    Text(post.username).font(.headline)
                    Text("Posted 8 hrs ago").font(.subheadline)
                }.padding(.leading, 8)
            }.padding(.leading, 16).padding(.top, 16)
            
            Text("Post body text that will hopefully support auto sizign vertically and span multiple lines").padding(.leading, 16).padding(.trailing, 32)
            Image("post_puppy").scaledToFill().frame(height: 350).clipped()
        }.padding(.leading, -20).padding(.bottom, -8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
