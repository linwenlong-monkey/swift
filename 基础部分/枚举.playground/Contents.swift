import Cocoa


//1)、枚举的值可以是整数、浮点数、字符串、字符
//2)、枚举也可以提供方法和遵循协议、和扩张
//3)、使用enum来定义一个枚举

//1. 定义简单枚举

enum SomeEnumeration {
    
}

//定义枚举
enum CompassPoint {
    case north
    case south
    case east
    case west
    case other
    case up
    case down
  
}
//与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的 CompassPoint 例子中，north，south，east 和 west 不会被隐式地赋值为 0，1，2 和 3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。

var directionToHead:CompassPoint = CompassPoint.east

//directionToHead 被声明为 CompassPoint 类型，你可以使用更简短的点语法将其设置为另一个 CompassPoint 的值：
directionToHead = .south

var test = CompassPoint.east

//test 被推断为CompassPoint类型，可以直接点语法设置值
test = .north

print(test)

//枚举定义在同一行

enum Planet {
    case mercury, venus, earth, jupiter, satur
}


//2. 枚举和switch的使用


directionToHead = .up

switch directionToHead {
    case .east:
        print("east")
    case .north:
        print("north")
    case .west:
        print("west")
    case .south:
        print("south")
    case .up,.down ://两个case一起，中间加逗号
        print("up or don")
    default:
        print("default")
}

//3. 枚举遍历
//令枚举遵循 CaseIterable 协议。Swift 会生成一个 allCases 属性，用于表示一个包含枚举所有成员的集合。

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numOfChoices = Beverage.allCases.count
print("\(numOfChoices) beverages available")

let choices = Beverage.allCases

for (index, item) in choices.enumerated() {
    print("\(index) -- \(item)")
}

//4. 枚举关联值

enum Barcode {
    case upc(Int ,Int ,Int ,Int)
    case qrCode(String)
}

var productBarcode =  Barcode.upc(10, 10, 10, 10)

productBarcode = Barcode.qrCode("helloworld")

//这时，原始的 Barcode.upc 和其整数关联值被新的 Barcode.qrCode 和其字符串关联值所替代。Barcode 类型的常量和变量可以存储一个 .upc 或者一个 .qrCode（连同它们的关联值），但是在同一时间只能存储这两个值中的一个。

//swift匹配
//匹配的时候可以将保存的值通过参数获取
switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let proCode) :
        print("QR code: \(proCode).")
}


//如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个 let 或者 var：
//将参数的标注
switch productBarcode {
    case let .upc(numberSystem, manufacturer, product, check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .qrCode(productCode):
        print("QR code: \(productCode).")
}
// 打印“QR code: ABCDEFGHIJKLMNOP.”


// 5. 原始值

//在 关联值 小节的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

print(ASCIIControlCharacter.tab.rawValue)

//ASCIIControlCharacter被设置成Character类型
//原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。


//6 .原始值的隐式赋值

//当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0

enum Planet1: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//rawValue获取值
print(Planet1.mercury.rawValue)

//当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。

enum CompassPoint1: String {
    case north, south, east, west
}

print(CompassPoint1.north.rawValue)

//通过rawValue来获取枚举置顶的枚举
//let position = CompassPoint1(rawValue: "north")

if let position = CompassPoint1(rawValue: "north"){
    print("position is \(position)");
}else {
    
}



//guard let position = CompassPoint1(rawValue: "north") else {
//
//
//}
//print("position1 is \(position)")


//7. 递归枚举

enum ArithmeticExpression1 {
    case number(Int)
    indirect case addition(ArithmeticExpression1, ArithmeticExpression1)
    indirect case multiplication(ArithmeticExpression1, ArithmeticExpression1)
}

//你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的：

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}


//使用

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))


//递归函数遍历
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

