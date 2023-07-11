# KZOpenAI

KZOpenAI is a Swift package that provides a convenient way to interact with the OpenAI API for chat-based language models. With this package, you can easily generate responses to a series of messages using OpenAI's powerful language model.

## Installation

You can install KZOpenAI using Swift Package Manager. Simply add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/kezzico/kzopenai.git", from: "1.0.0")
]
```

## Usage

1. Import the KZOpenAI module in your Swift file:

```swift
import KZOpenAI
```

2. Create an instance of `KZOpenAI`:

```swift
let openAI = KZOpenAI.shared
```

3. Set up the configuration for your OpenAI API. You can provide your API key and other options through the `KZOAIConfiguration` object. By default, the configuration looks for the API key in info.plist under openai_apikey. 

Make sure to set your API key before making any API calls.

```swift
    let config = KZOAIConfiguration(apikey: < YOUR API KEY HERE >)

    let openAI = KZOpenAI(config: config)
```

4. Prepare the input messages for the chat completion request. The messages should be in the form of an array of `KZOAIMessage` objects. Each message object has two properties: `role` and `content`. The `role` can be `"system"`, `"user"`, or `"assistant"`, and the `content` contains the text of the message.

```swift
let messages: [KZOAIMessage] = [
    let message1 = KZOAIMessage(role: .system, content: "you are a helpful assistant")
    let message2 = KZOAIMessage(role: .user, content: "Hello world!")
]
```

5. Call the `chatCompletion` method on the `KZOpenAI` instance to generate a response based on the input messages. Provide a completion handler to receive the generated response and the finish reason.

```swift
    openAI.chatCompletion(messages: [message1, message2]) { message, reason in
        print("\(message)")
    }
```

## Error Handling

If the OpenAI API key is not set in either the `Info.plist` file or through the APIs of your project, the package will raise a fatal error. 

Make sure to provide the correct API key before making any API calls.

## Contributing

Contributions to KZOpenAI are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the [GitHub repository](https://github.com/kezzico/kzopenai).

## License

KZOpenAI is released under the MIT license. See the [LICENSE](https://github.com/kezzico/kzopenai/LICENSE.md) file for more details.
