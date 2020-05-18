//
//  W3XMLParser.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class W3XMLParser: NSObject {
    private var xmlParser: XMLParser!
    private let descriptor = W3XMLParserDescriptor()
    
    private var completion: (([String : Any]) -> Void)?
    
    func parse(url: URL, with completion: (([String : Any]) -> Void)?) {
        self.completion = completion
        xmlParser = XMLParser(contentsOf: url)
        xmlParser.delegate = self
        xmlParser.parse()
    }
}

extension W3XMLParser: XMLParserDelegate {
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        descriptor.startNode(name: elementName)
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        descriptor.setValue(value: string)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        descriptor.closeNode(name: elementName)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(descriptor.toDictionary())
    }
}
