//
//  api.swift
//  Mirror
//
//  Created by 梁宁越 on 2023/2/5.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

struct Request: Codable {
    let prompt: String
}

struct Response: Codable {
    let response: String
}

struct RequestData: Codable {
    let prompt: String
    let max_tokens: Int
    let n: Int
    let temperature: Float
}

// make request to OpenAI api endpoint deployed on ec2
func makeRequest(request: Request, completion: @escaping (Result<Response, Error>) -> Void) {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let jsonData = try! encoder.encode(request)
    var urlRequest = URLRequest(url: URL(string: "http://ec2-3-15-156-220.us-east-2.compute.amazonaws.com:5000/response")!)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = jsonData
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"])))
            return
        }

        do {
            let response = try decoder.decode(Response.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(error))
        }
    }
    task.resume()
}

// function to be called for fetching AI response using prompt defined by user
func fetchData(prompt: String) -> Response? {
    
    let request = Request(prompt: prompt)
    var response: Response?
    let semaphore = DispatchSemaphore(value: 0)

    makeRequest(request: request) { result in
        switch result {
        case .success(let res):
            response = res
        case .failure(let error):
            print(error)
        }
        semaphore.signal()
    }

    semaphore.wait()
    return response
}

func callFlaskAPI(with parameters: [String: Any]){
    let url = URL(string: "http://ec2-3-15-156-220.us-east-2.compute.amazonaws.com:5000/response")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let parameters = parameters
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
         
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {
            print("No data received from API")
            return
        }
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            print(json)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }.resume()
}



//Davinci Version (intended for backup solution when OpenAI server's down)
func makeRequestDav(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    let apiKey = "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"
    
    let url = URL(string: "https://api.openai.com/v1/engines/text-davinci-003/completions")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let parameters = [
        "prompt": prompt,
        "max_tokens": 150,
        "n": 1,
        "stop": "",
        "temperature": 0.5,
    ] as [String : Any]
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from request"])))
            return
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let completions = json["choices"] as! [[String: Any]]
            let res = completions[0]["text"] as! String
            completion(.success(res))
        } catch let error {
            completion(.failure(error))
        }
    }
    task.resume()
}

func fetchCompletion(prompt: String) -> String? {
    var completion: String?
    let semaphore = DispatchSemaphore(value: 0)

    makeRequestDav(prompt: prompt) { result in
        switch result {
        case .success(let comp):
            completion = comp
        case .failure(let error):
            print(error)
        }
        semaphore.signal()
    }

    semaphore.wait()
    return completion
}

func callDavAPI(promptString: String){
    let apiKey = "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"
    let endpoint = "https://api.openai.com/v1/engines/text-davinci-003/completions"
    let requestData = RequestData(prompt: promptString, max_tokens: 100, n: 1, temperature: 0.5)

    let requestJson = try! JSONEncoder().encode(requestData)
    let request = NSMutableURLRequest(url: NSURL(string: endpoint)! as URL)
    request.httpMethod = "POST"
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = requestJson

    let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }

    task.resume()
}
