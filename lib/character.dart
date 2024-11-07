import 'monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character({required this.name, required this.health, required this.attack, required this.defense});

  // 공격 메서드: 몬스터에게 데미지를 입힘
  void attackMonster(Monster monster) {
    int damage = attack - monster.defense; //몬스터의 방어력을 고려하여 데미지 계산
    if (damage < 0) damage = 0;
    monster.health -= damage; //몬스터에게 공격을 가하고 데미지만큼 체력을 감소
    print('$name(이)가 ${monster.name}에게 $damage 만큼 데미지를 입혔습니다.');
    if (monster.health <= 0) {
      print('${monster.name}을(를) 물리쳤습니다!'); //몬스터가 체력이 0 이하가 되면 물리쳤다는 메시지 출력
    }
  }

  // 방어 메서드: 방어 시 체력을 회복하는 행동 수행
  void defend(int attackPlayer) {
    int healAmount = attackPlayer; // 몬스터가 입힌 데미지만큼 체력을 회복
    health += healAmount;
    print('$name(이)가 방어하여 $healAmount 만큼 체력을 회복했습니다.');
  }

  // 캐릭터 상태 출력 메서드
  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}