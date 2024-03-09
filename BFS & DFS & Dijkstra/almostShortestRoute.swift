/*
 [백준] 거의 최단경로
 */


import Foundation

//by rhyno

//왜 최단 거리 경로를 찾을때는 역방향으로 탐색을 할까??

struct PQ<T> {
    //heap
    var nodes = [T]()
    let sort:(T, T) -> Bool
    //정렬 기준 min heap 또는 max heap
    init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    var count: Int {
        return nodes.count
    }
    //특정 노드의 좌측 자식노드의 인덱스를 반환 받는 메소드
    func leftChild(of parentIndex: Int) -> Int {
        return parentIndex * 2 + 1
    }
    //특정 노드의 우측 자식노드의 인덱스를 반환 받는 메소드
    func rightChild(of parentIndex: Int) -> Int {
        return parentIndex * 2 + 2
    }
    //특정 노드의 부모노드의 인덱스를 반환 받는 메소드
    func parentIndex(of childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    mutating func shiftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChild(of: parent)
            let right = rightChild(of: parent)
            var candidate = parent
            //좌측 노드의 인덱스가 전체 인덱스 범위 안에 있고 (min heap 기준) 좌측 자식노드가 부모노드보다 작은 경우
            if left < count && sort(nodes[left], nodes[candidate]) {
                //candidate 변수에 좌측 자식노드의 인덱스 할당
                candidate = left
            }
            //좌측 노드의 인덱스가 전체 인덱스 범위 안에 있고 (min heap 기준) 우측 자식노드가 부모노드보다 작은 경우
            if right < count && sort(nodes[right], nodes[candidate]) {
                //candidate 변수에 우측 자식노드의 인덱스 할당
                candidate = right
            }
            //candidate의 변화가 없다면 변경할 필요 없음..
            if candidate == parent {
                return
            }

            nodes.swapAt(parent, candidate)
            parent = candidate
        }
        
    }
    mutating func shiftUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)
        //0을 포함하지 않는 이유는 인덱스의 0은 트리의 루트 노드 인덱스이기 때문에 부모노드가 없다.
        while child > 0 && sort(nodes[child], nodes[parent]) {
            nodes.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
        
    }
    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        nodes.swapAt(0, count-1)
        defer {
            shiftDown(from: 0)
        }
        return nodes.removeLast()
    }
    mutating func push(_ element: T) {
        nodes.append(element)
        shiftUp(from: count-1)
    }
}

while true{
    let INF = 5000000
    let NM = readLine()!.split(separator: " ").map{Int($0)!}
    let N = NM[0]
    let M = NM[1]
    
    if N+M == 0{ break }
    
    var arr = Array(repeating: [(node:Int, cost:Int)](), count: N)
    var rev = Array(repeating: [(node:Int, cost:Int)](), count: N)
    
    let SD = readLine()!.split(separator: " ").map{Int($0)!}
    let S = SD[0]
    let D = SD[1]
    
    for _ in 0..<M{
        let line = readLine()!.split(separator: " ").map{Int($0)!}
        let U = line[0]
        let V = line[1]
        let P = line[2]
        //정방향
        arr[U].append((V,P))
        //역방향
        rev[V].append((U,P))
    }
    
    //각 노드까지의 최단거리 배열 반환
    func dij(from:Int, arr:[[(node:Int, cost:Int)]]) -> [Int]{
        var visited = Array(repeating: false, count: N)
        var res = Array(repeating: INF, count: N)
        res[from] = 0
        
        //튜플을 선언할때 요소의 이름 할당이 가능하다
        var q = PQ<(node:Int, cost:Int)>(sort: {$0.1 > $1.1})
        q.push((from,0))
        
        while !q.isEmpty{
            let top = q.pop()!
            let curr = top.node
            let cost = top.cost
            
            visited[curr] = true
            
            //튜플의 .idx가 아닌 .요소이름
            for next in arr[curr]{
                if next.node<0 { continue }
                if visited[next.node] { continue }
                
                let newCost = cost+next.cost
                if res[next.node] > newCost{
                    res[next.node] = newCost
                    q.push((next.node,newCost))
                }
            }
        }
        
        return res
    }
    
    let minCost = dij(from: S, arr: arr)
    var visited = Array(repeating: false, count: N)
    
    //각 노드 최단거리 배열을 가지고 dfs 탐색으로 도착지점부터 시작해서 최단거리 경로를 구하고 해당 경로를 비활성화 진행
    func dfs(from:Int, cost:Int){
        let curr = from
        
        for i in 0..<rev[curr].count{
            let next = rev[curr][i].node
            //rev[curr][i].cost == curr -> nextNode.cost
            //cost == D -> curr
            //D -> nextNode
            
            //cost == S -> curr
            let newCost = rev[curr][i].cost + cost
            //요기 방법이 신기!: 해당 경로가 노드가 최단경로성 상에 있는지
            //newCost == S에서 해당 노드까지의 탐색비용, minCost[Next] D에서 해당 노드까지의 최단 비용
            //minCost == S에서 D까지의 최단비용
            if newCost + minCost[next] == minCost[D]{
                //S -> next -> curr -> node -> D
                //해당 노드의 익덱스 삭제
                rev[curr][i].node = -1
                
                if !visited[next]{
                    visited[next] = true
                    dfs(from: next, cost: newCost)
                }
            }
        }
    }
    
    visited[D] = true
    dfs(from: D, cost: 0)
    //최단 거기를 접근 불가 상태로 만들어 놓고 변화된 상태에서 출발지부터 목적지까지의 최단거리를 구하기
    let ans = dij(from: D, arr: rev)[S]
    print(ans==INF ? -1:ans)
}
