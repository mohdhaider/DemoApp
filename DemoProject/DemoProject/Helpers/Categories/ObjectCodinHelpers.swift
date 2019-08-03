//
//  ObjectCodinHelpers.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

protocol DecodingHelper {
    
    associatedtype Keys: CodingKey
    
    static func getStringValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> String?
    
    static func getIntValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> Int
}

extension DecodingHelper {
    
    static func getStringValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> String? {
        var str:String?
        
        if let obj = try? container.decode(String.self, forKey: key) {
            str = obj
        }
        else if let obj = try? container.decode(Int.self, forKey: key){
            str = String(obj)
        }
        return str
    }
    
    static func getIntValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> Int {
        var val: Int = 0
        
        if let obj = try? container.decode(String.self, forKey: key),
            let intVal = Int(obj){
            val = intVal
        }
        else if let obj = try? container.decode(Int.self, forKey: key){
            val = obj
        }
        return val
    }
}
