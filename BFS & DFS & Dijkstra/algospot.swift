/*
 [백준] 알고스팟
 
 기준 위치까지 벽을 부순 횟수를 저장하는 2차원 배열을 생성하여 회수가 최소가 되는 값을 저장하면서 문제 풀이를 진행하는 문제
 */

let RC: [Int] = readLine()!.split(separator: " ").map{Int(String($0))!}

let R = RC[0]
let C = RC[1]

var wallMap: [[Int]] = Array(repeating: [], count: C)

for i in 0..<C{
    let temp = readLine()!.map{Int(String($0))!}
    wallMap[i].append(contentsOf: temp)
}

let start: (Int,Int) = (0,0)
let end: (Int,Int) = (C-1,R-1)
var idx = 0
var counts = Array(repeating: Array(repeating: Int.max, count: R), count: C)
var queue = [start]
counts[start.0][start.1] = 0
while idx < queue.count{
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    let pop = queue[idx]
    let y = pop.0
    let x = pop.1
    
    for i in 0..<4{
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        if 0..<R ~= nx && 0..<C ~= ny{
            //벽과 빈공간을 모두 방문이 가능하지만 처리하는 방식이 다르다
            if wallMap[ny][nx] == 0{
                if counts[ny][nx] > counts[y][x] {
                    counts[ny][nx] = counts[y][x]
                    queue.append((ny,nx))
                }
            }
            if wallMap[ny][nx] == 1{
                if counts[ny][nx] > counts[y][x] + 1{
                    counts[ny][nx] = counts[y][x] + 1
                    queue.append((ny,nx))
                }
            }
        }
    }
    idx += 1
}
print(counts[end.1][end.0])
