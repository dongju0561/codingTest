/*
 [백준] 불
 
 놓친 부분
 탈출자의 현재 시간을 비교할 것이 아니라 이동한 후 즉 이동하려는 위치까지 이동을 하면서 발생한 시간을 반영하고
 불이 해당 지역까지 도달하는데 걸린 시간과 탈출자가 동일한 위치까지 도달하는데 걸린 시간을 비교했어야했다.
 if(두 시간이 같은 경우) -> 해당 지역에 불과 탈출자가 동시에 도착
 if(탈출자의 시간값이 더 큰 경우) -> 탈출자가 해당 지역에 도착하기 전에 불이 이미 났다는 것을 의미
 
  ....F
  ...J#
  ....#
  ....#
  ...#.

  (spreadFire)
  5 4 3 2 1
  4 3 2 @ #
  7 6 5 4 #
  8 7 4 3 #
  9 8 7 # 100

  F.F
  .J.
  F.F

  (spreadFire)
  1 2 1
  2 @ 2
  1 2 1
 */

let impossible: String = "IMPOSSIBLE"
let SC: Int = Int(readLine()!)!

func spreadFire(fireMap: inout [[Int]], height: Int, width: Int){
    var queue = [(Int,Int)]()
    var currentPos = [Int]()
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    
    //불 위치 enqueue
    for y in 0..<height{
        for x in 0..<width{
            if fireMap[y][x] == 1{
                queue.append((y,x))
            }
            if fireMap[y][x] == 2{
                currentPos.append(contentsOf: [y,x])
                fireMap[y][x] = 0
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
                
//              틀렸던 부분
//              if fireMap[ny][nx] > fireMap[y][x]{
                if fireMap[ny][nx] > fireMap[y][x] + 1{
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
        fireMap[height].append(contentsOf: readLine()!.map(){
            if $0 == "#"{
                return -2
            }
            else if $0 == "."{
                return 0
            }
            else if $0 == "@"{
                return -1
            }
            else {
                return 1
            }
        })
    }
    
    spreadFire(fireMap: &fireMap, height: h, width: w)
    print(findRoute(fireMap: &fireMap, height: h, width: w) ?? impossible)
    
}