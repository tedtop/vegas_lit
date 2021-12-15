import 'package:vegas_lit/data/models/nascar/nascar_driver.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race_results.dart';
import 'package:vegas_lit/data/providers/cloud_firestore.dart';
import 'package:vegas_lit/data/providers/sportsdata_api.dart';

class NascarRepository {
  NascarRepository({
    SportsdataApiClient? sportsProvider,
    CloudFirestoreClient? databaseProvider,
  })  : _sportsProvider = sportsProvider ?? SportsdataApiClient(),
        _databaseProvider = databaseProvider ?? CloudFirestoreClient();

  final SportsdataApiClient _sportsProvider;
  final CloudFirestoreClient _databaseProvider;

  Future<Driver> fetchDriverDetails({required String driverId}) =>
      _sportsProvider.fetchDriverDetails(driverId: driverId);

  Future<List<Driver>> fetchAllDrivers() => _sportsProvider.fetchAllDrivers();

  Future<List<Race>> fetchAllRaces() => _sportsProvider.fetchAllRaces();

  Future<RaceResults> fetchRaceResults({required String raceId}) =>
      _sportsProvider.fetchRaceResults(raceId: raceId);
}
