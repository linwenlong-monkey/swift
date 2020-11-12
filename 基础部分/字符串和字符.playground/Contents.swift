import Cocoa

//1. 字符串字面量

let someString = "Some string literal value"

//2. 字符串字面量 """ """

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.
"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""


let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#


// 3.初始化字符串

var emptyString = ""
var anotherEmptyString:String? = String()

var equal = (emptyString == anotherEmptyString)



//通过Character 数据初始化
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// 打印输出：“Cat!🐱”

// 4.isEmpty 坚持是否为空
if emptyString.isEmpty {
    print("Nothing to see here")
}


//4 .字符串是值类型 在 Swift 中 String 类型是值类型。如果你创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。



//5. 遍历字符串
for character in "Dog!🐶" {
    print(character)
}
// D
// o
// g
// !
// 🐶


//6. 连接字符串和字符

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

//你可以用 append() 方法将一个字符附加到一个字符串变量的尾部：

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome 现在等于 "hello there!"

//你不能将一个字符串或者字符添加到一个已经存在的字符变量上，因为字符变量只能包含一个字符。


//7. 字符串的长度 count
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a


//indices 属性会创建一个包含全部索引的范围（Range），用来在一个字符串中访问单个字符。

for index in greeting.indices {
   print("\(greeting[index]) ", terminator: "")
}



//8 .插入和删除

//调用 insert(_:at:) 方法可以在一个字符串的指定索引插入一个字符，调用 insert(contentsOf:at:) 方法可以在一个字符串的指定索引插入一个段字符串。

var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)
// welcome 变量现在等于 "hello!"

welcome1.insert(contentsOf:" there", at: welcome1.index(before: welcome1.endIndex))
// welcome 变量现在等于 "hello there!""


//调用 remove(at:) 方法可以在一个字符串的指定索引删除一个字符，调用 removeSubrange(_:) 方法可以在一个字符串的指定索引删除一个子字符串。

welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome 现在等于 "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome 现在等于 "hello""


//9. 子字符串


var greeting1 = "Hello, world!"
var index1 = greeting1.firstIndex(of: ",") ?? greeting1.endIndex
let beginning = greeting1[..<index1]
// beginning 的值为 "Hello"

greeting1 = "asdasdasdasd"
print("greeting1 \(greeting1)")
print("beginning \(beginning)")

// 把结果转化为 String 以便长期存储。
let newString = String(beginning)


//10 .比较字符串

//如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等，那就认为它们是相等的。只要可扩展的字形群集有同样的语言意义和外观则认为它们标准相等，即使它们是由不同的 Unicode 标量构成。

let quotation1 = "We're a lot alike, you and I."
let sameQuotation1 = "We're a lot alike, you and I."
if quotation1 == sameQuotation1 {
    print("These two strings are considered equal")
}
// 打印输出“These two strings are considered equal”

//11. 字符串已什么结尾、字符串已什么开始 hasPrefix(_:)/hasSuffix(_:)

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1Count = 0
var act2Count = 0


for str in romeoAndJuliet {
    if str.hasPrefix("Act 1") {
        act1Count += 1
    }else if str.hasPrefix("Act 2") {
        act2Count += 1
    }
}
print("act1Count  is \(act1Count)")
print("act2Count  is \(act2Count)")
