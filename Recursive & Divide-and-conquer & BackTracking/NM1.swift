/*
 N과 M(1)
 dfs와 백트래킹을 활용하여 문제 해결
 */


var nm = readLine()!.split(separator: " ").map{ Int($0)! }
let N = nm[0]
let M = nm[1]

var stack = [Int]()

private func dfs() {
    //스택에 쌓인 숫자들의 갯수가 M인 경우
    if stack.count == M {
        print(stack.map{ String($0) }.joined(separator:" "))
        return
    }
    
    for i in 1...N {
        //중복 반지를 위한 조건문
        if !stack.contains(i) {
            stack.append(i)
            dfs()
            stack.removeLast()
        }
    }
}
dfs()



//let NM = readLine()!.split(separator: " ").map{Int(String($0))!}
//let N = NM[0]
//let M = NM[0]
//
//var arr: [Int] = Array(repeating: 0, count: M)
//var visited = Array(repeating: false, count: 9)
//
//func dfs(_ level: Int,_ start: Int){
//    if level == M{
//        print(arr.map{String($0)}.joined(separator: " "))
//    }
//    for i in start...N{
//        if !visited[i]{
//            visited[i] = true
//            arr[i-1] = i
//            dfs(level + 1, i)
//            visited[i] = false
//        }
//    }
//}
//
//dfs(0, 1)
//
