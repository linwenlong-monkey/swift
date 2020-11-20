import UIKit


//1. 可选链式调用

//可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是 nil，那么调用将返回 nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil。


//2. 使用可选链式调用代替强制展开 （!）

//可选链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可选值。例如，使用可选链式调用访问属性，当可选链式调用成功时，如果属性原本的返回结果是 Int 类型，则会变为 Int? 类型。

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
    
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    //返回可选值
    func buildingIdentifier() -> String? { //可以返回可选值
        if buildingName != nil {
            return buildingName
        }else if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        }else {
            return nil
        }
    }
}


class Residence {
    
    //房间
    var rooms = [Room]()
    
    var numberOfRooms: Int { //计算属性
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
           return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    //地址
    var address: Address?
    
    
}



class Person {
    var residence: Residence?
}


let person = Person()

//这里会发生运行时错误，因为residence为nil
//person.residence!.numberOfRooms

//这里会返回nil
let residence = person.residence

let num = person.residence?.numberOfRooms

//通过if let
if let roomcount = person.residence?.numberOfRooms {
     print("John's residence has \(roomcount) room(s).")
}else {
    print("Unable to retrieve the number of rooms.")
}

person.residence = Residence()

let num1 = person.residence?.numberOfRooms

// 通过可选值来调用方法
//如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是 Void?，而不是 Void，因为通过可选链式调用得到的返回值都是可选的。这样我们就可以使用 if 语句来判断能否成功调用 printNumberOfRooms() 方法，即使方法本身没有定义返回值。通过判断返回值是否为 nil 可以判断调用是否成功：
if person.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// 打印“It was not possible to print the number of rooms.”


// 通过可选值来调用属性
//检查赋值是否成功
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"

if (person.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// 打印“It was not possible to set the address.”

print("room count is \(String(describing: person.residence?.numberOfRooms))")

let room = Room(name: "first")

person.residence?.rooms.append(room)

if (person.residence?[0] = room) != nil {
    print("rooms is \(person.residence?.numberOfRooms ?? 0)")
}else {
     print("It was not rooms to set the address.")
}

//通过可选择来访问下标
if let firstRoomName = person.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 打印“Unable to retrieve the first room name.”


//字典
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
//字典通过key访问的时候返回的是一个可选值类型
testScores["Dave"]?[0]


//连接多层可选链式调用 //
//返回string？
if let johnsStreet = person.residence?.address?.street {
    print("John's street name is \(johnsStreet.count).")
} else {
    print("Unable to retrieve the address.")
}
