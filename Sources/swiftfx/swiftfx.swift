import Foundation

public func synchronized<T>(_ obj: Any, _ f: () throws -> T) rethrows -> T {
    objc_sync_enter(obj)
    defer { objc_sync_exit(obj) }
    
    return try f()
}

//var mut = 1
//synchronized(mut) {
//    // mut is not changed by other threads.
//}

public func time<Result>(name: StaticString = #function,
                         line: Int = #line,
                         _ f: () -> Result) -> Result {
    let startTime = DispatchTime.now()
    let result = f()
    let endTime = DispatchTime.now()
    let diff = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000 as Double
    print("\(name) (line \(line)): \(diff) sec")
    return result
}

public func not(_ cond: Bool) -> Bool {
    !cond
}

//not(true)
//not(equal(2, 3))

public func equal<T: Equatable>(_ a: T, _ b: T) -> Bool where T: Any {
    a == b
}

public func first<T>(_ coll: T) -> T.Element? where T : Sequence,
                                                    T.Iterator.Element : Any {
    Array(coll).first
}

public func last<T>(_ coll: T) -> T.Element? where T : Sequence,
                                                   T.Iterator.Element : Any {
    Array(coll).last
}

//first([1,2])
//last([1,2])

public func type(_ any: Any) -> Any.Type {
    return type(of: any)
}

// (* 0.5 200)

// https://clojuredocs.org/clojure.core/*
public func multiply(_ op1: Double, _ op2: Double) -> Double {
    op1 * op2
}

// aclone
// https://clojuredocs.org/clojure.core/aclone


// and
// https://clojuredocs.org/clojure.core/and
// (and true true)

public func and(_ op1: Bool, _ op2: Bool) -> Bool {
    op1 && op2
}

//and(true, true)
//and(true, false)

/// 'or'
// https://clojuredocs.org/clojure.core/or
public func or(_ op1: Bool, _ op2: Bool) -> Bool {
    op1 || op2
}

//or(true, true)
//or(true, false)
//or(false, false)

public func isDouble(_ item: Any) -> Bool {
    (item as? Double) != nil ? true : false
}

public func isFloat(_ item: Any) -> Bool {
    (item as? Float) != nil ? true : false
}

public func isEven(_ item: Any) -> Bool {
    ((item as? Int)?.isMultiple(of: 2) ?? false) ? true : false
}

public func isOdd(_ item: Any) -> Bool {
    ((item as? Int)?.isMultiple(of: 2) ?? true) ? false : true
}

// (rest [1 2 3 4 5])            ;;=> (2 3 4 5)
// (rest ["a" "b" "c" "d" "e"])  ;;=> ("b" "c" "d" "e")

// ordering issue: set, dictionary
func rest<T>(_ col: T) -> Array<T.Element> where T : Sequence,
                                                 T.Iterator.Element : Any {
    col.dropFirst(1).map { $0 }
}

// let res = rest(hashSet(["a", "b", "c", "d", "e"]))
//let res = rest(["a":1, "b":2, "c":3])
//res

// user=> (peek [1 2 3 4])
// ;;=> 4

// (vec (range 0 10))
//func vec<T>(_ range: LazyRange) -> Array<T> {
//    return range
//}

func peek<T>(_ col: T) -> T.Element? where T : Sequence,
                                           T.Iterator.Element : Any {
    col.prefix(1).map { $0 }.first
}

// (pop [1 2 3])
func pop<T>(_ col: T) -> [T.Element] where T : Sequence,
                                           T.Iterator.Element : Any {
    col.dropLast()
}

//peek([1,2,3,4])
//pop([1,2,3])

public func time(_ f: (@escaping () -> ())) {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    f()
    
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Elapsed Time: \(timeElapsed)")
}

//time {
//    drop(2, [1,2,3,4])
//}

func hashSet<T>(_ arr: [T]) -> Set<T> {
    Set<T>(arr)
}

func rand(_ digit: Double = 1.0) -> Double {
    Double.random(in: 0..<digit)
}

//rand()
//rand()
//rand()
//rand()
//rand(10)
//rand(100)
//rand(2)
//rand(2)
//rand(2)
//rand(2)
//rand(2)

//let set = hashSet([1,2,3])
//set

