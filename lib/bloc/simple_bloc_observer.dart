import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('Transition ($bloc, $transition)');
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print('Event ($bloc, $event)');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('Error ($cubit, $error)');
    print(stackTrace);
    super.onError(cubit, error, stackTrace);
  }
}
