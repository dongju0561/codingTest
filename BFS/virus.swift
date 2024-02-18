/*
 [백준] 연구소
 
 백트랙킹 구현에 대해서 확실히 알게된 문제
 
 방법을 찾지를 못해 다른 분의 풀이 참조..
 효율적인 벽 설치법을 너무 생각해서 문제가 방법 찾는데 어려움을 느낌
 너무 풀리지 않을때는 brutal force까지 고려해서 문제를 해결해보기!
 
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
    //완전 탐색과 백트래킹으로 3개의 벽을 세울 수 있는 경우의 수를 찾고 벽 설치 그리고 제거
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

//현재 지도(3개의 벽을 추가적으로 설치한 지도)에서 바이러스 확산 후 안전지역의 크기 구하고 안전지역의 크기 최대값과 비교&갱신
func spreadVirus(){
    var queue = [[Int]]()
    var temp = virusMap
    for i in 0..<N{
        for j in 0..<M{
            if temp[i][j] == 2{
                
                queue.append([i,j])
                
                //현재 지도에서 바이러스 확산
                while !queue.isEmpty{
                    let pop = queue.removeFirst()
                    
                    let x = pop[0]
                    let y = pop[1]
                    
                    for idx in 0..<4{
                        let nx = x + dx[idx]
                        let ny = y + dy[idx]
                        
                        if nx >= 0 && nx < N && ny >= 0 && ny < M{
                            if temp[nx][ny] == 0{
                                //숙주가 전염시킨 지역은 '3'으로 변경
                                temp[nx][ny] = 3
                                queue.append([nx,ny])
                            }
                        }
                    }
                }
            }
        }
    }
    //안전지역의 크기 변수
    var sizeOfSafeArea = 0
    
    //확산이 끝나고 안전지역의 크기를 구하는 코드
    for i in 0..<N{
        for j in 0..<M{
            if temp[i][j] == 0{
                sizeOfSafeArea += 1
            }
        }
    }
    //가장 큰 안전지역의 크기를 저장
    maxNumOfSafeArea = max(maxNumOfSafeArea,sizeOfSafeArea)
}

makeWall(0)

print(maxNumOfSafeArea)
