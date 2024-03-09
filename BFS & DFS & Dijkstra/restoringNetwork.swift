/*
 2/28 9시 24분
 [백준] 네트워크 복구
 
 N = 컴퓨터(노드?)
 컴퓨터 성능(거리), 회선 성능(거리)의 차이 존재
 해커
 슈퍼컴퓨터 = 1번 컴퓨터
 최소 개수의 회선
 슈퍼컴퓨터 <-> 컴퓨터 최소 시간 > 원래 네트워크 통신 최소 시간 X
 
 M은 간선의 갯수
 회선은 무방향
 
 K = 복구할 회선의 갯수
 복구한 회선 A B
 
 해커의 공격? : 컴퓨터를 해킹 -> 슈퍼컴퓨터 확인 -> 보안 패키지 최소 비용으로 전송
 
 보안 프로그램 전송을 위한 최소 회선만 복구
 
 - 팁 -
 - 사용했던 회선을 중복해서 사용하면 효율적으로 전송이 가능
 - 슈퍼 컴퓨터(1번 컴퓨터)는 최소 비용으로 모든 컴퓨터와 연결되어야 한다.
 */

import Foundation

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

let NM: [Int] = readLine()!.split(separator: " ").map{Int(String($0))!}
let N = NM[0]
let M = NM[1]

//(도착노드 번호 - 1, 간선의 성능)
var graph: [[(Int,Int)]] = Array(repeating: [], count: N)

for _ in 0..<M{
    let temp = readLine()!.split(separator: " ").map{Int(String($0))!}
    let A = temp[0] - 1
    let B = temp[1] - 1
    let C = temp[2]
    
    graph[A].append((B,C))
    graph[B].append((A,C))
}

//복구된 회선이 최소
let INF = Int.max
var distances = Array(repeating: INF, count: N)
var route: [(Int,Int)] = Array(repeating: (0,0), count: N)
//기존의 다익스트라 문제풀이와 다르게 사용 경로를 출력해야하므로 다익스트라 함수에서 사용된 회선들 반환
func Dijkstra(startNode: Int) -> [(Int,Int)]{
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
        
        for nextData in graph[curNode]{
            let nextNode = nextData.0
            let nextCost = nextData.1
            //반복을 진행 nextNode까지 여태까지 중첩된 가중치가 보다 새로운 경로로 접근한 가중치의 중첩이 더 작다면
            if distances[nextNode] > nextCost + curCost{
                //새로운 경로로 접근한 경로의 가중치를 현재 노드의 중첩 가중치 배열에 저장
                distances[nextNode] = nextCost + curCost
                pq.push((nextCost+curCost, nextNode))
                //최단거리를 찾았을때 사용되는 회선 추가 혹은 갱신
                route[nextNode] = (curNode,nextNode)
            }
        }
    }
    return route
}
let ans = Dijkstra(startNode: 0)

print(ans.count - 1)
for idx in 1..<ans.count{
    print("\(ans[idx].0 + 1) \(ans[idx].1 + 1)")
}