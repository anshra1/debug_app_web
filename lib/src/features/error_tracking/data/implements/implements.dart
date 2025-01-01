
    import '../sources/sources.dart';
    import '../../domain/repositories/repositories.dart';
    
    class Error_trackingRepositoryImp implements Error_trackingRepository{

        final Error_trackingRemoteDataSource remoteDataSource;
        Error_trackingRepositoryImp({required this.remoteDataSource});
      
        // ... example ...
        //
        // Future<User> getUser(String userId) async {
        //     return remoteDataSource.getUser(userId);
        //   }
        // ...
    }
    