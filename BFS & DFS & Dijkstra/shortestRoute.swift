/*
 [백준] 최단 경로
 방향 그래프
 시작점에서 모든 노드로 가는 최단 경로를 구하는 문제
 
 정점의 갯수 = V
 간선의 갯수 = E
 노드의 번호는 1부터 시작한다. 하지만 다익스트라 문제는 정렬을 해야하므로 노드를 번호를 0부터 시작으로 변환
 시작 정점 = K
 출발 노드 = u
 도착 노드 = v
 가중치 = w
 시작 노드와 도착 노드는 같지 않다.
 두 노드간 간선은 여러개 존재(최소 가중치로만 이용)
 */

import Foundation
//우선순위 큐를 구현을 위한 구조체
struct PriorityQueue<T> {
    //우선순위 큐의 배열
    var array = [T]()
    //우선순위를 정하는 기준
    let sort: (T, T) -> Bool
    //초기화를 하는 과정에서 우선순위를 정하는 기준을 받아옴
    init(sort: @escaping (T, T) -> Bool) {
        //받아온 클로져 구조체 인스턴스 프로퍼티에 저장
        self.sort = sort
    }
    var isEmpty: Bool {
        return array.isEmpty
    }
    var count: Int {
        return array.count
    }
    //우선순위가 가장 높은 요소를 반환
    func peek() -> T? {
        return array.first
    }
    //트리 구조체에서 부모노드의 좌측 자식노드를 반환
    func leftChildIndex(ofParentAt index: Int) -> Int {
        return (2 * index) + 1
    }
    //트리 구조체에서 부모노드의 우측 자식노드를 반환
    func rightChildIndex(ofParentAt index: Int) -> Int {
        return (2 * index) + 2
    }
    //트리 구조체에서 자식노드의 부모노드를 반환
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
    // MARK:- remove operation
    mutating func pop() -> T? {
        guard !isEmpty else {
            return nil
        }
        array.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return array.removeLast()
    }
    mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            
            if left < count && sort(array[left], array[candidate]) {
                candidate = left
            }
            if right < count && sort(array[right], array[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            array.swapAt(parent, candidate)
            parent = candidate
        }
    }
    // MARK:- insert operation
    mutating func push(_ element: T) {
        array.append(element)
        siftUp(from: array.count - 1)
    }
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(array[child], array[parent]) {
            array.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
}

let input = readLine()!.split(separator:" ").map{Int(String($0))!}
let (N, M) = (input[0], input[1])
let K = Int(readLine()!)!
var nodes = Array(repeating: Array<(Int, Int)>(), count: N+1)
for _ in 0..<M{
    let input = readLine()!.split(separator:" ").map{Int(String($0))!}
    let (node1, node2, cost) = (input[0], input[1], input[2])
    nodes[node1].append((node2, cost))
}

Dijkstra(startNode: K)

func Dijkstra(startNode: Int) -> Void{
    let INF = Int.max
    //시작 위치에서 각 노드에 최단경로로 도달했을때 거리. 도달할 수 없다면 INF로 저장
    var distances = Array(repeating: INF, count: N+1)
    distances[startNode] = 0
    //우선순위 큐를 초기화와 동시에 우선순위를 정하기 위한 기준을 sort 인스턴스 프로퍼티에 저장
    var pq = PriorityQueue<(Int, Int)>(sort: {$0.0 < $1.0})
    //pq 초기화 탐색의 출발지는 K
    pq.push((0, startNode))
    
    
    while !pq.isEmpty{
        //접근
        let curData = pq.pop()!
        
        let curCost = curData.0
        let curNode = curData.1
        //현재 노드보다
        if distances[curNode] < curCost{
            continue
        }
        
        for nextData in nodes[curNode]{
            let nextNode = nextData.0
            let nextCost = nextData.1
            //반복을 진행 nextNode까지 여태까지 중첩된 가중치가 보다 새로운 경로로 접근한 가중치의 중첩이 더 작다면
            if distances[nextNode] > nextCost + curCost{
                //새로운 경로로 접근한 경로의 가중치를 현재 노드의 중첩 가중치 배열에 저장
                distances[nextNode] = nextCost + curCost
                pq.push((nextCost+curCost, nextNode))
            }
        }
    }
    
    for idx in 1..<distances.count{
        if distances[idx] == INF{
            print("INF")
        } else {
            print(distances[idx])
        }
    }
}


//
//let VE = readLine()!.split(separator: " ").map(){Int(String($0))!}
//let V = VE[0]
//let E = VE[1]
//let K = Int(readLine()!)! - 1
//
//var graph:[[(Int,Int)]] = Array(repeating: [], count: V)
//
//for _ in 0..<E{
//    let uvw = readLine()!.split(separator: " ").map(){Int(String($0))!}
//    let u = uvw[0] - 1
//    let v = uvw[1] - 1
//    let w = uvw[2]
//
//    //출발지와 도착지가 같은 중복되는 간선에서 가중치가 작은 오직 최적의 간선만 append
//    var tempIdx = Int()
//    if graph[u].contains(where: { t1 in
//        for idx in 0..<graph[u].count{
//            if graph[u][idx].0 == t1.0{
//                tempIdx = idx
//                return true
//            }
//        }
//        return false
//    }){
//        if graph[u][tempIdx].1 > w{
//            _ = graph[u].remove(at: tempIdx)
//            graph[u].append((v,w))
//        }
//    }
//    else {
//        graph[u].append((v,w))
//    }
//
//}
//print(graph)
//
//func findRoute(endNode: Int){
//    var weights: [Int] = Array(repeating: 0, count: V)
//    var queue = [Int]()
//    let startNode = 1
//    var index: Int = 0
//
//    queue.append(startNode)
//
//    while index < queue.count{
//        let pop = queue[index]
//        let cost = weights[pop]
//        print(pop,terminator: "->")
//        for node in graph[pop]{
//            let nextNode = node.0
//            let fee = node.1
//            if nextNode == endNode{
//                print(weights[pop] + fee)
//            }
//            if weights[nextNode] > cost + fee{
//                weights[nextNode] = cost + fee
//                print(nextNode,terminator: "->")
//                queue.append(nextNode)
//            }
//        }
//        print("")
//
//
//        index += 1
//    }
//    print("INF")
//}
//
//for node in 0..<V{
//    if node == K {
//        print(0)
//        continue
//    }
//    findRoute(endNode: node)
//}
