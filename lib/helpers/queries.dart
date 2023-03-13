const String getUpcomingLaunchesQuery = '''
   query { launches  {
    mission_name
    launch_date_local
    rocket {
        rocket_name
    }
    details
    } }
 ''';
