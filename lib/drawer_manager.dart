library drawer_manager;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [DrawerManagerProvider](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerManagerProvider-class.html) has the ability to swap Scaffold body contents, subclassing [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html).
///
/// A Drawer Manager is similar to the Android Drawer, in that it swaps out Widgets
/// (like Android Fragments). It does this by notifying the Scaffold body of the changes
/// needed for your selection using the DrawerManagerProvider's body property.
///
///  ```dart
///
///    Widget get body {
///      return Consumer<DrawerManagerProvider>(builder: (context, dmObj, _) {
///        if(drawerSelections.isNotEmpty) {
///          return drawerSelections[_currentDrawer];
///        } else {
///          return Container();
///        }
///      });
///    }
///
///  ```
/// Similar to Flutter's [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html), the Drawer Manager uses
/// [Provider](https://pub.dev/packages/provider)'s [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) as a parent class
/// to manage user selection by displaying the Widget selection. This happens in the
/// DrawerManagerProvider.selectDrawer method, and it basically returns from a list of onTap
/// functions the position that was tapped. Then it uses that positin to set the current 
/// drawer selection, and notifies the Drawer Manager's body property and any other Consumers 
/// to make the update for this drawer selection.
///
///
/// Selections can be more than the Drawer Tiles, but the tiles can not be more than the selections.
/// Here is an example of a DrawerManager with drawerElements and drawerSelections added.
///
/// ```dart
///
///    const drawerSelections = [
///      HelloPage(),
///      CounterPage(),
///      TheMACPage()
///    ];
/// 
///
///    final manager = Provider.of<DrawerManagerProvider>(context, listen: false);
///
///    return Scaffold(
///        appBar: AppBar(title: "Some App Bar Title"),
///        body: manager.body,
///        drawer: DrawerManager(
///            ...
///            tileSelections: drawerSelections
///        )
///    )
/// 
/// ```
class DrawerManagerProvider extends ChangeNotifier {
  int _currentDrawerSelection = 0;
  late List<Widget> drawerSelections = <Widget>[];
  late List<GestureTapCallback> onTapFunctions = <GestureTapCallback>[];

  int get selection => _currentDrawerSelection;

  Widget get body {
    return Consumer<DrawerManagerProvider>(builder: (context, dmObj, _) {
      if(drawerSelections.isNotEmpty) {
        return drawerSelections[_currentDrawerSelection];
      } else {
        return Container();
      }
    });
  }

  void selectDrawer(GestureTapCallback onTap) async {
    final position = await Future<int>.value(onTapFunctions.indexOf(onTap));
    _currentDrawerSelection = position;
    notifyListeners();
    onTap();
  }
}

/// A drawer container that has the ability to swap Scaffold body contents, using a custom provider.
///
/// A Drawer Manager is similar to the Android Drawer, in that it swaps out Widgets
/// (like Android Fragments). It does this by notifying the Scaffold body of the changes
/// needed for your selection using the DrawerManagerProvider's body property.
///
/// Similar to Flutter's [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html), the Drawer Manager uses
/// [Provider](https://pub.dev/packages/provider)'s [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) as a parent class
/// to manage user selection by displaying the Widget selection. This happens in the
/// DrawerManagerProvider.selectDrawer method, and it basically returns from a list of onTap
/// functions the position that was tapped. Then it uses that positin to set the current 
/// drawer selection, and notifies the Drawer Manager's body property and any other Consumers 
/// to make the update for this drawer selection.
///
///
/// The selections can be more than the Drawer Tiles, but the tiles can not be more than the selections.
///
/// ```dart
///
///    const drawerSelections = [
///      HelloPage(),
///      CounterPage(),
///      TheMACPage()
///    ];
/// 
/// ```
///
///
/// Here is an example of a DrawerManager with drawerElements and drawerSelections added.
///
/// ```dart
/// 
///     drawer: DrawerManager(
///         context: context,
///         drawerElements: [
///             const DrawerHeader(
///                 child: Padding(
///                     padding: EdgeInsets.only(bottom: 20),
///                     child: Icon(Icons.account_circle),
///                 ),
///             ),
///             DrawerTile(
///                 context: context,
///                 leading: const Icon(Icons.hail_rounded),
///                 title: Text('Hello'),
///                 onTap: () async {
///                     // RUN A BACKEND Hello, Flutter OPERATION
///                 },
///             ),
///             // ...
///         ],
///         tileSelections: drawerSelections
///     )
/// 
/// ```
class DrawerManager extends StatelessWidget {

