// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderHistoryHash() => r'a1e2dffec3780063d5eb2431eea684c88cbbd91c';

/// See also [OrderHistory].
@ProviderFor(OrderHistory)
final orderHistoryProvider =
    NotifierProvider<OrderHistory, List<OrderRecord>>.internal(
      OrderHistory.new,
      name: r'orderHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$orderHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OrderHistory = Notifier<List<OrderRecord>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
