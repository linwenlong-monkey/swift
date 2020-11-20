import Cocoa

var str = "Hello, playground"

// 1.实例方法

//实例方法要写在它所属的类型的前后大括号之间。
//实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。
//实例方法只能被它所属的类的某个特定实例调用。
//实例方法不能脱离于现存的实例而被调用

//struct Counter {
//    var count: Int
//}

//函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用），详情参见 指定外部参数名。方法参数也一样，因为方法就是函数，只是这个函数与某个类型相关联了

//在类、结构题、枚举中的函数就是方法
class Counter {
    var count: Int = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by num: Int) {
        count += num
    }
    
    func reset() {
        count = 0
    }
    
    //2. self属性
    //类型的每一个实例都有一个隐含属性叫做 self，self 完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的 self 属性来引用当前实例。
    func mutil(by num: Int) {
        self.count *= num
    }
    
    
}

//self可以用来区分参数和实例属性的
//结构体和枚举都是值类型，默认情况下，值类型的属性不能在它的实例方法中被修改
//结构体
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        //这里利用self来区分两个x
        self.x > x
    }
    
  //结构体和枚举都是值类型，默认情况下，值类型的属性不能在它的实例方法中被修改
    //如果你确实需要在某个特定的方法中修改结构体或者枚举的属性 需要在方法前面加 mutating
    //可变方法
   mutating func moveBy(x deletaX: Double, y deletaY: Double) {
        self.x += deletaX
        self.y += deletaY
    }
    
    //可变方法改变self
    mutating func moveByToSelf(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}


//枚举
//mutating self表示修改自己的值
//
enum ClassT {
   case north, west, east, south
    
    var num: Int {
        get {
            10
        }
        set {
            
        }
    }
    
   mutating func next() {
        switch self {
         case .north:
            self = .south
        case .west :
            self = .east
        case .east:
            self = .west
        case .south:
            self = .north
        }
    }
}

var t = ClassT.east
t.next()


//2. 类型方法

//实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的 func 关键字之前加上关键字 static，来指定类型方法。类还可以用关键字 class 来指定，从而允许子类重写父类该方法的实现。
//在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。

class SomeClass {
    //类方法 ,在类方法中的self指的的类本身，而不是类的实例
    class func someTypeMethod() {
        print("class someTypeMethod")
        print("class someTypeMethod\(self)")
    }
    //类方法
   static func someTypeMethod1() {
        print("static someTypeMethod")
    }

}

SomeClass.someTypeMethod()

SomeClass.someTypeMethod1()

//例子
//实例的方法不能访问静态属性（static修饰的变量）
//静态的方法不能访问非静态的属性
struct LevelTracker {
    static var highUnLockedLevel = 1
    var currentLevel = 1
    
    static func unlock(level: Int) {
        if level > highUnLockedLevel {
            highUnLockedLevel = level
        }
    }
    
    static func isUnlocked(level: Int) -> Bool {
        level <= highUnLockedLevel
    }
    
    //在结构体的方法中改变属性的值需要mutating，因为结构题是值类型
    
    //因为允许在调用 advance(to:) 时候忽略返回值，不会产生编译警告，所以函数被标注为 @discardableResult 属性，更多关于属性信息，请参考 特性章节。
    @discardableResult
    mutating func advance(level: Int) -> Bool {
        if LevelTracker.isUnlocked(level: level) {
            self.currentLevel = level
            return true
        }else {
            return false
        }
    }
    
}

class Player {
    var traker = LevelTracker();
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level: level+1)
        traker.advance(level: level+1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "linwenlong")
player.complete(level: 2);

print("highest unlocked level is now \(LevelTracker.highUnLockedLevel)")

