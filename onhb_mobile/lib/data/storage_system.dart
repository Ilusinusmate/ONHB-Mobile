import "package:hive_flutter/hive_flutter.dart";
import "package:onhb_mobile/data/models/team.dart";

/// Base class for storage operations using Hive
class StorageSystem {
  static const String _boxName = "myBox";
  static const String gabaritoKey = "#default_system_set_of_correct_questions";
  static bool _initialized = false;

  StorageSystem();

  /// Initialize Hive for Flutter and open the default box
  static Future<void> initHive() async {
    if (_initialized) return;

    try {
      // First initialize Hive
      await Hive.initFlutter();

      // Then register adapters
      if (!Hive.isAdapterRegistered(33)) {
        Hive.registerAdapter(TeamAdapter());
      }

      // Then open the box
      var box = await Hive.openBox(_boxName);
      print("Box opened with keys: ${box.keys.toList().toString()}");

      _initialized = true;
      print("Hive initialization complete");
    } catch (e) {
      print("Error initializing Hive: $e");
      rethrow;
    }
  }

  /// Get the Hive box instance
  static Box _getBox() {
    var box = Hive.box(_boxName);
    return box;
  }

  // ELEMENT OPERATIONS

  /// Save an element asynchronously
  static Future<void> saveElement<T>(String key, T element) async {
    await _getBox().put(key, element);
  }

  /// Save an element synchronously
  static void saveElementSync<T>(String key, T element) {
    _getBox().put(key, element);
  }

  static Future<void> deleteElement(String key) async {
    await _getBox().delete(key);
  }

  /// Get an element asynchronously
  static Future<T?> getElement<T>(String key) async {
    final res = _getBox().get(key);
    return res != null ? res as T : null;
  }

  /// Get an element synchronously
  static T? getElementSync<T>(String key) {
    final res = _getBox().get(key);
    return res != null ? res as T : null;
  }

  // LIST OPERATIONS

  /// Save a list asynchronously
  static Future<void> saveList<T>(String key, List<T> values) async {
    await _getBox().put(key, values);
  }

  /// Save a list synchronously
  static void saveListSync<T>(String key, List<T> values) {
    _getBox().put(key, values);
  }

  /// Load a list asynchronously
  static Future<List<T>> loadList<T>(String key) async {
    final result = _getBox().get(key);
    if (result == null) {
      return [];
    }
    return List<T>.from(result);
  }

  /// Load a list synchronously
  static List<T> loadListSync<T>(String key) {
    final result = _getBox().get(key);
    if (result == null) {
      return [];
    }
    return List<T>.from(result);
  }

  /// Update a list by adding an element asynchronously
  static Future<void> updateList<T>(String key, T element) async {
    List<T> list = await loadList<T>(key);
    list.add(element);
    await saveList<T>(key, list);
  }

  /// Update a list by adding an element synchronously
  static void updateListSync<T>(String key, T element) {
    List<T> list = loadListSync<T>(key);
    list.add(element);
    saveListSync<T>(key, list);
  }

  // MAP OPERATIONS

  /// Load a map asynchronously
  static Future<Map<K, V>> loadMap<K, V>(String key) async {
    final result = _getBox().get(key);
    if (result == null) {
      return {};
    }
    return Map<K, V>.from(result);
  }

  /// Load a map synchronously
  static Map<K, V> loadMapSync<K, V>(String key) {
    final result = _getBox().get(key);
    if (result == null) {
      return {};
    }
    return Map<K, V>.from(result);
  }

  /// Save a map asynchronously
  static Future<void> saveMap<K, V>(String key, Map<K, V> map) async {
    await _getBox().put(key, map);
  }

  /// Save a map synchronously
  static void saveMapSync<K, V>(String key, Map<K, V> map) {
    _getBox().put(key, map);
  }
}

/// Team-specific storage operations
class TeamStorageSystem extends StorageSystem {
  static const String _teamsListKey = "#system_all_teams";

