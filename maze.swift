/*
[백준] 미로 탐색
0과 1로 이루어진 미로에서 목적진까지의 최소 거리를 구하는 문제입니다
인덱스에 해당하는 값이 1인 경우는 접근할 수 있는 공간을 의미

BFS 탐색을 통해 최단거리를 구합니다.

문제를 풀면서 좀 까다로웠던 부분은 여태까지는 " "공백을 기준으로 입력값을 받았지만 공백없이 연속된 입력값을 처리하기 부분이 까다로웠습니다.
그리고 현재 위치에서 다음 갈 수 있는 공간은 동서남북으로 갈 수 있습니다.(방문했던 곳을 제외하면 사실상 3가지..)

하지만 현재위치가 지도의 가장자리인 경우 지도 밖을 가리킵니다. 즉 2차원배열 범위 밖을 가리키게 되고 에러를 발생시킵니다. 이것을 해겷하는데 어려움을 가졌습니다.

중복되는 코드로 인해 코드를 작성할때 가독성이 떨어져 작업에 어려움이 존재
*/

/*
 주의사항
 지도를 위한 입력들은 붙여진 상태로 입력 받는다.
 지도 좌표는 인덱스 row+1, col+1부터 시작이다.
 */

//------------------------------------------------------------------------------------------------------------------------------------------------
/*
순서
1. 목적지 좌표 입력 (N M)
2. 지도 입력
3. BFS 알고리즘으로 최단거리 구하기
*/

import Foundation

var queue: [[Int]] = []
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 6), count: 4)
var distances: [[Int]] = Array(repeating: Array(repeating: -1, count: 6), count: 4)

//목적지 좌표 입력 N(0번째 인덱스) M(1번째 인덱스)
//map(){ Int(String($0))} == 시간 절약
var destination: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0) ?? 0}

//지도 입력
//difficult: 띄어쓰기 구분되어 있지 않은 입력을 어떻게 처리할 수 있을까?
/*
readLine()!.map()과 readLine()!.components(seperatedBy: " ").map()의 차이
readLine()의 반환값은 String?
components(seperatedBy:)의 반환값은 [String]이다.
map 메소드는 컬렉션의 각 요소들을 클로져에서 정의한 코드대로 적용하여 해당 컬렉션으로 반환하는 메소드입니다.
그래서 readLine()으로부터 반환 받은 String의 각 요소($0)의 타입을 String.element(AKA Charactor)이고
components()으로부터 반환 받은 [String]의 각 요소의 타입은 String이 되게 됩니다.

이때 Charactor타입에서 Int 타입으로 바로 typecasting을 할 수 없기 때문에 String으로 형변환 후에 Int로 형변환
형변환 순서: Charactor -> String -> Int

이러한 이유로 readLine().map()의 클로져의 인자와 readLine().components(seperatedBy: ).map의 클로져의 인자의 타입의 차이가 발생하였고
Int형으로의 형변화 과정에 있어 방식이 달랐습니다.
 */
var map = [[Int]]()
for _ in 0..<destination[0]{
    map.append(readLine()!.map({Int(String($0))!}))
}

queue.append([0,0])
distances[0][0] = 1

while !queue.isEmpty{
    let currentPlace:[Int] = queue.removeFirst()
    //방문하지 않았다면
    let x = currentPlace[0]
    let y = currentPlace[1]

    //가독성을 위해 연속적으로 변경하는 값 동서남북와 같은 값을 배열 해당 값을 할당
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]

    for i in 0..<4 {
        //동서남북을 탐색을 위한 좌표 변수 nx, ny
        let nx = x + dx[i]
        let ny = y + dy[i]

        //지도의 범위를 범위를 벗어나지 않기 위한 조건문
        if nx >= 0 && nx < destination[0] && ny >= 0 && ny < destination[1] {
            //방문하지 않았던 곳과 지도 상에 해당 인덱스의 값이 1인 경우(접근이 가능한 경우)
            if !visited[nx][ny] && map[nx][ny] == 1{
                distances[nx][ny] = distances[x][y] + 1
                queue.append([nx,ny])
                visited[nx][ny] = true
            }
        }
    }
}

