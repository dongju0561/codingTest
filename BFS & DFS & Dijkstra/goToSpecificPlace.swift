/*
특정 거리의 도시 찾기
BFS, queue, graph
*/

import Foundation

//입력받기 위한 과정
//4개의 요소를 가지는 input값을 가질건데 공백(space)를 기준으로 나눌거야 대신 만약에 입력이 들어오질 않을 경우에는(nil) 0으로 대신 넣을거야
let input: [Int] = readLine()!.components(separatedBy: " ").map(){Int($0) ?? 0}
let numOfNode: Int = input[0]
let distance: Int = input[2]
let start: Int = input[3]

//방문했던 노드들을 기록하기 위한 bool타입을 가지는 배열 visited를 선언해줄거야 초기값은 방문하지 않았다는 것을 의미하는 false로 설정해주고 배열의 요소 갯수는 node의 총 갯수보다 하나 더 증가 시킨 만큼 배열을 선언할거야 노드의 변호와 같은 인덱스에 맵핑하려는 목적이야
var visited: [Bool] = Array(repeating: false, count: numOfNode + 1)
//각 노드들의 시작 지점으로부터 자신의 노드까지 거리를 정수 타입을 가진 배열에 저장 이때 조건은 초기값은 정수 타입의 최대값으로 초기화하고 노드의 갯수 + 1만큼 배열의 크기 설정
var distances: [Int] = Array(repeating: Int.max, count: numOfNode + 1)

//큐는 배열로 구현을 하고 append 메소드로 enqueue를 하고 removeFirst로 dequeue를 진행한다.
var queue: [Int] = [start]

// 단방향.
//swift 같은 경우 정수형 2차원 배열로 graph를 구현한다. 각 요소에 갈 수 있는 노드의 번호를 저장하는 방식
var graph: [[Int]] = Array(repeating: [], count: numOfNode + 1)

//두번째 인덱스만큼 반복하여 단방향 도로를 설치
//4 2
for _ in 0..<input[1] {
    //첫번째 노드에서 갈 수 있는 노드를 설정(도로 설치)
    let inputs: [Int] = readLine()!.components(separatedBy: " ").map { Int(String($0)) ?? 0 }
    graph[inputs[0]].append(inputs[1])
}

//시작 노드의 거리(distance)는 0이다.
distances[start] = 0
//시작 노드를 방분했다라는 사실을 visited 배열에 기록
visited[start] = true

//BFS: 너비 우선 탐색
// queue가 비어있지 않는 동안 코드를 반복
while !queue.isEmpty {
    //dequeue한 요소를 first 변수에 할당
    let first: Int = queue.removeFirst()
    
    //현재 노드에서 갈 수 있는 노드들로 반복
    for node in graph[first] {
        //visited 배열로 해당 노드를 방문했는지 확인
        if !visited[node] {
            //시작 노드로부터 현재 노드까지의 거리를 distance 배열에 저장
            distances[node] = distances[first] + 1
            //다음 순서때 방분하기 위해 queue에 저장
            queue.append(node)
            //해당 노드를 방문했다는 표시를 visited 배열에 기록
            visited[node] = true
        }
    }
}

var answer: [Int] = []

//index == 노드의 번호, value == 노드의 시작노드로부터의 거리
for (index, value) in distances.enumerated() {
    if value == distance {
        answer.append(index)
    }
}
//만약 최단거리(K)에 해당하는 노드가 존재하지 않는다면
if answer.count == 0 {
    //-1을 출력
    print(-1)
} else {
    //그렇지 않고 존재한다면 각 노드들을 출력
    answer.forEach { print($0) }
}

/*
 4 4 2 1
 1 2
 1 3
 2 3
 2 4
 */

// 4
