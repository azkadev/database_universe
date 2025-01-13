// ignore_for_file: non_constant_identifier_names

part of "package:database_universe/core/core.dart";

Pointer<CFilter> _buildFilter(Filter filter, List<Pointer<void>> pointers) {
  switch (filter) {
    case EqualCondition():
      final value = filter.value;
      if (value is double) {
        return DatabaseUniverseCore.b.database_universe_filter_between(
          filter.property,
          _database_universeValue(
            _adjustLowerFloatBound(value, true, filter.epsilon),
          ),
          _database_universeValue(
            _adjustUpperFloatBound(value, true, filter.epsilon),
          ),
          filter.caseSensitive,
        );
      } else {
        return DatabaseUniverseCore.b.database_universe_filter_equal(
          filter.property,
          _database_universeValue(filter.value),
          filter.caseSensitive,
        );
      }
    case GreaterCondition():
      final rawValue = filter.value;
      final value = rawValue is double
          ? _adjustLowerFloatBound(rawValue, false, filter.epsilon)
          : rawValue;
      return DatabaseUniverseCore.b.database_universe_filter_greater(
        filter.property,
        _database_universeValue(value),
        filter.caseSensitive,
      );
    case GreaterOrEqualCondition():
      final rawValue = filter.value;
      final value = rawValue is double
          ? _adjustLowerFloatBound(rawValue, true, filter.epsilon)
          : rawValue;
      return DatabaseUniverseCore.b.database_universe_filter_greater_or_equal(
        filter.property,
        _database_universeValue(value),
        filter.caseSensitive,
      );
    case LessCondition():
      final rawValue = filter.value;
      final value = rawValue is double
          ? _adjustUpperFloatBound(rawValue, false, filter.epsilon)
          : rawValue;
      return DatabaseUniverseCore.b.database_universe_filter_less(
        filter.property,
        _database_universeValue(value),
        filter.caseSensitive,
      );
    case LessOrEqualCondition():
      final rawValue = filter.value;
      final value = rawValue is double
          ? _adjustUpperFloatBound(rawValue, true, filter.epsilon)
          : rawValue;
      return DatabaseUniverseCore.b.database_universe_filter_less_or_equal(
        filter.property,
        _database_universeValue(value),
        filter.caseSensitive,
      );
    case BetweenCondition():
      final rawLower = filter.lower;
      final lower = rawLower is double
          ? _adjustLowerFloatBound(rawLower, true, filter.epsilon)
          : rawLower;
      final rawUpper = filter.upper;
      final upper = rawUpper is double
          ? _adjustUpperFloatBound(rawUpper, true, filter.epsilon)
          : rawUpper;
      return DatabaseUniverseCore.b.database_universe_filter_between(
        filter.property,
        _database_universeValue(lower),
        _database_universeValue(upper),
        filter.caseSensitive,
      );
    case StartsWithCondition():
      return DatabaseUniverseCore.b.database_universe_filter_string_starts_with(
        filter.property,
        _database_universeValue(filter.value),
        filter.caseSensitive,
      );
    case EndsWithCondition():
      return DatabaseUniverseCore.b.database_universe_filter_string_ends_with(
        filter.property,
        _database_universeValue(filter.value),
        filter.caseSensitive,
      );
    case ContainsCondition():
      return DatabaseUniverseCore.b.database_universe_filter_string_contains(
        filter.property,
        _database_universeValue(filter.value),
        filter.caseSensitive,
      );
    case MatchesCondition():
      return DatabaseUniverseCore.b.database_universe_filter_string_matches(
        filter.property,
        _database_universeValue(filter.wildcard),
        filter.caseSensitive,
      );
    case IsNullCondition():
      return DatabaseUniverseCore.b
          .database_universe_filter_is_null(filter.property);
    case AndGroup():
      if (filter.filters.length == 1) {
        return _buildFilter(filter.filters[0], pointers);
      } else {
        final filtersPtrPtr = malloc<Pointer<CFilter>>(filter.filters.length);
        pointers.add(filtersPtrPtr);
        for (var i = 0; i < filter.filters.length; i++) {
          filtersPtrPtr.setPtrAt(i, _buildFilter(filter.filters[i], pointers));
        }
        return DatabaseUniverseCore.b
            .database_universe_filter_and(filtersPtrPtr, filter.filters.length);
      }
    case OrGroup():
      if (filter.filters.length == 1) {
        return _buildFilter(filter.filters[0], pointers);
      } else {
        final filtersPtrPtr = malloc<Pointer<CFilter>>(filter.filters.length);
        pointers.add(filtersPtrPtr);
        for (var i = 0; i < filter.filters.length; i++) {
          filtersPtrPtr.setPtrAt(i, _buildFilter(filter.filters[i], pointers));
        }
        return DatabaseUniverseCore.b
            .database_universe_filter_or(filtersPtrPtr, filter.filters.length);
      }
    case NotGroup():
      return DatabaseUniverseCore.b
          .database_universe_filter_not(_buildFilter(filter.filter, pointers));
    case ObjectFilter():
      return DatabaseUniverseCore.b.database_universe_filter_nested(
        filter.property,
        _buildFilter(filter.filter, pointers),
      );
  }
}

Pointer<CDatabaseUniverseValue> _database_universeValue(Object? value) {
  if (value == null) {
    return nullptr;
  } else if (value is double) {
    return DatabaseUniverseCore.b.database_universe_value_real(value);
    // ignore: avoid_double_and_int_checks
  } else if (value is int) {
    return DatabaseUniverseCore.b.database_universe_value_integer(value);
  } else if (value is String) {
    return DatabaseUniverseCore.b.database_universe_value_string(
      DatabaseUniverseCore._toNativeString(value),
    );
  } else if (value is bool) {
    return DatabaseUniverseCore.b.database_universe_value_bool(value);
  } else if (value is DateTime) {
    return DatabaseUniverseCore.b
        .database_universe_value_integer(value.toUtc().microsecondsSinceEpoch);
  } else {
    throw ArgumentError('Unsupported filter value type: ${value.runtimeType}');
  }
}

double _adjustLowerFloatBound(double value, bool include, double epsilon) {
  if (value.isFinite) {
    if (include) {
      return value - epsilon;
    } else {
      return value + epsilon;
    }
  } else {
    return value;
  }
}

double _adjustUpperFloatBound(double value, bool include, double epsilon) {
  if (value.isFinite) {
    if (include) {
      return value + epsilon;
    } else {
      return value - epsilon;
    }
  } else {
    return value;
  }
}
