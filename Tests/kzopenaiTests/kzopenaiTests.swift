//
//  KZOpenAITests.swift
//  KZOpenAITests
//
//  Created by Lee Irvine on 6/23/23.
//  KEZZI.CO LLC
//

import XCTest
@testable import kzopenai

final class KZOpenAITests: XCTestCase {
    
    let apikey = "< ADD YOUR OPENAI APIKEY HERE >"
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testKZOAIMessageToJson() {
        let message = KZOAIMessage(role: .user, content: "Hello, world!")

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let jsonData = try! encoder.encode(message)

        let jsonString = String(data: jsonData, encoding: .utf8)!
    }

    func testKZOAIRequestToJson() {
        let message1 = KZOAIMessage(role: .system, content: "You are a helpful assistant.")
        let message2 = KZOAIMessage(role: .user, content: "Hello!")

        let configuration = KZOAIConfiguration(functions:[],temperature: 1.0)

        let chatRequest = KZOAIChatRequest(messages: [message1, message2], configuration: configuration)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let jsonData = try! encoder.encode(chatRequest)

        let jsonString = String(data: jsonData, encoding: .utf8)!

        print("JSON String: \(jsonString)")
    }

    func testKZOpenAIChatCompletion() {
        let wait = XCTestExpectation(description: "wait")
        let message1 = KZOAIMessage(role: .system, content: "this is a unit test.")
        let message2 = KZOAIMessage(role: .user, content: "Send interesting data")
        
        let config = KZOAIConfiguration(apikey: apikey)
        
        let openAI = KZOpenAI(config: config)
        openAI.chatCompletion(messages: [message1, message2]) { message, reason in
            print("message \(message)")
            XCTAssert(reason == .stop || reason == .length)

            wait.fulfill()
        }

        self.wait(for: [wait], timeout: 30.0)
    }

    func testKZOpenAIChatCompletionWithFunction() {
        let wait = XCTestExpectation(description: "wait")
        let message1 = KZOAIMessage(role: .system, content: "this is a unit test.")
        let message2 = KZOAIMessage(role: .user, content: "call the function")

        let functions = [
            KZOAIFunction(
                name: "problem",
                description: "ask a math question",
                parameters: [
                    KZOAIFunctionParameter(name: "type", type: "string", description: "the type of problem to ask, ie: addition, subtraction, ..."),
                    KZOAIFunctionParameter(name: "problem", type: "string", description: "The math equation to display to the student as a string")
                ], code: { _ in }),

            KZOAIFunction(
                name: "lecture",
                description: "describe how to solve the problem",
                parameters: [
                    KZOAIFunctionParameter(name: "words", type: "string", description: "the words that you will say to the student."),
                ], code: { _ in })
        ]


        let config = KZOAIConfiguration(apikey: apikey, functions:functions,temperature: 1.0)

        let openAI = KZOpenAI(config: config)
        openAI.chatCompletion(messages: [message1, message2]) { message, reason in
            XCTAssert(reason == .function)

            wait.fulfill()
        }

        self.wait(for: [wait], timeout: 20.0)
    }

}
