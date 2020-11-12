import Cocoa





//  2.常量和变量
// 常量一旦创建值就不能改变，变量可以随时改变
let maximumNumberOfLoginAttempts = 0
var currentLoginAttempt = 0

//同时声明多个变量
var x = 10, y = 10, z = 1
print(x)


//类型注解
//在使用变量之前必须初始化变量
var welcomeMessage: String = String()
print(welcomeMessage)

//同时声明多个变量，并添加注解
//var red, green, blue: Double
var red = 0.0, green = 10.0, blue: Double

// 3.常量和变量的命名
//常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符。也不能以数字开头，但是可以在常量与变量名的其他地方包含数字。

//4.输出常量和变量

var friendyWelcome = "hello"

print("The current value of friendlyWelcome is \(friendyWelcome)")

//5.  分号
//与其他大部分编程语言不同，Swift 并不强制要求你在每条语句的结尾处使用分号（;），当然，你也可以按照你自己的习惯添加分号。有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句：

let cat = "🐱"; print(cat)

//--------------------------------------------------------

//  基础数据类型
//Int、Int8、Int16、Int32、UInt8、UInt16、UInt32  整数
//Double、Float 浮点数
//String 字符串
//Bool 布尔类型
//Array、Set、Dictionry 集合类型

//6. 整数


let exponentDouble = 1.1275e1

//0x1C.3p2 = 1*16+12. 3 *1/16*2*2
let hexadecimalDouble = 0x1C.3p2

//数字通过下划线增强可读性
let oneMillion = 1_000_000


//7.类型别名
//给一个类型取一个新的名字
typealias AudioSample = UInt8
var maxAmplitudeFound: AudioSample = AudioSample.max


//8. 布尔
let orangesAreOrange = true
let turnipsAreDelicious = false

if orangesAreOrange {
    print("Mmm, tasty turnips!")
} else if turnipsAreDelicious {
    print("Eww, turnips are horrible.")
} else {
    print("Eww1, turnips are horrible.")
}


//8. 元组（tuple）
//相单于(Int, String)的元组
let http404Error = (404,"Not Found")

//你可以将一个元组的内容分解（decompose）成单独的常量和变量，然后你就可以正常使用它们了：
let (statusCode, statusMessage) = http404Error

print("The status code is \(statusCode)")
// 输出“The status code is 404”
print("The status message is \(statusMessage)")
// 输出“The status message is Not Found”


//如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记：
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// 输出“The status code is 404”

//还可以通过下标获取
print("The status code is \(http404Error.0)")
// 输出“The status code is 404”
print("The status message is \(http404Error.1)")
// 输出“The status message is Not Found”

//你可以在定义元组的时候给单个元素命名：
let http200Status = (statusCode: 200, description: "ok");
print("The status code is \(http200Status.statusCode)")
// 输出“The status code is 200”
print("The status message is \(http200Status.description)")
// 输出“The status message is OK”


//9 可选类型?
//可选类型表示两种可能： 或者有值， 你可以解析可选类型访问这个值， 或者根本没有值。

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

print(convertedNumber!)


var serverResponseCode: Int? = 404
// serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil
// serverResponseCode 现在不包含值

//nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。

var surveyAnswer: String?
// surveyAnswer 被自动设置为 nil

//注意

//Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。

var a: Int?
if a != nil {
    print(a!)
}



//10. 可选绑定

if let actualNumber = Int(possibleNumber){
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
}else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}


//你可以包含多个可选绑定或多个布尔条件在一个 if 语句中，只要使用逗号分开就行。只要有任意一个可选绑定的值为 nil，或者任意一个布尔条件为 false，则整个 if 条件判断为 false，这时你就需要使用嵌套 if 条件语句来处理，如下所示

if let firstNumber = Int("4"),
   let secondNumber = Int("42"),
   firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

//在 if 条件语句中使用常量和变量来创建一个可选绑定，仅在 if 语句的句中（body）中才能获取到值。相反，在 guard 语句中使用常量和变量来创建一个可选绑定，仅在 guard 语句外且在语句后才能获取到值



//11. 隐式解析可选类型

//这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型。

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号


//12. 错误处理

func canThrowAnError() throws {
    // 这个函数有可能抛出错误

}

do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}

/**
 
 */

//13. 断言和先决条件

//断言和先决条件是在运行时所做的检查。你可以用他们来检查在执行后续代码之前是否一个必要的条件已经被满足了。如果断言或者先决条件中的布尔条件评估的结果为 true（真），则代码像往常一样继续执行。如果布尔条件评估结果为 false（假），程序的当前状态是无效的，则代码执行结束，应用程序中止。

//断言和先决条件的不同点是，他们什么时候进行状态检测：断言仅在调试环境运行，而先决条件则在调试环境和生产环境中运行。在生产环境中，断言的条件将不会进行评估。这个意味着你可以使用很多断言在你的开发阶段，但是这些断言在生产环境中不会产生任何影响。

// 断言 assert(_:_:file:line:)

//在这个例子中，只有 age >= 0 为 true 时，即 age 的值非负的时候，代码才会继续执行。如果 age 的值是负数，就像代码中那样，age >= 0 为 false，断言被触发，终止应用。
let age = 3
assert(age >= 0, "A person's age cannot be less than zero")
print(age)

//如果不需要断言信息，可以就像这样忽略掉：
assert(age >= 0)

// 如果代码已经检查了条件，你可以使用 assertionFailure(_:file:line:) 函数来表明断言失败了，例如：
// assertionFailure 直接输出断言信息
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age > 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

// 先决条件

//你可以使用全局 precondition(_:_:file:line:) 函数来写一个先决条件。向这个函数传入一个结果为 true 或者 false 的表达式以及一条信息，当表达式的结果为 false 的时候这条信息会被显示：

var index: Int = 0

precondition(index >= 0, "Index must be greater than zero.")

//preconditionFailure 已经判断了index，直接输出
//preconditionFailure("Index must be greater than zero.");

//中断程序
fatalError("asdasdasd")

