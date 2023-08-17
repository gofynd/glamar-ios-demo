import Foundation
import SwiftUI

// ApiDataFetcher class for fetching data from the API
class ApiDataFetcher: ObservableObject {
    
    // Published properties to hold fetched data
    @Published var SkuData: [Sku] = []
    
    @Published var patternKey: [String] = []
    @Published var colorValue: [String] = []
    @Published var colorIntensity: [QuantumValue?] = []
    @Published var applyMakeUpConfigJsonString : String = ""
    // Default initializer
    init() {}
    
    // Method to fetch data from the API
    func fetchData(completion: @escaping (Result<[Sku], Error>) -> Void) {
        print("ApiDataFetcher - fetchData function called")
        
        
        
        var baseURLComponents = URLComponents(string: Constants.baseUrl)!
        
        // Add query parameter to the base URL
        baseURLComponents.path.append("-list")
        
        // Check if the resulting URL is valid
        guard let url = baseURLComponents.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        // Create a URL request with API_KEY and other required headers
        var request = URLRequest(url: url)
        request.addValue(Constants.API_KEY, forHTTPHeaderField: Constants.HttpHeaderAuthField)
        request.addValue(Constants.HttpHeaderContentTypeValue, forHTTPHeaderField: Constants.HttpHeaderContentTypeField)
        request.addValue(Constants.HttpHeaderSourceValue, forHTTPHeaderField: Constants.HttpHeaderSourceField)
        
        // Perform a data task to fetch data from the API
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            // Check if data is received
            guard let responseData = data else {
                print("No data received")
                return
            }
            
            // Decode the received data into an array of Sku objects
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Sku].self, from: responseData)
                
                DispatchQueue.main.async {
                    // Update the published property with the fetched data
                    self.SkuData = decodedData
                    print(self.SkuData)
                    // Completion block to signal success and pass the fetched data
                    completion(.success(self.SkuData))
                }
            } catch {
                print("Error decoding data: \(error)")
                // Completion block to signal failure and pass the error
                completion(.failure(error))
            }
        }.resume() // Start the data task
    }
    
    
    func fetchParticularData(id: Int,completion: @escaping (Result<String, Error>) -> Void) {
        print("ApiDataFetcher - ParticularfetchData function called")
        
        var baseURLComponents = URLComponents(string: Constants.baseUrl)!
        
        
        let queryItem = URLQueryItem(name: "id", value: "493")
        baseURLComponents.queryItems = [queryItem]
        
        // Check if the resulting URL is valid
        guard let url = baseURLComponents.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        // Create a URL request with API_KEY and other required headers
        var request = URLRequest(url: url)
        request.addValue(Constants.API_KEY, forHTTPHeaderField: Constants.HttpHeaderAuthField)
        request.addValue(Constants.HttpHeaderContentTypeValue, forHTTPHeaderField: Constants.HttpHeaderContentTypeField)
        request.addValue(Constants.HttpHeaderSourceValue, forHTTPHeaderField: Constants.HttpHeaderSourceField)
        
        // Perform a data task to fetch data from the API
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(error))
                return
            }
            
            // Check if data is received
            guard let responseData = data else {
                print("No data received")
                completion(.failure(NSError(domain: "NoDataReceivedError", code: 0, userInfo: nil)))
                return
            }
            
            // Convert the received data to a JSON string
            if let jsonString = String(data: responseData, encoding: .utf8) {
                DispatchQueue.main.async {
                    // Completion block to signal success and pass the JSON string
                    self.applyMakeUpConfigJsonString = jsonString
                    print("zzz\(self.applyMakeUpConfigJsonString)")
                    completion(.success(self.applyMakeUpConfigJsonString))
                }
            } else {
                print("Error converting data to JSON string")
                completion(.failure(NSError(domain: "JSONConversionError", code: 0, userInfo: nil)))
            }
        }.resume() // Start the data task
    }
    

    // Method to extract pattern data from the fetched SKU data
    func GetDictionaryData(sku: [Sku]) {
        for data in sku {
            for (key, value) in data.pattern {
                // Add pattern keys to the patternKey array
                patternKey.append(key)
                for (key1, value1) in value {
                    if key1.hasSuffix("ColorIntensity") {
                        // Add color intensity to the colorIntensity array
                        colorIntensity.append(value1)
                    }
                    if key1.hasSuffix("Color") {
                        // Add color to the colorValue array
                        colorValue.append(value1?.stringValue() ?? "#FFFFF")
                    }
                }
            }
        }
    }
}






