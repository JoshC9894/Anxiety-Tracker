//
//  BluetoothService+CBPeripheralDelegate.swift
//  Anxiety Tracker
//
//  Created by Joshua Colley on 05/09/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import CoreBluetooth

extension BluetoothService: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let service = peripheral.services?.first {
            self.targetService = service
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            self.characteristics = characteristics
            characteristics.forEach({ peripheral.setNotifyValue(true, for: $0) })
            self.delegate?.didDiscoverCharacteristics(characteristics)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value else { return }
        print(data)
    }
}