  /// The provider that manages the widget presentation.
  late DrawerManagerProvider dmProvider;

  /// Sets the color of the [Material] that holds all of the [Drawer]'s
  /// contents.
  ///
  /// If this is null, then [DrawerThemeData.backgroundColor] is used. If that
  /// is also null, then it falls back to [Material]'s default.
  final Color? backgroundColor;

  /// The z-coordinate at which to place this drawer relative to its parent.
  ///
  /// This controls the size of the shadow below the drawer.
  ///
  /// If this is null, then [DrawerThemeData.elevation] is used. If that
  /// is also null, then it defaults to 16.0.
  final double? elevation;

  /// The shape of the drawer.
  ///
  /// Defines the drawer's [Material.shape].
  ///
  /// If this is null, then [DrawerThemeData.shape] is used. If that
  /// is also null, then it falls back to [Material]'s default.
  final ShapeBorder? shape;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [SliverList].
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  late Widget? child;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to
  /// [MaterialLocalizations.drawerLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  /// The widget list that is selected from to view in the app body.
  ///
  /// [List<Widget>].
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final List<Widget>? drawerElements;

  DrawerManager(
    BuildContext context, {
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.child,
    this.semanticLabel,
    this.drawerElements,
    required List<Widget> tileSelections,
  }) : super(key: key) {
    dmProvider = Provider.of<DrawerManagerProvider>(context, listen: false);
    dmProvider.drawerSelections = tileSelections;

    var drawerSelectionCount = tileSelections.length;
    final drawerTileCount = dmProvider.onTapFunctions.length;
    
    final drawerTileCountErrorMessage = 'The DrawerTile count is more than the drawer selections. Check that your DrawerTiles ($drawerTileCount), and your selections ($drawerSelectionCount) match.';
    assert(drawerTileCount <= drawerSelectionCount, drawerTileCountErrorMessage);

  }

  @override
  Widget build(BuildContext context) {

    const drawerElementsErrorMessage = 'The drawerElements value is not set. You need to pass a drawerElements value, if you are not using a Column or ListView for the child.';
    const drawerTileErrorMessage = 'The ListTile is a parent of DrawerTile, with all its attributes but includes a BuildContext. You need to pass a DrawerTile instead.';

    if(child == null) {
        
        assert(drawerElements != null, drawerElementsErrorMessage);
        child = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: drawerElements!);

        final listColumn = child as Column;
        for(var index = 0; index < listColumn.children.length; index++) {
            if(listColumn.children[index] is ListTile) {
                final listTile = listColumn.children[index] as ListTile;
                assert(listTile is DrawerTile, drawerTileErrorMessage);
            }
        }

    } else if(child is Column) {

        final listColumn = child as Column;
        for(var index = 0; index < listColumn.children.length; index++) {
            if(listColumn.children[index] is ListTile) {
                final listTile = listColumn.children[index] as ListTile;
                assert(listTile is DrawerTile, drawerTileErrorMessage);
            }
        }

    } else if (child is ListView) {
      
        final listView = child as ListView;
        final childrenDelegate = listView.childrenDelegate as SliverChildListDelegate;

        for(var index = 0; index < childrenDelegate.children.length; index++) {
            if(childrenDelegate.children[index] is ListTile) {
                final listTile = childrenDelegate.children[index] as ListTile;
                assert(listTile is DrawerTile, drawerTileErrorMessage);
            }
        }
      
    }

    return Drawer(
        key: key,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        child: child,
        semanticLabel: semanticLabel
    );
  }
}

