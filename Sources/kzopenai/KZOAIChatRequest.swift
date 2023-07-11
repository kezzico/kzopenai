//
//  KZOAIChatRequest.swift
//  KZOpenAI
//
//  Created by Lee Irvine on 6/23/23.
//  KEZZI.CO LLC
//

import Foundation

struct KZOAIChatRequest: Encodable {
    let messages: [KZOAIMessage]
    
    let configuration: KZOAIConfiguration
    
    enum CodingKeys: String, CodingKey {
        case model
        case temperature
        case maxTokens = "max_tokens"
        case messages
        case functions
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(configuration.model, forKey: .model)
        try container.encode(configuration.temperature, forKey: .temperature)
        try container.encode(configuration.maxTokens, forKey: .maxTokens)
        
        if configuration.functions.count > 0 {
            try container.encode(configuration.functions, forKey: .functions)
        }
        
        try container.encode(messages, forKey: .messages)
    }
}
