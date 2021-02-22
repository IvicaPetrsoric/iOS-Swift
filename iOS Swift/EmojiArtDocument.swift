//
//  EmojiArtDocument.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 21/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI
import Combine

class EmojiArtDocument: ObservableObject {
    
    static let palette: String = "🦙🦛🦨🦧☁︎"
    
//    @Published private var emojiArt: EmojiArt {
//        willSet {
////            objectWillChange.send()
//        }
//        didSet {
////            print("json =\(emojiArt.json?.utf8 ?? "nil")")
//
//        }
//    }
    
    @Published private var emojiArt: EmojiArt
    
    private static let untitled = "EmojiArtDocument.Untitled"
    
    private var autosaveCancellabe: AnyCancellable?
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        autosaveCancellabe = $emojiArt.sink { emojiArt in
            print("\(emojiArt.json?.utf8 ?? "nil")")
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
        fetchBackgroundImageData()
    }
    
    @Published private(set) var backgroundImage: UIImage?
    

    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    //MARK: - Intents
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    var backgroundURL: URL? {
        get {
            emojiArt.backgroundURL
        } set {
            emojiArt.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }
    
    private var fetcImageCancelable: AnyCancellable?

    private func fetchBackgroundImageData() {
        backgroundImage = nil
        
        if let url = self.emojiArt.backgroundURL {
//            DispatchQueue.global(qos: .userInitiated).async {
//                if let imageData = try? Data(contentsOf: url) {
//                    if url == self.emojiArt.backgroundURL {
//                        DispatchQueue.main.async {
//                            self.backgroundImage = UIImage(data: imageData)
//                        }
//                    }
//                }
//            }
            
            fetcImageCancelable?.cancel()
            fetcImageCancelable = URLSession.shared.dataTaskPublisher(for: url)
                .map {data, urlResponse in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                .assign(to: \.backgroundImage, on: self)
            
        }
    }
    

}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}


