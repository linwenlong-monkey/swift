import UIKit

// 类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现
//还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。

//1. 语法

/**
 protocol SomeProtocol {
     // 这里是协议的定义部分
 }
 */

//遵循协议
/**
 struct SomeStructure: FirstProtocol, AnotherProtocol {
     // 这里是结构体的定义部分
 
 }
 */

//类遵循协议，应该将继承写在前面

/**
 class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
     // 这里是类的定义部分
 
 }
 */


//2. 属性要求

///2.1协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性
///2.2协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型。
///2.3协议还指定属性是可读的还是可读可写的。
///2.4如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。
///2.5如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。

///2.6协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示：

protocol SomeProtocol {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}


///在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性：

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}



//例子
///FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}


var john = Person(fullName: "John Appleseed")
john.fullName = "Appleseed"
// john.fullName 为 "John Appleseed"



//将fullname作为存储属性来实现
//Starship 类把 fullName 作为只读的计算属性来实现。每一个 Starship 类的实例都有一个名为 name 的非可选属性和一个名为 prefix 的可选属性。 当 prefix 存在时，计算属性 fullName 会将 prefix 插入到 name 之前，从而得到一个带有 prefix 的 fullName。
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName 为 "USS Enterprise"


//3. 方法


///协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法提供默认参数。

///正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。即使在类实现时，类方法要求使用 class 或 static 作为关键字前缀，前面的规则仍然适用：

protocol RandomNumberGenerator {
    func random() -> Double
}



class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// 打印 “Here's a random number: 0.37464991998171”
print("And another one: \(generator.random())")
// 打印 “And another one: 0.729023776863283”


//4. 异变方法要求
///有时需要在方法中改变（或异变）方法所属的实例。例如，在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前

///实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。

protocol Togglable {
    mutating func toggle()
}

///mutating 枚举或者结构体修改实例
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch 现在的值为 .on


//5. 构造器

///协议可以要求遵循协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：

///你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
///使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。


protocol SomeProtocol1 {
    init()
}

class SomeSuperClass1 {
    init() {
        // 这里是构造器的实现部分
    }
}
//required 遵循协议的构造器
class SomeSubClass1: SomeSuperClass1, SomeProtocol1 {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        
    }
}


//6. 协议作为类型

///作为函数、方法或构造器中的参数类型或返回值类型
///作为常量、变量或属性的类型
///作为数组、字典或其他容器中的元素类型

protocol RandomNumberGenerator1 {
    func random() -> Double
}


///generator 属性的类型为 RandomNumberGenerator，因此任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator，除此之外并无其他要求。并且由于其类型是 RandomNumberGenerator，在 Dice 类中与 generator 交互的代码，必须适用于所有 generator 实例都遵循的方法。这句话的意思是不能使用由 generator 底层类型提供的任何方法或属性。但是你可以通过向下转型，从协议类型转换成底层实现类型，比如从父类向下转型为子类。请参考 向下转型。

///传递的generator可以是实现了RandomNumberGenerator1协议的类

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator1
    init(sides: Int, generator: RandomNumberGenerator1) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

struct GeneratorS: RandomNumberGenerator1 {
    func random() -> Double {
        return 10.0
    }
}

let dice = Dice(sides: 19, generator: GeneratorS())


print("roll is \(dice.roll())")



//7. 委托

///委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
//里面传递的是实现了DiceGame的类或结构体
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}


class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: GeneratorS())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}


class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}


let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns


//8. 扩展添加协议的遵循

protocol TextRepresentable {
    var textualDescription: String { get }

}

extension Dice: TextRepresentable{
    
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
    
}

let d12 = Dice(sides: 12, generator: GeneratorS())
print(d12.textualDescription)
// 打印 “A 12-sided dice”


//9. 有条件的遵循协议

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
    
        let itemsAsText = self.map{ $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let d6 = Dice(sides: 12, generator: GeneratorS())
let myDice = [d6, d12]
print(myDice.textualDescription)
// 打印 "[A 6-sided dice, A 12-sided dice]"


//10. 在扩展里声明采纳协议
///当一个类型已经符合了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空的扩展来让它采纳该协议：


struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

//Hamster 在定义的时候已经遵循了协议的所有要求，显示遵循协议
extension Hamster: TextRepresentable {}

//从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用：


let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// 打印 “A hamster named Simon”


//11 .协议类型的集合
///下面的三个变量都遵循TextRepresentable协议
let things: [TextRepresentable] = [simonTheHamster, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}


//12. 协议的继承

///协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 这里是协议的定义部分
}


// 例子

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}
//遵循PrettyTextRepresentable的协议，则必须也要满足TextRepresentable中的所有要求


extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return "prettyTextualDescription"
    }
    
    var textualDescription: String {
        return "textualDescription"
    }
}



//13. 类专属的协议
///你通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳（以及非结构体或者非枚举的类型）。
/**
 protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
     // 这里是类专属协议的定义部分
 }
 */


//14. 协议合成类型

///协议组合使用 SomeProtocol & AnotherProtocol 的形式

//协议组合也能包含类类型
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}

//传递的celebrator同时满足Named & Aged两个协议
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// 打印 “Happy birthday Malcolm - you're 21!”



//协议和类类型组合
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}





let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
///beginConcert(in:) 函数接受一个类型为 Location & Named 的参数，这意味着“任何 Location 的子类，并且遵循 Named 协议”。例如，City 就满足这样的条件。
// 打印 "Hello, Seattle!"



//15. 检查协议的一致性

//你可以使用 类型转换 中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换协议的语法与检查和转换类型是完全一样的

/// is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false

/// as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil

/// as! 将实例强制向下转换到某个协议类型，如果强转失败，将触发运行时错误。


protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

//AnyObject只能存储类类型
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]


//is
for object in objects {
    var count = 0
    if object is HasArea { //判断有几个对象遵循了HasArea协议
        count += 1
    }
}

//as
///as? 转换失败会返回nil
///as！转换失败会报运行时错误
for objcet in objects {
    if let objectArea = objcet as? HasArea {
        print("Area is \(objectArea.area)")
    }else {
        print("没有遵循HasArea")
    }
}


//16. 协议扩展

//为HasArea协议扩展方法
extension HasArea {
    func add(num1: Int, num2: Int) -> Int {
        num1 + num2
    }
}


//下面遵循HasArea自动获得add方法，不需要在做其他操作
let cirle1 = Circle(radius: 23.9)
cirle1.add(num1: 10, num2: 20)


//17. 为协议扩展添加限制条件
//如果集合中的所有元素都一致，allEqual() 方法才返回 true。
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}



//18. 可选的协议要求
 
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}
