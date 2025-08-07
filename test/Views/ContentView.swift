//
//  ContentView.swift
//  test
//
//  Created by Michael Miroshnikov on 07/08/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataCollector: DataCollector
    @EnvironmentObject var backgroundTaskManager: BackgroundTaskManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Заголовок
                VStack {
                    Image(systemName: "battery.100")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Модуль збору даних")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Технічна діагностика пристрою")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 30)
                
                Spacer()
                
                // Статус батареї
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "battery.25")
                            .font(.title2)
                            .foregroundColor(batteryColor)
                        
                        VStack(alignment: .leading) {
                            Text("Рівень батареї")
                                .font(.headline)
                            Text("\(Int(dataCollector.currentBatteryLevel * 100))%")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(batteryColor)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                // Статус моніторингу
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: dataCollector.isMonitoring ? "play.circle.fill" : "stop.circle.fill")
                            .font(.title2)
                            .foregroundColor(dataCollector.isMonitoring ? .green : .red)
                        
                        VStack(alignment: .leading) {
                            Text("Статус моніторингу")
                                .font(.headline)
                            Text(dataCollector.isMonitoring ? "Активний" : "Зупинений")
                                .font(.subheadline)
                                .foregroundColor(dataCollector.isMonitoring ? .green : .red)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Статус фонової задачі
                    HStack {
                        Image(systemName: backgroundTaskManager.isBackgroundTaskActive ? "clock.fill" : "clock")
                            .font(.title2)
                            .foregroundColor(backgroundTaskManager.isBackgroundTaskActive ? .blue : .gray)
                        
                        VStack(alignment: .leading) {
                            Text("Фонова задача")
                                .font(.headline)
                            Text(backgroundTaskManager.isBackgroundTaskActive ? "Активна" : "Неактивна")
                                .font(.subheadline)
                                .foregroundColor(backgroundTaskManager.isBackgroundTaskActive ? .blue : .gray)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Кнопки управління
                VStack(spacing: 15) {
                    Button(action: {
                        if dataCollector.isMonitoring {
                            dataCollector.stopDataCollection()
                        } else {
                            dataCollector.startDataCollection()
                        }
                    }) {
                        HStack {
                            Image(systemName: dataCollector.isMonitoring ? "stop.fill" : "play.fill")
                            Text(dataCollector.isMonitoring ? "Зупинити збір" : "Почати збір")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(dataCollector.isMonitoring ? Color.red : Color.green)
                        .cornerRadius(12)
                    }
                    
                    // Інформація про модуль
                    VStack(alignment: .leading, spacing: 8) {
                        Text("ℹ️ Інформація про модуль:")
                            .font(.headline)
                        
                        Text("• Збір даних кожні 2 хвилини")
                        Text("• Відправка на сервер через HTTPS")
                        Text("• Базовий захист даних (Base64)")
                        Text("• Оптимізація для фонового режиму")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
    
    // Колір батареї залежно від рівня
    private var batteryColor: Color {
        let level = dataCollector.currentBatteryLevel
        if level > 0.5 {
            return .green
        } else if level > 0.2 {
            return .orange
        } else {
            return .red
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataCollector())
        .environmentObject(BackgroundTaskManager())
} 