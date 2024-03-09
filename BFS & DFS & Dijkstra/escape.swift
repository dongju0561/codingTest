let CR = readLine()!.split(separator: " ").map(){Int(String($0))!}

let col = CR[0]
let row = CR[1]
var rowIdx = 0
var start = [Int]()
var end = [Int]()
var coorFlood = [[Int]]()
var forest: [[Int]] = Array(repeating: [], count: col)
let KAKTUS = "KAKTUS"
//지도 그리기
for c in 0..<col{
    rowIdx = 0
    forest[c].append(contentsOf: readLine()!.map(){
        if $0 == "D"{
            end.append(contentsOf: [c,rowIdx])
            rowIdx += 1
            return -2
        }else if $0 == "S"{
            start.append(contentsOf: [c,rowIdx])
            rowIdx += 1
            return -1
        }else if $0 == "."{
            rowIdx += 1
            return 0
        }else if $0 == "*"{
            coorFlood.append([c,rowIdx])
            rowIdx += 1
            return 1
        }else if $0 == "X"{
            rowIdx += 1
            return -2
        }
        else{
            rowIdx += 1
            print("something wrong")
            return -4
        }
    })
}

func flood(){
    var queue = [[Int]]()
    var idx = 0
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    queue.append(contentsOf: coorFlood)
    
    while idx < queue.count{
        let pop = queue[idx]
        let x = pop[1]
        let y = pop[0]
        for i in 0..<4{
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if 0..<row ~= nx && 0..<col ~= ny{
                if forest[ny][nx] == 0{
                    forest[ny][nx] = forest[y][x] + 1
                    queue.append([ny,nx])
                }
            }
        }
        idx += 1
    }
}
func goToD(){
    var queue = [[Int]]()
    var idx = 0
    let dx = [1,-1,0,0]
    let dy = [0,0,1,-1]
    let startY = start[0]
    let startX = start[1]
    forest[startY][startX] = 1
    queue.append(start)
    
    while idx < queue.count{
        let pop = queue[idx]
        let x = pop[1]
        let y = pop[0]
        for i in 0..<4{
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if 0..<row ~= nx && 0..<col ~= ny{
                if end[0] == ny && end[1] == nx{
                    print(forest[y][x])
                    return
                }
                if forest[ny][nx] > forest[y][x] + 1{
                    forest[ny][nx] = forest[y][x] + 1
                    queue.append([ny,nx])
                }
            }
        }
        idx += 1
    }
    print(KAKTUS)
}
func change(){
    for c in 0..<col{
        for r in 0..<row{
            if forest[c][r] == 0{
                forest[c][r] = Int.max
            }
        }
    }
}

flood()
change()
goToD()


