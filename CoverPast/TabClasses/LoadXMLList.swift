//
//  LoadXMLList.swift
//  CoverPast
//
//  Created by SivaSankar on 09/10/14.
//  Copyright (c) 2014 Paradim Creatives. All rights reserved.
//

import UIKit

protocol xmlResultDelegate{
    func xmlResultSuccessWithArray(itemsArray:NSMutableArray)
}

class LoadXMLList: NSObject , NSXMLParserDelegate{
    class var sharedInstance:LoadXMLList {
        get{
            struct Static {
                static var instance : LoadXMLList? = nil
                static var token: dispatch_once_t = 0
            }
            dispatch_once(&Static.token, {
                Static.instance = LoadXMLList()
            })
            return Static.instance!
        }
    }
    var xmlDelegate:xmlResultDelegate?
    var xmlDict:NSMutableDictionary = NSMutableDictionary()
    var isList = false
    var listArray:NSMutableArray = []
    var itemName:String = String()
    
    func loadXmlData(path:String){
        var url = NSURL.fileURLWithPath(path)
        var xmlParsing = NSXMLParser(contentsOfURL: url)
        xmlParsing.delegate = self
        xmlParsing.shouldResolveExternalEntities = false
        xmlParsing.parse()
    }
    
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName: String!, attributes: Dictionary<String, Float>) {
        if elementName == "list"{
            isList = true
            xmlDict = NSMutableDictionary()
        }
    }
    
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        itemName = string
    }
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
         if elementName == "list"{
            isList = false
            listArray.addObject(xmlDict)
        }
        if isList == true{
            xmlDict.setValue(itemName, forKeyPath: elementName)
        }
        if elementName == "listOfItems"{
            xmlDelegate?.xmlResultSuccessWithArray(listArray)
    }
}
}

