//
//  Grid.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 17/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: self.items.count, in: geometry.size)
            ForEach(items) { item in
                if let index = items.firstIndex(matching: item)  {
                    self.viewForItem(item)
                        .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                        .position(layout.location(ofItemAt: index))
                }
            }
        }
    }
    
//    func index(of item: Item) -> Int?  {
//        for index in 0..<items.count {
//            if items[index].id == item.id {
//                return index
//            }
//        }
//        return nil
//    }
}



//struct Grid_Previews: PreviewProvider {
//    static var previews: some View {
//        Grid()
//    }
//}
