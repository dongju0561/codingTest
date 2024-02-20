import Foundation

var L = Int()
var C = Int()
var R = Int()
var buildingMap = [[[Int]]]()

//현재 지도에서 상에서
func BFS(_ start: [Int], _ end: [Int]) -> Int{
    let dx = [1,-1,0,0,0,0]
    let dy = [0,0,1,-1,0,0]
    let dz = [0,0,0,0,1,-1]
    
    var queue = [[Int]]()
    var visited: [[[Bool]]] = Array(repeating: Array(repeating: Array(repeating: false, count: R), count: C), count: L)
    queue.append(start)
    visited[start[0]][start[1]][start[2]] = true
    
    while !queue.isEmpty{
        let  pop = queue.removeFirst()
        
        let z = pop[0]
        let y = pop[1]
        let x = pop[2]
        
        for i in 0..<6{
            let nz = z + dz[i]
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            if(nz >= 0 && nz < L && ny >= 0 && ny < C && nx >= 0 && nx < R){
                if(!visited[nz][ny][nx] && buildingMap[nz][ny][nx] == 1){
                    if [nz,ny,nx] == end{
                        return buildingMap[z][y][x]
                    }
                    buildingMap[nz][ny][nx] = buildingMap[z][y][x] + 1
                    visited[nz][ny][nx] = true
                    queue.append([nz,ny,nx])
                }
            }
        }
    }
    return -1
}

while true{
    let LCR: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0)!}
    if LCR == [0,0,0] {break}
    
    var start = [Int]()
    var end = [Int]()
    //L = z축, R = Y축, C = X축
    L = LCR[0]
    C = LCR[1]
    R = LCR[2]
    buildingMap = Array(repeating: Array(repeating: [], count: C), count: L)
    
    //지도 입력
    for level in 0..<L{
        for col in 0..<C{
            var row = -1
            buildingMap[level][col].append(contentsOf: readLine()!.map(){
                row += 1
                if "S" == $0{
                    start = [level,col,row]
                    return 1
                }
                else if "E" == $0{
                    end = [level,col,row]
                    return 1
                }
                else if "#" == $0{
                    return 0
                }
                else {
                    return 1
                }
            })
        }
        _ = readLine()!
    }
    var time = BFS(start,end)
    if time != -1{
        //"." 안짝었다고 틀렸다고 처리...
        print("Escaped in \(time) minute(s).")
    }
    else{
        print("Trapped!")
    }
}
