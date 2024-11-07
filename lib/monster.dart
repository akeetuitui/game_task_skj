class Monster {
  String name;
  int health;
  int attack;
  int defense;

  // 방어력을 0으로 기본값 설정
  Monster({required this.name, required this.health, required this.attack, this.defense = 0});

  // 몬스터 공격메서드
  int attackPlayer() {
    return attack;
  }

  // 몬스터 상태출력 메서드
  void showStatus() {
    print('$name - 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}