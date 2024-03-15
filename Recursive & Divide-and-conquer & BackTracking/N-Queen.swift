
/*
 N 1부터 15까지
 
 퀸이 공격할 수 있는 범위는 가로, 세로, 대각선
 
 
 */

let n = Int(readLine()!)!
//체스판을 1차원 배열로 선언
/*
 체스판을 1차원 배열로 선언한 이유?
 퀸 같은 경우 퀸의 위치에서 가로세로 대각선으로 이동할 수 있다.
 규칙을 고려해 본다면 퀸을 위치 시키고 다음 퀸을 위치 시킬때는 이전 퀸의 x축 선상에 위치시키지 못한다는 특징을 가지고 있다.
 그러므로 하나의 x축에는 하나의 퀸만 위치할 수 있기 때문에 굳이 2차원 배열로 선언하지 않아도 되기 때문에 체스판을 1차원배열로 선언하였다.
 board의 인덱스는 x좌표를 의미하고 인덱스에 맵핑 되어있는 값은 y좌표에 해당한다.
 */
import Foundation

struct AlgoTimer{
    private var startTime: TimeInterval = 0.0
    private var endTime: TimeInterval = 0.0
    
    mutating func start(){
        startTime = NSDate().timeIntervalSince1970
    }
    mutating func end() -> TimeInterval{
        endTime = NSDate().timeIntervalSince1970
        return endTime - startTime
    }
}

var timeChecker = AlgoTimer()
var board = [Int](repeating: 0, count: n)
var visited = [Bool](repeating: false, count: n)
var answer = 0

func check(x: Int) -> Bool {
    for i in 0..<x {
        //세로 확인
        //board의 인덱스가 다르지만 각각 인덱스에 할당된 값이 같다는 것은 퀸이 같은 y축 선상에 있다는 것을 의미
        if board[i] == board[x] {
            return false
        }
        //대각선 확인
        /*
        신기하네.. 대각선 상에 있는지 확인하는 방법
        if 두 점의 x간의 거리 == y간의 거리 => 대각선 상에 있음
        */
        if abs(i - x) == abs(board[i] - board[x]) {
            return false
        }
    }
    return true
}

func dfs(x: Int) {
    if x == n {
        answer += 1
        return
    }
    //순열
    for i in 0..<n {
    //가로 선상에 queen 있는지 확인
    if visited[i] {continue}
        
        //(x,i) 위치에 queen 위치시키기
        board[x] = i
        
        //세로 대각선 확인
        if check(x: x) {
            //조건에 부합하면, 방문 확정
            visited[i] = true
            dfs(x: x + 1)
            //back
            visited[i] = false
        }
    }
}
timeChecker.start()
dfs(x: 0)
print(timeChecker.end())
/*
 continue:   0.24009394645690918
 continue X: 0.44844579696655273
 */
print(answer)

// let N = 8//Int(readLine()!)!

// var queenMap: [[Int]] = Array(repeating: Array(repeating: 0, count: N), count: N)
// var attackRange: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
// var Qvisited: [[Bool]] = Array(repeating: Array(repeating: false, count: N), count: N)
// var queenCoordins = [(x: Int,y: Int)]()
// var cnt = 0

// func setQueenAttackRange(_ x: Int,_ y: Int){
//    //가로 세로 범위
//    for i in 0..<N{
//        attackRange[x][i] = true
//        attackRange[i][y] = true
//        if 0..<N ~= x-i && 0..<N ~= y-i{
//            attackRange[x-i][y-i] = true
//        }
//        if 0..<N ~= x+i && 0..<N ~= y-i{
//            attackRange[x+i][y-i] = true
//        }
//        if 0..<N ~= x-i && 0..<N ~= y+i{
//            attackRange[x-i][y+i] = true
//        }
//        if 0..<N ~= x+i && 0..<N ~= y+i{
//            attackRange[x+i][y+i] = true
//        }
//    }
// }
// func updateQueenAttackRange(coordins: [(x: Int,y: Int)]){
//    //업데이트 시 visited 초기화
//    attackRange = Array(repeating: Array(repeating: false, count: N), count: N)
   
//    for coordin in coordins {
//        setQueenAttackRange(coordin.x, coordin.y)
//    }
// }


// func recursive(_ numOfQueen: Int){
//    if numOfQueen == N{
//        cnt += 1
//        return
//    }
   
//    for x in 0..<N{
//        for y in 0..<N{
//            if !Qvisited[x][y]{
//                if !attackRange[x][y]{
// //                    Qvisited[x][y] = true
//                    queenCoordins.append((x, y))
//                    updateQueenAttackRange(coordins: queenCoordins)
// //                    for coor in queenCoordins{
// //                        print(coor.y,terminator: "\t")
// //                    }
// //                    print("")
//                    recursive(numOfQueen + 1)
// //                    Qvisited[x][y] = false
//                    queenCoordins.removeLast()
//                    updateQueenAttackRange(coordins: queenCoordins)
//                }
//            }
//        }
//    }
// }
// recursive(0)
// //경우의 수 출력
// print(cnt)



