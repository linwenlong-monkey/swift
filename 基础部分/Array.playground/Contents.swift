import Cocoa


//1. 声明空数组

var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
someInts.append(3) //添加数据
// someInts 现在包含一个 Int 值
someInts = [] //变为空数组
// someInts 现在是空数组，但是仍然是 [Int] 类型的

//2. 创建一个带默认值的数据
var threeDouble = Array(repeating: 0.3, count: 3)
print("threeDouble is \(threeDouble)")
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]

//数据合并 不是同一类型的数组不能相加

var sixDoubles = threeDouble + anotherThreeDoubles


//3. 字面量创建数组

var shoppingList: [String] = ["eggs", "mills", "origin"]



//4. 访问和修改数组 count  isEmpty append
print("count is \(shoppingList.count)")
print("shoppingList is \(shoppingList.isEmpty)")
//添加append()
shoppingList.append("flour")

//通过+号添加
shoppingList += ["five"]
//添加多个
shoppingList += ["six", "seven"]


//访问数据通过下标
var firstItem = shoppingList[0]

//修改数组的值
shoppingList[0] = "Six eggs"

//同时修改多个值
shoppingList[4...6] = ["Bananas", "Apples"]

//插入 insert
shoppingList.insert("Maple Syrup", at: 0)

//对应的是移除 remove
shoppingList.remove(at: 0)

//移除第一个和最后一个 removeFirst removeLast
shoppingList.removeLast()
shoppingList.removeFirst()


//5. 数组遍历
for item in shoppingList {
    print(item)
}


for (index, value) in shoppingList.enumerated() {
    
    print("Item is \(index + 1) value is \(value)")
//    print("Item \(String(index + 1)): \(value)")
}











