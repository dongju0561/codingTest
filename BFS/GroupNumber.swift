//2월 17일 8시 32분 시작

/*
 [백준] 단지번호붙이기
 */

/*입력
 
 가로 세로의 길이(N)
 집의 유무 정보 2차원 배열
 */

import Foundation

func AllBFS(){
    for i in 0..<N{
        for j in 0..<N{
            if !visited[i][j] && houseMap[i][j] == 1{
                numOfGroup += 1
                numOfHouseList.append(BFS(i,j))
            }
        }
    }
}

//BFS 탐색 후 탐색한 집의 갯수 반환
func BFS(_ i: Int, _ j: Int) -> Int{
    var numOfHouse: Int = 0

    //처음 탐색을 시작한 노드의 방문처리
    visited[i][j] = true
    numOfHouse += 1
    
    var queue = [[Int]]()
    
    queue.append([i,j])
    
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    while !queue.isEmpty{
        let pop: [Int] = queue.removeFirst()
        let x = pop[0]
        let y = pop[1]
        
        for direction in 0..<4{
            let nx = x + dx[direction]
            let ny = y + dy[direction]
            
            if nx >= 0 && nx < N && ny >= 0 && ny < N{
                if !visited[nx][ny] && houseMap[nx][ny] == 1{
                    numOfHouse += 1
                    visited[nx][ny] = true
                    queue.append([nx,ny])
                }
            }
        }
    }
    return numOfHouse
}

//가로 세로의 길이(N) 입력
let N = Int(readLine()!)!

var houseMap: [[Int]] = Array(repeating: [], count: N)
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
//집의 유무 정보 2차원 배열 생성
for idx in 0..<N{
    let temp = readLine()!.map(){Int(String($0))!}
    houseMap[idx].append(contentsOf: temp)
}

//단지별 집의 갯수 배열
var numOfGroup: Int = 0
var numOfHouseList = [Int]()

AllBFS()

/*
 출력
 
 단지의 갯수
 각 단지의 집의 갯수
 */
numOfHouseList.sort(by: {$0<=$1})
print(numOfGroup)
numOfHouseList.forEach {
    print($0)
}

