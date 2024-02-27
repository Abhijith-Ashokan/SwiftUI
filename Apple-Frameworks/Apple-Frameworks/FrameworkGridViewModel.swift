//
//  FrameworkGridViewModel.swift
//  Apple-Frameworks
//
//  Created by Aoole on 27/02/24.
//

import Foundation

final class FrameworkGridViewModel: ObservableObject {
    
    var selectedFramework: Framework? {
        didSet {
            isShowingDetailView = true
        }
    }
    @Published var isShowingDetailView = false
    
}
