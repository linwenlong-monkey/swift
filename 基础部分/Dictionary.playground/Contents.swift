import Cocoa


//1. 创建一个空字典

var nameOfIntegers = [Int: String]()

nameOfIntegers[16] = "sixteen"
// namesOfIntegers 现在包含一个键值对
nameOfIntegers = [:]


//2. 字面量创建

var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//3. 访问和修改 count isEmpty

print("The dictionary of airports contains \(airports.count) items.")
// 打印“The dictionary of airports contains 2 items.”（这个字典有两个数据项）

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// 打印“The airports dictionary is not empty.”

//添加
airports["LHR"] = "London"
// airports 字典现在有三个数据项

//修改
airports["LHR"] = "London Heathrow"


//updataValue添加和修改
//作为另一种下标方法，字典的 updateValue(_:forKey:) 方法可以设置或者更新特定键对应的值。就像上面所示的下标示例，updateValue(_:forKey:) 方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的值。和上面的下标方法不同的，updateValue(_:forKey:) 这个方法返回更新值之前的原值。这样使得我们可以检查更新是否成功。

//let oldValue =  airports.updateValue("China", forKey: "LHR")
//print("oldValue is \(oldValue!)")

if let oldValue = airports.updateValue("London Heathrow Hello", forKey: "LHR1") {
    print("oldValue is \(oldValue)");
}

print("airports is \(airports)")

//我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回 nil：

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

// 我们还可以使用下标语法来通过给某个键的对应值赋值为 nil 来从字典里移除一个键值对：

airports["APL"] = "Apple Internation"
print("airports1 is \(airports)")
// “Apple Internation”不是真的 APL 机场，删除它
airports["APL"] = nil
// APL 现在被移除了
print("airports2 is \(airports)")

//removeValue(forKey:) 方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回 nil：

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// 打印“The removed airport's name is Dublin Airport.”

//字典遍历

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}


//遍历keys和values
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: YYZ
// Airport code: LHR

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: Toronto Pearson
// Airport name: London Heathrow


//Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的 keys 或 values 属性使用 sorted() 方法。
