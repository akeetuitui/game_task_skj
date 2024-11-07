import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';

class Game {
  Character player;
  List<Monster> monsterList;
  int targetMonsters; // 목표 몬스터 수
  int monstersDefeated = 0;

  Game(this.player, this.monsterList, this.targetMonsters); //Game 클래스의 생성자. 생성자를 통해 플레이어, 몬스터 리스트, 목표 몬스터 수를 초기화
  
  //1. 게임시작 메서드
  void startGame() {
    // 게임 시작 시 캐릭터의 이름을 출력
    print('캐릭터의 이름을 입력하세요: ${player.name}');
    print('게임을 시작합니다!');
    player.showStatus(); //게임 시작 시 캐릭터 상태 출력

    while (player.health > 0 && monstersDefeated < targetMonsters) {
      // 플레이어가 살아있고, 몬스터를 물리치지 못한 경우 게임 반복
      Monster currentMonster = getRandomMonster(); //random 메서드 호출, 랜덤으로 몬스터 선택
      battle(currentMonster);

      if (player.health <= 0) {
        print('캐릭터가 쓰러졌습니다. 게임 오버!');
        break;
      }

      print('다음 몬스터와 싸우시겠습니까? (y/n): ');
      String? input = stdin.readLineSync();
      if (input?.toLowerCase() != 'y') {
        print('게임을 종료합니다.'); //사용자가 y를 하지 않은 경우 게임 종료
        break;
      }
    }

    // 설정된 목표 몬스터 수만큼 물리쳤을 때 승리 결과 출력
    if (monstersDefeated == targetMonsters) {
      print('축하합니다! 모든 몬스터를 물리쳤습니다.');
    }
  }

  // 게임 종료 후 결과 저장 메서드
  void saveResult(String result) {
    print('결과를 저장하시겠습니까? (y/n): ');
    String? input = stdin.readLineSync();
    if (input?.toLowerCase() == 'y') {
      try {
        final file = File('result.txt');
        String content = '캐릭터 이름: ${player.name}\n남은 체력: ${player.health}\n게임 결과: $result\n';
        file.writeAsStringSync(content);
        print('결과가 result.txt 파일에 저장되었습니다.');
      } catch (e) {
        print('결과 저장 중 오류가 발생했습니다: $e');
      }
    } else {
      print('결과가 저장되지 않았습니다.');
    }
  }

  //2. 전투진행 메서드
  void battle(Monster monster) {
    print('새로운 몬스터가 나타났습니다!');
    monster.showStatus(); //몬스터의 상태 출력

    while (monster.health > 0 && player.health > 0) {
      // 플레이어의 턴
      print('${player.name}의 턴');
      print('행동을 선택하세요 (1: 공격, 2: 방어): ');
      String? action = stdin.readLineSync();

      if (action == '1') {
        // 공격 선택
        player.attackMonster(monster);
        print('${player.name}(이)가 ${monster.name}에게 ${player.attack}의 데미지를 입혔습니다.');
      } else if (action == '2') {
        // 방어 선택: 몬스터의 공격 메서드 호출 & 캐릭터의 방어 메서드 호출
        int recoverHealth = monster.attackPlayer(); 
        player.defend(recoverHealth); // 방어메서드 체력 회복
        print('${player.name}(이)가 방어 태세를 취하여 ${recoverHealth}만큼 체력을 얻었습니다.');
      } else {
        print('잘못된 입력입니다. 다시 선택해주세요.');
        continue; // 유효한 입력이 나올 때까지 루프를 반복
      }

      // 몬스터의 턴 (몬스터가 살아있을 때만)
      if (monster.health > 0) {
        print('${monster.name}의 턴');
        int monsterDamage = monster.attackPlayer(); // 몬스터 공격메서드를 호출하여 공격력 값 저장
        player.health -= monsterDamage; // 플레이어 체력 잃음
        print('${monster.name}(이)가 ${player.name}에게 ${monsterDamage}의 데미지를 입혔습니다.');
      }

      // 매 턴마다 상태 출력
      player.showStatus();
      monster.showStatus();
    }

    if (monster.health <= 0) {
      print('${monster.name}(을)를 물리쳤습니다!');
      monstersDefeated++; // 처치한 몬스터 수 증가(초기값=0)
      monsterList.remove(monster); // 몬스터 리스트에서 몬스터 삭제
    }
}

  //3. 랜덤몬스터 메서드
  Monster getRandomMonster() {
    Random rand = Random();
    return monsterList[rand.nextInt(monsterList.length)]; // 인덱스 범위 내의 무작위 인덱스 반환
  }
}