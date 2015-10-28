//
//  AlamofireRequest+Extension.swift
//  Birds Around Me
//
//  Created by Michael E. Smith on 2015-10-28.
//  Copyright © 2015 Sobremesa. All rights reserved.
//

import Foundation
import Alamofire
import Decodable

extension Alamofire.Request {
    public func responseCollection<T: Decodable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            
            guard error == nil else { return .Failure(error!) }
            
            let result = Alamofire
                .Request
                .JSONResponseSerializer(options: .AllowFragments)
                .serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                do {
                    return .Success(try [T].decode(value))
                } catch {
                    return .Failure(Error.errorWithCode(.JSONSerializationFailed,
                        failureReason: "JSON parsing error, JSON: \(value)"))
                }
            case .Failure(let error): return.Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}