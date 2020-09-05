//
//  HomeState.swift
//  Anxiety Tracker
//
//  Created by Joshua Colley on 05/09/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import SwiftUI

class HomeState: ObservableObject {
    @Published private(set) var value = "Test"
    private let service: HomeServiceProtocol = HomeService()
    
    func load() {
        service.setup()
    }
    
    func action() {
        self.value = "Success"
    }
}

//class ViewModel: ObservableObject {
//    @Published private(set) var countries: [Country] = []
//
//    private let service: WebService
//
//    func loadCountries() {
//        service.getCountries { [weak self] result in
//            self?.countries = result.value ?? []
//        }
//    }
//}
