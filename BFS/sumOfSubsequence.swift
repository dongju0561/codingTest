/*
 [백준] 부분 수열의 합
 
 아이디어#1: 모든 수들의 그래프로 연결해서 BFS탐색을 통해 모든 경우의 수를 구할려고 했지만 많은 연산이 예상됨
 if(N == 20){ 연산의 횟수 = 20 * 20! }
 
 무 방향이 아닌 단방향 그래프로 노드들을 연결 단, 노드간 간선은 하나뿐이여야 함(중복제거)
 */

import Foundation

//함수정의

//BFS(특정 노드에서 BFS 탐색해서 시작해서 값들의 합들이 S값과 일치한 횟수를 반환)
func BFS(startNode: Int) -> Int{
    var queue: [Int] = [startNode]
    var visited: [Bool] = Array(repeating: false, count: N)
    var count: Int = 0
    var sum = Int()
    
    while !queue.isEmpty{
        let pop = queue.removeFirst()
        //부분수열 합
        sum += nums[pop]
        //부분수열 합 S와 비교, 같다면 count
        if  sum == S { count += 1}
        if !visited[pop]{
            visited[pop] = true
            queue.append(contentsOf: graph[pop])
        }
    }
    return count
}


let NS: [Int] = readLine()!.components(separatedBy: " ").map(){Int(String($0))!}

let N = NS[0]
let S = NS[1]

var total: Int = 0

let nums: [Int] = readLine()!.components(separatedBy: " ").map(){Int(String($0))!}

var graph: [[Int]] = Array(repeating: [], count: N)

//모든 노드들 연결해버리기
for start in 0..<N{
    for end in 0..<N{
        if start != end{
            if !graph[end].contains(nums[start]){
                graph[start].append(end)
            }
        }
    }
}

for start in 0..<N{
    total += BFS(startNode: start)
}

print(total)


// /*
//  [백준] 부분수열의 합
//  참고:https://sapjilkingios.tistory.com/entry/SwiftBruteForce-%EB%B0%B1%EC%A4%80-1182%EB%B2%88-%EB%B6%80%EB%B6%84%EC%88%98%EC%97%B4%EC%9D%98-%ED%95%A9
//  */

// import Foundation

// //수열 요소의 갯수(N), 부분 수열 요소들을 더하여 얻고 싶은 목표값(S) 입력
// let ns = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
// let n = ns[0]
// let s = ns[1]

// //수열의 요소들 입력
// let arr = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

// var visited = Array(repeating: false, count: 21)

// var cnt = 0
// var sum = 0
// func dfs(_ depth: Int, _ start: Int){
//     if sum == s && depth >= 1{
//         cnt += 1
//     }
    
//     for i in start..<n{
//         if !visited[i]{
//             visited[i] = true
//             sum += arr[i]
//             dfs(depth + 1, i)
//             visited[i] = false
//             sum -= arr[i]
//         }
//     }
// }

// dfs(0, 0)
// print(cnt)
