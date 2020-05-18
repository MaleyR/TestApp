//
//  W3XMLParserDescriptor.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class W3XMLParserDescriptor {
    private var mainNode: W3XMLParserNode?
    private var currentNode: W3XMLParserNode?
    
    func startNode(name: String) {
        if let _ = self.mainNode {
            let node = W3XMLParserNode(name: name)
            node.parent = self.currentNode
            self.currentNode?.nodes.append(node)
            self.currentNode = node
        } else {
            self.mainNode = W3XMLParserNode(name: name)
            self.currentNode = self.mainNode
        }
    }
    
    func setValue(value: String) {
        self.currentNode?.value = value
    }
    
    func closeNode(name: String) {
        self.currentNode = self.currentNode?.parent
    }
    
    func toDictionary() -> [String : Any] {
        return mainNode?.toDictionary() ?? [:]
    }
}
