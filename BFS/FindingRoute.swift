/*
 [백준] 경로 찾기
 
 */

 /*
 시작노드와 목적지 노드가 같다면 다른 노드롤 경유하고 왔을때의 '1' 처리해줘야하는 경우를 처리하지 못했음
 무조건 방문했으면 '1'처리함 그래서 시작노드와 목적지 노드가 같았을때 '1'처리가 되어 틀림
 */
import Foundation

//함수 정의
func BFS(start: Int, end: Int) -> Int{
    //i번째 노드부터 j번째 노드까지 도달할 수 있는지 알아내는 함수
    var queue = [Int]()
    var isFirstTime: Bool = true
    queue.append(start)
    
    while !queue.isEmpty{
        let pop: Int = queue.removeFirst()
        
        if !visited[pop] {
            
//            첫번째 시도
//            이렇게 코드를 짜면 start 노드와 end 노드가 같을때 무조건 1을 반환
//            다른 노드를 거쳐 start 노드로 돌아오는 경우가 진짜 1인 경우
//            if pop == end{
//                return 1
//            }
            //처음 노드는 주위를 살피기만 하고 방문을 안했다고 할거임
            if pop == start && pop == end && isFirstTime{
                //명시적으로 방문을 속였다는것을 보여주기 위해
                visited[pop] = false
                queue.append(contentsOf: G[pop])
                isFirstTime = !isFirstTime
                continue
            }
            
            if pop == end{
                return 1
            }
            
            visited[pop] = true
            queue.append(contentsOf: G[pop])
        }
    }
    return 0
}

//정점의 갯수 입력받기
let N = Int(readLine()!) ?? 0

//인접 행렬 입력 받기
var inputMatrix = [[Int]]()
for _ in 0..<N{
    let temp = readLine()!.components(separatedBy: " ").map(){ Int(String($0))! }
    inputMatrix.append(temp)
}

//간선 설치(방향 그래프)
var G:[[Int]] = Array(repeating: [], count: N)

for i in 0..<N{
    for j in 0..<N{
        if inputMatrix[i][j] == 1{
            G[i].append(j)
        }
    }
}

var result:[[Int]] = Array(repeating: Array(repeating: 0, count: N), count: N)
var visited: [Bool] = Array(repeating: false, count: N)

for i in 0..<N{
    for j in 0..<N{
        result[i][j] = BFS(start: i, end: j)
        visited = Array(repeating: false, count: N)
    }
}

//결과 출력
for i in 0..<N{
    for j in 0..<N{
        print(result[i][j], terminator: " ")
    }
    print("")
}
