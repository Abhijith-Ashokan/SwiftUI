//
//  UIApplication.swift
//  CrytpoTracker
//
//  Created by Abhijith on 11/03/24.
//

import SwiftUI

extension UIApplication {
    
    //Dismiss the Keyboard
    func endEditing() {
        sendAction(#selector(UIResponder().resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
