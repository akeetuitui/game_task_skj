import 'package:test/test.dart';
import 'character.dart';
import 'monster.dart';
import 'game.dart';

void main() {
  group('Game', () {
    test('Game initializes correctly with player and monster list', () {
      // Arrange
      var player = Character(name: 'Hero', health: 100, attack: 10, defense: 5);
      var monster = Monster(name: 'Goblin', health: 30, attack: 5, defense: 0);
      var game = Game(player, [monster], 1);

      // Act & Assert
      expect(game.player.name, 'Hero');
      expect(game.monsterList.length, 1);
      expect(game.targetMonsters, 1);
    });

    test('Player can defeat a monster', () {
      // Arrange
      var player = Character(name: 'Hero', health: 100, attack: 10, defense: 5);
      var monster = Monster(name: 'Goblin', health: 10, attack: 5, defense: 0);
      var game = Game(player, [monster], 1);

      // Act
      game.battle(monster);

      // Assert
      expect(monster.health, lessThanOrEqualTo(0));
      expect(game.monstersDefeated, 1);
    });

    test('Game records victory when target monsters are defeated', () {
      // Arrange
      var player = Character(name: 'Hero', health: 100, attack: 10, defense: 5);
      var monster = Monster(name: 'Goblin', health: 10, attack: 5, defense: 0);
      var game = Game(player, [monster], 1);

      // Act
      game.startGame();

      // Assert
      expect(game.monstersDefeated, 1);
      expect(player.health, greaterThan(0));
    });

    test('Game ends when player health reaches zero', () {
      // Arrange
      var player = Character(name: 'Hero', health: 10, attack: 10, defense: 0);
      var monster = Monster(name: 'Dragon', health: 100, attack: 20, defense: 0);
      var game = Game(player, [monster], 1);

      // Act
      game.battle(monster);

      // Assert
      expect(player.health, lessThanOrEqualTo(0));
    });
  });
}