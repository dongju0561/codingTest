/*
 색종이 붙이기
 
 각 종류의 색종이 5개
 1x1 2x2 3xx3 4x4 5x5
 1 = 모두 색종이로 덮여져야 함
 
 종이의 경계 밖으로 나가서는 안되고,
 
 색종이끼리 겹쳐도 안 된다
 
 0 = 색종이가 붙으면 안된다.
 */


/*
 색종이 붙이기
 
 각 종류의 색종이 5개
 1x1 2x2 3xx3 4x4 5x5
 1 = 모두 색종이로 덮여져야 함
 
 종이의 경계 밖으로 나가서는 안되고,
 
 색종이끼리 겹쳐도 안 된다
 
 0 = 색종이가 붙으면 안된다.
 */

typealias coordinate = (x: Int, y: Int)
var map: [[Int]] = Array(repeating: [], count: 10)
//1x1 == 0(idx)부터 시작
var numOfColorPaper = [5,5,5,5,5]
for i in 0..<10{
    let temp = readLine()!.split(separator: " ").map{Int(String($0))!}
    map[i].append(contentsOf: temp)
}
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 10), count: 10)
var maxCnt = Int.max
var cnt = 0
//만약 필요한 색종이가 부족하다면 true로 토글
var flag = false

func recursive(_ range: Int, start: coordinate){
    //범위내에 값들이 1이다.
    var flag1 = true
    if range == 0{
        return
    }
    if 0...10 ~= start.x + range && 0...10 ~= start.y + range{
        for x in start.x ..< start.x + range{
            for y in start.y ..< start.y + range{
                if map[x][y] != 1{ flag1 = false}
                if !flag1 {break}
            }
            if !flag1 {break}
        }
        if !flag1 {
            recursive(range - 1, start: start)
            return
        }
        //만약 특정 색종이가 부족하다면
        if numOfColorPaper[range - 1] - 1 < 0{
            flag = true
            return
        }
        for x in start.x ..< start.x + range{
            for y in start.y ..< start.y + range{
                visited[x][y] = true
            }
        }
        numOfColorPaper[range - 1] = numOfColorPaper[range - 1] - 1
        for i in 0..<visited.count{
            print(visited[i].map{String($0)}.joined(separator: "\t"))
        }
        print("")
        cnt += 1
        return
    }
    else{
        recursive(range - 1, start: start)
    }
}

for plusX in 0..<10{
    for plusY in 0..<10{
        for x in 0..<10{
            for y in 0..<10{
                if map[(x+plusX)%10][(y+plusY)%10] == 1 && !visited[(x+plusX)%10][(y+plusY)%10]{
                    recursive(5, start: ((x+plusX)%10,(y+plusY)%10))
                }
                if flag{break}
            }
            if flag{break}
         }
        if !flag{
            
            maxCnt = min(maxCnt,cnt)
        }
        cnt = 0
        visited = Array(repeating: Array(repeating: false, count: 10), count: 10)
        flag = false
        numOfColorPaper = [5,5,5,5,5]
    }
}

flag ? print("-1") : print(maxCnt)




// typealias coordinate = (x: Int, y: Int)
// var map: [[Int]] = Array(repeating: [], count: 10)
// //1x1 == 0(idx)부터 시작
// var numOfColorPaper = [5,5,5,5,5]
// for i in 0..<10{
//     let temp = readLine()!.split(separator: " ").map{Int(String($0))!}
//     map[i].append(contentsOf: temp)
// }
// var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 10), count: 10)
// var cnt = 0
// //만약 필요한 색종이가 부족하다면 true로 토글
// var flag = false

// func recursive(_ range: Int, start: coordinate){
//     //범위내에 값들이 1이다.
//     var flag1 = true
//     if range == 0{
//         return
//     }
//     if 0...10 ~= start.x + range && 0...10 ~= start.y + range{
//         for x in start.x ..< start.x + range{
//             for y in start.y ..< start.y + range{
//                 if map[x][y] != 1{ flag1 = false}
//                 if !flag1 {break}
//             }
//             if !flag1 {break}
//         }
//         if !flag1 {
//             recursive(range - 1, start: start)
//             return
//         }
//         //만약 특정 색종이가 부족하다면
//         if numOfColorPaper[range - 1] - 1 < 0{
//             flag = true
//             return
//         }
//         for x in start.x ..< start.x + range{
//             for y in start.y ..< start.y + range{
//                 visited[x][y] = true
//             }
//         }
//         numOfColorPaper[range - 1] = numOfColorPaper[range - 1] - 1
//         cnt += 1
//         return
//     }
//     else{
//         recursive(range - 1, start: start)
//     }
// }

// for x in 0..<10{
//     for y in 0..<10{
//         if map[x][y] == 1 && !visited[x][y]{
//             recursive(5, start: (x,y))
//         }
//         if flag{break}
//     }
//     if flag{break}
// }

// flag ? print("-1") : print(cnt)
