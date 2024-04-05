/*
[프로그래머스] 쿼드압축 후 개수 세기
*/

import Foundation

var numOf0 = 0
var numOf1 = 0

func recursive(n: Int, startX: Int, startY: Int, arr: [[Int]]){
    if n == 1{
        if arr[startX][startY] == 0 {numOf0 += 1}
        else {numOf1 += 1}
        
        return
    }
    var flag = false
    let initialNum = arr[startX][startY]
    
    for nx in startX..<startX+n{
        for ny in startY..<startY+n{
            if arr[nx][ny] != initialNum{
                recursive(n: n/2, startX: startX, startY: startY, arr: arr)
                recursive(n: n/2, startX: startX, startY: startY+n/2, arr: arr)
                recursive(n: n/2, startX: startX+n/2, startY: startY, arr: arr)
                recursive(n: n/2, startX: startX+n/2, startY: startY+n/2, arr: arr)
                return
            }
        }
    }
    if initialNum == 0 {numOf0 += 1}
    else {numOf1 += 1}
}

func solution(_ arr:[[Int]]) -> [Int] {
    let n = arr.count
    recursive(n: n, startX: 0, startY: 0, arr: arr)
    return [numOf0,numOf1]
}