/// A [DrawerTile](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerTile-class.html) provides access to the drawer selections, using the DrawerManagerProvider.
///
/// The Drawer Tile class is a child of [ListTile](https://api.flutter.dev/flutter/material/ListTile-class.html), but has a required on onTap
/// attribute, to maintain the selection order. The first [DrawerTile](https://pub.dev/documentation/drawer_manager/latest/drawer_manager/DrawerTile-class.html) will align with the first drawer selection. You 
/// can have more selections than tiles, but not more Drawer Tiles than selections.
/// 
/// This happens in the DrawerManagerProvider.selectDrawer method, and it returns from a list 
/// of onTap functions the position that was tapped. Then it uses that position to set the current 
/// drawer selection, and notifies the Drawer Manager's body property and any other Consumers to make 
/// the update for this drawer selection. Lastly, it calls to the onTap that was passed from the Drawer Tile.
/// 
/// ```dart
///
///  void selectDrawer(GestureTapCallback onTap) async {
///    final position = await Future<int>.value(onTapFunctions.indexOf(onTap));
///    _currentDrawerSelection = position;
///    notifyListeners();
///    onTap();
///  }
///
/// ```
///
/// Similar to Flutter's [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html), the Drawer Manager uses
/// [Provider](https://pub.dev/packages/provider)'s [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) as a parent class
/// to manage user selection by displaying the Widget selection.
///
/// Here is an example of a DrawerManager with drawerElements and more drawerSelections added than Drawer Tiles.
///
/// ```dart
///
///    const drawerSelections = [
///      HelloPage(),
///      CounterPage(),
///      TheMACPage()
///    ];
/// 
/// ```
///
/// ```dart
/// 
///     drawer: DrawerManager(
///         context: context,
///         drawerElements: [
///             const DrawerHeader(
///                 child: Padding(
///                     padding: EdgeInsets.only(bottom: 20),
///                     child: Icon(Icons.account_circle),
///                 ),
///             ),
///             DrawerTile(
///                 context: context,
///                 leading: const Icon(Icons.hail_rounded),
///                 title: Text('Hello'),
///                 onTap: () async {
///                     // RUN A BACKEND Hello, Flutter OPERATION
///                 },
///             ),
///             // ...
///         ],
///         tileSelections: drawerSelections
///     )
/// 
/// ```
class DrawerTile extends ListTile {

  static GestureTapCallback getDefaultCallback() {
    return () {};
  }

  DrawerTile({
    required BuildContext context,
    required onTap,
    Key? key,
    leading,
    title,
    subtitle,
    trailing,
    isThreeLine = false,
    dense,
    visualDensity,
    shape,
    style,
    selectedColor,
    iconColor,
    textColor,
    contentPadding,
    enabled = true,
    onLongPress,
    mouseCursor,
    selected = false,
    focusColor,
    hoverColor,
    focusNode,
    autofocus = false,
    tileColor,
    selectedTileColor,
    enableFeedback,
    horizontalTitleGap,
    minVerticalPadding,
    minLeadingWidth}) : 
    super(
      key: key,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      isThreeLine: isThreeLine,
      dense: dense,
      visualDensity: visualDensity,
      shape: shape,
      style: style,
      selectedColor: selectedColor,
      iconColor: iconColor,
      textColor: textColor,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: () {

        if(onTap != null) {
            Navigator.pop(context);
            final dMProvider = Provider.of<DrawerManagerProvider>(context, listen: false);
            dMProvider.selectDrawer(onTap);
        }

      },
      onLongPress: onLongPress,
      mouseCursor: mouseCursor,
      selected: selected,
      focusColor: focusColor,
      hoverColor: hoverColor,
      focusNode: focusNode,
      autofocus: autofocus,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      enableFeedback: enableFeedback,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: minVerticalPadding,
      minLeadingWidth: minLeadingWidth,
    ) {

        final dMProvider = Provider.of<DrawerManagerProvider>(context, listen: false);        
        if(onTap != null) {

            final drawerSelectionCount = dMProvider.drawerSelections.length;
            final drawerTileCount = dMProvider.onTapFunctions.length;
            
            if(drawerSelectionCount > 0 && drawerTileCount >= drawerSelectionCount) {
                dMProvider.onTapFunctions.clear();
            }
            dMProvider.onTapFunctions.add(onTap);
        } else {
            dMProvider.onTapFunctions.add(getDefaultCallback());
        }

    }

}