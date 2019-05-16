import 'package:flutter/material.dart';
import 'package:hquplink/widgets.dart';
import 'package:swlegion/catalog.dart';
import 'package:swlegion/swlegion.dart';

export 'tiles/army_preview.dart';
export 'tiles/command_tile.dart';

/// Creates multiple [Unit]s for a given [Rank] as a header.
class UnitTileGroup extends StatelessWidget {
  /// Cards being rendered.
  final List<Reference<Unit>> cards;

  /// Rank being displayed.
  final Rank rank;

  /// When [cards] is tapped.
  final void Function(Unit) onTap;

  UnitTileGroup({
    @required this.cards,
    @required this.rank,
    this.onTap,
  }) : assert(rank != null) {
    // ignore: prefer_asserts_in_initializer_lists
    assert(cards != null && cards.isNotEmpty);
  }

  @override
  build(context) {
    final header = <Widget>[
      Container(
        child: ListTile(
          title: Text(
            toTitleCase(rank.name),
            overflow: TextOverflow.ellipsis,
          ),
          leading: CircleAvatar(
            child: Text(rank.name[0].toUpperCase()),
          ),
        ),
        color: Theme.of(context).backgroundColor,
      ),
    ];
    final children = cards.map(
      (c) {
        return UnitTile(
          card: c,
          onTap: onTap == null ? null : () => onTap(catalog.toUnit(c)),
        );
      },
    ).toList();
    return Column(
      children: header + children,
    );
  }
}

/// Creates a [ListTile] for a [Upgrade].
class UpgradeTile extends StatelessWidget {
  /// [Upgrade] being referenced for the tile.
  final Reference<Upgrade> card;

  /// When the tile is pressed.
  final void Function() onTap;

  const UpgradeTile({
    @required this.card,
    this.onTap,
  }) : assert(card != null);

  @override
  build(_) {
    final details = catalog.toUpgrade(card);
    return ListTile(
      leading: UpgradeIcon(card: details),
      trailing: Text('${details.points}'),
      title: Text(
        details.name,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}

/// Creates multiple [Upgrade]s for a given [UpgradeSlot] as a header.
class UpgradeTileGroup extends StatelessWidget {
  /// Cards being rendered.
  final List<Reference<Upgrade>> cards;

  /// Slot being displayed.
  final UpgradeSlot slot;

  /// When [cards] is tapped.
  final void Function(Upgrade) onTap;

  UpgradeTileGroup({
    @required this.cards,
    @required this.slot,
    this.onTap,
  }) : assert(slot != null) {
    // ignore: prefer_asserts_in_initializer_lists
    assert(cards != null && cards.isNotEmpty);
  }

  @override
  build(context) {
    final header = <Widget>[
      Container(
        child: ListTile(
          title: Text(toTitleCase(slot.name)),
          leading: CircleAvatar(
            child: Text(slot.name[0].toUpperCase()),
          ),
        ),
        color: Theme.of(context).backgroundColor,
      ),
    ];
    final children = cards.map(
      (c) {
        return UpgradeTile(
          card: c,
          onTap: onTap == null ? null : () => onTap(catalog.toUpgrade(c)),
        );
      },
    ).toList();
    return Column(
      children: header + children,
    );
  }
}

class DismissBackground extends StatelessWidget {
  const DismissBackground();

  @override
  build(context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.primaryColor,
      child: Row(
        children: const [
          Icon(Icons.delete),
          Icon(Icons.delete),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
