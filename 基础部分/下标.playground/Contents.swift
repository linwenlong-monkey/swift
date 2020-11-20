import UIKit


//下标语法可以用在结构体、类、枚举当中
//语法
//subscript(index: Int) -> Int {
//    // 返回一个适当的 Int 类型的值
//}

//subscript
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let timesTable = TimesTable(multiplier: 3)

let result = timesTable[6]

print("result is \(result)")


//枚举

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}


let mars = Planet[4]
print(mars)
