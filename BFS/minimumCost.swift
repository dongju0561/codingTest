/*
 [백준] 최소비용 구하기
 
 다익스트라 알고리즘 특징
 - 이전의 연산값이 앞으로의 연산에 영향을 미친다.
 - 최소 비용을 구하기 위해 정렬을 진행한다.(오름차순)
 - 간선 상 비용이 존재
 
 연산 시간을 줄이는 방법
 - split(separator: )
 - index를 증가함으로써 dequeue 진행하는 큐 구현
 
 
 */
let N: Int = Int(readLine()!)!
let M: Int = Int(readLine()!)!
var dist = Array(repeating: Int.max, count: N)
var graph: [[(Int, Int)]] = Array(repeating: [(Int, Int)](), count: N)


for _ in 0..<M{
    let temp: [Int] = readLine()!.split(separator: " ").map(){Int($0)!}
    //노드 번호와 인덱스번호 일치화 과정
    let start = temp[0] - 1
    let end = temp[1] - 1
    let cost = temp[2]
    //그래프 생성
    graph[start].append((end, cost))
}

//출발지에서 갈 수 있는 경로의 비용 오름차순으로 정렬
for i in 0..<N{
    graph[i].sort(by: {$0.1 < $1.1})
}

let input: [Int] = readLine()!.split(separator: " ").map(){Int($0)!}
let startPoint = input[0] - 1
let endPoint = input[1] - 1
dist[startPoint] = 0

var queue = [startPoint]
var idx = 0
while idx < queue.count{
    let pop = queue[idx]
    let cost = dist[pop]
    
    for node in graph[pop]{
        let nextNode = node.0
        let fee = node.1
        if dist[nextNode] > cost + fee{
            dist[nextNode] = cost + fee
            queue.append(nextNode)
        }
    }
    idx += 1
}

print(dist[endPoint])