print(distances[destination[0]-1][destination[1]-1])


/*
- 알게된 것
공백으로 구분되어 있지 않고 구분된 입력 받는 방법
for _ in (입력된 문자열의 길이){
    let temp = readLine()!.map(){ Int(String($0))!}
    (전체입력을 위한 2차원배열).append(temp)
}

가독성을 위해 반복되는 값들을 짧은 이름의 변수에 할당

가독성을 위해 동서남북과 같이 연속되는 값을 배열로 묶고 반복문으로 값을 변경하면서 값을 처리
*/

//[백준] 미로 탐색
// 내 풀이
// /*
//  순서
//  1. 목적지 좌표 입력 (N M)
//  2. 지도 입력
//  3. BFS 알고리즘으로 최단거리 구하기
// */

// /*
//  주의사항
//  지도를 위한 입력들은 붙여진 상태로 입력 받는다.
//  지도 좌표는 인덱스 row+1, col+1부터 시작이다.
//  */

//미로의 시작은 1,1 명시되어 있지만 2차원 배열의 처음 시작 인덱스는 0,0
//let start = [0,0]
//var queue: [[Int]] = []
//var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 6), count: 4)
//var distances: [[Int]] = Array(repeating: Array(repeating: -1, count: 6), count: 4)
//
////목적지 좌표 입력 N(0번째 인덱스) M(1번째 인덱스)
//var destination: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0) ?? 0}
//
////지도 입력
////difficult: 띄어쓰기 구분되어 있지 않은 입력을 어떻게 처리할 수 있을까?
//var map = [[Int]]()
//for _ in 0..<destination[0]{
//       map.append(readLine()!.map({Int(String($0))!}))
//}
//
//queue.append(start)
////visited[start[0]][start[1]] = true
//
//while !queue.isEmpty{
//    // print(queue)
//    // print(visited)
//    let currentPlace:[Int] = queue.removeFirst()
//    //방문하지 않았다면
//    if (!visited[currentPlace[0]][currentPlace[1]]){
//        //동서남북 다음 차례에 갈 수 있는 영역 찾기
//        //difficult: out of range error 발생...
//        //가독성 안좋음
//        if(destination[1] > currentPlace[1]+1){
//            if(map[currentPlace[0]][currentPlace[1]+1] == 1){
//                queue.append([currentPlace[0],currentPlace[1]+1])
//                distances[currentPlace[0]][currentPlace[1]+1] = distances[currentPlace[0]][currentPlace[1]] + 1
//            }
//        }
//        if(destination[1] < currentPlace[1]-1){
//            if(map[currentPlace[0]][currentPlace[1]-1] == 1){
//                queue.append([currentPlace[0],currentPlace[1]-1])
//                distances[currentPlace[0]][currentPlace[1]-1] = distances[currentPlace[0]][currentPlace[1]] + 1
//            }
//        }
//        if(destination[0] < currentPlace[0]+1){
//            if(map[currentPlace[0]+1][currentPlace[1]] == 1){
//                queue.append([currentPlace[0]+1,currentPlace[1]])
//                distances[currentPlace[0]+1][currentPlace[1]] = distances[currentPlace[0]][currentPlace[1]] + 1
//            }
//        }
//        if(destination[0] < currentPlace[0]-1){
//            if(map[currentPlace[0]-1][currentPlace[1]] == 1){
//                queue.append([currentPlace[0]-1,currentPlace[1]])
//                distances[currentPlace[0]-1][currentPlace[1]+1] = distances[currentPlace[0]][currentPlace[1]] + 1
//            }
//        }
//    }
//}
//
//print(distances)
