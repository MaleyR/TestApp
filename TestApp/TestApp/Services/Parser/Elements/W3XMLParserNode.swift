//
//  W3XMLParserNode.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class W3XMLParserNode {
    var parent: W3XMLParserNode?
    var nodes: [W3XMLParserNode] = []
    var name: String
    var value: String?
    
    init(name: String) {
        self.name = name
    }
    
    func toDictionary() -> [String : Any] {
        var dictionary: [String : Any] = [:]
        
        // If there are no child nodes, simply return key-value pare
        if nodes.isEmpty {
            dictionary[name] = value ?? ""
            return dictionary
        } else { // If the node contains child node call the function recursively
            var array: [[String : Any]] = []
            
            for node in nodes {
                array.append(node.toDictionary())
            }
            
            dictionary[name] = array
        }
        
        return dictionary
    }
}
