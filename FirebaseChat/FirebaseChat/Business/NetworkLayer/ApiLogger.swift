//
//  ApiLogger.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import Foundation
import Alamofire

struct APILogger {
    
    func logResponse(_ response: AFDataResponse<Any>) {
        print("=======================================")
        print("URL: ", response.request?.url ?? "")
        print("Method: ", response.request?.method ?? "")
        print("Headers: ", response.request?.headers ?? "")
        print("Status code: ", response.response?.statusCode ?? 0)
        
        switch response.result {
        case .success:
            print("Success Response: ", response.data?.printData() ?? "")
        case .failure:
            print("Failure Response: ", response.data?.printData() ?? "")
        }
        print("=======================================")
        print("=======================================")
        print("=======================================")
    }
    
}