  /// Update the teams list by adding a team asynchronously
  static Future<void> updateTeamsList(Team team) async {
    List<Team> currentTeams = await getTeamsList();

    // Check if team already exists in the list
    bool teamExists = currentTeams.any((t) => t.teamName == team.teamName);
    if (!teamExists) {
      currentTeams.add(team);
      await StorageSystem.saveList<Team>(_teamsListKey, currentTeams);
      print("Team added to teams list: ${team.teamName}");
    } else {
      // Update the existing team in the list
      int index = currentTeams.indexWhere((t) => t.teamName == team.teamName);
      if (index != -1) {
        currentTeams[index] = team;
        await StorageSystem.saveList<Team>(_teamsListKey, currentTeams);
        print("Team updated in teams list: ${team.teamName}");
      }
    }
  }

  /// Update the teams list by adding a team synchronously
  static void updateTeamsListSync(Team team) {
    List<Team> currentTeams = getTeamsListSync();

    // Check if team already exists in the list
    bool teamExists = currentTeams.any((t) => t.teamName == team.teamName);
    if (!teamExists) {
      currentTeams.add(team);
      StorageSystem.saveListSync<Team>(_teamsListKey, currentTeams);
      print("Team added to teams list (sync): ${team.teamName}");
    } else {
      // Update the existing team in the list
      int index = currentTeams.indexWhere((t) => t.teamName == team.teamName);
      if (index != -1) {
        currentTeams[index] = team;
        StorageSystem.saveListSync<Team>(_teamsListKey, currentTeams);
        print("Team updated in teams list (sync): ${team.teamName}");
      }
    }
  }

  static void updateTeamGabarito(String teamName, Map<int, int> gabarito) {
    var team =
        TeamStorageSystem.getTeamSync(teamName) ??
        Team(teamName: teamName, questions: {});
    team.questions = gabarito;
    saveTeam(team);
  }

  /// Get the list of all teams asynchronously
  static Future<List<Team>> getTeamsList() async {
    var teams = await StorageSystem.loadList<Team>(_teamsListKey);
    print("Retrieved teams list: ${teams.length} teams");
    return teams;
  }

  /// Get the list of all teams synchronously
  static List<Team> getTeamsListSync() {
    var teams = StorageSystem.loadListSync<Team>(_teamsListKey);
    print("Retrieved teams list (sync): ${teams.length} teams");
    return teams;
  }

  /// Save a team and update teams list asynchronously
  static Future<void> saveTeam(Team team) async {
    await StorageSystem.saveElement<Team>(team.teamName, team);
    await updateTeamsList(team);
    print("Team saved with name: ${team.teamName}");
  }

  /// Save a team and update teams list synchronously
  static void saveTeamSync(Team team) {
    StorageSystem.saveElementSync<Team>(team.teamName, team);
    updateTeamsListSync(team);
    print("Team saved with name (sync): ${team.teamName}");
  }

  /// Get a team by name asynchronously
  static Future<Team?> getTeam(String teamName) async {
    return await StorageSystem.getElement<Team>(teamName);
  }

  /// Get a team by name synchronously
  static Team? getTeamSync(String teamName) {
    return StorageSystem.getElementSync<Team>(teamName);
  }

  static Future<void> deleteTeamSync(String teamName) async {
    await StorageSystem.deleteElement(teamName);

    // Remove the team from the teams list
    List<Team> currentTeams = await getTeamsList();
    currentTeams.removeWhere((team) => team.teamName == teamName);
    await StorageSystem.saveList<Team>(_teamsListKey, currentTeams);

    // Log the deletion
    print("Deleted team: $teamName");
  }

  /// Check if a team exists synchronously
  static bool teamExistsSync(String teamName) {
    return StorageSystem._getBox().containsKey(teamName);
  }
}

class GabaritoStorageSystem {
  static void saveGabarito(Map<int, int> gabarito) {
    StorageSystem.saveMapSync(StorageSystem.gabaritoKey, gabarito);
    print("Saved gabarito: $gabarito");
  }

  static Map<int, int> getGabarito() {
    var gabarito = StorageSystem.loadMapSync<int, int>(
      StorageSystem.gabaritoKey,
    );
    print("Got gabarito: $gabarito");
    return gabarito;
  }
}
