//
//  KZOpenAI.swift
//  KZOpenAI
//
//  Created by Lee Irvine on 6/23/23.
//  KEZZI.CO LLC
//

import Foundation

class KZOpenAI {
    static let shared = KZOpenAI()
    
    let configuration: KZOAIConfiguration
    
    init(config: KZOAIConfiguration = KZOAIConfiguration()) {
        self.configuration = config
    }
    
    func chatCompletion(messages: [KZOAIMessage], completion: @escaping (String, KZOAIFinishReason)->()) {
        let chatRequest = KZOAIChatRequest(messages: messages, configuration: configuration)

        let requestBody = try! JSONEncoder().encode(chatRequest)

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        guard let apiKey = configuration.apikey else {
            fatalError("OpenAI API Key not set. in Info.plist. Use key openai_apikey.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = requestBody
        
        print("Request: \( String(data: requestBody, encoding: .utf8)! )")
        // STEP 3:
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error: no data")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Error: unable to parse json \( String(data: data, encoding: .utf8)! )")
                return
            }
            
            guard let choices = (json["choices"] as? Array<Any>)?[0] as? [String : Any] else {
                print("Error: choices missing from json \( String(data: data, encoding: .utf8)! )")
                return
            }
            
            let message = (choices["message"] as? [String : Any])?["content"] as? String ?? ""
            
            let finish_reason = KZOAIFinishReason(rawValue: choices["finish_reason"] as? String ?? "") ?? .empty
            
            completion(message, finish_reason)
            
            if finish_reason == .function {
                // special code goes here
            }
        }
        
        task.resume()

    }
}

