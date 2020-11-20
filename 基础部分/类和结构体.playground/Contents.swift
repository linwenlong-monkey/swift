import Cocoa


//类和结构体的共同点

    //1.定义属性存储值
    //2.定义方法用于提供功能
    //3.定义下标操作用于通过下标语法访问它们的值
    //4.定义构造器
    //5.通过扩展（exextion）提供额外的方法
    //6.通过协议（protocol）提供某种功能

//类和结构题的不同点
    
    //1.类可以通过继承来获得父类的方法或者属性
    //2.类型转换允许在运行时检查和解释一个类实例的类型
    //3.析构器允许一个类实例释放任何其所分配的资源
    //4.引用计算允许对一个类的多次引用
    //5.结构体是值类型，类是引用类型

//注:类支持的附加功能是以增加复杂性为代价的。作为一般准则，优先使用结构体，因为它们更容易理解，仅在适当或必要时才使用类。实际上，这意味着你的大多数自定义数据类型都会是结构体和枚举。更多详细的比


//1. 定义结构体和类

//1. 如果结构体和类中的属性没有初始化值的时候，需要提供初始化函数初始化这些变量
//2. 如果结构体和类中没有初始化函数，默认会替提供一个不带参数的构造器

struct Resolution {
    var width = 0
    var height = 0
}


class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var fremrate = 0.0
    var name: String? //表示如果没有值就设置为nil
}

//2. 创建结构体和类实例
var resolution = Resolution()
var vidoMode = VideoMode()

//3. 属性访问
//获取
print("The width of resolution is \(resolution.width)")
print("The width of vidoMode is \(vidoMode.resolution.width)")

//设置
resolution.width = 100
print("The width of resolution is \(resolution.width)")

//4. 结构体类型会默认有一个逐一构造器 ，类实例没有逐一构造器

//所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
Resolution(width: 200, height: 200)


//5. 结构体和枚举是值类型

//值类型是这样一种类型，当它被赋值给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。

    //Swift 中所有的基本类型：整数（integer）、浮点数（floating-point number）、布尔值（boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，其底层也是使用结构体实现的。


    //Swift 中所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型的属性，在代码中传递的时候都会被复制。
    //标准库定义的集合，例如数组，字典和字符串，都对复制进行了优化以降低性能成本。新集合不会立即复制，而是跟原集合共享同一份内存，共享同样的元素。在集合的某个副本要被修改前，才会复制它的元素。而你在代码中看起来就像是立即发生了复制。

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048

print("cinema is now  \(cinema.width) pixels wide")
// 打印 "cinema is now 2048 pixels wide"
print("hd is still \(hd.width) pixels wide")
// 打印 "hd is still 1920 pixels wide"



//6. 类是引用类型

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.fremrate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.fremrate = 30.0


//tenEighty的fremrate一样被修改成了30.0
print("The frameRate property of tenEighty is now \(tenEighty.fremrate)")
// 打印 "The frameRate property of theEighty is now 30.0"


//7. 恒等运算符 === !==
//用来判断两个变量或者常量引用了同一个实例

print(alsoTenEighty === tenEighty)

var otherTenEighty = tenEighty

print(alsoTenEighty === otherTenEighty)
 

