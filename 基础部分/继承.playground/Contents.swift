import UIKit



//1. 定义一个基类

class Vehicle {
    var currentSpeed = 0.0 //存储属性
    
    var description: String { //计算属性
        return "traveling at \(currentSpeed) miles per hour"
    }
    //方法
    func makeNoise() {
        print("Vehicle makeNoise");
    }
    
    subscript(a: Double)->Double {
        return currentSpeed * a
    }
    
    //防止被子类重写
    //你可以通过把方法，属性或下标标记为 final 来防止它们被重写，
    final var finalVar = 1.0
    final func finalFuc() {
        
    }
    final subscript(a: String)-> String {
        return  a + "hello"
    }
    
    //静态方法和静态属性 也不能被重写
    //Cannot override static property
    static var name: String?
    //Cannot override static method
    static func staFuc() {
        
    }
    
    //class修饰的类方法 可以被重写，希望不被重写需要加final
    class func claFuc(){ //可以被重写
        
    }
    
    //class修饰计算属性 不能修饰存储属性 类属性
    class var count: Int {
        return  10
    }
    
    final class func finClaFuc() {
        
    }
    
    
}

// 继承

//语法


//class SomeClass: SomeSuperClass {
//
//}


//子类可以继承实例方法、类方法、实例属性、类属性，获取重写方法
//子类继承的类方法、类属性只能有子类类调用
//子类继承的实例方法、实例属性只能用子类实例调用
//子类可以重写父类的方法

class Bicycle: Vehicle {
    var hasBasket = false
    var gear = 1
    //重写 前面加 override
    override func makeNoise() {
        print("Bicycle makeNoise")
    }
    
    
    //重写下标a
    override subscript(a: Double) -> Double {
         return currentSpeed * a * a
    }
    
    //重写计算属性
    //你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
    override var description: String {
        get {//super.description访问父类的description计算属性
            return super.description + "gear is \(gear)"
        }
    }
    
    //重写存储属性观察器
    override var currentSpeed: Double {
        willSet { //这里面是即将设置的newValue
            newValue
        }
        didSet { //这里面是oldValue
            
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
    
//    override static var name: String? {
//        didSet {
//
//        }
//    }
    
    override class func claFuc() {
        
    }
    
//    override static func staFuc() {
//
//    }
    


}


let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 2.0
bicycle.makeNoise()

if let name = Bicycle.name {
    print("name is \(name)")
}else {
    print("Bicycle.name == nil")
}


//3. 访问超类的方法，属性及下标

//当你在子类中重写超类的方法，属性或下标时，有时在你的重写版本中使用已经存在的超类实现会大有裨益。比如，你可以完善已有实现的行为，或在一个继承来的变量中存储一个修改过的值。

//在合适的地方，你可以通过使用 super 前缀来访问超类版本的方法，属性或下标：
//
//在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
//在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
//在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。


//4. class和static的相同点和不同点

//相同点

//1.都可以用来修饰方法，static修饰的是静态方法，class修饰的是类方法，都不可以访问非静态存储属性
//2.都可以用来修饰计算属性

//不同点

//1.class不能修饰存储属性
//2.class修饰的计算可以被重写，static修饰的不能被重写（static修饰的属性和方法都不能被重写）
//3.static可以修饰存储属性，static修饰的存储属性成为静态变量
//4.static修饰的静态方法不能被重写，class修饰的类方法可以被重写
//5.class修饰的类方法被重写时，可以用static让方法变为静态方法
//6.class修饰的计算属性被重写时，可以使用static让其变为静态属性，但他的子类就不能被重写了。
//7.class只能在类中修饰，static可以在类、结构体或者枚举中都可以使用


//Class methods are only allowed within classes; use 'static' to declare a static method
struct test {
//    class func make(){
//
//    }
    static func make() {
        
    }
}

//可以通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 。这样的类是不可被继承的，试图继承这样的类会导致编译报错。

final class finalClass {
    
}

//Inheritance from a final class 'finalClass'
//class finalChildClass: finalClass {
//    
//}
