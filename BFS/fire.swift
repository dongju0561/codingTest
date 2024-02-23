let impossible: String = "IMPOSSIBLE"
let WALL = -2
let SPACE = 0
let ME = -1
let FIRE = 1

let SC: Int = Int(readLine()!)!

func spreadFire(fireMap: inout [[Int]], height: Int, width: Int){
    var queue = [(Int,Int)]()
    var currentPos = [Int]()
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    //불 위치 enqueue
    for y in 0..<height{
        for x in 0..<width{
            if fireMap[y][x] == FIRE{
                queue.append((y,x))
            }
            if fireMap[y][x] == ME{
                currentPos.append(contentsOf: [y,x])
                fireMap[y][x] = SPACE
            }
        }
    }
    
    var idx = 0
    while idx < queue.count{
        let pop = queue[idx]
        
        let y = pop.0
        let x = pop.1
        
        for i in 0..<4{
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if nx >= 0 && nx < width && ny >= 0 && ny < height{
                if fireMap[ny][nx] == 0{
                    fireMap[ny][nx] = fireMap[y][x] + 1
                    queue.append((ny,nx))
                }
            }
        }
        idx += 1
    }
    
    for h in 0..<height{
        for w in 0..<width{
            if fireMap[h][w] == 0{
                fireMap[h][w] = Int.max
            }
        }
    }
            
    fireMap[currentPos[0]][currentPos[1]] = ME
}
func isSpaceForEscape(fireMap:[[Int]],height: Int, width: Int) -> Bool{
    //지도 외곽에 탈출할 수 있는 공간이 없는 경우
    var isPossibleEscape = false
    for col in 0..<height{
        if fireMap[col][0] == 0 {
            isPossibleEscape = true
            break
        }
        if fireMap[col][width - 1] == 0 {
            isPossibleEscape = true
            break
        }
    }
    for row in 0..<width{
        if fireMap[0][row] == 0{
            isPossibleEscape = true
            break
        }
         if fireMap[height - 1][row] == 0 {
            isPossibleEscape = true
            break
        }
    }
    if !isPossibleEscape {
        print(impossible)
        return false
    }
    else {
        return true
    }
}
func findRoute(fireMap: inout [[Int]], height: Int, width: Int) -> Int?{
    var queue = [(Int,Int)]()
    var idx = 0
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    for h in 0..<height{
        for w in 0..<width{
            if fireMap[h][w] == -1{
                queue.append((h,w))
                fireMap[h][w] = 1
            }
        }
    }
    
    while idx < queue.count{
        
        let pop = queue[idx]
        
        let y = pop.0
        let x = pop.1
        
        for i in 0..<4{
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if nx >= 0 && nx < width && ny >= 0 && ny < height{
                if fireMap[ny][nx] > fireMap[y][x]{
                    fireMap[ny][nx] = fireMap[y][x] + 1
                    queue.append((ny,nx))
                }
            }else{
                return fireMap[y][x]
            }
        }
        
        idx += 1
    }
    return nil
}

for _ in 0..<SC{
    let hw: [Int] = (readLine()!.split(separator: " ").map(){Int(String($0))!})
    let h = hw[1]
    let w = hw[0]


    var fireMap: [[Int]] = Array(repeating: [], count: h)


    for height in 0..<h{
        let temp = readLine()!.map(){
            if $0 == "#"{
                return WALL
            }
            else if $0 == "."{
                return SPACE
            }
            else if $0 == "@"{
                return ME
            }
            else {
                return FIRE
            }
        }
        fireMap[height].append(contentsOf: temp)
    }
   
    
    if !isSpaceForEscape(fireMap: fireMap, height: h, width: w){ continue }

    spreadFire(fireMap: &fireMap, height: h, width: w)
    
    print(findRoute(fireMap: &fireMap, height: h, width: w) ?? impossible)
    
}

