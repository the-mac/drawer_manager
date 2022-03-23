
The Drawer Manager class has the ability to swap Scaffold body contents, using a custom provider.

## Features

The Drawer Manager is similar to the Android Drawer, in that it swaps out Widgets (like Android Fragments). It does this by notifying the Scaffold body of the changes needed for your selection using the DrawerManagerProvider's body property.

```dart

  Widget get body {
    return Consumer<DrawerManagerProvider>(builder: (context, dmObj, _) {
      if(drawerSelections.isNotEmpty) {
        return drawerSelections[_currentDrawer];
      } else {
        return Container();
      }
    });
  }

```

This approach allows for a cleaner development experience.


```dart

    const drawerSelections = [
      HelloPage(),
      CounterPage(),
      TheMACPage()
    ];

    final manager = Provider.of<DrawerManagerProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(title: "Some App Bar Title"),
        body: manager.body,
        drawer: DrawerManager(
            ...
            tileSelections: drawerSelections
        )
    )

```

Note: Similar to Flutter's [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html), the Drawer Manager uses [Provider](https://pub.dev/packages/provider)'s [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) as a parent class to manage user selection by displaying the Widget selection. This happens in the DrawerManagerProvider.selectDrawer method, and it basically returns from a list of onTap functions the position that was tapped. Then it uses that positin to set the current drawer selection, and notifies the Drawer Manager's body property and any other Consumers to make the update for this drawer selection.

```dart

  void selectDrawer(GestureTapCallback onTap) async {
    final position = await Future<int>.value(onTapFunctions.indexOf(onTap));
    _currentDrawerSelection = position;
    notifyListeners();
    onTap();
  }

```

## Getting started

### Install Drawer Manager
```bash

  flutter pub get provider
  flutter pub get drawer_manager

```

### Or install Drawer Manager (in pubspec.yaml)
```yaml
    
dependencies:
  flutter:
    sdk: flutter

    ...
  provider: 6.0.2
  drawer_manager: 0.0.4

```

### Import Drawer Manager
```yaml

import 'package:flutter/material.dart';
import 'package:drawer_manager/drawer_manager.dart';
    ...

```

### Add DrawerManagerProvider as MaterialApp ChangeNotifierProvider
```dart

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DrawerManagerProvider>(
        create: (_) => DrawerManagerProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const MyHomePage(),
        )
    );
  }

```

## Usage

### Set up drawer selections
```dart

    const drawerSelections = [
      HelloPage(),
      CounterPage(),
      TheMACPage()
    ];

```

### Set up drawer manager

The Drawer Manager is able to manage the selections with the [DrawerTile](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerTile-class.html) class.

```dart
        drawer: DrawerManager(
            context: context,
            drawerElements: [
                const DrawerHeader(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Icon(Icons.account_circle),
                    ),
                ),
                DrawerTile(
                    context: context,
                    leading: const Icon(Icons.hail_rounded),
                    title: Text('Hello'),
                    onTap: () async {
                        // RUN A BACKEND Hello, Flutter OPERATION
                    },
                ),
                ...
            ],
            tileSelections: drawerSelections
        )

```

Note: The [DrawerTile](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerTile-class.html) class is a child of [ListTile](https://api.flutter.dev/flutter/material/ListTile-class.html), but has a required on onTap attribute, to maintain the selection order. The first [DrawerTile](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerTile-class.html) will align with the first drawer selection. You can have more selections than tiles, but not more [DrawerTile](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerTile-class.html)s than selections.


Alternatively, you can use a Column, or a ListView for drawer elements, to easily adapt Drawer Manager into existing Drawer implementations.

### Use With a Column Widget
```dart
        drawer: DrawerManager(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  ...
              ]
            )
        )

```

### Use With a ListView Widget
```dart
        drawer: DrawerManager(
            context: context,
            child: ListView(
              children: [
                  ...
              ]
            )
        )

```

## Additional information

To view the documentation on the package, [follow this link](https://pub.dev/documentation/drawer_manager/latest/)
