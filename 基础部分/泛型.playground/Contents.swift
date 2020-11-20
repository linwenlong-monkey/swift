import UIKit

///泛型代码让你能根据自定义的需求，编写出适用于任意类型的、灵活可复用的函数及类型。你可避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。

///泛型是 Swift 最强大的特性之一，很多 Swift 标准库是基于泛型代码构建的。实际上，即使你没有意识到，你也一直在语言指南中使用泛型。例如，Swift 的 Array 和 Dictionary 都是泛型集合。你可以创建一个 Int 类型数组，也可创建一个 String 类型数组，甚至可以是任意其他 Swift 类型的数组。同样，你也可以创建一个存储任意指定类型的字典，并对该类型没有限制。



//1. 泛型函数
//交换两个数

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}


func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//1. 通过泛型函数整合
//上面 swapTwoValues(_:_:) 例子中，占位类型 T 是一个类型参数的例子，类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如 <T>）。
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//在下面的两个例子中，T 分别代表 Int 和 String：
var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt 现在是 107，anotherInt 现在是 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString 现在是“world”，anotherString 现在是“hello”


//2. 泛型类型


///非泛型版本 里面只可以用数字

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

///泛型版本

struct Stack<Elenment> {
    var items: [Elenment] = [Elenment]()
    mutating func push(item: Elenment) {
        items.append(item)
    }
    
   mutating func pop() throws -> Elenment? {
        
        if items.isEmpty {
            return nil
        }
        return items.removeLast()
    }
}

var stackSts: Stack<String> = Stack<String>()

//开始移除下
if let str = try? stackSts.pop() {
    print("\(str) is remove ");
}else {
    print("stack is emety")
}

stackSts.push(item: "aasdasdd")
stackSts.push(item: "aasdasdd1")
stackSts.push(item: "aasdasdd2")
if let str = try? stackSts.pop() {
    print("\(str) is remove ");
}else {
    print("stack is emety")
}

//3. 泛型扩展

//当对泛型类型进行扩展时，你并不需要提供类型参数列表作为定义的一部分。原始类型定义中声明的类型参数列表在扩展中可以直接使用，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用。
extension Stack {
    var topItem: Elenment? {
        
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackSts.topItem {
    print("The top item on the stack is \(topItem).")
}

//4. 泛型约束
///在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束。下面将展示泛型函数约束的基本语法（与泛型类型的语法相同）：

// func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//     // 这里是泛型函数的函数体部分
// }
 
/// 上面这个函数有两个类型参数。第一个类型参数 T 必须是 SomeClass 子类；第二个类型参数 U 必须符合 SomeProtocol 协议。

//不使用泛型，查找数组中特定的字符串
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}


//上面的方法只能在字符串中使用，使用泛型来处理下

//func findTIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}


//上面所写的函数无法通过编译。问题出在相等性检查上，即 "if value == valueToFind"。不是所有的 Swift 类型都可以用等式符（==）进行比较。例如，如果你自定义类或结构体来描述复杂的数据模型，对于这个类或结构体而言，Swift 无法明确知道“相等”意味着什么。正因如此，这部分代码无法保证适用于任意类型 T，当你试图编译这部分代码时就会出现相应的错误。

//T: Equatable 需要满足这个协议的，才可以使用==和!=

func findTIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

if let index = findTIndex(of: 3, in: [1,3,4]) {
    print("index \(index)")
}else {
    print("没有")
}




//5. 关联类型