// (hash-set 1 2 3)

func drop<T>(_ upto: Int, _ collection: T) -> [T.Element]
    where T : Sequence,
          T.Iterator.Element : Any,
          T.Iterator.Element : Comparable {
    return collection
        .sorted(by: { $0 > $1 })
        .suffix(upto)
        .map { $0 }
    
//    if let dict = collection as? [String:Any] {
//        let res = dict
//            .sorted(by: { $0.key < $1.key })
//            .suffix(2)
//
//        var array = [T.Element]()
//        for (k,v) in res {
//            array.append([k:v] as! T.Element)
//        }
//
//        return array
//    } else {
//        return collection
//            .sorted(by: { $0 > $1 })
//            .suffix(upto)
//            .map { $0 }
//    }
}

//extension Dictionary: Equatable, Comparable {
//    static func ==<K, L: Hashable, R: Hashable>(lhs: [K: L], rhs: [K: R] ) -> Bool {
//       (lhs as NSDictionary).isEqual(to: rhs)
//    }
//}

//drop(2, [1,2,3,4])
//drop(2, Set([1,2,3,4]))

//drop(2, (0,0))


//extension Dictionary {
//
//}
//let d = ["a":1, "b": 2, "c": 3]
//drop(2, d)

//let d = ["a":"a", "b": "b", "c": "c", "d" : "d"]
//    .sorted(by: { $0.key < $1.key })
//    .suffix(2)
//
//for (k,v) in d {
//    print("v : \(v)")
//}



//cljs.user=> (drop 2 [1 2 3 4])
//(3 4)
//cljs.user=> (drop 3 [1 2 3 4])
//(4)
//cljs.user=> (drop 3 #{1 2 3 4})
//(4)
//cljs.user=> (drop 5 #{1 2 3 4})
//()
//cljs.user=> (drop 1 #{1 2 3 4})
//(2 3 4)
//cljs.user=> (drop 1 {:a "a" :b "b"})
//([:b "b"])
//cljs.user=> (drop 2 {:a "a" :b "b"})
//()
//cljs.user=> (drop 3 {:a "a" :b "b"})
//()
//cljs.user=> (drop -1 {:a "a" :b "b"})
//([:a "a"] [:b "b"])

/// `cycle`
/// "Returns a lazy (infinite!) sequence of repetitions of the items in coll."
/// - Parameter range: range to cycle repeatedly
func get(_ collection: Any, _ key: Any) -> Any? {
    switch collection {
        case is [String:Any]:
            guard let key = key as? String else { return nil }
            guard let collection = collection as? [String:Any] else { return nil }
            
            return collection[key]
        case is Array<Any>:
            guard let key = key as? Int else { return nil }
            guard let array = collection as? Array<Any> else { return nil }
            return array.count - 1 > key ? array[key] : nil
        case is Set<Int>:
            guard let key = key as? Int else { return nil }
            guard let set = collection as? Set<Int> else { return nil }
            let array = Array(set).sorted(by: <)
            return array.count - 1 > key ? array[key] : nil
        default:
            return nil
    }
}

//get(Set<Int>([0,1,2,3,4,5]), 7)
//get([0, 1, 2, 3, 4, 5], 7)
//get(["a":"a", "b":"b"], "c")

/// `cycle`
/// "Returns a lazy (infinite!) sequence of repetitions of the items in coll."
/// - Parameter range: range to cycle repeatedly
func cycle(_ range: LazySequence<Array<Int>>) ->
    CycleSequence<Range<LazySequence<Array<Int>>.Element>> {
//    AnySequence<IndexingIterator<Array<Int>>.Element> {
    return CycleSequence(cycling: range.first!..<range.last!)
//    return cycleSequence(for: range)
}

// take(10, cycle(range(0, 2)))
// [0, 1, 0, 1, 0, 1, 0, 1, 0, 1]

/// `take`
///
/// "Returns a lazy sequence of the first n items in coll, or all items if
/// there are fewer than n.  Returns a stateful transducer when
/// no collection is provided."
/// - Parameter n: number to take out of range
/// - Parameter range: given range of array
func take<S: Sequence>(_ n: Int, _ range: S) -> [S.Element] {
    zip(1...n, range).map { $1 }
}

