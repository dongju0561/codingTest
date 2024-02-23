/*
 [백준] 벽 부수고 이동하기
 
 참고

 경우의 수: 벽을 부수지 않고 목표 공간 도달, 벽을 부수고 목표 공간 도달
 */

import Foundation
let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0], m = input[1]
var graph: [[Character]] = []
for _ in 0..<n {
    graph.append(readLine()!.map { $0 })
}

//경우를 벽을 부쉈을때, 그렇지 않을때로 나눔
//[break][y[x] break인덱스가 0인 경우 벽을 부수지 않았을때를 의미
var visited = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false, count: m), count: n), count: 2)

func isValidCoord(y: Int, x: Int) -> Bool {
    // ~= 패턴 매칭 연산자이다. 범위 내에 x 또는 y 값이 존재하는 bool형태로 반환
    //만약 n == 6, y == 3라면 -> 0부터 5까지의 범위이기 때문에 3은 범위내에 존재하므로 true를 반환 받는다.
    return 0..<n ~= y && 0..<m ~= x
}

let dx = [1, 0, -1, 0]
let dy = [0, 1, 0, -1]

//큐의 2번째는 걸리를 의미 시작점부터 거리를 세기로 했으
//첫번째는 y축 두번째는 x축 네번째는 벽을 부순 횟수를 의미합니다.
var queue = [(0, 0, 1, 0)]
var index = 0
var answer = -1

while queue.count > index {
    let y = queue[index].0
    let x = queue[index].1
    let d = queue[index].2
    let brokenCount = queue[index].3
    
    //목표 지점에 도달하면 answer 변수에 거리 정보 할당하고 반복 종료
    if y == n - 1 && x == m - 1 {
        answer = d
        break
    }
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        
        //지도 외 지역에 접근하거나 방문했던 지역이면 해당 공간 접근 안함
        if !isValidCoord(y: ny, x: nx) || visited[brokenCount][ny][nx] {
            continue
        }
        
        //접근이 가능한 공간
        if graph[ny][nx] == "0" {
            visited[brokenCount][ny][nx] = true
            queue.append((ny, nx, d + 1, brokenCount))
        }
        
        //벽을 부순 경우 없고 좌표(nx,ny)가 벽이라면 벽을 부수고 해당 공간에 방문 이때 벽을 한번만 부수는 걸 허용
        if graph[ny][nx] == "1" && brokenCount == 0 {
            visited[brokenCount + 1][ny][nx] = true
            queue.append((ny, nx, d + 1, brokenCount + 1))
            /*
            위 코드의 탐색의 범위 설명
            0 = 접근 가능 범위
            1 = 접근 불가능 범위
            3 = 탐색 범위
            (지도)
            0001
            1101
            1111
            1110

            (기존의 탐색 범위)
            3331
            1131
            1111
            1110

            (탐색 범위)
            3333
            3333
            1131
            1110
            */
        }
        
        //목표 지점에 도달하지 못하면 answer 변수에 거리 정보(d)를 할당하지 못하므로 초기값 -1을 반환
    }
    index += 1
}

print(answer)