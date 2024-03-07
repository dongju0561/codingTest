
import Foundation

let input = readLine()!.split(separator: " ").map{ Int(String($0))! }
let N = input[0], R = input[1], C = input[2]
let Z = [[0, 1], [2, 3]]

func recursion(n: Int, r: Int, c: Int, result: Double) -> Int {
    if n == 1 {
        return Z[r][c] + Int(result)
    }
    
    //N^2 * N^2 크기의 지도의 반을 나누기 위한 기준이 되는 수 변수 half에 할당
    let half = Int(pow(2.0, Double(n)) / 2)
    
    if r < half && c < half  { // 1사분면
        return recursion(n: n - 1, r: r, c: c, result: result)
    } else if r < half && c >= half { // 2사분면
        return recursion(n: n - 1, r: r, c: c - half, result: result + pow(Double(half), 2.0))
    } else if r >= half && c < half { // 3사분면
        return recursion(n: n - 1, r: r - half, c: c, result: result + pow(Double(half), 2.0) * 2)
    } else { // 4사분면
        return recursion(n: n - 1, r: r - half, c: c - half, result: result + pow(Double(half), 2.0) * 3)
    }
}

print(recursion(n: N, r: R, c: C, result: 0))

/*
 [백준] Z
 
 4등분 -> 하나의 영역의 칸이 4개가 될때까지 ->
 64
 변화하는 부분
 Z탐색 시작 인덱스
 
 Z탐색 순서
 (startX,starY) -> (startX+1,starY) -> (startX,starY+1) -> (startX+1,starY+1)
 (0,0 -> 0,1 -> 1,0 -> 1,1) -> (2,0 -> 3,0 -> 2,1 -> 2,2) -> (0,2 -> 1,2 -> 0,3 -> 1,3) -> (2,2 -> 3,2 -> 2,3 -> 3,3)
 
 */

//let Nrc = readLine()!.split(separator: " ").map{Int(String($0))!}
//let N = Nrc[0]
//let c = Nrc[1]
//let r = Nrc[2]
//let repeatXArray: [Int] = [1,1,0,0]
//let repeatYArray: [Int] = [0,0,1,1]
//var num = 0
//var arr: [[Int]] = Array(repeating: Array(repeating: 0, count: N*N), count: N*N)
//
////지도를 반드고
//func recursive(_ level: Int,_ startX: Int,_ startY: Int){
//    if N == level{
//        return
//    }
//    for idx in 0..<4{
//        let x = startX + repeatXArray[idx]
//        let y = startY + repeatYArray[idx]
//        arr[y][x] = num
//        num += 1
//    }
////    arr[][] = num
////    num + 1
//}
//
//recursive(1,0,0)
////특정영역의 값 출력
//print(arr[c][r])
