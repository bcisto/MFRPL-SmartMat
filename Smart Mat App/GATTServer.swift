//
//  GATTServer.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 9/27/24.
//
import Foundation
import CoreBluetooth

class GATTServer: NSObject, CBPeripheralManagerDelegate {

    var peripheralManager: CBPeripheralManager?
    var pressureCharacteristic: CBMutableCharacteristic?

    let pressureServiceUUID = CBUUID(string: "1234")
    let pressureCharacteristicUUID = CBUUID(string: "5678")
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    // MARK: - Peripheral Manager Delegate Methods
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print("Bluetooth is ON")
            startAdvertising()
        } else {
            print("Bluetooth is not available")
        }
    }
    
    func startAdvertising() {
        let pressureCharacteristic = CBMutableCharacteristic(
            type: pressureCharacteristicUUID,
            properties: [.write, .notify],
            value: nil,
            permissions: [.writeable]
        )
        
        let pressureService = CBMutableService(type: pressureServiceUUID, primary: true)
        pressureService.characteristics = [pressureCharacteristic]
        
        peripheralManager?.add(pressureService)
        peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [pressureServiceUUID]])
        
        self.pressureCharacteristic = pressureCharacteristic
        print("Started advertising")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic.uuid == pressureCharacteristicUUID {
                if let data = request.value {
                    processPressureData(data: data)
                }
                peripheralManager?.respond(to: request, withResult: .success)
            }
        }
    }
    
    func processPressureData(data: Data) {
        let sensorData = data.map { Float($0) }
        let grid = convertToGrid(sensorData: sensorData)
        
        if let pressureSquare = findPressureSquare(grid: grid) {
            let squareIndex = convertTo1DIndex(row: pressureSquare.row, col: pressureSquare.col)
            sendExpectedSquare(squareIndex: squareIndex)
        }
    }
    
    func convertToGrid(sensorData: [Float]) -> [[Float]] {
        var grid = [[Float]]()
        for row in 0..<4 {
            let start = row * 9
            let end = start + 9
            let gridRow = Array(sensorData[start..<end])
            grid.append(gridRow)
        }
        return grid
    }
    
    func findPressureSquare(grid: [[Float]]) -> (row: Int, col: Int)? {
        var maxPressure: Float = 0.0
        var pressureSquare: (row: Int, col: Int)? = nil
        
        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                let pressure = grid[row][col]
                if pressure > maxPressure {
                    maxPressure = pressure
                    pressureSquare = (row, col)
                }
            }
        }
        return pressureSquare
    }
    
    func convertTo1DIndex(row: Int, col: Int) -> Int {
        return row * 9 + col
    }
    
    func sendExpectedSquare(squareIndex: Int) {
        if let characteristic = pressureCharacteristic {
            let data = Data([UInt8(squareIndex)]) // Send as single byte
            peripheralManager?.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
        }
    }
}
