//
//  GenerateXML.swift
//  1_3_ParseData
//
//  Created by 新居雅行 on 2014/08/08.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation

@objc class GenerateXML: NSObject   {
    @objc func testGenerateXML()        {
        let bodyElement = GDataXMLElement.elementWithName("records")
        var parent = GDataXMLElement.elementWithName("record")
        var element = GDataXMLElement.elementWithName("name", stringValue: "My Name")
        parent.addChild(element)
        element = GDataXMLElement.elementWithName("ruby", stringValue: "My Name")
        parent.addChild(element)
        bodyElement.addChild(parent)
        let xmlDoc = GDataXMLDocument(rootElement: bodyElement)
        xmlDoc.setCharacterEncoding("utf-8")
        
        println(bodyElement.XMLString())
    }
}