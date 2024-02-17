/*
 [백준] 부분수열의 합
 참고:https://sapjilkingios.tistory.com/entry/SwiftBruteForce-%EB%B0%B1%EC%A4%80-1182%EB%B2%88-%EB%B6%80%EB%B6%84%EC%88%98%EC%97%B4%EC%9D%98-%ED%95%A9
 */

import Foundation

//수열 요소의 갯수(N), 부분 수열 요소들을 더하여 얻고 싶은 목표값(S) 입력
let ns = readLine()!.components(separatedBy: " ").map{Int(String($0))!}
let n = ns[0]
let s = ns[1]

//수열의 요소들 입력
let arr = readLine()!.components(separatedBy: " ").map{Int(String($0))!}

var visited = Array(repeating: false, count: 21)

var cnt = 0
var sum = 0
func dfs(_ depth: Int, _ start: Int){
    if sum == s && depth >= 1{
        cnt += 1
    }
    
    for i in start..<n{
        if !visited[i]{
            visited[i] = true
            sum += arr[i]
            dfs(depth + 1, i)
            visited[i] = false
            sum -= arr[i]
        }
    }
}

dfs(0, 0)
print(cnt)
