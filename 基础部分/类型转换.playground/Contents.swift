import UIKit

// as、 is、Any、AnyObject

//1 .as is

//这两个操作符分别提供了一种简单达意的方式去检查值的类型或者转换它的类型。

//你也可以用它来检查一个类型是否遵循了某个协议


class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}


//创建数组
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]


// 数组 library 的类型被推断为 [MediaItem]

///在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是，若你迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作，你需要检查它们的类型或者向下转换它们到其它类型，就像下面描述的一样。


//检查类型

///用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {//检查是否是Movie类型
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// 打印“Media library contains 2 movies and 3 songs”


// 向下转型

///1.某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试用类型转换操作符（as? 或 as!）向下转到它的子类型。

///2.因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式 as? 返回一个你试图向下转成的类型的可选值。强制形式
///3.as! 把试图向下转型和强制解包转换结果结合为一个操作。
///4.当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。


for item in library {
    if let movie = item as? Movie {//
        print("Movie: \(movie.name), dir. \(movie.director)")
    }else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

//转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用。


//2. Any、AnyObject

///Any 可以表示任何类型，包括函数类型。
///AnyObject 可以表示任何类类型的实例。

var things = [Any]() //可以包含任意类型

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })


for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0.0 as Double:
        print("zero as a Double")
    case let someInt as Int: //装置转换为Int
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}


///Any 类型可以表示所有类型的值，包括可选类型。Swift 会在你用 Any 类型来表示一个可选值的时候，给你一个警告。如果你确实想使用 Any 类型来承载可选值，你可以使用 as 操作符显式转换为 Any，如下所示：

let optionalNumber: Int? = 3
things.append(optionalNumber)        // 警告
things.append(optionalNumber as Any) // 没有警告