/// `map`
///
/// "Returns a lazy sequence of the first n items in coll, or all items if
/// there are fewer than n.  Returns a stateful transducer when
/// no collection is provided."
/// - Parameter upto: number to take out of range
/// - Parameter range: given range of array
func map<A,B>(_ arr: [A], _ fn: ((A) -> B)) -> [B] where A: Equatable, B: Equatable {
    var res = [B]()

    for i in arr {
        res.append(fn(i))
    }

    return res
}

/// `map`
///
/// "Returns a lazy sequence of the first n items in coll, or all items if
/// there are fewer than n.  Returns a stateful transducer when
/// no collection is provided."
/// - Parameter upto: number to take out of range
/// - Parameter range: given range of array
func filter<F>(_ arr: [F], _ fn: ((F) -> Bool)) -> [F] {
    var res = [F]()

    for i in arr {
        if fn(i) {
            res.append(i)
        }
    }

    return res
}

/// `map`
///
/// "Returns a lazy sequence of the first n items in coll, or all items if
/// there are fewer than n.  Returns a stateful transducer when
/// no collection is provided."
/// - Parameter upto: number to take out of range
/// - Parameter range: given range of array
func reduce<F>(_ arr: [F], _ fn: ((F) -> F)) -> F where F: Numeric {
    var res: F = 0

    for i in arr {
        res += fn(i)
    }

    return res
}

/// `map`
///
/// "Returns a lazy sequence of the first n items in coll, or all items if
/// there are fewer than n.  Returns a stateful transducer when
/// no collection is provided."
/// - Parameter upto: number to take out of range
/// - Parameter range: given range of array

typealias LazyRange = LazySequence<Array<Int>>
func range(_ from: Int, _ to: Int) -> LazyRange {
    Array((from...to)).lazy
}

public struct CycleSequence<C: Collection>: Sequence {
    public let cycledElements: C

    public init(cycling cycledElements: C) {
        self.cycledElements = cycledElements
    }

    public func makeIterator() -> CycleIterator<C> {
        return CycleIterator(cycling: cycledElements)
    }
}

public struct CycleIterator<C: Collection>: IteratorProtocol {
    public let cycledElements: C
    public private(set) var cycledElementIterator: C.Iterator

    public init(cycling cycledElements: C) {
        self.cycledElements = cycledElements
        self.cycledElementIterator = cycledElements.makeIterator()
    }

    public mutating func next() -> C.Iterator.Element? {
        if let next = cycledElementIterator.next() {
            return next
        } else {
            self.cycledElementIterator = cycledElements.makeIterator() // Cycle back again
            return cycledElementIterator.next()
        }
    }
}

//let res2 = map(range(0, 10)) { String($0) }
// print(res2)
// ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

//let res3 = filter(range(0,6)) { $0 % 2 == 0 }
// print(res3)
// [0, 2, 4, 6]

//let arr = [1, 2, 3]
//var a: Int = 0

//let sum = reduce(range(0, 100), +)
// print(sum)
// 5050


//let s1 = CycleSequence(cycling: [1, 2, 3]) // Works with arrays of numbers, as you would expect.
//// Taking one element at a time, manually
//var i1 = s1.makeIterator()
//print(i1.next() as Any) // => Optional(1)
//print(i1.next() as Any) // => Optional(2)
//print(i1.next() as Any) // => Optional(3)
//print(i1.next() as Any) // => Optional(1)
//print(i1.next() as Any) // => Optional(2)
//print(i1.next() as Any) // => Optional(3)
//print(i1.next() as Any) // => Optional(1)
//
//let s2 = CycleSequence(cycling: 2...5) // Works with any Collection. Ranges work!
//// Taking the first 10 elements
//print(Array(s2.prefix(10))) // => [2, 3, 4, 5, 2, 3, 4, 5, 2, 3]
//
//let s3 = CycleSequence(cycling: "abc") // Strings are Collections, so those work, too!
//s3.prefix(10).map{ "you can even map over me! \($0)" }.forEach{ print($0) }


