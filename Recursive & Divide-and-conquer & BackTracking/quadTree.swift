/*
 [백준] 쿼드트리
 
 쿼드트리란?
 
 흰점 = 0
 검은점 = 1
 
 (왼쪽 위, 오른쪽 위, 왼쪽 아래, 오른쪽, 아래)
 
 반복이 진행될때마다 변화하는 값
 N (탐색 범위)
 시작 위치 x,y
 
 첫 시작 요소와 앞으로의 요소 비교 -> 다르면 4등분 분할 분할한 각가의 영역에서 다시 비교, 같다면 첫 시작 요소 answer 변수에 append
 */
import Foundation
let N = Int(readLine()!)!
var image: [[Int]] = Array(repeating: [], count: N)

for idx in 0..<N{
    let temp = readLine()!.map{Int(String($0))!}
    image[idx].append(contentsOf: temp)
}
var answer = String()

func recursive(_ N: Int, startX: Int, startY: Int){
    var isDivide = false
    let firstNum = image[startY][startX]
    for col in startY..<startY + N{
        for row in startX..<startX + N{
            if image[col][row] != firstNum{
                //4등분 진행
                isDivide = true
            }
        }
    }
    if isDivide{
        answer += "("
        recursive(N/2, startX: startX, startY: startY)//왼 위
        recursive(N/2, startX: startX + N/2, startY: startY)//오 위
        recursive(N/2, startX: startX, startY: startY + N/2)//왼 아
        recursive(N/2, startX: startX + N/2, startY: startY + N/2)//오 아
        answer += ")"
    }else{
        answer += String(firstNum)
    }
    
}

recursive(N, startX: 0, startY: 0)
print(answer)
//((110(0101))(0010)1(0001))
//((110(00011011))(0010)1(0001))
/*
 (,),0,1
 어느 시점에 위에 문자들을 append해야할까?
 
 순서
 처음 문자와 비교 -> 처음 문자 기준 범위 내 요소들 같은지 비교 -> if(다르면) 4등분 분할 -> 각 분할된 영역 시작 위치 전달
 if(같으면) -> 정답 문자열에 append
 
 */
