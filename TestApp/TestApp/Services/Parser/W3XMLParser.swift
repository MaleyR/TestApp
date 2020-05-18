//
//  W3XMLParser.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

fileprivate enum W3XMLKey: String {
    case title = "TITLE"
    case artist = "ARTIST"
    case country = "COUNTRY"
    case company = "COMPANY"
    case price = "PRICE"
    case year = "YEAR"
    case cd = "CD"
    case catalog = "CATALOG"
}

class W3XMLParser: NSObject, Parser {
    private var xmlParser: XMLParser!
    
    private var cds: [CD] = []
    private var currentKey: W3XMLKey?
    private var currentItem: CD?
    
    private var completion: (([CD]) -> Void)?
    
    func parse(data: Data, with completion: @escaping (([CD]) -> Void)) {
        self.completion = completion
        xmlParser = XMLParser(data: data)
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
        self.currentKey = W3XMLKey(rawValue: elementName)
        
        if let key = self.currentKey, key == .cd {
            currentItem = CD()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let key = self.currentKey else { return }
        
        let string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch key {
        case .artist: currentItem?.artist.append(string)
        case .company: currentItem?.company.append(string)
        case .country: currentItem?.country.append(string)
        case .price: currentItem?.price.append(string)
        case .title: currentItem?.title.append(string)
        case .year: currentItem?.year.append(string)
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard let item = self.currentItem,
            let key = W3XMLKey(rawValue: elementName),
            key == .cd else { return }
        cds.append(item)
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completion?(cds)
    }
}
