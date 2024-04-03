//
//  HomeStatisticsView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 11/03/24.
//

import SwiftUI

struct HomeStatisticsView: View {
    
    @Binding var showPortFolio: Bool
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticsView(stat: stat)
                    .frame(width: (UIScreen.main.bounds.width / 3))
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortFolio ? .trailing : .leading)
    }
}

struct HomeStatisticsViewPreviews: PreviewProvider  {
    static var previews: some View {
        HomeStatisticsView(showPortFolio: .constant(false)) .environmentObject(DeveloperPreview.instance.homeVM)
    }
}

