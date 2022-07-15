//
//  ApiService.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import Foundation
import Alamofire

class ApiService {
    
    static let shared = ApiService()
    private init(){}
    private let logger = APILogger()
    private let parser = Parser()
    
    func getData<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, type: T.Type, completion: @escaping (Result<T,Error>) -> ()){
        if Connectivity.isConnectedToInternet {
             print("Connected")
         } else {
             print("No Internet")
        }
        var encoding: ParameterEncoding = URLEncoding.default
        if method == .get {
            encoding = URLEncoding.default
        } else {
            encoding = JSONEncoding.default
        }
        
        AF
            .request(url, method: method, parameters: parameters, encoding: encoding,  headers: headers)
            .validate()
            .responseJSON { [weak self] response in
                
                guard let self = self else { return }
                self.logger.logResponse(response)
                let statusCode = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success:
                    guard let responseData = response.data else { return }
                    self.parser.parseSuccessResponse(data: responseData, type: type) { result in
                        completion(result)
                    }
                case .failure(let error):
                    if let data = response.data { // backend error
                        self.parser.parseFailureResponse(data: data, statusCode: statusCode) { result in
                            completion(result)
                        }
                    } else { // other error
                        completion(.failure(error))
                    }
                }
            }
    }
}
