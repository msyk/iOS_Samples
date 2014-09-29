//
//  SampleClass.swift
//  SampleClass
//
//  Created by 新居雅行 on 2014/09/07.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit


struct KeyValue {
    var key: String
    var value: String
}

class SampleClass : UIViewController {
  
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil?, bundle: nibBundleOrNil?)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 一般的なメソッドの定義
    func length() -> Int {
        return countElements(insideText);
    }
    
    func appendHTMLTaggedString(aString: String, withTag theTag: String)
        -> NSString {
            return "<\(theTag)>\(aString)</\(theTag)>";
    }
    
    // 一般的なプロパティの定義
    let standard : String = "HTML"
    var magicNumber : Int = 4
    var insideText : String = ""
    
    // 値の設定前後にメソッドを記述したメソッド（Observableの実装がやりやすい）
    var tagString : String = "p"  {
        willSet {
            println("The property tag will set.[\(tagString)->\(newValue)]")
        }
        didSet  {
            println("The property tag did set.[\(oldValue)->\(tagString)]")
            magicNumber = tagString.utf16Count
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
    lazy var htmlStringFix : String?
        = "<\(self.tagString)>\(self.insideText)</\(self.tagString)>"
    
    var htmlStringCompute : String? {
        return "<\(tagString)>\(insideText)</\(tagString)>"
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