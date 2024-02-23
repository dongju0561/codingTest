

// import Foundation
// /*
//  처음에는 BFS를 활용해서 문제를 풀이하려 하였지만, 1일을 증가하는 타이밍을 찾지 못해
 
//  배열을 순회하면서 1이 존재하면 주변에 익지 않은 토마토를 익혀버리는 방식으로 문제를 풀었습니다.
 
//  1일이 경과하면 익은 토마토 주변은 1로 변화한다.
//  연산량을 줄이기 위해서 이미 익음에 영향을 준 토마토는 값'2'로 변경한다.
 
//  */
// let MN: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0)!}

// let M: Int = MN[0]
// let N: Int = MN[1]

// var tomatoMap : [[Int]] = Array(repeating: [], count: N)

// for col in 0..<N{
//     tomatoMap[col].append(contentsOf: readLine()!.components(separatedBy: " ").map(){Int($0)!})
// }

// var day: Int = 0
// var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)

// var startPoints : [[Int]]

// //토마토가 익는 상태를 과거와 현재를 비교해서 반복을 토마토 상태에 따라 반복을 진행합니다.
// while(true){
//     let yesterdayTomatoMap = tomatoMap
//     //상태 변화를 확인하는 변수
//     var isChanged = true
    
//     //하루가 지남에 따른 토마토 상태 변경
//     ripeOneDay()
    
//     //만약 토마토 상태가 전날과 같다면
//     if yesterdayTomatoMap == tomatoMap{
//         for col in 0..<N{
//             //일부 토마도가 익지 않았다면
//             if tomatoMap[col].contains(0){
//                 print("-1")
//                 isChanged = false
//                 break
//             }
//             //모든 토마도가 익었다면
//             else{
//                 print(day - 1)
//                 isChanged = false
//                 break
//             }
//         }
//     }
//     if !isChanged{
//         break
//     }
// }

// import Foundation
// /*
//  처음에는 BFS를 활용해서 문제를 풀이하려 하였지만, 1일을 증가하는 타이밍을 찾지 못해
 
//  배열을 순회하면서 1이 존재하면 주변에 익지 않은 토마토를 익혀버리는 방식으로 문제를 풀었습니다.
 
//  1일이 경과하면 익은 토마토 주변은 1로 변화한다.
//  연산량을 줄이기 위해서 이미 익음에 영향을 준 토마토는 값'2'로 변경한다.
 
//  */
// let MN: [Int] = readLine()!.components(separatedBy: " ").map(){ Int($0)!}

// let M: Int = MN[0]
// let N: Int = MN[1]

// var tomatoMap : [[Int]] = Array(repeating: [], count: N)

// for col in 0..<N{
//     tomatoMap[col].append(contentsOf: readLine()!.components(separatedBy: " ").map(){Int($0)!})
// }

// var day: Int = 0
// var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)

// //하루동안 모든 1의 동서남북 탐색을 1회 탐색
// func ripeAround(_ start: [Int],_ willRipe: inout [[Int]]){
//     let dx = [1,-1,0,0]
//     let dy = [0,0,1,-1]
    
//     let y = start[0]
//     let x = start[1]
    
//     for idx in 0..<4{
//         let nx = x + dx[idx]
//         let ny = y + dy[idx]
        
//         if nx >= 0 && nx < M && ny >= 0 && ny < N {
//             if !visited[ny][nx] && tomatoMap[ny][nx] == 0{
//                 willRipe.append([ny,nx])
//             }
//         }
//     }
// }
// func ripeOneDay(){
//     var willRipe = [[Int]]()
//     for col in 0..<N{
//         for row in 0..<M{
//             if tomatoMap[col][row] == 1{
//                 ripeAround([col,row], &willRipe)
//                 tomatoMap[col][row] = 2
//             }
//         }
//     }
    
//     //당일에 익은 토마토는 주변의 토마토를 익히지 못하기 때문에 처리
//     for i in 0..<willRipe.count{
//         let ny = willRipe[i][0]
//         let nx = willRipe[i][1]
//         visited[ny][nx] = true
//         tomatoMap[ny][nx] = 1
//     }
//     day += 1
// }

// //토마토가 익는 상태를 과거와 현재를 비교해서 반복을 토마토 상태에 따라 반복을 진행합니다.
// while(true){
//     let yesterdayTomatoMap = tomatoMap
//     //상태 변화를 확인하는 변수
//     var isChanged = true
    
//     //하루가 지남에 따른 토마토 상태 변경
//     ripeOneDay()
    
//     //만약 토마토 상태가 전날과 같다면
//     if yesterdayTomatoMap == tomatoMap{
//         for col in 0..<N{
//             //일부 토마도가 익지 않았다면
//             if tomatoMap[col].contains(0){
//                 print("-1")
//                 isChanged = false
//                 break
//             }
//             //모든 토마도가 익었다면
//             else{
//                 print(day - 1)
//                 isChanged = false
//                 break
//             }
//         }
//     }
//     if !isChanged{
//         break
//     }
// }