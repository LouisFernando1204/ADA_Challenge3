//
//  OpenAIViewModel.swift
//  ADA_Challenge3
//
//  Created by Louis Fernando on 14/05/25.
//

import Foundation

class OpenAIViewModel: ObservableObject {
    static let shared = OpenAIViewModel()
    
    private let apiKey = "PrivateKey.shared.openai_apikey"
    
    private init() {}
    
    func sendMessage(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are an expert personality evaluation assistant. Your job is to objectively and thoroughly assess MBTI-based personality compatibility between individuals, providing clear, friendly, and well-structured analysis. Do not guess or assume things beyond the given user answers."],
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 500
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ URLSession ERROR: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1)))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("📝 FULL RAW RESPONSE: \(json ?? [:])")
                if let choices = json?["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
                } else {
                    completion(.success("No response content"))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
