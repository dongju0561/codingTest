/*
 [백준] 소문난 칠공주
 
 이다솜파 = S
 임도연파 = Y
 여학생 7명
 
 해당 여학생들은 인접해야함
 
 이다솜파로만 칠공주를 구성할 필요없다 == 임도연파 여학생들로도 구성이 가능하다
 
 7공주 중 이다솜파의 학생이 4명 이상 포함 되어야한다.
 
 주어진 자리배치도에 따라 7공주를 구성할 수 있는 경우의 수를 구해라
 
 */

typealias coordinate = (x: Int, y:Int)
let N = 5
let d: [coordinate] = [(0,1),(0,-1),(1,0),(-1,0)]
var map: [[String]] = Array(repeating: [], count: N)
for idx in 0..<5{
    let temp = readLine()!.map{String($0)}
    map[idx].append(contentsOf: temp)
}
var cnt = 0

func BFS(_ binaryMap: [[Int]],_ start: coordinate) -> Bool{
    var numOfVisit = 0
    var queue = [coordinate]()
    var idx = 0
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
    let d: [coordinate] = [(0,1),(0,-1),(1,0),(-1,0)]
    visited[start.x][start.y] = true
    queue.append(start)
    numOfVisit += 1
    
    while queue.count > idx{
        let pop = queue[idx]
        idx += 1
        for i in 0..<4{
            let nx = pop.x + d[i].x
            let ny = pop.y + d[i].y
            
            if 0..<5 ~= nx && 0..<5 ~= ny{
                if !visited[nx][ny] && (binaryMap[nx][ny] == 1){
                    visited[nx][ny] = true
                    numOfVisit += 1
                    queue.append((nx,ny))
                }
            }
        }
    }
    
    if numOfVisit == 7{
        return true
    }
    return false
}
func check(_ result: [Int]){
    var numOfS = 0
    var connectedMap: [[Int]] = Array(repeating: Array(repeating: 0, count: N), count: N)
    var start: coordinate = (0,0)
    for idx in result{
        let x = idx/5
        let y = idx%5
        
        if map[x][y] == "S"{
            numOfS += 1
            connectedMap[x][y] = 1
        }
        else{ //
            connectedMap[x][y] = 1
        }
        start = (x,y)
    }
    if !(numOfS >= 4){
        return
    }
    if !BFS(connectedMap, start){
        return
    }
    cnt += 1
}


func recursive(_ depth: Int,_ result: [Int],_ start: Int){
    if result.count == 7{
        //해당 요소들이 인접해 있는지 && numOfS >= 4
        check(result)
        return
    }
    for i in start..<25{
        if !result.contains(i){
            var temp = result
            temp.append(i)
            recursive(depth + 1, temp, i)
            temp.removeLast()
        }
    }
}
recursive(0, [], 0)
print(cnt)