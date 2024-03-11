//
//  StatisticsView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 11/03/24.
//

import SwiftUI

struct StatisticsView: View {
    
    let stat: Statistics
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees:(stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.themeGreen : Color.themeRed)
            .opacity((stat.percentageChange != nil) ? 1.0 : 0.0)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView(stat: dev.sampleStat1)
                .previewLayout(.sizeThatFits)
            StatisticsView(stat: dev.sampleStat2)
                .previewLayout(.sizeThatFits)
            StatisticsView(stat: dev.sampleStat3)
                .previewLayout(.sizeThatFits)
        }
    }
}
