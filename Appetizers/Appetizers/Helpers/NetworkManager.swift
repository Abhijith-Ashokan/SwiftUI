//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseUrl = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let appetizersUrl = baseUrl + "appetizers"
    
    private init() { }
    
    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) {
        
        guard let url = URL(string: appetizersUrl) else {
            completed   (.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            //Note: if image is already present in cache, skip the network call and load the cached image
        }
        guard let url = URL(string:urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
            
        }
        task.resume()
    }
}
