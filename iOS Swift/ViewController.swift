//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

//

struct Photo: Codable, Identifiable {
    let id: String
    let author: String
    let width, height: Int
    let url, download_url: URL
}

struct PhotoLoadingError: Error {
    
}

final class Remote<A>: ObservableObject {
    @Published var result: Result<A, Error>? = nil
    
    var value: A? {
        try! result?.get()
    }
    
    let url: URL
    let transform: (Data) -> A?
    
    init(url: URL, transform: @escaping (Data) -> A?) {
        self.url = url
        self.transform = transform
    }
    
    func load() {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                if let data = data, let v = self.transform(data) {
                    self.result = .success(v)
                } else {
                    self.result = .failure(PhotoLoadingError())
                }
            }
        }.resume()
    }
}

struct PhotoView: View {
    @ObservedObject var image: Remote<UIImage>
    
    init(_ url: URL) {
        self.image = Remote(url: url, transform: {
            UIImage(data: $0)
        })
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Group {
                if image.value == nil {
                    if #available(iOS 14.0, *) {
                        ProgressView()
                            .onAppear {
                                image.load()
                            }
                    } else {
                    }
                } else {
                    Image(uiImage: image.value!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }.navigationTitle("Photo")
        } else {
            // Fallback on earlier versions
        }
    }
}

struct StartView: View {
    
    @ObservedObject var items = Remote(url: URL(string: "https://picsum.photos/v2/list")!,
                                       transform: {
                                        try? JSONDecoder().decode([Photo].self, from: $0)
                                       })
    
    var body: some View {
        NavigationView {
            if items.value == nil {
                if #available(iOS 14.0, *) {
                    ProgressView()
                        .onAppear {
                            items.load()
                        }
                } else {
                    // Fallback on earlier versions
                }
            } else {
                if #available(iOS 14.0, *) {
                    List {
                        ForEach(items.value!){ photo in
                            NavigationLink(
                                destination: PhotoView(photo.download_url),
                                label: {
                                    Text(photo.author)
                                })
                        }
                    }.navigationTitle("Author")
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
