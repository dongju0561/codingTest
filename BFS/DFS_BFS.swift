/*
 [백준] DFS와 BFS
 하나의 그래프에서 DFS 방식과 BFS 방식을 각각 사용하여 노드 이동경로를 출력하는 문제
 조건은 정점의 번호가 작은것부터 출력해야함
 */

/*
 간선 중복 방지
 
 입력
 5 5 3
 5 4 (중복)
 4 5 (중복)
 1 2
 3 4
 3 1
 
 출력
 변경 전: [[], [2, 3], [1], [4, 1], [5, 5, 3], [4, 4]]
 변경 후: [[], [2, 3], [1], [4, 1], [5, 3], [4]]
 */

/*
 BFS, DFS 탐색에서 N번째 노드에 인접한 노드들의 처리하는 순서가 다름
 BFS 같은 경우 1에 인접한 노드들을 모두 검사하고 다음 인접한 노드들의 노드에 인접한 노드들로 탐색
 DFS 같은 경우 매번 새로운 특정 노드에 인접한 노드들을 탐색한다.

 주의: 출력 결과 예시와 같은 형식으로 출력해야함 otherwise 백준에서 틀림 처리..
 */

import Foundation

//함수 정의

func DFS(node startNode: Int) -> [Int]{
    var stack = [Int]()
    //노드번호와 인덱스 일치
    var visited: [Bool] = Array(repeating: false, count: numOfNode + 1)
    
    var orderOfNode = [Int]()
    
    stack.append(startNode)
    
    while !stack.isEmpty{
        let pop = stack.removeLast()
        if !visited[pop]{
            visited[pop] = true
            //노드에 방문한 시점에 orderOfNode에 요소 추가
            orderOfNode.append(pop)
            //간선으로 연결된 노드들을 내림차순으로 정렬 후 push
            stack.append(contentsOf: graph[pop].sorted(by: {$1 < $0}))
        }
    }
    return orderOfNode
}

func BFS(node startNode: Int) -> [Int]{
    var queue = [Int]()
    
    //노드번호와 인덱스 일치
    var visited: [Bool] = Array(repeating: false, count: numOfNode + 1)
    //노드 접근 순서
    var orderOfNode = [Int]()
    
    queue.append(startNode)
    
    while !queue.isEmpty{
        let pop = queue.removeFirst()
        if !visited[pop]{
            visited[pop] = true
            //노드에 방문한 시점에 orderOfNode에 요소 추가
            orderOfNode.append(pop)
            //간선으로 연결된 노드들을 오름차순으로 정렬 후 enqueue
            queue.append(contentsOf: graph[pop].sorted(by: {$0 < $1}))
        }
    }
    return orderOfNode
}

//노드 간선 시작점 입력 처리
let input: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0) ?? 0}

let numOfNode = input[0]
let numOfLine = input[1]
let startNode = input[2]

//간선 설치(간선 중복 방지 처리)
var graph: [[Int]] = Array(repeating: [], count: numOfNode + 1)

for _ in 0..<numOfLine{
    let nodes: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0) ?? 0}
    let firstNode = nodes[0]
    let secondNode = nodes[1]
    
    //간선 중복 방지 처리
    if !graph[firstNode].contains(secondNode){
        graph[firstNode].append(secondNode)
        graph[secondNode].append(firstNode)
    }
}

//주의: 출력 결과 예시와 같은 형식으로 출력해야함
DFS(node: startNode).forEach({ num in
    print(num,terminator: " ")
})
print("")
BFS(node: startNode).forEach({ num in
    print(num,terminator: " ")
})
print("")
