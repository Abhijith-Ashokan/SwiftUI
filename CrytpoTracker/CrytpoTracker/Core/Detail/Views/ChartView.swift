//
//  ChartView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 04/04/24.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let minY: Double
    private let maxY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var trimPercentage: CGFloat = 0
    
    init(coin: Coin) {
        data = coin.sparklineIn7D?.price ?? []
        minY = data.min() ?? 0
        maxY = data.max() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoDateString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    //MATH FOR DUMMIES:
    /*
     x Position:
         Say, screenwidth = 300 & data items = 100
         Each item would have x = 300/100 = 3
         Multiply it by (index + 1)
         
         eg : First data point  = 3 * 1 = 3
              Second data point = 3 * 2 = 6
                .
                .
              100th data point  = 3 * 100 = 300
     
     y Position:
         Say, max data = 60,000, min data = 50,000
         Y Axis = 60,000 - 50,000 = 10,000
         Let data point = 52,000
         y = 52,000 - 50,000 = 2000 / 10,000 = 20%
     
     Note : Coordinate system in iOS has (0,0) starting from top-left corner. Hence add (1 - y Position) to inverse it to bottom left
     */
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(
                    chartBackground
                )
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    trimPercentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    
    private var chartView : some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: trimPercentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.8), radius: 5, x: 0, y: withAnimation(.linear(duration: 1.0)) { trimPercentage * 5 }) 
            .shadow(color: lineColor.opacity(0.6), radius: 8, x: 2, y: withAnimation(.linear(duration: 1.0)) { trimPercentage * 8 })
            .shadow(color: lineColor.opacity(0.4), radius: 10, x: 4, y: withAnimation(.linear(duration: 1.0)) { trimPercentage * 10 })

        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY)/2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
