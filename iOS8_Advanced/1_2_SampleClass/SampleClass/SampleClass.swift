//
//  SampleClass.swift
//  SampleClass
//
//  Created by 新居雅行 on 2014/09/07.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation


struct KeyValue {
    var key: String
    var value: String
}

class SampleClass : NSMutableString {
    
    // 初期化メソッド
    override init()  {
        super.init()
    //    self.tag = "p"
    }
    
    // NSMutableStringを継承すると必要になる初期化メソッド
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 既存のメソッドをオーバーライドするとき
    override func appendString(aString: String)   {
        super.appendString("<\(tag)>\(aString)</\(tag)>")
    }
    
    // メソッドの定義
    func appendHTMLTaggedString(aString: String, withTag theTag: String) -> NSString {
        return "<\(theTag)>\(aString)</\(theTag)>";
    }
    
//    override var length: Int {
//        get {
//            return super.length
//        }
//    }
    
    // 一般的なプロパティの定義
    let standard : String = "HTML"
    var magicNumber : Int = 4
    var insideText : String = ""
    
    // 値の設定前後にメソッドを記述したメソッド（Observableの実装がやりやすい）
    var tag : String = "p"  {
        willSet {
            println("The property tag will set.[\(tag)->\(newValue)]")
        }
        didSet  {
            println("The property tag did set.[\(oldValue)->\(tag)]")
            magicNumber = countElements(tag)
        }
    }
    
    // セッタやゲッタの記述
    private var attributes : Dictionary<String, String> = [:]
    private var lastAttribute : KeyValue = KeyValue(key: "a", value: "a")
    var attribute : KeyValue {
        get {
            return lastAttribute
        }
        set(aKeyValue) {
            self.attributes[aKeyValue.key] = aKeyValue.value
            lastAttribute = aKeyValue
        }
    }
    
    func attributeValueFromKey(aKey : String) -> String?    {
        //tag = "ul"
        return attributes[aKey]
    }
    
    // lazy initializerを組み込んだプロパティ
    lazy var htmlStringFix : String? = "<\(self.tag)>\(self.insideText)</\(self.tag)>"
    
    var htmlStringCompute : String? {
        return "<\(tag)>\(insideText)</\(tag)>"
    }
    
    func tempHTMLString() -> String?    {
        return self.htmlStringFix
    }
    
    // サブスクリプト
    subscript(index: Int) -> String {
        switch index    {
            case 0: return "#"+standard
            case 1: return "#"+insideText
            default : return "#no way"
        }
    }
    subscript(index: String) -> String {
        switch index    {
            case "class": return "Sample Class"
            case "auther": return "It's me"
            default : return "info"
        }
    }
}