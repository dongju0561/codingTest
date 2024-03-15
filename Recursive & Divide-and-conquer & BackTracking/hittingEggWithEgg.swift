/*
 [백준] 계란으로 계란치기
 틀린 문제 수 * 5 = 턱걸이 갯수
 
 계란의 내구도 - 계란의 무게 = 달걀을 친 후 내구도
 
 if 계란의 내구도 <= 0 -> 계란 깨침
 
 가장 왼쪽의 계란을 든다.
 
 단, 손에 든 계란이 깨졌거나 깨지지 않은 다른 계란이 없으면 치지 않고 넘어간다.
 이후 손에 든 계란을 원래 자리에 내려놓고 3번 과정을 진행한다.
 손에 들고 있는 계란으로 깨지지 않은 다른 계란 중에서 하나를 친다.

 달걀이 3개인 경우
 
 O O O
 
*/
//참고 코드
import Foundation

let n = Int(readLine()!)!

//typealias를 사용해서 재정의해준 타입이 관련된 정보가 무엇인지 알려줄 수 있다.
typealias Egg = (d: Int, w: Int)

var eggs = [Egg](repeating: (0, 0), count: n)
var result = 0
for i in 0..<n {
   let egg = readLine()!.split(separator: " ").map { Int(String($0))! }
   eggs[i] = (egg[0], egg[1])
}

dfs(idx: 0)
print(result)

// 집은 계란의 index
func dfs(idx: Int) {
   // 종료 조건. 마지막 계란을 잡았으면 종료
    if idx == n {
        var tmp = 0
        for i in 0..<n {
            if eggs[i].d <= 0 {
                tmp += 1
            }
        }
        result = max(result, tmp)
        return
    }
    var flag = false
    for i in 0..<n {
       //대상 달걀이 들고 있는 달걀인지 그리고 그 두개의 달걀이 깨져있는지 확인
        if i != idx && eggs[idx].d > 0 && eggs[i].d > 0 {
            flag = true
           // 침
            eggs[i].d -= eggs[idx].w
            eggs[idx].d -= eggs[i].w
           // dfs
            dfs(idx: idx+1)
           // 취소
            eggs[i].d += eggs[idx].w
            eggs[idx].d += eggs[i].w
        }
    }
    //들고 있는 달걀을 가지고 오른쪽에 달걀을 치지 못하는 경우에도 다음으로 진행
    if !flag { dfs(idx: idx+1) }
}


let N = Int(readLine()!)!

var eggInfo = [[Int]]()
var isBroken: [Bool] = Array(repeating: false, count: N)
var maxCnt = 0
for _ in 0..<N{
    let temp = readLine()!.split(separator: " ").map{Int(String($0))!}
    let durability = temp[0]
    let weight = temp[1]
    eggInfo.append(temp)
}

func hit(_ holdingEgg: Int,_ hittenEgg: Int) -> Int{
    var cnt = 0
    let holdingEggDurability = eggInfo[holdingEgg][0]
    let holdingWeight  = eggInfo[holdingEgg][1]
    
    let hittenDurability = eggInfo[hittenEgg][0]
    let hittenWeight  = eggInfo[hittenEgg][1]
    
    let newHoldingEggDurability = holdingEggDurability - hittenWeight
    eggInfo[holdingEgg][0] = newHoldingEggDurability
    if newHoldingEggDurability <= 0 {
        isBroken[holdingEgg] = true
        cnt += 1
    }
    
    let newHittenEggDurability = hittenDurability - holdingWeight
    eggInfo[hittenEgg][0] = newHittenEggDurability
    if newHittenEggDurability <= 0 {
        isBroken[hittenEgg] = true
        cnt += 1
    }
    return cnt
}
func recover(_ holdingEgg: Int,_ hittenEgg: Int){
    isBroken[holdingEgg] = false
    isBroken[hittenEgg] = false
    
    let holdingEggDurability = eggInfo[holdingEgg][0]
    let holdingEggWeight  = eggInfo[holdingEgg][1]
    
    let hittenEggDurability = eggInfo[hittenEgg][0]
    let hittenEggWeight  = eggInfo[hittenEgg][1]
    
    let newHoldingEggDurability = holdingEggDurability + hittenEggWeight
    eggInfo[holdingEgg][0] = newHoldingEggDurability
    
    let newHittenEggDurability = hittenEggDurability + holdingEggWeight
    eggInfo[hittenEgg][0] = newHittenEggDurability
}

func recursive(_ currentIdx: Int,_ acumCnt: Int){
    var cnt = 0
    if currentIdx == N - 1{
        maxCnt = max(maxCnt, acumCnt)
        print(isBroken)
        return
    }
    var recoverFlag = false
    for i in 0..<N{
        //손에 쥔 계란 != 칠 계란
        if currentIdx != i{
            //손에 쥔 계란이 깨지지 않았을때
            if !isBroken[currentIdx]{
                //칠 계란이 깨졌을때
                if isBroken[i]{
                    continue
                }
                //손에 쥔 계란과 칠 계란이 안깨져 있을때
                cnt = hit(currentIdx,i)
                recoverFlag = true
            }
            
            //다음 계란 쥠
            recursive(currentIdx + 1, cnt + acumCnt)
            
            //back: 깨진 달걀 복구 & 내구성 복구
            if recoverFlag {
                recover(currentIdx, i)
            }
        }
    }
}
recursive(0,0)
print(maxCnt)
