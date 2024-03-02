/*
 [백준] 도로포장
 
 9시 03분
 
 K = 설치 가능한 도로 갯수
 N = 도시의 갯수
 
 포장하면 시간 0으로 됨
 포장하지 않으면 기존의 시간 +
 서울 = 1번
 포천 = N번
 
 입력
 N(도시의 수) M(도로의 수) K(포장할 도로의 수)
 
 포장할 도로의 선택 기준
 
 처음 접근을 할때 포장할 도로를 저장해두고 저장한 데이터로 문제해결해야된다고 생각함
 
 코드상에는 어디에 도로가 포장했는지 저장하지 않고 어딘가에 포장했을때 도착노드까지 최단거리를 가지고 최단거리를 구하는 코드
 
 */
import Foundation

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

let input = readLine()!.split(separator: " ").map{Int(String($0))!}
let (N, M, K) = (input[0], input[1], input[2])
var nodes = Array(repeating: [(Int, Int)](), count: N+1)
let INF = Int.max

for _ in 0..<M {
    let input = readLine()!.split(separator: " ").map{Int(String($0))!}
    let (node1, node2, cost) = (input[0], input[1], input[2])
    //무방향 그래프
    nodes[node1].append((node2, cost))
    nodes[node2].append((node1, cost))
}

let distances = Dijkstra(start: 1)
if let answer = distances[N].min() {
    print(answer)
}

//시작 노드부터 특정 노드까지의 최단거리를 distances에 저장하고 distances 배열을 반환하는 함수
func Dijkstra(start: Int) -> [[Int]] {
    //distances 배열은 col = 시작 노드 row = 끝 노드까지 가는데 최소거리를 저장
    var distances = Array(repeating: Array(repeating: INF, count: K+1), count: N+1)
    //시작
    distances[start][0] = 0
    var pq = PQ<(Int, Int, Int)>(sort: {$0.0 < $1.0})
    //현재 노드까지 도달하는데 최소비용??, 현재 노드의 번호, curNum = ??
    pq.push((0, start, 0))
    
    while !pq.isEmpty {
        guard let curData = pq.pop() else { break }
        //curCost = 특정 노드에서 curNode까지 가는데 드는 누적 비용을 저장하는 변수
        let curCost = curData.0
        let curNode = curData.1
        let curNum = curData.2
        
        //무방향그래프에서 환경을 변화가 없을때 탐색하지 않기 위한 조건문
        //distances에 담긴 curNode의 최소 비용보다 현재 비용이 작으면 continue
        if distances[curNode][curNum] < curCost {
            continue
        }
        //현재 노드에서 접급 가능한 노드 탐색
        for nextData in nodes[curNode] {
            let nextNode = nextData.0
            let nextCost = nextData.1
            
            //포장 도로를 설치하지 않을 때
            //현재 노드까지 누적된 비용 + 다음 노드를 접근하는데 드는 비용이 다음 노드에 접근하는데 드는 최소 누적 비용을 비교
            if distances[nextNode][curNum] > nextCost + curCost {
                distances[nextNode][curNum] = nextCost + curCost
                //이게 dynamic programming인가 보다..
                pq.push((nextCost + curCost, nextNode, curNum))
            }
            
            // 포장 도로 설치 가능 + 이득이 있을 때
            if curNum < K {
                //현재 노드까지 누적된 비용이 다음 노드에 접근하는데 드는 최소 누적 비용을 비교
                if distances[nextNode][curNum+1] > curCost {
                    distances[nextNode][curNum+1] = curCost
                    pq.push((curCost, nextNode, curNum + 1))
                }
            }
        }
    }
    return distances
}
