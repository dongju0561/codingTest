// /*
//  알게된 사실

//  - 처음 문제를 풀때는 BFS를 사용할지 DFS를 사용하지 고민하지않고 BFS를 무조건적으로 사용하였다.(BFS 사용으로 인한 시간 초과 발생)
//  - DFS와 BFS의 차이
//     BFS 탐색의 경우 기준이 되는 노드와 인접한 노드들을 우선적으로 탐색하고 인접한 노드들의 인접한 노드들을 탐색을 진행하게 된다
//     반대로 DFS 탐색은 기준이 되는 노드와 인접한 노드들을 탐색을 끝내기 이전에 기준 노드와 인접한 노드의 자식 노드를 우선적으로 탐색하는 것을 의미한다.
//     트리 구조로 예를 들자면, BFS 같은 경우 같은 레벨에 존재하는 노드들을 우선적으로 탐색을 하고 DFS는 탐색이 진행할 수록 레벨이 증가 즉 깊이가 깊어지면서 탐색을 진행합니다.
//  - 이 문제 또한 하나의 공간에서 여러번 DFS 탐색이 일어나는 문제이다.
//  */

// /*
//  실수한 것
//  - BFS를 구현하면서 queue가 채워져있는 동안의 반복에서 append하는 코드를 생략하여 다음 탐색이 이루워지지 않았습니다.
//  - 노드 번호와 배열의 인덱스 번호를 일치시키는 것을 신경쓰자 -> 실수를 줄 일수 있음
//  - queue의 enqueue를 진행할때 이전에 enqueue된 요소와 현재 enqueue의 중복이 발생하여 불필요한 연산이 진행..

 
// */
// import Foundation

// func DFS(_ nextNode: Int){
//     var stack = [Int]()
    
//     stack.append(contentsOf: graph[nextNode])
    
//     while !stack.isEmpty{
//         let pop = stack.removeLast()
        
//         if !visited[pop]{
//             //생략하는 실수...
//             stack.append(contentsOf: graph[pop])
//             visited[pop] = true
//         }
//     }
// }

// let input: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}

// let N: Int = input[0]
// let M: Int = input[1]

// var graph: [[Int]] = Array(repeating: [], count: N + 1)
// //노드 번호와 인덱스 값을 일치시키기 위해 인덱스 0은 사용하지 않음
// graph[0] = []

// //노드 간 간선 설치
// for _ in 0..<M{
//     let inputLine: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}
//     let start = inputLine[0]
//     let end = inputLine[1]
//     //무방향그래프의 간선을 그리기 위한 노력 -> 다른 방법도 있는지 확인해 보자
//     //대부분 아래와 같은 방식으로 진행
//     graph[start].append(end)
//     graph[end].append(start)
// }

// //노드 번호와 인덱스 값을 일치시키기 위해 인덱스 0은 사용하지 않음
// var visited: [Bool] = Array(repeating: false, count: N + 1)
// var numOfConnection = 0

// for idx in 1..<graph.count{
//     if !visited[idx]{
// //        visited[1] = true
//         visited[idx] = true
//         numOfConnection += 1
//         DFS(idx)
//     }
// }
// print(numOfConnection)

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
///시간 초과
import Foundation

func BFS(_ nextNode: Int){
    var queue = [Int]()
    
    queue.append(contentsOf: graph[nextNode])
    
    while !queue.isEmpty{
        let pop = queue.removeFirst()
        
        if !visited[pop]{
            //생략하는 실수...
            queue.append(contentsOf: graph[pop])
            visited[pop] = true
        }
    }
}

let input: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}

let N: Int = input[0]
let M: Int = input[1]

var graph: [[Int]] = Array(repeating: [], count: N + 1)
graph[0] = []

//노드 간 간선 설치
for _ in 0..<M{
    let inputLine: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}
    let start = inputLine[0]
    let end = inputLine[1]
    graph[start].append(end)
    graph[end].append(start)
}

var visited: [Bool] = Array(repeating: false, count: N + 1)
var numOfConnection = 0

for idx in 1..<graph.count{
    if !visited[idx]{
        visited[idx] = true
        numOfConnection += 1
        BFS(idx)
    }
}
print(numOfConnection)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// 주의: 인덱스와 입력받는 노드의 번호가 일치하지 않음
// import Foundation

// func BFS(_ nextNode: Int){
//     var queue = [Int]()
    
//     queue.append(contentsOf: graph[nextNode])
    
//     while !queue.isEmpty{
//         let pop = queue.removeFirst()
        
//         if !visited[pop]{
//             //생략하는 실수...
//             queue.append(contentsOf: graph[pop])
//             visited[pop] = true
//         }
//     }
// }

// let input: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}

// let N: Int = input[0]
// let M: Int = input[1]

// var graph: [[Int]] = Array(repeating: [], count: N + 1)
// //노드 번호와 인덱스 값을 일치시키기 위해 인덱스 0은 사용하지 않음
// graph[0] = []

// //노드 간 간선 설치
// for _ in 0..<M{
//     let inputLine: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}
//     let start = inputLine[0]
//     let end = inputLine[1]
//     //무방향그래프의 간선을 그리기 위한 노력 -> 다른 방법도 있는지 확인해 보자
//     graph[start].append(end)
//     graph[end].append(start)
// }

// //노드 번호와 인덱스 값을 일치시키기 위해 인덱스 0은 사용하지 않음
// var visited: [Bool] = Array(repeating: false, count: N + 1)
// var numOfConnection = 0

// for idx in 1..<graph.count{
//     if !visited[idx]{
// //        visited[1] = true
//         visited[idx] = true
//         numOfConnection += 1
//         BFS(idx)
//     }
// }
// print(numOfConnection)