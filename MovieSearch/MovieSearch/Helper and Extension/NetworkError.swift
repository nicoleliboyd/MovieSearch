//
//  NetworkError.swift
//  MovieSearch
//
//  Created by David Boyd on 5/7/21.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        
        switch self {
        case.invalidURL:
            return "Unable to reach the server"
            
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
            
        case .noData:
            return "The server responded with no data"
            
        case .unableToDecode:
            return "Unable to decode data"
        }
    }
}//End of enum
