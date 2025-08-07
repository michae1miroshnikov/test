//
//  DataModel.swift
//  test
//
//  Created by Michael Miroshnikov on 07/08/2025.
//

import Foundation
import UIKit

/// Модель даних для збору інформації про стан пристрою
struct DeviceData: Codable {
    let batteryLevel: Float
    let timestamp: Date
    let deviceId: String
    
    init(batteryLevel: Float) {
        self.batteryLevel = batteryLevel
        self.timestamp = Date()
        self.deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
    }
}

/// Відповідь сервера
struct ServerResponse: Codable {
    let id: Int?
    let success: Bool?
    let message: String?
} 