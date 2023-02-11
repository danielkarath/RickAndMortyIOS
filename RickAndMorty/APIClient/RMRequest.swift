//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 1/13/23.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    /// The API constant(s)
    private struct Constants {
        static let baseURL: String = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    ///The path components for API, if any
    private let pathComponents: [String]
    
    /// The querry components for API, if any
    private let querryParameters: [URLQueryItem]
    
    /// Constructed URL for the REST api request in a string format
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !querryParameters.isEmpty {
            string += "?"
            let argumentString = querryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// The constructed API URL
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired HTTP method
    public let httpMethod = "GET"
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: target endpoint
    ///   - pathComponents: collection of unique path components, if any
    ///   - querryParameters: collection of querry components, if any
    init(endpoint: RMEndpoint, pathComponents: [String] = [], querryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.querryParameters = querryParameters
    }
    
    /// Attempt to create request
    /// - Parameter url: url to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURL) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseURL+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] //Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(
                        endpoint: rmEndpoint,
                    pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count > 1 {
                let endpointString = components[0]
                let querryItemsString = components[1]
                let querryItems: [URLQueryItem] = querryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, querryParameters: querryItems)
                    return
                }
            }
        }
        return nil
    }
    
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
