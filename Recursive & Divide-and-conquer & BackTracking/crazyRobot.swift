/*
 [백준] 미친 로봇
 
 N = 로봇 동작 횟수(N <= 14)
 (N*2+1 X N*2+1)평명 상 현재 위치는 [N,N]
 동서남북 임의로 한번 이동
 한번이라도 같은 곳으로 가게 된다면 -> 단순하지 않음
 한번이라도 같은 곳으로 가지 않는다면 -> 단순함
 이동 경로가 단순하지 않을 확률 = 같은 곳으로 한 번보다 많이 이동하지 않을 경우 / 이동 전체 경우의 수
 */
/*
 지도를 만드는것이 아니라 이동 좌표만 저장
 */
typealias Coordinate = (x:Int,y:Int)
let Newsn = readLine()!.split(separator: " ").map{Int(String($0))!}
let N = Newsn[0]
let eastPos = Double(Newsn[1])/100
let westPos = Double(Newsn[2])/100
let southPos = Double(Newsn[3])/100
let NorthPos = Double(Newsn[4])/100

let directions: [Coordinate] = [(0,1),(0,-1),(1,0),(-1,0)]
var totalPercentage: Double = 0.0
func recursive(_ numOfRepeat: Int,_ result: [Coordinate],_ percentage: Double,_ currentCoordinate: Coordinate){
    if numOfRepeat == N{
        totalPercentage += percentage
        return
    }
    for direction in directions {
//        var isSimple = true
        let nextCoordinate: Coordinate = (currentCoordinate.x + direction.x, currentCoordinate.y + direction.y)
        //단순한 경우
        if !result.contains(where: {return $0 == nextCoordinate}){
            var posTemp = result
            posTemp.append(nextCoordinate)
            var tempPercentage = percentage
            if directions[0] == direction{
                tempPercentage *= eastPos
            }
            else if directions[1] == direction{
                tempPercentage *= westPos
            }
            else if directions[2] == direction{
                tempPercentage *= southPos
            }
            else if directions[3] == direction{
                tempPercentage *= NorthPos
            }
            recursive(numOfRepeat + 1, posTemp, tempPercentage, nextCoordinate)
        }
    }
}

recursive(0, [(0,0)], 1.0, (0,0))
print(totalPercentage)

// typealias Coordinate = (x:Int,y:Int)
// let Newsn = readLine()!.split(separator: " ").map{Int(String($0))!}
// let N = Newsn[0]
// let eastPos = Double(Newsn[1])
// let westPos = Double(Newsn[2])
// let southPos = Double(Newsn[3])
// let NorthPos = Double(Newsn[4])

// let directions: [Coordinate] = [(0,1),(0,-1),(1,0),(-1,0)]
// var totalPercentage: Double = 0.0
// func recursive(_ numOfRepeat: Int,_ result: [Coordinate],_ dirArr: [Coordinate],_ currentCoordinate: Coordinate){
//     if numOfRepeat == N{
//         var percentage: Double = 1.0
//         for direction in dirArr{
//             if directions[0] == direction{
//                 percentage *= eastPos/100
//             }
//             else if directions[1] == direction{
//                 percentage *= westPos/100
//             }
//             else if directions[2] == direction{
//                 percentage *= southPos/100
//             }
//             else if directions[3] == direction{
//                 percentage *= NorthPos/100
//             }
//         }
//         totalPercentage += percentage
//         return
//     }
//     for direction in directions {
// //        var isSimple = true
//         let nextCoordinate: Coordinate = (currentCoordinate.x + direction.x, currentCoordinate.y + direction.y)
//         //단순한 경우
//         if !result.contains(where: {return $0 == nextCoordinate}){
//             var posTemp = result
//             var dirTemp = dirArr
//             posTemp.append(nextCoordinate)
//             dirTemp.append(direction)
//             recursive(numOfRepeat + 1, posTemp, dirTemp, nextCoordinate)
//         }
//     }
// }

// recursive(0, [(0,0)], [], (0,0))
// print(totalPercentage)



/*
방향이 추가될때마다 단순인지 확인
*/

// typealias coordinate = (x: Int, y: Int)
// let Newsn = readLine()!.split(separator: " ").map{Int(String($0))!}
// let N = Newsn[0]
// let eastPos = Double(Newsn[1])
// let westPos = Double(Newsn[2])
// let southPos = Double(Newsn[3])
// let NorthPos = Double(Newsn[4])
// let directions = ["E","W","S","N"]
// var dicisionArr = [String]()
// var map: [[Bool]] = Array(repeating: Array(repeating: false, count: N*2+1), count: N*2+1)
// var currentCoordinate: coordinate = (N,N)
// var totalPosibilty: Double = 0.0
// map[currentCoordinate.x][currentCoordinate.y] = true
// var isSimple = false

