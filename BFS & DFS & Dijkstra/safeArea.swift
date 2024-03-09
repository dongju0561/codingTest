/*
 [백준] 안전 영역
 
 코딩 순서
 물높이 입력(N) -> 지형지도 입력(groundHeight) 입력-> 물에 잠긴 지형 관련 binary 지도 생성
 -> 반복(방문할 곳이 없을때 까지){안전지역 탐색 -> 방문? -> BFS 탐색}
 
 여태까지 풀었던 BFS 카테고리의 문제와 해당 문제의 차이점
 기존 문제들은 한번의 BFS 탐색으로 문제가 끝났지만 하나의 지도(2차원배열에서)해당 문제는 BFS탐색을 여러번 진행하여 문제를 해결하는 문제입니다.
 BFS 탐색들을 진행하면서 해당 지도내에서는 visited 데이터를 유지해야 합니다.
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

func makeBinaryMap(waterHeight:Int){
    for i in 0..<N{
        for j in 0..<N{
            if waterHeight < groundHeight[i][j]{
                binaryMap[i][j] = true
            }
            else{
                binaryMap[i][j] = false
            }
        }
    }
}

func AllBFS() -> Int{
    //visited를 변수를 BFS()함수 내부에 넣지 않은 이유 모든 안전구역의 갯수를 세기 전까지 사라지면 안되는 데이터이기 때문이다.
    //visited 변수를 AllVBFS() 전역변수가 아닌 함수 내부에 선언함으로써 하나의 binaryMap 전체 BFS탐색이 끝이 나고 visited 변수 초기화를 진행하지 않아도됨
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
    var numOfSafeArea: Int = 0

    for i in 0..<N{
        for j in 0..<N{
            if(!visited[i][j] && binaryMap[i][j]){
                numOfSafeArea += 1
                BFS(i, j, &visited)
            }
        }
    }
    return numOfSafeArea
}

func BFS(_ i: Int,_ j: Int, _ visited: inout [[Bool]]){
    //BFS 탐색 시작
    
    let dx:[Int] = [1,-1,0,0]
    let dy:[Int] = [0,0,1,-1]
    var queue = [[Int]]()
    
    queue.append([i,j])
    visited[i][j] = true

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

var maxNumOfSafeArea: Int = 1

for waterHeight in 0...100{
    //물높이에 따른 Binary 지도 생성
    makeBinaryMap(waterHeight: waterHeight)
    maxNumOfSafeArea = max(AllBFS(),maxNumOfSafeArea)
}

//안전구역 갯수의 최대값 출력
print(maxNumOfSafeArea)
