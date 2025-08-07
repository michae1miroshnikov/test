//
//  BackgroundTaskManager.swift
//  test
//
//  Created by Michael Miroshnikov on 07/08/2025.
//

import Foundation
import UIKit

/// Менеджер для роботи у фоновому режимі
class BackgroundTaskManager: ObservableObject {
    @Published var isBackgroundTaskActive = false
    
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid
    
    /// Починає фонову задачу
    func beginBackgroundTask() {
        guard backgroundTaskID == .invalid else { return }
        
        backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: "DataCollectionTask") { [weak self] in
            self?.endBackgroundTask()
        }
        
        isBackgroundTaskActive = true
        print("🔄 Фонова задача активована")
    }
    
    /// Завершує фонову задачу
    func endBackgroundTask() {
        guard backgroundTaskID != .invalid else { return }
        
        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        backgroundTaskID = .invalid
        isBackgroundTaskActive = false
        print("🔄 Фонова задача завершена")
    }
    
    /// Перевіряє чи залишився час для фонової роботи
    func checkBackgroundTimeRemaining() -> TimeInterval {
        return UIApplication.shared.backgroundTimeRemaining
    }
    
    deinit {
        endBackgroundTask()
    }
} 