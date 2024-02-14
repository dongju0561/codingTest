/*
 놓친 부분이 존재..
 */

//순서: 빙고판 입력 -> 사회자 call 순서 입력 -> call에 따른 값 변화(call한 값에 해당하는 빙고판에 좌표의 값을 0을 할당) -> 빙고가 3개 이상인지 확인

import Foundation

//빙고판 입력: 2차원 배열
var bingo: [[Int]] = Array(repeating: [0,0,0,0,0], count: 5)
for row in 0..<5{
    let input = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}
    bingo[row] = input
}

//사회자 언급 번호 입력: 1차원 배열
var caller = [Int]()
for row in 0..<5{
    let input = readLine()!.components(separatedBy: " ").map{Int($0)!}
    caller.append(contentsOf: input)
}

//언급된 번호 언급되었다는 의미의 숫자 '0'으로 바꿈
for (count, value) in caller.enumerated(){
    for col in 0..<5{
        //firstIndex(of: ) 메소드로 탐색하고자하는 값 탐색
        if let targetIndex = bingo[col].firstIndex(of: value){
            //언급한 숫자 '0'으로 바꿈
            bingo[col][targetIndex] = 0
        }
    }
    if isBingo(){
        print(count + 1)
        break
    }
}

//3개 이상 라인의 빙고가 있는지 판별하는 함수
func isBingo() -> Bool{
    var count = 0
    var isDiagonalBingo1 = true
    var isDiagonalBingo2 = true
    
    //세로 빙고 확인
    for col in 0..<5{
        //[0,0,0,0,0]배열을 생성하여 bingo[col]와 비교
        if(bingo[col] == [Int](repeating: 0, count: 5)){
            //가로 빙고 갯수 증가
            count += 1
        }
        //세로 빙고 확인
        var colBingo = true
        for row in 0..<5{
            if bingo[col][row] != 0{ colBingo = false }
        }
        if(colBingo){ count += 1 }
        
        //대각선 빙고 확인
        //왼쪽 위부터 시작하여 오른쪽 아래로 끝나는 대각선 확인
        if(bingo[col][col] != 0 ? true : false){ isDiagonalBingo1 = false}
        //오른쪽 위부터 시작하여 왼쪽 아래로 끝나는 대각선 확인
        if(bingo[col][4-col] != 0 ? true : false){ isDiagonalBingo2 = false}
    }
    
    if(isDiagonalBingo1){ count += 1}
    if(isDiagonalBingo2){ count += 1}
    
    if count >= 3{ return true }
    else{ return false}
}
