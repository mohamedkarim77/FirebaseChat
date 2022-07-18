//
//  Data+Extension.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//


import Foundation

extension Data {
    
    func printData() {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            if let object = json as? [String: Any] {
                // json is a dictionary
                print(object)
            } else if let object = json as? [Any] {
                // json is an array
                print(object)
            } else {
                print("JSON is invalid")
            }
        } catch {
            print("json parsing error: ", error)
        }
    }
    
    func toDictionary() -> [String: Any]? {
        do {
            let dictionary = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
            return dictionary
        } catch {
            print("json parsing error: ", error)
            return nil
        }
    }
    
}



