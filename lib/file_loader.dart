import 'dart:io';
import 'character.dart';
import 'monster.dart';

// 비동기로 캐릭터 데이터를 불러오는 함수 (이름을 제외한 체력, 공격력, 방어력만 불러옴)
Future<Character?> loadCharacterStatsAsync(String playerName) async {
  print("캐릭터 데이터를 불러오는 중...");
  try {
    final file = File('characters.txt');
    if (!await file.exists()) {
      print('characters.txt 파일이 존재하지 않습니다.');
      return null;
    }
    final contents = await file.readAsString();
    final stats = contents.split(',');

    // 데이터 형식 검사
    if (stats.length < 3) {
      print('characters.txt 파일의 데이터 형식이 잘못되었습니다. 체력, 공격력, 방어력 순으로 입력되어야 합니다.');
      return null;
    }

    // 캐릭터의 스탯 정보만 읽어들임 (이름은 사용자가 입력한 이름을 사용)
    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    return Character(name: playerName, health: health, attack: attack, defense: defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    return null;
  }
}

// 비동기로 몬스터 데이터를 불러오는 함수
Future<List<Monster>> loadMonstersAsync() async {
  try {
    final file = File('monsters.txt');
    final contents = await file.readAsLines();
    
    List<Monster> monsters = [];
    for (var line in contents) {
      final stats = line.split(',');
      String name = stats[0];
      int health = int.parse(stats[1]);
      int attack = int.parse(stats[2]);

      // 방어력 값을 명시하지 않으므로 자동으로 0이 할당됨
      monsters.add(Monster(name: name, health: health, attack: attack));
    }

    return monsters;
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    return [];
  }
}