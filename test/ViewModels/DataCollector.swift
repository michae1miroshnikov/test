//
//  DataCollector.swift
//  test
//
//  Created by Michael Miroshnikov on 07/08/2025.
//

import Foundation
import UIKit

/// Клас для збору даних про стан пристрою
class DataCollector: ObservableObject {
    @Published var currentBatteryLevel: Float = 0.0
    @Published var isMonitoring = false
    
    private var timer: Timer?
    
    init() {
        // Включаємо моніторинг батареї
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    /// Починає збір даних кожні 2 хвилини
    func startDataCollection() {
        guard !isMonitoring else { return }
        
        isMonitoring = true
        
        // Збираємо дані одразу
        collectBatteryData()
        
        // Встановлюємо таймер на кожні 2 хвилини (120 секунд)
        timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { [weak self] _ in
            self?.collectBatteryData()
        }
    }
    
    /// Зупиняє збір даних
    func stopDataCollection() {
        isMonitoring = false
        timer?.invalidate()
        timer = nil
    }
    
    /// Збирає дані про батарею
    private func collectBatteryData() {
        let batteryLevel = UIDevice.current.batteryLevel
        currentBatteryLevel = batteryLevel
        
        // Створюємо об'єкт з даними
        let deviceData = DeviceData(batteryLevel: batteryLevel)
        
        // Відправляємо дані на сервер
        NetworkManager.shared.sendData(deviceData)
        
        print("📊 Зібрано дані: рівень батареї \(batteryLevel * 100)%")
    }
    
    deinit {
        stopDataCollection()
        UIDevice.current.isBatteryMonitoringEnabled = false
    }
} 