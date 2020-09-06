//
//  HomeState.swift
//  Anxiety Tracker
//
//  Created by Joshua Colley on 05/09/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import SwiftUI
import CoreBluetooth

class HomeState: ObservableObject {
    @Published private(set) var connectionStatus = "Not connected"
    lazy var bluetoothService: BluetoothServiceProtocol = { [weak self] in
        let service = BluetoothService(delegate: self)
        return service
    }()
    
    func startScanning() {
        self.bluetoothService.scanForDevice()
    }
    
    func disconnect() {
        self.bluetoothService.disconnectConnectedPeripheral()
    }
}

extension HomeState: BluetoothServiceDelegate {
    func didConnect(to peripheral: CBPeripheral) {
        connectionStatus = "Connected"
//        let name = peripheral.name ?? ""
//        self.delegate?.didConnectToDevice(text: "Connected: \(name)")
    }
    
    func didDisconnect() {
        connectionStatus = "Not connected"
//        self.delegate?.didDisconnectFromDevice(text: "Not connected")
    }
    
    func didDiscoverCharacteristics(_ characteristics: [CBCharacteristic]) {
//        self.dataSource.data = characteristics
//        self.delegate?.didUpdateTableData()
    }
}
