//
//  ContentView.swift
//  AnalogClockApp
//
//  Created by Ramill Ibragimov on 08.09.2020.
//

import SwiftUI

struct ContentView: View {
    @State var isDark = false
    
    var body: some View {
        
        NavigationView {
            
            Home(isDark: $isDark)
                .navigationBarHidden(true)
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
