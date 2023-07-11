//
//  KZOAIConfiguration.swift
//  KZOpenAI
//
//  Created by Lee Irvine on 6/23/23.
//  KEZZI.CO LLC
//

import Foundation

class KZOAIConfiguration {
    var functions: [KZOAIFunction]

    var temperature: Double?

    let maxTokens: Int
    
    let model: String
    
    let apikey: String?
    
    init(apikey:String? = nil, functions: [KZOAIFunction] = [], temperature: Double? = nil, maxTokens: Int = 100, model: String = "gpt-3.5-turbo-0613") {
        self.functions = functions
        self.temperature = temperature
        self.maxTokens = maxTokens
        self.model = model
        self.apikey = apikey ?? Bundle.main.infoDictionary?["openai_apikey"] as? String
    }
}
