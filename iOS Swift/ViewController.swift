//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

protocol ChartDataProvider {
    var percentage: Double { get }
    var description: String { get }
    var color: Color { get }
}


protocol ChartViewModel: ObservableObject {
    var data: [ChartDataProvider] { get }
}

enum Asset {
    case equity
    case cash
    case bond
    case realEstate
}


struct CarPreference: ChartDataProvider {
    let percentage: Double
    let description: String
    let color: Color
}

struct AssetAllocation: ChartDataProvider {
    let asset: Asset
    let percentage: Double
    let description: String
    let color: Color
}

final class AssetViewModel: ChartViewModel {
    
    @Published var data: [ChartDataProvider] = [
        AssetAllocation(asset: .cash, percentage: 0.1, description: "Cash", color: Color.gray),
        AssetAllocation(asset: .equity, percentage: 0.4, description: "Stocks", color: Color.blue),
        AssetAllocation(asset: .bond, percentage: 0.3, description: "Bonds", color: Color.red),
        AssetAllocation(asset: .realEstate, percentage: 0.2, description: "Real Estate", color: Color.green)
    ]
    
}

final class CarsViewModel: ChartViewModel {
    
    @Published var data: [ChartDataProvider] = [
        CarPreference(percentage: 0.3, description: "BMW", color: Color.gray),
        CarPreference(percentage: 0.4, description: "Audi", color: Color.blue),
        CarPreference(percentage: 0.3, description: "Toyota", color: Color.red),

    ]
    
}

// Views
struct PieceOfPie: Shape {
    
    let startDegree: Double
    let endDegree: Double
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            p.move(to: center)
            p.addArc(center: center, radius: rect.width / 2,
                     startAngle: Angle(degrees: startDegree),
                     endAngle: Angle(degrees: endDegree),
                     clockwise: false)
            p.closeSubpath()
            
        }
    }
    
}

struct PieChart<T>: View where T: ChartViewModel {
    
    @ObservedObject var viewModel: T
    @State var selectedPieChartElement: Int? = nil
    let action: ((ChartDataProvider) -> Void)?
    
    var body: some View {
        ZStack {
            
            ForEach(0..<viewModel.data.count) { index in
                let currentData = viewModel.data[index]
                let currentEndDegree = currentData.percentage * 360
                let lastDegree = viewModel.data.prefix(index).map { $0.percentage }.reduce(0, +) * 360
                
                ZStack {
                    PieceOfPie(startDegree: lastDegree, endDegree: lastDegree + currentEndDegree)
                        .fill(currentData.color)
                        .scaleEffect(index == selectedPieChartElement ? 1.2 : 1.0)
                    
                    GeometryReader { geometry in
                        Text(currentData.description)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .position(getLabelCoordinate(in: geometry.size, for: lastDegree + currentEndDegree / 2))
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if index == selectedPieChartElement {
                            selectedPieChartElement = nil
                        } else {
                            selectedPieChartElement = index
                            action?(currentData)
                        }
                    }
                }
                
            }
        }
    }
    
    private func getLabelCoordinate(in geoSize: CGSize, for degree: Double) -> CGPoint {
        let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
        
        // move it a bit closer to ther center
        let radius = geoSize.width / 3
        
        let yCoordinate = radius * sin(CGFloat(degree) * (CGFloat.pi / 180))
        let xCoordinate = radius * cos(CGFloat(degree) * (CGFloat.pi / 180))
        
        return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
    }
}

struct StartView: View {
    
    var body: some View {
        VStack {
            PieChart(viewModel: CarsViewModel()) { carData in
                print(carData.description)
            }
                .frame(width: 300, height: 300)
            
            PieChart(viewModel: AssetViewModel()) { assetsData in
                print(assetsData.description)

            }
                .frame(width: 300, height: 300)
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
