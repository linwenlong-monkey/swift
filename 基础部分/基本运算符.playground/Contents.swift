import Cocoa



//1. 给元组赋值运算符

var (x, y) = (1, 2)
print("x is \(x), y is \(y)")


//2. 一元负号运算符

//数值的正负号可以使用前缀 -（即一元负号符）来切换：

let three = 3
let minusThree = -three       // minusThree 等于 -3
let plusThree = -minusThree   // plusThree 等于 3, 或 "负负3"

//3. 一元正号运算符
//一元正号符（+）不做任何改变地返回操作数的值：

let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 等于 -6

//4. 组合赋值运算符

var a = 1
a += 2  // a 现在是 3 a = a + 2


//5. 元组比较

(1, "zebra") < (2, "apple")   // true，因为 1 小于 2
(3, "apple") < (3, "bird")    // true，因为 3 等于 3，但是 apple 小于 bird
(4, "dog") == (4, "dog")      // true，因为 4 等于 4，dog 等于 dog


//当元组中的元素都可以被比较时，你也可以使用这些运算符来比较它们的大小。例如，像下面展示的代码，你可以比较两个类型为 (String, Int) 的元组，因为 Int 和 String 类型的值可以比较。相反，Bool 不能被比较，也意味着存有布尔类型的元组不能被比较。

//Swift 标准库只能比较七个以内元素的元组比较函数。如果你的元组元素超过七个时，你需要自己实现比较运算符。

("blue", -1) < ("purple", 1)       // 正常，比较的结果为 true
//("blue", false) < ("purple", true) // 错误，因为 < 不能比较布尔类型


//6 空合运算符 a ?? b

//空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解包，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。

var a1: Int?
var b1 = 10
var c1 = a1 != nil ? a1! : b1
var c2 = a1 ?? b1 //跟c1的结果一样



//7 .闭区间运算符 （a...b） 定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b。

for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}
// 1 * 5 = 5
// 2 * 5 = 10
// 3 * 5 = 15
// 4 * 5 = 20
// 5 * 5 = 25

//8 .半开区间运算符

//半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("第 \(i + 1) 个人叫 \(names[i])")
}
// 第 1 个人叫 Anna
// 第 2 个人叫 Alex
// 第 3 个人叫 Brian
// 第 4 个人叫 Jack

//9 .单侧区间

//闭区间操作符有另一个表达形式，可以表达往一侧无限延伸的区间 —— 例如，一个包含了数组从索引 2 到结尾的所有值的区间。在这些情况下，你可以省略掉区间操作符一侧的值。这种区间叫做单侧区间，因为操作符只有一侧有值。

for name in names[2...] {
    print(name)
}
// Brian
// Jack

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian

//半开区间操作符也有单侧表达形式，附带上它的最终值。就像你使用区间去包含一个值，最终值并不会落在区间内

for name in names[..<2] {
    print(name)
}
// Anna
// Alex


// 定义一个单侧区间

let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true




