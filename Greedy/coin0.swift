/*
 [벡준] 동전 0
 
 N = 종류
 K = 합
 동전의 갯수 최소값
 
 처음 코딩에서는 동전 하나하나를 비교하고 한번에 하나의 동전 값만큼 빼면서 반복을 진행..
 나눗셈은 뺄셈의 연속을 모르고 반복을 여러번 진행
 */
let NK = readLine()!.split(separator: " ").map{Int(String($0))!}
let N = NK[0]
var K = NK[1]
var coins = [Int]()
var idx = 0
var cnt = 0
var numOfUsing: [Int] = Array(repeating: 0, count: N)

for _ in 0..<N{
    let coin = Int(readLine()!)!
    coins.append(coin)
}
coins.sort(by: {$0 > $1})

for coin in coins {
    if  coin <= K{
        cnt += K / coin
        K = K % coin
    }else if K == 0{
        break
    }
}

print(cnt)
/*
 let NK = readLine()!.split(separator: " ").map{Int(String($0))!}
 let N = NK[0]
 var K = NK[1]
 var coins = [Int]()
 var idx = 0
 var  cnt = 0
 var numOfUsing: [Int] = Array(repeating: 0, count: N)

 for _ in 0..<N{
     let coin = Int(readLine()!)!
     coins.append(coin)
 }
 coins.sort(by: {$0 > $1})

 while true{
     if 0..<10 ~= idx{
         if K - coins[idx] > 0{
             K -= coins[idx]
             numOfUsing[idx] += 1
         }else if K - coins[idx] < 0{
             idx += 1
         }else{
             break
         }
     }
 }

 print(numOfUsing.reduce(0) { $0 + $1 })
 */
//while true{
//    if K - coins[idx] > 0{
//        K -= coins[idx]
//        isUsed[idx] = true
//        idx += 1
//    }else if K - coins[idx] < 0{
//        idx += 1
//    }else{
//        break
//    }
//}
//isUsed.forEach {
//    if $0{
//        cnt += 1
//    }
//}
//print(cnt)
