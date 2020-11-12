import Cocoa

//if if-else for-in while switch Fallthrough if-let guard-let where

//1. for-in循环

//你可以使用 for-in 循环来遍历一个集合中的所有元素，例如数组中的元素、范围内的数字或者字符串中的字符。

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

//遍历字典
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

//遍历数字范围
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}


//如果不需要使用遍历的值，可以用_替换变量名
let power = 10
for _ in 1...power {
   print("111")
}

//半开区间
let minutes = 60
for tickMark in 0..<minutes {
    // 每一分钟都渲染一个刻度线（60次）
    print("tickMark is \(tickMark)")
}

//2. while循环

//while condition {
//    statements
//}

//相当于do-while

//repeat {
//    statements
//} while condition


//3. 条件语句

// if-else

let temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}


//4. switch
//与 C 和 Objective-C 中的 switch 语句不同，在 Swift 中，当匹配的 case 分支中的代码执行完毕后，程序会终止 switch 语句，而不会继续执行下一个 case 分支。这也就是说，不需要在 case 分支中显式地使用 break 语句。这使得 switch 语句更安全、更易用，也避免了漏写 break 语句导致多个语言被执行的错误。

//基本的switch
let someCharacter: Character = "z"
switch someCharacter {
    case "a":
        print("The first letter of the alphabet")
    case "z":
        print("The last letter of the alphabet")
    default:
        print("Some other character")
}


//每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的：

//let anotherCharacter: Character = "a"
//switch anotherCharacter {
//case "a": // 无效，这个分支下面没有语句
//case "A":
//    print("The letter A")
//default:
//    print("Not the letter A")
//}
// 这段代码会报编译错误

//为了让单个 case 同时匹配 a 和 A，可以将这个两个值组合成一个复合匹配，并且用逗号分开：

let anotherCharacter: Character = "a"
switch anotherCharacter {
    case "a", "A":
        print("The letter A")
    default:
        print("Not the letter A")
}
// 输出“The letter A”


//匹配区间的switch
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String

switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// 输出“There are dozens of moons orbiting Saturn.”


//元组匹配switch

let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
}
// 输出“(1, 1) is inside the box”


//值绑定switch
let anotherPoint = (2, 2)
switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
}


//where switch

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
}
// 输出“(1, -1) is on the line x == -y”


//复合型 cases
let someCharacter1: Character = "e"
switch someCharacter1 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter1) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter1) is a consonant")
default:
    print("\(someCharacter1) is not a vowel or a consonant")
}


//值绑定和复合型 cases
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
    case (let distance, 0), (0, let distance):
        print("On an axis, \(distance) from the origin")
    default:
        print("Not on an axis")
}


//控制转移语句改变你代码的执行顺序，通过它可以实现代码的跳转。Swift 有五种控制转移语句：

//continue
//break
//fallthrough
//return
//throw



//检查api的可用性

if #available(iOS 11,macOS 10.12, *) {
    
}
