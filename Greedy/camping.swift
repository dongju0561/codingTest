/*
 [백준] 캠핑
 
 20일 중 10일 사용 가능
 
 28일 휴가
 
 P = 전체 일 수
 L = 연속해서 사용 가능한 일 수
 V = 일 일 수
 */

/*
 [백준] 캠핑
 
 20일 중 10일 사용 가능
 
 28일 휴가
 
 P = 전체 일 수
 L = 연속해서 사용 가능한 일 수
 V = 일 일 수
 */
var cnt = 0

var L = 0
var P = 0
var V = 0

while true{
    let LPV = readLine()!.split(separator: " ").map{Int(String($0))!}
    L = LPV[0]
    P = LPV[1]
    V = LPV[2]
    cnt += 1
    if L == 0 && P == 0 && V == 0 { break }
    var result = 0
    
    let a = V / P * L
    let b = V % P > L ? L : V % P
    print("Case \(cnt): \(a+b)")
}




// var cnt = 0

// var L = 0
// var P = 0
// var V = 0

// func recursive(dayOff: Int){
//     if dayOff - P < 0{
//         numOfCamping += dayOff
//         return
//     }
//     numOfCamping += L
//     recursive(dayOff: dayOff - P)
// }

// var numOfCamping = 0
// while true{
//     let LPV = readLine()!.split(separator: " ").map{Int(String($0))!}
//     L = LPV[0]
//     P = LPV[1]
//     V = LPV[2]
//     cnt += 1
//     if L == 0 && P == 0 && V == 0 { break }
//     var result = 0
    
//     recursive(dayOff: V)

//     print("Case \(cnt): \(numOfCamping)")
//     numOfCamping = 0
// }


