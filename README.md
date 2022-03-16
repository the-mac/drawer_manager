
The Drawer Manager class has the ability to swap Scaffold body contents, using a custom provider.

<table border="0">
  <tr>
    <td><img width="140" src="https://raw.githubusercontent.com/the-mac/drawer_manager/main/media/drawer_manager_0.png"></td>
    <td><img width="140" src="https://raw.githubusercontent.com/the-mac/drawer_manager/main/media/drawer_manager_1.png"></td>
    <td><img width="140" src="https://raw.githubusercontent.com/the-mac/drawer_manager/main/media/drawer_manager_2.png"></td>
    <td><img width="140" src="https://raw.githubusercontent.com/the-mac/drawer_manager/main/media/drawer_manager_3.png"></td>
    <td><img width="140" src="https://raw.githubusercontent.com/the-mac/drawer_manager/main/media/drawer_manager_ezgif_resize.gif"></td>
  </tr>  
  <tr center>
    <td  align="center"><p>Open Drawer</p></td>
    <td  align="center"><p>Hello, Flutter!</p></td>
    <td  align="center"><p>Counter</p></td>
    <td  align="center"><p>The MAC</p></td>
    <td  align="center"><p>All Pages</p></td>
  </tr>   
</table>

## Features

The Drawer Manager is similar to the Android Drawer, in that it swaps out Widgets (like Android Fragments). It does this by notifying the Scaffold body of the changes needed for your selection, using the DrawerManagerProvider's body property. This approach allows for a cleaner development experience.

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

Note: Similar to Flutter's [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html), the Drawer Manager uses [Provider](https://pub.dev/packages/provider)'s [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) as a parent class to manage user selection by displaying the Widget selection.


## Getting started

### Install Provider and Drawer Manager
```bash

  flutter pub get provider
  flutter pub get drawer_manager

```

### Or install Provider and Drawer Manager (in pubspec.yaml)
```yaml
    
dependencies:
  flutter:
    sdk: flutter

    ...
  provider: 6.0.2
  drawer_manager: 0.0.3

```

### Import Drawer Manager & Provider
```yaml

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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


## Alternate Usage

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

To support this repo, take a look at the [SUPPORT.md](https://github.com/the-mac/drawer_manager/blob/main/SUPPORT.md) file.

To view the documentation on the package, [follow this link](https://pub.dev/documentation/drawer_manager/latest/)