//func cycle2(_ range: LazySequence<Array<Int>>, _ generator: Generator? = nil) {
//    var generator = generator == nil ? Generator(start: range.first!) : generator
//
//    let res = generator!.next()!
//    if res >= range.last! {
//        generator = Generator(start: range.first!)
//    }
//
//    cycle2(range, generator)
//}
//
//// cycle(range(0, 2))
//let result = (1...)
//   .lazy
//   .map { $0 }
//   .first(where: { $0 > 100})

//struct Generator: Sequence, IteratorProtocol {
//    var start: Int = 1
//    var i = 1
//    mutating func next()-> Int?{
//        defer {
//            start += 1
//        }
//        return start
//    }
//}

//class FibIterator : IteratorProtocol {
//    var (a, b) = (0, 1)
//
//    func next() -> Int? {
//        (a, b) = (b, a + b)
//        return a
//    }
//}
//
//let fibs = AnySequence{ FibIterator() }
//Array(fibs.prefix(10))

// [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

//func cycleSequence<C: Collection>(for c: C) -> AnySequence<C.Iterator.Element> {
//    AnySequence(sequence(state: (elements: c, elementIterator: c.makeIterator()),
//                         next: { state in
//                            if let nextElement = state.elementIterator.next() {
//                                return nextElement
//                            } else {
//                                state.elementIterator = state.elements.makeIterator()
//                                return state.elementIterator.next()
//                            }
//                         })
//    )
//}

// credit: https://gist.github.com/dabrahams
// reference: https://gist.github.com/dabrahams/ea5495b4cccc2970cd56e8cfc72ca761

/// Returns `self.map(transform)`, computed in parallel.
///
/// - Requires: `transform` is safe to call from multiple threads.
public func concurrentMap<A, B>(_ array: [A],
                                minBatchSize: Int = 4096,
                                transform: (A) -> B) -> [B] {
    precondition(minBatchSize >= 1)
    
    let n = array.count
    let batchCount = (n + minBatchSize - 1) / minBatchSize
    if batchCount < 2 { return array.map(transform) }
    
    return Array(unsafeUninitializedCapacity: n) { uninitializedMemory, resultCount in
        resultCount = n
        let baseAddress = uninitializedMemory.baseAddress!
        
        DispatchQueue.concurrentPerform(iterations: batchCount) { b in
            let startOffset = b * n / batchCount
            let endOffset = (b + 1) * n / batchCount
            
            var sourceIndex = array.index(array.startIndex, offsetBy: startOffset)
            for p in baseAddress+startOffset..<baseAddress+endOffset {
                p.initialize(to: transform(array[sourceIndex]))
                array.formIndex(after: &sourceIndex)
            }
        }
    }
}

//public func time<Result>(name: StaticString = #function,
//                         line: Int = #line,
//                         _ f: () -> Result) -> Result {
//    let startTime = DispatchTime.now()
//    let result = f()
//    let endTime = DispatchTime.now()
//    let diff = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000 as Double
//    print("\(name) (line \(line)): \(diff) sec")
//    return result
//}

//let arr = Array(0...9999999)

//time {
//    arr.map { $0 &+ 1 }                       // 1.855952671 sec(Swift standard library)

//    let _ = concurrentMap(arr) { $0 &+ 1 }    // 0.410607567 sec(current implementation)
//    arr.concurrentMap { $0 &+ 1 }             // 57.975536616 sec
//}

// Implementation from https://talk.objc.io/episodes/S01E90-concurrent-map
//import Foundation
//
//extension Array {
//    func concurrentMap<B>(_ transform: @escaping (Element) -> B) -> [B] {
//        let result = ThreadSafe(Array<B?>(repeating: nil, count: count))
//
//        DispatchQueue.concurrentPerform(iterations: count) { idx in
//            let element = self[idx]
//            let transformed = transform(element)
//            result.atomically {
//                $0[idx] = transformed
//            }
//        }
//
//        return result.value.map { $0! }
//    }
//
//    private final class ThreadSafe<A> {
//        private var _value: A
//        private let queue = DispatchQueue(label: "concurrentMap.threadSafe")
//
//        init(_ value: A) {
//            self._value = value
//        }
//
//        var value: A {
//            return queue.sync { _value }
//        }
//
//        func atomically(_ transform: (inout A) -> ()) {
//            queue.sync {
//                transform(&self._value)
//            }
//        }
//    }
//}
