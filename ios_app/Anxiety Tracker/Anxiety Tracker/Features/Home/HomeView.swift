//
//  HomeView.swift
//  Anxiety Tracker
//
//  Created by Joshua Colley on 05/09/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var state: HomeState = HomeState()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(state.connectionStatus)
//                Text("SwiftUI")
//                Button(action: state.action, label: {
//                    Text("Action!")
//                })
            }
        }.onAppear {
            self.state.startScanning()
        }
    }
}

struct HomeView_Previewsr: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
