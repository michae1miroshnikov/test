//
//  testApp.swift
//  test
//
//  Created by Michael Miroshnikov on 07/08/2025.
//

import SwiftUI

@main
struct testApp: App {
    @StateObject private var dataCollector = DataCollector()
    @StateObject private var backgroundTaskManager = BackgroundTaskManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataCollector)
                .environmentObject(backgroundTaskManager)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    // Починаємо фонову задачу при переході у фон
                    backgroundTaskManager.beginBackgroundTask()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    // Завершуємо фонову задачу при поверненні
                    backgroundTaskManager.endBackgroundTask()
                }
        }
    }
} 