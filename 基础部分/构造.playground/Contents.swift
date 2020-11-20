import UIKit

//1. 存储属性的初始赋值
//当你为存储型属性分配默认值或者在构造器中为设置初始值时，它们的值是被直接设置的，不会触发任何属性观察者。 不会执行didset和willset方法


//2. 构造器

//init() {

//}

//2.1在结构体中声明一个变量指定了类型的时候，没有构造器不会报错，因为结构体会默认生成一个构造器

//2.2在类中声明一个变量并指定了类型，如果没有初始化值的时候，会报错，因为类不会有默认的构造器
struct Fahrenheit {
    var temperature: Double
    
}

//Class 'claFahrenHeit' has no initializers
class claFahrenHeit {
    var temperature: Double
    
    //构造器
    init() {
        temperature = 32.0
    }
}


// 通过参数来构造

struct Celsius {
    var temperatureCelsius: Double
    
    //形参命名和实参标签
    init(fahrenheit: Double) {
        temperatureCelsius = fahrenheit
    }
    
    init(kelvin: Double) {
        temperatureCelsius = kelvin
    }
    
    //不带实参标签的构造器
    init(_ kelvin: Double) {
         temperatureCelsius = kelvin
    }
    
}

print("temperatureCelsius  is \(Celsius(fahrenheit: 273.15).temperatureCelsius)")


// 不通形参的构造器
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}


// 可选属性类型构造的时候不用初始化，会默认初始化为nil
//response 不用通过init方法来初始化，
//当 SurveyQuestion 的实例初始化时，它将自动赋值为 nil，表明“暂时还没有字符“。
class SurveyQuestion {
    var text: String
    //Return from initializer without initializing all stored properties
    //question是常量，一旦初始化了就不能改变了
    let question: String
    var response: String?
    init(text: String, question: String) {
        self.text = text
        self.question = question
    }
    func ask() {
        print(text)
    }
}


//3. 默认构造器
//如果结构体或类为所有属性提供了默认值，又没有提供任何自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器。这个默认构造器将简单地创建一个所有属性值都设置为它们默认值的实例。
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()


//4. 结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

//当你调用一个逐一成员构造器（memberwise initializer）时，可以省略任何一个有默认值的属性
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// 打印 "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// 打印 "0.0 0.0"



//4. 值类型的构造器代理

//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能避免多个构造器间的代码重复。
//对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内部调用 self.init。

struct Point {
    var x = 0.0, y = 0.0
}

//通过Size1 和 Point构造器来构造Rect
struct Rect {
    var origin: Point = Point()
    var size: Size = Size()
    //无参构造器，因为都有默认值
    
    //第一个 Rect 构造器 init()，在功能上跟没有自定义构造器时自动获得的默认构造器是一样的。这个构造器是函数体是空的，使用一对大括号 {} 来表示。调用这个构造器将返回一个 Rect 实例，它的 origin 和 size 属性都使用定义时的默认值 Point(x: 0.0, y: 0.0) 和 Size(width: 0.0, height: 0.0)：
    init() {
    }
    
    //第二个 Rect 构造器 init(origin:size:)，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的。这个构造器只是简单地将 origin 和 size 的实参值赋给对应的存储型属性：
    init(origin:Point , size:Size) {
        self.origin = origin;
        self.size = size;
    }
    
    //自己调用自己的构造器
    
    //第三个 Rect 构造器 init(center:size:) 稍微复杂一点。它先通过 center 和 size 的值计算出 origin 的坐标，然后再调用（或者说代理给）init(origin:size:) 构造器来将新的 origin 和 size 值赋值到对应的属性中：
    init(center: Point ,size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin:Point(x: originX, y: originY), size:size)
    }
}



//5. 类的继承和构造过程

//5.1 指定构造器和便利构造器

//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并调用合适的父类构造器让构造过程沿着父类链继续往上进行。

//便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为部分形参提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。

//你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。


//类的指定构造器的写法跟值类型简单构造器一样：

//init(parameters) {
//    statements
//}


//便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分开：

//convenience init(parameters) {
//    statements
//}


//5.2 类类型的构造器代理

//  指定构造器必须调用其直接父类的的指定构造器。
//  便利构造器必须调用同类中定义的其它构造器。
//  便利构造器最后必须调用指定构造器。
// 指定构造器必须总是向上代理
// 便利构造器必须总是横向代理





//6. 可失败的构造器

//

//结构体
//在init后面添加？表示可以返回nil，nil表示构造的过程失败了
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

//枚举类型的可失败的构造器

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    //在init后面添加？表示可以返回nil，nil表示构造的过程失败了
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}


//7. 构造失败的传递

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name  = name
    }
}

class CartItem: Product {
    let quantity: Int
    
//1.如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器///2.。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败
    //重写父类的失败构造器，可以改成非失败的构造器
    override init?(name: String) {
        //一般都是先初始化自己的属性，然后初始化父类
        self.quantity = 1
        super.init(name: name)
    }
    
    init?(name: String, quantity: Int) {
        
        if quantity < 1 {
            return nil
        }
        
       
       // Property 'self.quantity' not initialized at super.init cal
        self.quantity = quantity;
        super.init(name: name)
         //先判断quantity 之后再调用父类的可失败的构造
    }
}


class Document {
    var name: String?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
         //如果属性是从父类中继承的，则必须写在父亲的构造器方法之后
        super.init()
        self.name = "[Untitled]"
    }
    
    //重写父类的失败构造器
    override init(name: String) {
         //如果属性是从父类中继承的，则必须写在父亲的构造器方法之后
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    //你可以在子类的不可失败构造器中使用强制解包来调用父类的可失败构造器
    //它在构造过程中使用了父类的可失败构造器 init?(name:)：
    override init() {
        super.init(name: "[Untitled]")!
    }
}




//8. 必要构造器

//通过required关键之修饰，这个构造器在子类中必须要实现

//如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。
class SomeClass {
    var name: String
    
    //Return from initializer without initializing all stored properties
    required init() {
        // 构造器的实现代码
        self.name = "unName"
    }
    
    init(name: String) {
        self.name = name
    }
    
    
}

class SomeSubClass: SomeClass {
    required init() {
        super.init(name: "unName")
    }
}











