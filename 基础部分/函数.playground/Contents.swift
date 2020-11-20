import Cocoa

//1. 无参数无返回值
//函数类型 ()-Void
func greet() {
    print("hello world")
}

//2. 无参数有返回值

//函数类型 ()-String
func greet() ->String {
    return "hello world"
}

//3. 有参数有返回值

func add(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

//如果返回值只是一个表达式，可以省略return

func addTwoInts(num1: Int, num2: Int) -> Int {
    num1 + num2
}

//4. 返回元组

func maxMin(numbers: [Int]) -> (max: Int, min: Int) {
    var currentMax = numbers[0]
    var currentMin = numbers[0]
    for value in numbers {
        if value > currentMax {
            currentMax = value
        }else if value < currentMin {
            currentMin = value
        }
        
    }
    return (currentMax,currentMin)
}

var result: (max:Int,min:Int) =  maxMin(numbers: [1,2,3,8,3,2,7,3]);


//5. 可选的元组返回
//可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的。可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。

func maxMin1(numbers: [Int]) -> (max: Int, min: Int)? {
    if numbers.isEmpty {
        return nil
    }
    var currentMax = numbers[0]
    var currentMin = numbers[0]
    for value in numbers {
        if value > currentMax {
            currentMax = value
        }else if value < currentMin {
            currentMin = value
        }
    }
    return (currentMax,currentMin)
}


//6. 参数名称和隐藏参数名称

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// 打印“Hello Bill!  Glad you could visit from Cupertino.”

func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
     // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(1, secondParameterName: 2)


//7. 默认返回值
//你可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数。

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12


//8 .可变参数 跟传递一个数组一样

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// 返回 3.0, 是这 5 个数的平均数。
arithmeticMean(3, 8.25, 18.75)
// 返回 10.0, 是这 3 个数的平均数。


//9. 输入输出参数

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// 打印“someInt is now 107, and anotherInt is now 3”


//10. 函数作为参数

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}


func printMathResult(math:(Int, Int)->Int, num1: Int, num2: Int) {
    print("Result: \(math(num1, num2))")
}

var mathFunction = addTwoInts(_:_:)
//如果有两个addTwoInts这时候，声明一个函数的变量需要后面加上参数的

printMathResult(math: mathFunction, num1: 2, num2: 3)



//11 .函数类型作为返回值
func stepForward(_ input: Int, _ input1: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int,_ input1: Int) -> Int {
    return input - 1
}


func chooseStepFunc(backward: Bool) -> (Int, Int) -> Int {
    return backward ? stepBackward : stepForward
}
//stepBackward和stepForward只有一个，可以后面不用指定传递的参数


//12 .嵌套函数
//函数直接写在函数里面
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!


