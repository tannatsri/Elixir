import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elixir/bloc/network_event.dart';
import 'package:elixir/bloc/network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(ConnectionInitial());

  StreamSubscription _subscription;

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is ListenConnection) {
      _subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? ConnectionFailure()
            : ConnectionSuccess()));
      });
    }
    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
