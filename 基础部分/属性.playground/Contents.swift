import Cocoa


//属性将值与特定的类、结构体或枚举关联。存储属性会将常量和变量存储为实例的一部分，而计算属性则是直接计算（而不是存储）值。计算属性可以用于类、结构体和枚举，而存储属性只能用于类和结构体。



//1. 存储属性
//一个存储属性就是存储在特定类或结构体实例里的一个常量或变量。存储属性可以是变量存储属性（用关键字 var 定义），也可以是常量存储属性（用关键字 let 定义
//声明一个属性的时候必须指定变量的类型或者给默认的值，给默认的值的时候可以自动推倒变量的类型
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOf = FixedLengthRange(firstValue: 10, length: 10)
rangeOf.firstValue = 20

//2. 常量结构体实例的存储属性
//如果创建了一个结构体实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使被声明为可变属性也不行:
//原因：因为 rangeOfFourItems 被声明成了常量（用 let 关键字），所以即使 firstValue 是一个可变属性，也无法再修改它了。
//这种行为是由于结构体属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
//属于引用类型的类则不一样。把一个引用类型的实例赋给一个常量后，依然可以修改该实例的可变属性。

let rangeOfFourItems = FixedLengthRange(firstValue: 20, length: 20)
//rangeOfFourItems.firstValue = 30 //会报错


//3. 延时加载存储属性

//延时加载存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延时加载存储属性。
//lazy属性必须声明为var，因为let的属性在构造的时候必须初始化，而lazy声明的属性有可能在构造之后才得到值
class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter() //
    var data = [String]()
    // 这里会提供数据管理功能
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建

print(manager.importer.fileName) //使用的时候创建
// DataImporter 实例的 importer 属性现在被创建了
// 输出“data.txt”
//注意: 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。



//4. 计算属性
//除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var point = Point()
    var size = Size()
    
    //计算属性
    var center: Point {
        get {
            let centerX = point.x + (size.width / 2)
            let centerY = point.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        //简化get
//        get {
//            Point(x: point.x + (size.width / 2), y: point.y + (size.height / 2))
//        }
        set(newCenter) { //设置point
            point.x = newCenter.x - (size.width / 2)
            point.y = newCenter.y - (size.height / 2)
        }
        //简化set方法，如果没有传递参数，默认是newValue
//        set {
//            point.x = newValue.x - (size.width / 2)
//            point.y = newValue.y - (size.height / 2)
//
//        }
    }
    
}

var square = Rect(point: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))

let center = square.center
print("center is \(center)")

square.center = Point(x: 15.0, y: 15.0)

print("point is \(square.point)")
print("center1 is \(center)")

print("center1 is \(square.center)")


//5. 只读的计算属性

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
    //只读
    var test: Double { //只读的计算属性
        width + height + depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//计算属性必须用var来声明，因为计算属性的值一般都是不确定的，而let声明的属性是创建了之后值就不能改变的


//6. 属性观察器 willset、didset

//每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。

//willSet 在新的值被设置之前调用
//didSet 在新的值被设置之后调用

struct StepCounter {
    var totalSteps: Int  {
        willSet(newTotalSteps) {
            print("将 totalSteps 的值设置为 \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
        
    }
}
var stepCounter = StepCounter(totalSteps: 10)
stepCounter.totalSteps = 200
// 将 totalSteps 的值设置为 200
// 增加了 200 步
stepCounter.totalSteps = 360
// 将 totalSteps 的值设置为 360
// 增加了 160 步
stepCounter.totalSteps = 896
// 将 totalSteps 的值设置为 896
// 增加了 536 步


enum SomeEnumeration {
    var storedTypeProperty: String {
        get {
            return "hello world"
        }
        set {
            print(newValue)
        }
    }
     
     var computedTypeProperty: Int {
        return 6
    }
}
