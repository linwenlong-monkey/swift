import Cocoa

//集合（Set）用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。

//一个类型为了存储在集合中，该类型必须是可哈希化的——也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a==b,因此必须 a.hashValue == b.hashValue。

//1. 创建一个空集合

var letters = Set<Character> ()

letters.insert("a")
// letters 现在含有1个 Character 类型的值
letters = []
// letters 现在是一个空的 Set，但是它依然是 Set<Character> 类型

//2. 字面量创建集合
var favoritegenres: Set = ["Rock", "Classical", "Hip hop"]


//2 .访问和修改 count isEmpty insert remove contain

let count = favoritegenres.count

let empty: Bool = favoritegenres.isEmpty

favoritegenres.insert("four")
favoritegenres.remove("four")
favoritegenres.contains("")


//3. 遍历
for genre in favoritegenres {
    print("\(genre)")
}


//4. 集合的操作

//使用 intersection(_:) 方法根据两个集合中都包含的值创建的一个新的集合。
//使用 symmetricDifference(_:) 方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
//使用 union(_:) 方法根据两个集合的值创建一个新的集合。
//使用 subtracting(_:) 方法根据不在该集合中的值创建一个新的集合。

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

//使用“是否相等”运算符（==）来判断两个集合是否包含全部相同的值。
//使用 isSubset(of:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
//使用 isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值。
//使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
//使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值（是否没有交集）



