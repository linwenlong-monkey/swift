import UIKit


//throw try do-catch rethrow
//Swift 在运行时提供了抛出、捕获、传递和操作可恢复错误（recoverable errors）的一等支持（first-class support）。

//Error是个空的协议
enum VendMachineError: Error {
    case invalidSelection                     //选择无效
    case insufficientFunds(coinsNeeded: Double) //金额不足
    case outOfStock                             //缺货
}

VendMachineError.insufficientFunds(coinsNeeded: 4)

//1).某个错误被抛出时，附近的某部分代码必须负责处理这个错误，例如纠正这个问题、尝试另外一种方式、或是向用户报告错误

//2). 你可以把函数抛出的错误传递给调用此函数的代码、用 do-catch 语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生。
//3). 在调用一个能抛出错误的函数、方法或者构造器之前，加上 try 关键字，或者 try? 或 try! 这种变体。这些关键字在下面的小节中有具体讲解。


//1. 用 throwing 函数传递错误

//1.1 为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数之后加上 throws 关键字。一个标有 throws 关键字的函数被称作 throwing 函数。如果这个函数指明了返回值类型，throws 关键词需要写在返回箭头（->）的前面。

//表示一个throwing的函数
func canThrowErrors() throws -> String {
    return "canThrowErrors"
}

func cannotThrowErrors() -> String {
    return "cannotThrowErrors"
}

//1.2 例子

struct Item {
    var price: Double
    var count: Int
}

class VendingMachine {
    var inventory = [ //定义一个字典的存储属性
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0.0
    
    func vend(name: String) throws {
        guard let item = inventory[name] else {//没有这个对象
            throw VendMachineError.invalidSelection //抛error
        }
        
        guard item.count > 0 else {
            throw VendMachineError.outOfStock //抛error
        }
        
        guard item.price <= coinsDeposited else {
            throw VendMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        //上面的判断都通过的时候
        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")

    }
}


let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

//这个函数调用了vendingMachine 的vend方法有可能活抛错误，所以用try
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(name: snackName)
}


//throwing 构造器能像 throwing 函数一样传递错误。例如下面代码中的 PurchasedSnack 构造器在构造过程中调用了 throwing 函数，并且通过传递到它的调用者来处理这些错误。

struct PurchasedSnack {
    let name: String
    //构造器中调用了vend方法，会抛出异常
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(name: name)
        self.name = name
    }
}


//2 .用 Do-Catch 处理错误
/**
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch {
    statements
}
 */

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendMachineError.invalidSelection  {
    print("Invalid Selection.")
} catch VendMachineError.outOfStock {
    print("Out of Stock.")
} catch VendMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch  {
    print("Unexpected error: \(error).")
}


//3. 将错误转换成可选值

//可以使用 try? 通过将错误转换成一个可选值来处理错误。如果是在计算 try? 表达式时抛出错误，该表达式的结果就为 nil。例如，在下面的代码中，x 和 y 有着相同的数值和等价的含义：

func someThrowingFunction() throws -> Int {
    // ...
    return 10
}

let x = try? someThrowingFunction()

let y: Int?

do {
    y = try someThrowingFunction()
} catch  {
    y = nil
}


//如果 someThrowingFunction() 抛出一个错误，x 和 y 的值是 nil。否则 x 和 y 的值就是该函数的返回值。注意，无论 someThrowingFunction() 的返回值类型是什么类型，x 和 y 都是这个类型的可选类型。例子中此函数返回一个整型，所以 x 和 y 是可选整型。


//举例子

struct Data {
    
}

func fetchDataFromDisk() throws -> Data {
    return Data()
}

func fetchDataFromServer() throws -> Data {
    return Data()
}

func fetchData() -> Data? {
    //try? 如果fetchDataFromDisk()这个函数抛出异常就会返回nil。没有抛出异常就会返回Data实例。从而不用补货各种异常
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}


//4. 禁止错误传递 try!

//有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写 try! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。

//例如，下面的代码使用了 loadImage(atPath:) 函数，该函数从给定的路径加载图片资源，如果图片无法载入则抛出一个错误。在这种情况下，因为图片是和应用绑定的，运行时不会有错误抛出，所以适合禁用错误传递。


//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")


//5. 指定清理操作

//你可以使用 defer 语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如 return、break 的语句。例如，你可以用 defer 语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。

//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // 处理文件。
//        }
//        // close(file) 会在这里被调用，即作用域的最后。
//    }
//}

//上面的代码使用一条 defer 语句来确保 open(_:) 函数有一个相应的对 close(_:) 函数的调用。