// func push(_ d: String){
//     dicisionArr.append(d)
//     switch d {
//     case "E":
//         //동쪽으로 이동
//         currentCoordinate = (currentCoordinate.x,currentCoordinate.y+1)
//     case "W":
//         //서쪽으로 이동
//         currentCoordinate = (currentCoordinate.x,currentCoordinate.y-1)
//     case "S":
//         //남쪽으로 이동
//         currentCoordinate = (currentCoordinate.x+1,currentCoordinate.y)
//     case "N":
//         //북쪽으로 이동
//         currentCoordinate = (currentCoordinate.x-1,currentCoordinate.y)
//     default:
//         break
//     }
// }
// //같은 곳을 한번이라도 도달했다면 단순하지 않음을 의미하는 false 반환
// func Check() -> Bool{
//     //한번이라도 같은 곳을 도달했을때
//     if map[currentCoordinate.x][currentCoordinate.y]{
//         //단순하지 않음
//         return false
//     }
//     //한번도 방문하지 않았다면
//     //단순함
//     map[currentCoordinate.x][currentCoordinate.y] = true
//     return  true
// }
// func back(_ d: String, _ isSimple: Bool){
//     _ = dicisionArr.removeLast()
//     if isSimple{
//         if currentCoordinate.x == N && currentCoordinate.y == N{
//             map[currentCoordinate.x][currentCoordinate.y] = true
//         }
//         else{
//             map[currentCoordinate.x][currentCoordinate.y] = false
//         }
//     }
//     //현재위치 조정
//     switch d {
//     case "E":
//         //동쪽으로 이동
//         currentCoordinate = (currentCoordinate.x,currentCoordinate.y-1)
//     case "W":
//         //서쪽으로 이동
//         currentCoordinate = (currentCoordinate.x,currentCoordinate.y+1)
//     case "S":
//         //남쪽으로 이동
//         currentCoordinate = (currentCoordinate.x-1,currentCoordinate.y)
//     case "N":
//         //북쪽으로 이동
//         currentCoordinate = (currentCoordinate.x+1,currentCoordinate.y)
//     default:
//         break
//     }
// }

// func recursive(_ idx: Int){
//     if N == idx{
//         var tempPossibility:Double = 1.0
//         for ch in dicisionArr{
//             switch ch {
//             case "E":
//                 tempPossibility *= eastPos/100
//             case "W":
//                 tempPossibility *= westPos/100
//             case "S":
//                 tempPossibility *= southPos/100
//             case "N":
//                 tempPossibility *= NorthPos/100
//             default:
//                 break
//             }
//         }
//         totalPosibilty += tempPossibility
//         return
//     }
//     //차이점: 문자를 추가할때마다 check를 진행
//     for direction in directions {
//         var isSimple = true
//         push(direction)
//         if Check(){
//             recursive(idx+1)
//         }
//         else{
//             isSimple = false
//         }
//         //back
//         back(direction,isSimple)
//     }
// }

// recursive(0)
// print(totalPosibilty)

/*
 전체 이동 범위를 구하고 check를 진행
 */
//typealias coordinate = (x: Int, y: Int)
//let Newsn = readLine()!.split(separator: " ").map{Int(String($0))!}
//let N = Newsn[0]
//let eastPos = Double(Newsn[1])
//let westPos = Double(Newsn[2])
//let southPos = Double(Newsn[3])
//let NorthPos = Double(Newsn[4])
//let directions = ["E","W","S","N"]
//var dicisionArr = [String]()
//var map: [[Bool]] = Array(repeating: Array(repeating: false, count: N*2+1), count: N*2+1)
//var currentCoordinate: coordinate = (N,N)
//var totalPosibilty: Double = 0.0
//map[currentCoordinate.x][currentCoordinate.y] = true
//var isSimple = false
//
//func check() -> Bool{
//    for d in dicisionArr{
//        switch d {
//        case "E":
//            //동쪽으로 이동
//            currentCoordinate = (currentCoordinate.x,currentCoordinate.y+1)
//        case "W":
//            //서쪽으로 이동
//            currentCoordinate = (currentCoordinate.x,currentCoordinate.y-1)
//        case "S":
//            //남쪽으로 이동
//            currentCoordinate = (currentCoordinate.x+1,currentCoordinate.y)
//        case "N":
//            //북쪽으로 이동
//            currentCoordinate = (currentCoordinate.x-1,currentCoordinate.y)
//        default:
//            break
//        }
//        if map[currentCoordinate.x][currentCoordinate.y]{
//            //같은 곳을 한번이라도 도달했다면 단순하지 않음을 의미하는 false 반환
//            return false
//        }
//        map[currentCoordinate.x][currentCoordinate.y] = true
//    }
//    return  true
//}
//
//func recursive(_ idx: Int){
//    if N == idx{
//        if check(){
//            var tempPossibility:Double = 1.0
//            print(dicisionArr)
//            for ch in dicisionArr{
//                switch ch {
//                case "E":
//                    tempPossibility *= eastPos/100
//                case "W":
//                    tempPossibility *= westPos/100
//                case "S":
//                    tempPossibility *= southPos/100
//                case "N":
//                    tempPossibility *= NorthPos/100
//                default:
//                    break
//                }
//            }
//            totalPosibilty += tempPossibility
//        }
//        //현재위치, 지도 초기화
//        map = Array(repeating: Array(repeating: false, count: N*2+1), count: N*2+1)
//        currentCoordinate = (N,N)
//        map[currentCoordinate.x][currentCoordinate.y] = true
//        return
//    }
//    //
//    for d in directions {
//        dicisionArr.append(d)
//        recursive(idx+1)
//        _ = dicisionArr.removeLast()
//    }
//}
//
//recursive(0)
//print(totalPosibilty)
//
