import Cocoa

print("hello world")

func test(num1: Int) ->Void {
    
}

//将函数转换闭包，将函数名称去掉，大括号移动到最前面，在返回类型和代码块之间添加in
let col = {(num: Int)->Void in
    print("num is \(num)")
}
col(10)


//1. 闭包表达式

//函数类型
//"in"关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。即由in引入函数。
//(parameters) -> returnType

//{(parameters) -> returnType in
//    statements
//}

//2. 闭包的三种形式：
//全局函数是具有名称并且不捕获任何值得闭包
//嵌套函数是具有名称并可以从其闭包函数捕获值得闭包
//闭包表达式是以轻量级语法编写的未命名的闭包，可以从其定义的上下文中捕获并存储任何常量和变量的引用。


//3. 闭包的优点
//从上下文中推导参数和返回值类型
//单个表达式的闭包会隐式返回
//速记参数名称
//尾随闭包语法


//实例
//函数
func sum(num1: Int ,num2: Int) -> Int {
    return num1 + num2
}

print("sum is \(sum(num1: 10, num2: 12))")

////闭包
let colum = {(num1: Int ,num2: Int) -> Int in
    return num1 + num2
}
print("sum is \(colum(22,23))")


//4. 取别名

typealias block = (Int, Int) -> Int

let blockSum: block = {(a,b) -> Int in
    return a + b
}
print("blockSum is \(blockSum(10,30))")



//5. 闭包的用法

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let sortNum = names.sorted { (s1: String, s2: String) -> Bool in
    return s1 > s2
}

print("第0次 \(sortNum)")

let sortNum1 = names.sorted { (s1, s2) -> Bool in
    return s1 > s2
}

print("第1次 \(sortNum1)")

let sortNum2 = names.sorted { (s1, s2) -> Bool in
    s1 > s2
}

print("第2次 \(sortNum2)")

let sortNum3 = names.sorted(by: {(s1, s2)-> Bool in
    s1 > s2
})

print("第3次 \(sortNum3)")

//用函数排序

func sortNum(s1: String, s2: String) -> Bool {
    return s1 > s2
}
let sortNum4 = names.sorted(by: sortNum)

print("第4次 \(sortNum4)")


//6 .尾随闭包 如果是最后一个参数的时候，可以将闭包写在括号外面

let sortNum5 = names.sorted(by: {
    (s1, s2) -> Bool in
    s1 > s2
})

print("第5次 \(sortNum5)")

//尾随闭包

let sortNum6 = names.sorted() {
    (s1, s2) -> Bool in
    s1 > s2
}

print("第6次 \(sortNum6)")


//实例

func sum(by: (Int, Int) -> Int) -> Int {
    return by(10, 20)
}
let num = sum() {
    (a, b) in
    return a + b
}
print("和为 \(num)")


func sum1(a: Int, b: Int, by: (Int, Int) -> Int) -> Int{
    return by(a + 10, b + 10)
}

let num1 = sum1(a: 10, b: 30) {
    (a, b) in
    return a + b
}
print("和为 \(num1)")


//7. 捕获常量和变量


func sjzFunc(a: Int) -> () -> Int {
    var sjz = 0

    func addSjz() -> Int {
        sjz += a // 100
        return sjz
    }

    addSjz()
    print("sjz的值为：\(sjz), a的值为：\(a)")

    return addSjz
}


let sjzF = sjzFunc(a: 100);
print("值为：\(sjzF())")
print("值为：\(sjzF())")
print("值为：\(sjzF())")


let colums =  {(a: Int) -> () -> Int in
    var sjz = 0
    return {() -> Int in
        sjz += a
        return sjz
    }
}

let colums1 = colums(10)

print("值为1：\(colums1())")
print("值为1：\(colums1())")
print("值为1：\(colums1())")


//闭包和函数其实是共用的
let test = {(s1: String ,s2: String) -> () -> String in
    func inner() -> String {
        s1 + s2
    }
    return inner
//    return {() -> String in
//        s1 + s2
//    }
}

print(test("hello","world")())




//闭包 练习
var sjzBlock: () -> Void = {
    
}

var sjzBlock1 = {() -> Void in
    
}

//sjzBlock 和 sjzBlock1等效

//复习

let col1: () -> Void = {
  
}

let col2 = {()-> Void in
    
}

func sum2(a: Int, b: Int, by: (Int, Int) -> Int) -> Int{
    return by(a + 10, b + 10)
}
 
func test1(a: Int, b: Int, by: (Int, Int) -> Int) -> Int {
    return by(a,b);
}

let num10 =  test1(a: 10, b: 10) { (num1, num2) -> Int in
    num1 + num2
}
print("num10 = \(num10)")

let num11 = test1(a: 20, b: 20, by: { (num1, num2) -> Int in
    num1 + num2
})

test1(a: 30, b: 30) {(num1, num2) -> Int in
    num1 + num2
}

//8. 逃逸闭包

var completionHandlers: [()->Void] = []

//@escaping
func someFunctionWithEscapingClosure(colsure: @escaping ()->Void) {
    completionHandlers.append(colsure)
}
//将一个闭包用@escaping修饰的时候，你必须在闭包中显示引用 self。

//non-eacaping
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doString() -> Void {
        someFunctionWithEscapingClosure() {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doString()
print(instance.x)
// 打印出“200”

completionHandlers.first?()
print(instance.x)
// 打印出“100”



//9. 自动闭包
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出“5”

//customerProvider 闭包代码块，没有参数和返回值只是执行一段代码块，达到延时执行的效果
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 打印出“5”

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// 打印出“4”

// 使用自动闭包
// customersInLine is ["Ewa", "Barry", "Daniella"]

// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// 打印出“Now serving Alex!

//使用autoclosure 自动闭包
func serve1(customer customerProvider: @autoclosure  () -> String) {
    print("Now serving \(customerProvider())!")
}
//省略了 {}
serve1(customer: customersInLine.remove(at: 0))
// 打印“Now serving Ewa!”


