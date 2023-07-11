//
//  KZOAIFunction.swift
//  KZOpenAI
//
//  Created by Lee Irvine on 6/23/23.
//  KEZZI.CO LLC
//

import Foundation

//{
//    "name": "baz",
//    "description": "description of baz in AI terms",
//    "parameters": {
//        "type": "object",
//        "properties": {
//            "player": {
//                "type": "string",
//                "description": "The name of the player who played"
//            },
//            "position": {
//                "type": "integer",
//                "description": "The position where the player played"
//            }
//        },
//        "required": ["player", "position"]
//    }
//}

class KZOAIFunctionParameter {
    let name: String
    
    let type: String
    
    let description: String
    
    let required: Bool

    init(name: String, type: String, description: String, required: Bool = true) {
        self.name = name
        
        self.type = type
            
        self.description = description
        
        self.required = required
    }
}

class KZOAIFunction: Encodable {
    let name: String
    
    let description: String
    
    let parameters: [KZOAIFunctionParameter]
    
    let code: ([Any]) -> ()
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case parameters
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)

        //        "type": "object",
        //        "properties": {
        //            "player": {
        //                "type": "string",
        //                "description": "The name of the player who played"
        //            },
        //            "position": {
        //                "type": "integer",
        //                "description": "The position where the player played"
        //            }
        //        },
        //        "required": ["player", "position"]

        let prs: [String : Encodable] = [
            "type": "object",
            "properties": parameters.map {[
                $0.name: [
                    "type": $0.type,
                    "description": $0.description
                ]
            ]},

            "required": parameters
                .filter { $0.required }
                .map { $0.name }
        ]

//        try container.encode(prs, forKey: .parameters)
    }

    init(name: String, description: String, parameters: [KZOAIFunctionParameter], code: @escaping ([Any]) -> ()) {
        self.name = name
            
        self.description = description
        
        self.parameters = parameters

        self.code = code
    }
    
    
}
