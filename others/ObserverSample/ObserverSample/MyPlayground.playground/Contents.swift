//: Playground - noun: a place where people can play

import UIKit

var a = NSURL(string: "http://msyk.net")
print(a) // ✍ Optional(http://msyk.net)
print(a?.host) // ✍ Optional(msyk.net)
print(a?.port) // ✍ nil

//var b = a.host  // Error (Not unwrapped)
var b = a?.host
//var c = a?.host as String // Error (Not unwrapped)
var c = (a?.host)! as String

var an : NSURL? = nil
print(an) // ✍ nil
print(an?.host) // ✍ nil

b = an?.host
//c = (an?.host)! as String // EXC_BAD_INSTRUCTION

var url = NSURL(string: "http://msyk.net")
//url = nil
var hostname: String?
if let u = url {
    hostname = u.host
}
print(hostname) // ✍ "msyk.net" or nil

var dict: Dictionary<String, NSURL>? = nil
dict = ["Test": NSURL(string: "http://msyk.net")!]
dict = ["Test": a!]

if let c = NSURL(string: "http://msyk.net") {
    dict = ["Test": c]
}

if let
    d1 = NSURL(string: "http://msyk.net"),
    d2 = NSURL(string: "http://msyk.net"),
    d3 = NSURL(string: "http://msyk.net"),
    d4 = NSURL(fileURLWithPath: "") as NSURL?
{
    dict = ["d1": d1, "d2": d2, "d3": d3, "d4": d4]
} else {
    print("OMG")
}

print(NSURL(fileURLWithPath: "/"))

var dict2: Dictionary<String, NSURL?> = [:]
dict2 = ["Test": NSURL(string: "http://msyk.net")]

dict2 = [
    "d1": NSURL(string: "http://msyk.net"),
    "d2": NSURL(string: "http://msyk.net"),
    "d3": NSURL(string: "http://msyk.net"),
    "d4": NSURL(fileURLWithPath: "")
]
print(dict2["d1"])// ✍ Optional(Optional(http://msyk.net))
print(dict2["d4"])// ✍ Optional(nil)

var k = 1.1;
print(++k)
print(k++)
print(k)

var z = [3:"a",4:"b",5:"c"]
print((4).predecessor())

var f = Optional<String>("cc")
print(f) // Optional("cc")
f = "aa"
print(f) // Optional("aa")

