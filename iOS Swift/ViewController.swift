//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct Layer {
    let id = UUID()
    let name: String
    let backgroundColor: Color
    
    static var layerCounter = 0
    static func assingNextLayerName() -> String {
        layerCounter += 1
        return "Layer \(layerCounter)"
    }
    
    init(backgroundColor: Color, name: String = assingNextLayerName()) {
        
        self.backgroundColor = backgroundColor
        self.name = name
    }
}

class GraphicEditor: ObservableObject {
    @Published var layers = [
        Layer(backgroundColor: Color.blue.opacity(0.8), name: "Blue Card"),
        Layer(backgroundColor: Color.green.opacity(0.8), name: "Green Card"),
        Layer(backgroundColor: Color.orange.opacity(0.8), name: "Orange Card"),
        Layer(backgroundColor: Color.black.opacity(0.8), name: "Black Card"),
    ]
    
    func moveLayers(fromOffset source: IndexSet, toOffset destination: Int) {
        if let start = source.first?.distance(to: layers.count - 1) {
            var correctDestination = (layers.count - 1 - destination)
            correctDestination += (correctDestination < start) ? 1 : 0
            let removeCard = layers.remove(at: start)
            layers.insert(removeCard, at: correctDestination)
        }
    }
}

struct LayerView: View  {
    
    let layer: Layer
    
    @State private var dragOffset: CGSize = .zero
    @State private var lastPosition: CGSize = .zero
    
    var body: some View {
        Rectangle()
            .fill(layer.backgroundColor)
            .cornerRadius(20)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 400)
            .offset(x: lastPosition.width + dragOffset.width,
                    y: lastPosition.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        dragOffset = value.translation
                    }).onEnded({ (value) in
                        lastPosition.width += value.translation.width
                        lastPosition.height += value.translation.height
                        dragOffset = .zero
                    })
            )
            
    }
}

struct LayerNavigatior: View {
    
    var layers: Binding<[Layer]>
    var onChange: ((IndexSet, Int) -> Void)?
    
    init(layers: Binding<[Layer]>) {
        self.layers = layers
        UITableView.appearance().isScrollEnabled = false
    }
    
    var body: some View {
        List {
            HStack {
                Text("Layers ")
                Spacer()
                Text("*")
            }
            .foregroundColor(.white)
            .listRowBackground(Color.blue.opacity(0.7))
            
            ForEach(layers.wrappedValue.reversed(), id: \.id) { layer in
                Text("\(layer.name)")
                    .font(.title)
            }.onMove(perform: move)
            .listRowBackground(Color.clear)
        }
        .frame(width: UIScreen.main.bounds.width - 40,
               height: CGFloat(layers.wrappedValue.count) * 60, alignment: .center)
        .fixedSize()
        .environment(\.editMode, .constant(.active))

    }
    
    func onChangingLayers(perform onChange: @escaping(_ source: IndexSet, _ destination: Int) -> Void) -> Self {
        var copy = self
        copy.onChange = onChange
        return copy
    }
    
    private func move(fromOffset source: IndexSet, toOffset destination: Int) {
        onChange?(source, destination)
    }
    
}

struct StartView: View {
    
    @ObservedObject var editor = GraphicEditor()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            
            ForEach(editor.layers, id: \.id) { layer in
                LayerView(layer: layer)
                    .onTapGesture(count: 2) {
                        if layer.id != editor.layers.last!.id {
                            if let index = editor.layers.firstIndex(where: { $0.id == layer.id }) {
                                editor.layers.move(fromOffsets: IndexSet(integer: index), toOffset: editor.layers.count)
                            }
                        }
                    }
            }
            
            VStack {
                Spacer()
                LayerNavigatior(layers: $editor.layers).onChangingLayers { (IndexSet, destination) in
                    editor.moveLayers(fromOffset: IndexSet, toOffset: destination)
                }
            }
            
        }.edgesIgnoringSafeArea(.all)
//        LayerView()
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
