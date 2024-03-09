/*
 [백준] 종이의 개수
 
 N = 행과 열의 길이
 -1, 0, 1
 
 0  0  0 | 1  1  1 -1 -1 -1
 0  0  0 | 1  1  1 -1 -1 -1
 0  0  0 | 1  1  1 -1 -1 -1
 
 1  1  1 | 0  0  0  0  0  0
 1  1  1 | 0  0  0  0  0  0
 1  1  1 | 0  0  0  0  0  0
 
 0  1 -1 | 0  1 -1  0  1 -1
 0 -1  1 | 0  1 -1  0  1 -1
 0  1 -1 | 1  0 -1  0  1 -1
 */
let N = Int(readLine()!)!
var numOfMinus = 0
var numOfZero = 0
var numOfPlus = 0
var paper: [[Int]] = Array(repeating: [], count: N)

for idx in 0..<N{
    let temp = readLine()!.split(separator: " ").map{Int(String($0))!}
    paper[idx].append(contentsOf: temp)
}

func recursive(_ N: Int, _ startX: Int, _ startY: Int){
    let firstElement = paper[startY][startX]
    var isDivide = false
    for col in startY..<startY + N{
        for row in startX..<startX + N{
            if paper[col][row] != firstElement{
                isDivide = true
                if isDivide == true { break }
            }
            if isDivide == true { break }
        }
    }
    if isDivide{
        recursive(N/3, startX, startY)//북서
        recursive(N/3, startX + (N/3), startY)//북
        recursive(N/3, startX + (N*2/3), startY)//북동
        
        recursive(N/3, startX, startY + (N/3))//서
        recursive(N/3, startX + (N/3), startY + (N/3))//중앙
        recursive(N/3, startX + (N*2/3), startY + (N/3))//동
        
        recursive(N/3, startX, startY + (N*2/3))//남서
        recursive(N/3, startX + (N/3), startY + (N*2/3))//남
        recursive(N/3, startX + (N*2/3), startY + (N*2/3))//남동
    }
    else{
        if firstElement == -1{ numOfMinus += 1 }
        else if firstElement == 0{ numOfZero += 1 }
        else { numOfPlus += 1 }
    }
}

recursive(N, 0, 0)
print(numOfMinus)
print(numOfZero)
print(numOfPlus)
