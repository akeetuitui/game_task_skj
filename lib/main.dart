import 'dart:io';
import 'character.dart';
import 'monster.dart';
import 'game.dart';
import 'file_loader.dart';

void main() async {
  // 사용자로부터 캐릭터 이름을 입력받음
  String playerName = _getValidatedPlayerName(); // 유효성 검사 반환

  // 캐릭터 데이터를 불러옴
  Character? player = await loadCharacterStatsAsync(playerName);
  if (player != null) {
    player.name = playerName; // 입력받은 이름을 캐릭터에 설정
  }

  // 몬스터 데이터를 불러옴
  List<Monster> monsters = await loadMonstersAsync();

  // 목표 몬스터 수 설정
  const int targetMonsters = 3; // 여기서 목표 몬스터 수를 미리 설정

  if (player != null && monsters.isNotEmpty) {
    print('캐릭터와 몬스터 데이터를 성공적으로 불러왔습니다!');
    var game = Game(player, monsters, targetMonsters); // 게임 객체 생성, 게임 시작
    game.startGame();
  } else {
    print('캐릭터 또는 몬스터 데이터를 불러오는 데 문제가 발생했습니다.');
  }
}

// 캐릭터 이름 유효성 검사 및 입력 함수
String _getValidatedPlayerName() {
  while (true) {
    print('캐릭터의 이름을 입력하세요:');
    String? input = stdin.readLineSync();

    if (input != null && _isValidName(input)) {
      return input; // 유효한 이름이면 반환
    } else {
      print('잘못된 이름입니다. 한글 또는 영문 대소문자만 사용할 수 있으며, 빈 문자열은 허용되지 않습니다.');
    }
  }
}

// 이름 유효성 검사 함수
bool _isValidName(String name) {
  // 한글, 영문 대소문자만 허용하는 정규표현식
  RegExp regex = RegExp(r'^[a-zA-Z가-힣]+$');
  return regex.hasMatch(name); // 특수문자, 숫포함, 빈 문자열의 경우 flase 반환
}