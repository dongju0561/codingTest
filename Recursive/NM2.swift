
/*
 [백준] N과 M (5)
 */

let NM = readLine()!.split(separator: " ").map{Int(String($0))!}
let N = NM[0]
let M = NM[1]

var nums = readLine()!.split(separator: " ").map{Int(String($0))!}
nums = nums.sorted{$0 < $1}

var stack = [Int]()

func dfs(){
    if stack.count == M{
        print(stack.map{String($0)}.joined(separator: " "))
        return
    }
    for idx in 0..<nums.count{
        if !stack.contains(nums[idx]){
            stack.append(nums[idx])
            dfs()
            stack.removeLast()
        }
    }
}

dfs()
