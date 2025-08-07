//
//  NetworkManager.swift
//  test
//
//  Created by Michael Miroshnikov on 07/08/2025.
//

import Foundation

/// Менеджер для мережевої взаємодії з сервером
class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    private let session = URLSession.shared
    
    private init() {}
    
    /// Відправляє дані на сервер з базовим захистом
    func sendData(_ deviceData: DeviceData) {
        // Кодуємо дані в JSON
        guard let jsonData = try? JSONEncoder().encode(deviceData) else {
            print("❌ Помилка кодування JSON")
            return
        }
        
        // Кодуємо JSON у Base64 для базового захисту
        let base64Data = jsonData.base64EncodedString()
        
        // Створюємо payload для відправки
        let payload = ["data": base64Data, "type": "device_data"]
        
        guard let payloadData = try? JSONSerialization.data(withJSONObject: payload) else {
            print("❌ Помилка створення payload")
            return
        }
        
        // Створюємо URL запит
        guard let url = URL(string: baseURL) else {
            print("❌ Невірний URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payloadData
        
        // Виконуємо запит
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.handleResponse(data: data, response: response, error: error)
            }
        }
        
        task.resume()
    }
    
    /// Обробляє відповідь сервера
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print("❌ Помилка мережі: \(error.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("❌ Невірна відповідь сервера")
            return
        }
        
        if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
            print("✅ Дані успішно відправлено на сервер")
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(ServerResponse.self, from: data)
                    print("📡 Відповідь сервера: \(response)")
                } catch {
                    print("⚠️ Не вдалося декодувати відповідь сервера")
                }
            }
        } else {
            print("❌ Помилка сервера: статус \(httpResponse.statusCode)")
        }
    }
} 