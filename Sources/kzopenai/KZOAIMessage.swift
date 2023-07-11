//
//  KZOAIMessage.swift
//  KZOpenAI
//
//  Created by Lee Irvine on 6/23/23.
//  KEZZI.CO LLC
//

import Foundation

enum KZOAIRole: String {
    case system
    case user
    case assistant
    case function
}

enum KZOAIFinishReason: String {
    case empty
    case length
    case function
    case stop
}

public class KZOAIMessage: Encodable {
    let role: KZOAIRole
    let content: String
    
    init(role: KZOAIRole, content: String) {
        self.role = role
        self.content = content
    }

    enum CodingKeys: String, CodingKey {
        case role
        case content
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role.rawValue, forKey: .role)
        try container.encode(content, forKey: .content)
    }
}
