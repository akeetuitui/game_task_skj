# 프로젝트 개요
**몬스터를 물리치는 RPG 게임** 
몬스터와 싸우고, 승리를 거둬보세요!


# 프로젝트 기능
**✅ 기본 기능**
 - 플레이어 이름 입력
 - 플레이어의 상태: 체력/공격력/방어력
 - 몬스터의 상태: 체력/공격력/방어력(0)

**🧌 몬스터와 전투**
 - L3마리의 몬스터(배트맨,스파이더맨,슈퍼맨)가 무작위로 등장합니다.
 - 플레이어는 몬스터와 번갈아가며 싸움을 진행합니다.
 - 플레이어는 자신의 턴에서 공격/방어를 선택해 싸움을 진행합니다.
 - 플레이어가 방어를 할 시, 몬스터의 공격력만큼 체력이 증가됩니다.
 - 몬스터는 방어를 할 수 없으며, 공격만 합니다.

**🏆 전투의 승패**
 - 플레이어의 체력이 0이 될 시 게임에서 패배합니다.
 - 플레이어가 몬스터를 n마리 물리치면 게임에서 승리합니다. (main.dart에서 n값 설정 가능)

**📁 게임 저장**
 - 전투가 끝나면 플레이어는 게임을 저장할 수 있습니다.
 

## TroubleShooting

    🚨 몬스터의 공격 시 데미지 문구 출력

 - 문제: 몬스터의 턴에서 몬스터가 공격 시, 데미지 문구가 출력되지 않았습니다.
 - 해결: game.dart에서 몬스터의 턴 시 [// 공격 결과 출력] Print문 추가
 - 고민: 플레이어의 턴 시, 데미지 문구는 character.dart에 있어서 일관성이 떨어짐.
 
