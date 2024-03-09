/*
 부분수열의 합
 
 N = 수의 갯수
 
 S = 수열의 부분수열의 요소들의 전체합
 
 */
//아래 코드는 조합에 해당
let NS = readLine()!.split(separator: " ").map{Int(String($0))!}
let N = NS[0]
let S = NS[1]

let nums = readLine()!.split(separator: " ").map{Int(String($0))!}
var sum = 0
var visited = Array(repeating: false, count: nums.count)
var count = 0

/*
start는 수를 더할지 말지를 고려해야하는 idx범위의 시작
level은 더한 값의 갯수를 의미

*/
func DFS(_ level: Int, _ start: Int){
    if level > 0 && sum == S{
        count += 1
    }
    //visited 배열을 통해 수열의 요소를 합할지 말지를 결정하여 중복을 제거
    //visited는 이미 변경되어 확정된값

    //고려해야 하는 범위는 첫 인덱스부터 N-1까지 고려
    //조합
    for i in start..<N{
        // if !visited[i]{
            //더했어!!
            visited[i] = true
            sum += nums[i]
            //
            DFS(level + 1, i+1)
            //빼준 경우
            visited[i] = false
            sum -= nums[i]
        // }
    }
}
DFS(0, 0)
print(count)


/*
 시간초과
 아래 코드는 순열에 해당
 요소에 값의 순서가 달라지면 다른 경우라 판단
 [-7, -3, -2, 5, 8]
 [-7, -3, -2, 8, 5]
 
 이러한 부분 수열로 시간초과? 네!
 [-7 -3 -2 5 8]
 
 순열: 5P5 서로 다른 5개의 수 중에 5개를 선택한 경우 (순서 상관 없음)
 
 중복을 허용하지 않은 순열: 
 
 [-7, -3, -2, 5, 8], 
 [-7, -3, -2, 8, 5], 
 [-7, -3, 5, -2, 8], 
 [-7, -3, 5, 8, -2], 
 [-7, -3, 8, -2, 5], 
 [-7, -3, 8, 5, -2], 
 [-7, -2, -3, 5, 8], 
 [-7, -2, -3, 8, 5], 
 [-7, -2, 5, -3, 8], 
 [-7, -2, 5, 8, -3], 
 [-7, -2, 8, -3, 5], 
 [-7, -2, 8, 5, -3], 
 [-7, 5, -3, -2, 8], 
 [-7, 5, -3, 8, -2], 
 [-7, 5, -2, -3, 8], 
 [-7, 5, -2, 8, -3], 
 ...
 
 순열: 5C5 == 서로 다른 5개의 수 중에 5개를 선택한 경우 (순서 상관 있음)
 중복을 허용하지 않은 조합: [[-7, -3, -2, 5, 8]]
*/

//
//import Foundation
//
//let NS = readLine()!.split(separator: " ").map{Int(String($0))!}
//let N = NS[0]
//let S = NS[1]
////-7 -3 -2 5 8 -7 -3 -2 5 8 -7 -3 -2 5 8 -7 -3 -2 5 8 -7 -3 -2 5 8
//
//let nums = readLine()!.split(separator: " ").map{Int(String($0))!}
//
//var stack = [Int]()
//var count = 0
//
//func sumAndCheck(_ arr: [Int]) -> Bool{
//    var result = 0
//    for num in arr{
//        result += num
//    }
//    if S == result{ return true }
//    else { return false }
//}
//
//func dfs(){
//    print(stack.sorted(by: {$0 < $01}))
//    if stack.count == N{
//        if sumAndCheck(stack){ count += 1}
//        return
//    }
//    else {
//        if sumAndCheck(stack){ count += 1}
//    }
//    for idx in 0..<nums.count{
//        if !stack.contains(nums[idx]){
//            stack.append(nums[idx])
//            dfs()
//            stack.removeLast()
//        }
//    }
//}
//dfs()
//print(count)
//
