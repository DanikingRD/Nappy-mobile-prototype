# Steps to create a View (Screen).

The view is where the user is interacting with Widgets that are shown on the screen.

These user events request some actions which navigate to ViewModel, and the rest of ViewModel does the job.
Once ViewModel has the required data then it updates View.

1. Create a new class extending <b> ViewModel</b>.

```dart
  class LoginViewModel extends ViewModel {}
```

2. Register the ViewModel locator factory.

```dart
  Future<void> setupLocator() async {
    locator.registerFactory(() => LoginViewModel());
  }
```

3. Create a new View.

```dart
  class LoginView extends StatelessWidget {

  }
```

4. Declare an identifier for the route.

```dart
    static const String id = "/login";
```

5. Register the route on the <b> router </b>.

```dart
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginView.id:
        return MaterialPageRoute(
          builder: (_) => const LoginView();
        );
  }
}
```

6. In the build method, return a <b> ViewBuilder<?> </b>, where ? is a placeholder for your <b> ViewModel</b>.

```dart
    return ViewBuilder<LoginViewModel>(
        builder: (context, model child) {
            return Container();
        }
    );
```

7. Add your screen UI inside the <b> builder() </b> method.

8. Handle the state of your View on the ViewModel side.

```dart
class LoginViewModel extends ViewModel {
    late final TextEditingController email;

    // Fired on initState()
    @override
    void onModelReady() {
        email = TextEditingController();
    }
    // Fired on dispose();
    @override
    void onDestroy() {
        email.dispose();
    }

    void onSubmit() {
        // validate input
    }
}

```
