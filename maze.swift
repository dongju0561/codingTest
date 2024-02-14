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

// //미로의 시작은 1,1 명시되어 있지만 2차원 배열의 처음 시작 인덱스는 0,0
// let start = [0,0]
// var queue: [[Int]] = []
// var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 6), count: 4)
// var distances: [[Int]] = Array(repeating: Array(repeating: -1, count: 6), count: 4)

// //목적지 좌표 입력 N(0번째 인덱스) M(1번째 인덱스)
// var destination: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0) ?? 0}

// //지도 입력
// //difficult: 띄어쓰기 구분되어 있지 않은 입력을 어떻게 처리할 수 있을까?
// var map = [[Int]]()
// for _ in 0..<destination[0]{
//        map.append(readLine()!.map({Int(String($0))!}))
// }

// queue.append(start)
// //visited[start[0]][start[1]] = true

// while !queue.isEmpty{
//     print(queue)
//     print(visited)
//     let currentPlace:[Int] = queue.removeFirst()
//     //방문하지 않았다면
//     if (!visited[currentPlace[0]][currentPlace[1]]){
//         //동서남북 다음 차례에 갈 수 있는 영역 찾기
//         //difficult: out of range error 발생...
//         //가독성 안좋음
//         if(destination[1] > currentPlace[1]+1){
//             if(map[currentPlace[0]][currentPlace[1]+1] == 1){
//                 queue.append([currentPlace[0],currentPlace[1]+1])
//                 distances[currentPlace[0]][currentPlace[1]+1] = distances[currentPlace[0]][currentPlace[1]] + 1
//             }
//         }
//         if(destination[1] < currentPlace[1]-1){
//             if(map[currentPlace[0]][currentPlace[1]-1] == 1){
//                 queue.append([currentPlace[0],currentPlace[1]-1])
//                 distances[currentPlace[0]][currentPlace[1]-1] = distances[currentPlace[0]][currentPlace[1]] + 1
//             }
//         }
//         if(destination[0] < currentPlace[0]+1){
//             if(map[currentPlace[0]+1][currentPlace[1]] == 1){
//                 queue.append([currentPlace[0]+1,currentPlace[1]])
//                 distances[currentPlace[0]+1][currentPlace[1]] = distances[currentPlace[0]][currentPlace[1]] + 1
//             }
//         }
//         if(destination[0] < currentPlace[0]-1){
//             if(map[currentPlace[0]-1][currentPlace[1]] == 1){
//                 queue.append([currentPlace[0]-1,currentPlace[1]])
//                 distances[currentPlace[0]-1][currentPlace[1]+1] = distances[currentPlace[0]][currentPlace[1]] + 1
//             }
//         }
//     }
// }

// print(distances)
