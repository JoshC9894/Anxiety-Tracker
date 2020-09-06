//
//  BluetoothService.swift
//  Anxiety Tracker
//
//  Created by Joshua Colley on 05/09/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import CoreBluetooth

protocol BluetoothServiceDelegate: class {
    func didConnect(to peripheral: CBPeripheral)
    func didDisconnect()
    func didDiscoverCharacteristics(_ characteristics: [CBCharacteristic])
}

protocol BluetoothServiceProtocol {
    var connectedPeripheral: CBPeripheral? { get }
    func scanForDevice()
    func disconnectConnectedPeripheral()
}

class BluetoothService: NSObject, BluetoothServiceProtocol {
//    static let Service_Id: String = "80023094-f1f6-4b3d-b2a3-be85d0c7ffca"
    static let Service_Id: String = "bb432abe-7ba2-488f-8a9d-7b2d63a12ad1"
    
    var connectedPeripheral: CBPeripheral?
    var targetService: CBService?
    var characteristics: [CBCharacteristic]?
    weak var delegate: BluetoothServiceDelegate?
    
    init(delegate: BluetoothServiceDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
    
    lazy var centralManager: CBCentralManager? = { [weak self] in
        let manager = CBCentralManager(delegate: self, queue: nil)
        return manager
    }()
    
    func scanForDevice() {
        guard let manager = self.centralManager else { return }
        
        switch manager.state {
        case .poweredOn:
            let service_cbuuid = CBUUID(string: BluetoothService.Service_Id)
            self.centralManager?.scanForPeripherals(withServices: [service_cbuuid], options: nil)
            
        default: return
        }
    }
    
    func disconnectConnectedPeripheral() {
        if let peripheral = self.connectedPeripheral {
            self.centralManager?.cancelPeripheralConnection(peripheral)
        }
    }
}
