import 'package:shared_preferences/shared_preferences.dart';
import 'program_item.dart';

class ProgramProvider {
  Future<List<ProgramItem>> fetchPrograms() async {
    final prefs = await SharedPreferences.getInstance();
    final programsData = prefs.getStringList('programs') ?? [];

    return programsData.map((programString) {
      return ProgramItem.fromStorageString(programString);
    }).toList();
  }

  Future<void> addProgram(ProgramItem program) async {
    final prefs = await SharedPreferences.getInstance();
    final programsData = prefs.getStringList('programs') ?? [];

    programsData.add(program.toStorageString());
    await prefs.setStringList('programs', programsData);
  }

  Future<void> deleteProgram(ProgramItem program) async {
    final prefs = await SharedPreferences.getInstance();
    final programsData = prefs.getStringList('programs') ?? [];

    programsData.removeWhere((e) => e.startsWith(program.title));
    await prefs.setStringList('programs', programsData);
  }

  Future<void> updateProgram(ProgramItem oldProgram, ProgramItem newProgram) async {
    final prefs = await SharedPreferences.getInstance();
    final programsData = prefs.getStringList('programs') ?? [];

    int index = programsData.indexWhere((e) => e.startsWith(oldProgram.title));
    if (index != -1) {
      programsData[index] = newProgram.toStorageString();
      await prefs.setStringList('programs', programsData);
    }
  }
}
