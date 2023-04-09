//
//  api.swift
//  Mirror
//


import Foundation
// Structs for handling request and response data
struct Request: Codable {
    let prompt: String
}

struct Response: Codable {
    let response: String
}
public var currentHis: [[String:Any]] = [["role": "system", "content": "You are a helpful assistant."]]
public var currentQues: String = ""
public var currentAns: String = ""
public var currentScore: String = "0"


func mergeWithChatHistory(prompt: String, chatHistory: [[String:Any]]) -> [[String:Any]] {
    var mergedMessages = chatHistory
    mergedMessages.append(["role": "user", "content": prompt])
    return mergedMessages
}



// Function for making a request to OpenAI's Chatgpt API and returning the response
func makeRequestGPT(chatHistory: [[String:Any]], isQues: Bool = false, completion: @escaping (Result<String, Error>) -> Void) {
    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
    // Set up request with required headers and parameters
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer \(apiKey ?? "")", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let parameters = [
        "model": "gpt-3.5-turbo",
        "messages": chatHistory
    ] as [String : Any]
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
    // Send the request asynchronously and handle the response
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        // If there was no data in the response, call the completion handler with a failure
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"])))
            return
        }
        // Parse the JSON response and extract the text completion, call the completion handler with a success result
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            print(json)
            let completions = json["choices"] as! [[String: Any]]
            let resDic = completions[0]["message"] as! [String: Any]
            currentHis.append(resDic)
            let res = resDic["content"] as! String
            if isQues {
                currentQues = res
            }
            completion(.success(res))
        } catch let error {
            completion(.failure(error))
        }
    }
    task.resume()
}


// A function that fetches a text completion for a given prompt using the makeRequestGPT function
func fetchCompletion(prompt: String) -> String? {
    var completion: String?
    let semaphore = DispatchSemaphore(value: 0)
    // Send the request asynchronously and handle the response
    var isQuestion = false
    if prompt.contains("with the question only") {
        isQuestion = true
    }
    currentHis = mergeWithChatHistory(prompt: prompt, chatHistory: currentHis)
    
    makeRequestGPT(chatHistory: currentHis, isQues: isQuestion) { result in
        switch result {
        case .success(let comp):
            completion = comp
        case .failure(let error):
            print(error)
        }
        // Signal the semaphore to indicate that the completion handler has been call
        semaphore.signal()
    }
    // Wait for the completion handler to be called
    semaphore.wait()
    return completion
}

// Function for making a request to a API endpoint and returning the response
func makeRequest(request: Request, completion: @escaping (Result<Response, Error>) -> Void) {
    // Create encoder and decoder for encoding/decoding JSON data
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    // Encode request data into JSON
    let jsonData = try! encoder.encode(request)
    // Create URL request to send the request to API endpoint
    var urlRequest = URLRequest(url: URL(string: "http://ec2-3-15-156-220.us-east-2.compute.amazonaws.com:5000/response")!)
    // Set HTTP method to POST and add JSON data to the request body
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = jsonData
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    // Create URLSession data task to send the request and handle the response
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error { //check error
            completion(.failure(error))
            return
        }
        // Check if data was received from the request
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"])))
            return
        }
        // Decode response JSON data into Response struct
        do {
            let response = try decoder.decode(Response.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(error))
        }
    }
    task.resume() // Start the data task
}

// function to be called for fetching AI response using prompt defined by user
func fetchData(prompt: String) -> Response? {
    // Create a request struct with the given prompt
    let request = Request(prompt: prompt)
    var response: Response?
    let semaphore = DispatchSemaphore(value: 0)
    // Make the request asynchronously and handle the response in a closure
    makeRequest(request: request) { result in
        switch result {
        case .success(let res):
            response = res
        case .failure(let error):
            print(error)
        }
        semaphore.signal()// Signal the semaphore to indicate that the request is complete
    }

    semaphore.wait() //Wait for the request to complete before returnthe response
    return response
}
