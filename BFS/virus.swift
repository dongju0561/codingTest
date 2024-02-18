/*
 [백준] 연구소
 
 백트랙킹 구현에 대해서 알게된 문제
  */
import Foundation

let NM = readLine()!.components(separatedBy: " ").map(){ Int(String($0))!}

let N: Int = NM[0]
let M: Int = NM[1]

var virusMap: [[Int]] = Array(repeating: [], count: N)

for idx in 0..<N{
    virusMap[idx].append(contentsOf: readLine()!.components(separatedBy: " ").map(){Int(String($0))!})
}

let dx = [1,-1,0,0]
let dy = [0,0,1,-1]

var maxNumOfSafeArea = 0

//벽 설치 경우의 수
//DFS 백트래킹을 이용한 벽 설치 전체 경우의 수 구하기
func makeWall(_ numOfwall: Int){
    //탐색을 종료하는 조건(벽 3개 설치)
    if numOfwall == 3{
        //바이러스 확산 최대 안전지역 갱신
        spreadVirus()
        
        return
    }
    for i in 0..<N{
        for j in 0..<M{
            if virusMap[i][j] == 0{
                virusMap[i][j] = 1
                makeWall(numOfwall + 1)
                //back
                virusMap[i][j] = 0
            }
        }
    }
}

func spreadVirus(){
    var queue = [[Int]]()
    var temp = virusMap
    for i in 0..<N{
        for j in 0..<M{
            if temp[i][j] == 2{
                
                queue.append([i,j])
                
                //확산
                while !queue.isEmpty{
                    let pop = queue.removeFirst()
                    
                    let x = pop[0]
                    let y = pop[1]
                    
                    for idx in 0..<4{
                        let nx = x + dx[idx]
                        let ny = y + dy[idx]
                        
                        if nx >= 0 && nx < N && ny >= 0 && ny < M{
                            if temp[nx][ny] == 0{
                                temp[nx][ny] = 3
                                queue.append([nx,ny])
                            }
                        }
                    }
                }
            }
        }
    }
    var sizeOfSafeArea = 0
    for i in 0..<N{
        for j in 0..<M{
            if temp[i][j] == 0{
                sizeOfSafeArea += 1
            }
        }
    }
    maxNumOfSafeArea = max(maxNumOfSafeArea,sizeOfSafeArea)
}

makeWall(0)

print(maxNumOfSafeArea)
