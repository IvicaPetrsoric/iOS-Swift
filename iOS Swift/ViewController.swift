//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct LineGraph: Shape {
    // normalization data points between 0 and 1
    var dataPoints: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (1 - point) * rect.height
            
            return CGPoint(x: x, y: y)
        }
        
        return Path { p in
            guard dataPoints.count > 1 else { return }
            
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: ( 1 - start) * rect.height))
            
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
    
    
}

struct ChartLoader: View {
    
    @State var isAtMaxScale = false
    
    private let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
    
    private let maxScale: CGFloat = 1
    
    var body: some View {
        VStack {
            Text("Loading")
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue)
                .frame(width: UIScreen.main.bounds.width / 2, height: 30)
                .scaleEffect(CGSize(width: isAtMaxScale ? maxScale : 0.01, height: 1.0))
                .onAppear {
                    withAnimation(animation) {
                        isAtMaxScale.toggle()
                    }
                }
        }
    }
    
}

final class ChartViewModel: ObservableObject {
    @Published var chartData = [CGFloat]()
    
    func loadData(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.chartData = ChartMockData.oneMonth.normalized
            completion()
        }
    }
}

struct StartView: View {
    
    @ObservedObject var viewModel = ChartViewModel()
    
    @State private var animateChart = false
    @State private var showLoader = false
    
    
    var body: some View {
        ZStack {
            //        LineGraph(dataPoints: [0, 0.1, 0.2, 0.3, 0.6, 1])
//            LineGraph(dataPoints: ChartMockData.oneMonth.normalized)
            LineGraph(dataPoints: viewModel.chartData)
                .trim(to: animateChart ? 1 : 0)
                .stroke(Color.blue)
                .frame(width: 400, height: 300)
                .onAppear {
                    showLoader = true
                    
                    viewModel.loadData {
                        showLoader = false
                        withAnimation(.easeInOut(duration: 2)) {
                            animateChart = true
                        }
                    }
                    

                }
            if showLoader {
                ChartLoader()
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

extension Array where Element == CGFloat {
    /// rettunrs elements of sequence normalized
    var normalized: [CGFloat] {
        if let min = self.min(), let max = self.max() {
            return self.map { ($0 - min) / (max - min) }
        }
        
        return []
    }
}
