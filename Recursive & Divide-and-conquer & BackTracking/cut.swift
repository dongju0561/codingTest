/*
 분술물
 보석 결정체
 
 불순물이 없는 조각(보석결정체 포함)
 
 가로 -> 세로
 세로 -> 가로
 
 1 = 분순물
 2 = 보석 결정체
 0 = 깨끗
 
 1. 분순물 제거 순열 구함
 2. 가로로 먼저 시작한 경우, 세로로 먼저 시작한 경우 두번 진행
    2-1
 3. 만약 count == 0 print("-1") else print(count)
 
 해석 오류: 석판을 자를 때에는 이전에 자른 방향과 같은 방향으로는 자를 수 없다.
 
 */
import Foundation

var arr = [[Int]]()
var N = 0

func part(_ strx: Int, _ endx: Int, _ stry: Int, _ endy: Int, _ p: Int) -> Int {
    var is_visit = false
    var jewely = 0
    var cnt = 0
    //1 = 분순물, 2 = 보석 결정체
    for i in strx..<endx {
        for j in stry..<endy {
            // 탐색 범위 내에 보석 갯수 찾기
            if arr[i][j] == 2 {
                jewely += 1
            }
            
            if arr[i][j] == 1 {
                is_visit = true
                
                var temp = 1
                var temp1 = 1
                
                // p=2는 세로 방향으로 자를때
                if p != 2 {
                    var is_possible = true
                    for k in strx..<endx {
                        //자르는 선상에 보석이 존재한다면
                        if arr[k][j] == 2 {
                            // 해당 시도는 실패
                            is_possible = false
                        }
                    }
                    //만약 자르는게 가능하다면
                    if is_possible {
                        //가로축 탐색 범위의 시작과 끝이 같지 않다면 자르기 진행
                        if stry != j {
                            //자른 선 기준 왼쪽 탐색
                            temp = part(strx, endx, stry, j, 2)
                        }
                        if endy != j + 1 {
                            //자른 선 기준 오른쪽 탐색
                            temp1 = part(strx, endx, j + 1, endy, 2)
                        }
                        cnt += temp * temp1
                    }
                }
                // p=1은 가로 방향으로 가를때
                if p != 1 {
                    temp = 1
                    temp1 = 1

                    var is_possible = true
                    for k in stry..<endy {
                        if arr[i][k] == 2 {
                            is_possible = false
                        }
                    }
                    if is_possible {
                        if strx != i {
                            temp = part(strx, i, stry, endy, 1)
                        }
                        if endx != i + 1 {
                            temp1 = part(i + 1, endx, stry, endy, 1)
                        }
                        cnt += temp * temp1
                    }
                }
            }
        }
    }
    
    if !is_visit {
        if jewely == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    return cnt
}

func main() {
    N = Int(readLine()!)!
    for _ in 0..<N {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        arr.append(row)
    }
    
    //0은 가로 세로 자르기 둘 다 진행
    let cnt = part(0, N, 0, N, 0)

    if cnt == 0 {
        print(-1)
    } else {
        print(cnt)
    }
}

main()



//let N = Int(readLine()!)!
//var trash = 0, jewel = 0, answer = Int()
//var rockMap: [[Int]] = Array(repeating: [], count: N)
//var dirtyList = [(col: Int,row: Int)]()
//var twoList = [(col: Int,row: Int)]()
////지도 생성
//for idx in 0..<N{
//    var row = -1
//    let col = idx
//    let temp = readLine()!.split(separator: " ").map{
//        row += 1
//        if "1" == $0{
//            trash += 1
//        }
//        else if "2" == $0{
//            jewel += 1
//        }
//        return Int(String($0))!
//    }
//    rockMap[idx].append(contentsOf: temp)
//}
//
//var orders = [[Int]]()
//var stack = [Int]()
//
//var isWidth = true
//var tempMap = rockMap
//func DivideAndConquer(_ x: Int, _ y: Int, _ a: Int, _ b: Int, _ direction: Bool) -> Int{
//    var divideComplete = 0, trash = 0, jewel = 0
//    //가로로 잘랐을때
//    for i in x...a{
//        for j in y...b{
//            if rockMap[i][j] == 1{
//                trash += 1
//                if direction{
//                    divideComplete += DivideAndConquer(x,y,i-1,b, !direction) * DivideAndConquer(i + 1, y, a, b, !direction)
//                }
//                else {
//                    divideComplete += DivideAndConquer(x,y,a,j-1, !direction) * DivideAndConquer(x, j + 1, a, b, !direction)
//                }
//            }
//        }
//    }
//    if trash == 0 { return jewel == 1 ? 1 : 0}
//    return divideComplete
//}
//
//if trash == 0 { 
//    if jewel == 1{
//        answer = 1
//    }
//    else{
//        answer = 0
//    }
//}else {
//    answer = DivideAndConquer(0,0,N-1,N-1,true)
//}


//for idx in 0..<tempMap.count{
//    print(tempMap[idx].map{String($0)}.joined(separator: " "))
//}




//let N = Int(readLine()!)!
//
//var rockMap: [[Int]] = Array(repeating: [], count: N)
//var dirtyList = [(col: Int,row: Int)]()
//var twoList = [(col: Int,row: Int)]()
////지도 생성
//for idx in 0..<N{
//    var row = -1
//    var col = idx
//    let temp = readLine()!.split(separator: " ").map{
//        row += 1
//        if "1" == $0{
//            dirtyList.append((col,row))
//        }
//        else if "2" == $0{
//            twoList.append((col,row))
//        }
//        return Int(String($0))!
//    }
//    rockMap[idx].append(contentsOf: temp)
//}
//
//var orders = [[Int]]()
//var stack = [Int]()
//
////분순물 제거 순열 구함
//func dfs(){
//    if stack.count == dirtyList.count{
//        orders.append(stack)
//        return
//    }
//    
//    for pos in 0..<dirtyList.count{
//        if !stack.contains(pos){
//            stack.append(pos)
//            dfs()
//            stack.removeLast()
//        }
//    }
//}
//
//var isWidths = true
//var tempMap = rockMap
//func recursive(_ curIdx: Int,_ isWidth: Bool,_ order: [Int]){
//    if curIdx > dirtyList.count{
//        return
//    }
//    let y = dirtyList[order[curIdx]].col
//    let x = dirtyList[order[curIdx]].row
//    
//    if isWidth == true{//가로 먼저
//        //가로 선 상에 만약에 "2" 원석이 존재하면
//        for idx in x..<N{
//            if tempMap[y][idx] == 2{
//                return
//            }
//            if tempMap[y][idx] == 3{
//                break
//            }
//            //"3" 쪼갠 자리
//            tempMap[y][idx] = 3
//        }
//        for idx in 0..<x{
//            if tempMap[y][idx] == 2{
//                return
//            }
//            if tempMap[y][idx] == 3{
//                break
//            }
//            //"3" 쪼갠 자리
//            tempMap[y][idx] = 3
//        }
//        recursive(curIdx + 1, !isWidth,order)
//    }
//    else{ //세로 먼저
//        for idx in y..<N{
//            if tempMap[idx][x] == 2{
//                return
//            }
//            if tempMap[idx][x] == 3{
//                break
//            }
//            //"3" 쪼갠 자리
//            tempMap[idx][x] = 3
//        }
//        for idx in 0..<y{
//            if tempMap[idx][x] == 2{
//                return
//            }
//            if tempMap[idx][x] == 3{
//                break
//            }
//            //"3" 쪼갠 자리
//            tempMap[idx][x] = 3
//        }
//        
//        recursive(curIdx + 1, !isWidth,order)
//    }
//    
//}
//dfs()
//
//recursive(0, true, orders[15])
//
//
////for idx in 0..<tempMap.count{
////    print(tempMap[idx].map{String($0)}.joined(separator: " "))
////}
//
//
