//
//  ApiParser.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import Foundation

struct Parser {
    
    let decoder = JSONDecoder()
    
    func parseSuccessResponse<T: Decodable>(data: Data, type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        do  {
            let modelData = try decoder.decode(T.self, from: data)
            completion(.success(modelData))
        } catch let jsonError {
            print("=====================================================")
            print("JSON PARSING ERROR")
            print(jsonError)
            print("=====================================================")
            completion(.failure(jsonError))
        }
    }
    
    func parseFailureResponse<T: Decodable>(data: Data, statusCode: Int, type: T.Type? = nil, completion: @escaping (Result<T, Error>) -> ()) {
        let jsonDict = data.toDictionary() ?? [:]
        let errorsDict = jsonDict["errors"] as? [String: [String]]
        let firstError = errorsDict?.first?.value.first ?? ""
        let backendError = NSError(domain: "sukkar.com", code: statusCode, userInfo: ["NSLocalizedDescription": firstError])
        completion(.failure(backendError))
    }
    
}
