import UIKit


//扩展

///1.扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能。

///2.扩展和 Objective-C 的分类很相似。（与 Objective-C 分类不同的是，Swift 扩展是没有名字的。）


///3.可以添加计算型实例属性和计算型类属性

///4.定义实例方法和类方法

///5.定义下标

///6.定义和使用新的嵌套类型

///7.使已经存在的类型遵循一个协议


//1.语法

///使用 extension 关键字声明扩展：

/**
extension SomeType {
  // 在这里给 SomeType 添加新的功能
}
*/

///扩展可以扩充一个现有的类型，给它添加一个或多个协议。协议名称的写法和类或者结构体一样

/**
 extension SomeType: SomeProtocol, AnotherProtocol {
  // 协议所需要的实现写在这里
}
 */

//

extension Double {
    var mm: Double {
        return self / 1_000.0
    }
    
    var ft: Double { return self / 3.28084 }
    
    //静态属性了
    static var maxValue: Double {
        return 10000.0
    }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")



//2. 构造器

///扩展可以给现有的类型添加新的构造器，它使你可以把自定义类型作为参数来供其他类型的构造器使用，或者在类型的原始实现上添加额外的构造选项

///扩展可以给一个类添加新的便利构造器，但是它们不能给类添加新的指定构造器或者析构器。指定构造器和析构器必须始终由类的原始实现提供。

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

//因为 Rect 结构体给所有的属性都提供了默认值，所以它自动获得了一个默认构造器和一个成员构造器，就像 默认构造器 中描述的一样。这些构造器可以用来创建新的 Rect 实例

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))

//添加新的构造器
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


//3. 方法

//1.扩展可以给现有类型添加新的实例方法和类方法

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

1.repetitions(task: {
    print("111")
})


// 通过扩展添加的实例方法同样也可以修改（或 mutating（改变））实例本身。结构体和枚举的方法，若是可以修改 self 或者它自己的属性，则必须将这个实例方法标记为 mutating，就像是改变了方法的原始实现。
//可变实例方法

extension Int {
    //结构体或者枚举的方法都必须加mutating才能修改自己
    mutating func square() {
        self = self * self
    }
}




//4. 下标

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]
// 返回 5
746381295[1]
// 返回 9
746381295[2]
// 返回 2
746381295[8]
// 返回 7


//5. 嵌套类型

///扩展可以给现有的类，结构体，还有枚举添加新的嵌套类型：

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}


func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// 打印“+ + - 0 - 0 + ”


