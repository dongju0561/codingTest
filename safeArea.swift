/*
    [백준] 안전 영역

    코딩 순서
    물높이 입력(N) -> 지형지도 입력(groundHeight) 입력-> 물에 잠긴 지형 관련 binary 지도 생성 
    -> 반복(방문할 곳이 없을때 까지){안전지역 탐색 -> 방문? -> BFS 탐색}
*/
//내 풀이
import Foundation

//물높이 입력
let N: Int = Int(readLine()!)!

//지형지도 입력
var groundHeight = [[Int]]()
for _ in 0..<N{
    let temp = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}
    groundHeight.append(temp)
}

//binary 지도 생성 1 == 안전지역, 0 == 침수지역
var binaryMap: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)

for i in 0..<N{
    for j in 0..<N{
        if N < groundHeight[i][j]{ binaryMap[i][j] = true }
    }
}

//BFS 탐색
var queue = [[Int]]()
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
var numOfSafeArea: Int = 0

let dx:[Int] = [1,-1,0,0]
let dy:[Int] = [0,0,1,-1]

for i in 0..<N{
    for j in 0..<N{
        if(!visited[i][j] && binaryMap[i][j]){
            //BFS 탐색 시작
            queue.append([i,j])
            visited[i][j] = true
            numOfSafeArea += 1
            while !queue.isEmpty{
                
                let pop = queue.removeFirst()
                
                let x = pop[0]
                let y = pop[1]
                
                for z in 0..<4{
                    let nx = x + dx[z]
                    let ny = y + dy[z]
                    
                    if(nx >= 0 && nx < N && ny >= 0 && ny < N){
                        if(!visited[nx][ny] && binaryMap[nx][ny]){
                            queue.append([nx,ny])
                            visited[nx][ny] = true
                        }
                    }
                }
            }
        }
    }
}

print(numOfSafeArea)
