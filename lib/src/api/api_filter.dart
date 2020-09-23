/// See filters at https://docs.directus.io/api/query/filter.html
class ApiFilter {
  final String field;
  String _operator, _value;

  ApiFilter(this.field);

  /// Equal to
  ApiFilter equals(String value) {
    this._value = value;
    this._operator = 'eq';
    return this;
  }

  /// Not equal to
  /// The negation of [equals]
  ApiFilter equalsNot(String value) {
    this._value = value;
    this._operator = 'neq';
    return this;
  }

  /// Less than
  ApiFilter lessThan(String value) {
    this._value = value;
    this._operator = 'lt';
    return this;
  }

  /// Less than or equal to
  ApiFilter lessThanOrEqualTo(String value) {
    this._value = value;
    this._operator = 'lte';
    return this;
  }

  /// Greater than
  ApiFilter greaterThan(String value) {
    this._value = value;
    this._operator = 'gt';
    return this;
  }

  /// Greater than or equal to
  ApiFilter GreaterThanOrEqualTo(String value) {
    this._value = value;
    this._operator = 'gte';
    return this;
  }

  /// Exists in one of the values
  ApiFilter isIn(String value) {
    this._value = value;
    this._operator = 'in';
    return this;
  }

  /// Not in one of the values
  /// The negation of [isIn]
  ApiFilter isNotIn(String value) {
    this._value = value;
    this._operator = 'nin';
    return this;
  }

  /// It is null
  ApiFilter isNull() {
    this._value = '';
    this._operator = 'null';
    return this;
  }

  /// It is not null
  /// The negation of [isNull]
  ApiFilter isNotNull() {
    this._value = '';
    this._operator = 'nnull';
    return this;
  }

  /// Contains the substring
  ApiFilter contains(String value) {
    this._value = value;
    this._operator = 'like';
    return this;
  }

  /// Doesn't contain the substring
  /// The negation of [containsWildcard]
  ApiFilter containsNot(String value) {
    this._value = value;
    this._operator = 'like';
    return this;
  }

  /// Contains a substring using a wildcard
  /// see https://docs.directus.io/api/query/filter.html#filter-relational
  /// Example for `ends with @directus.io`: %@directus.io
  ApiFilter containsWildcard(String value) {
    this._value = value;
    this._operator = 'rlike';
    return this;
  }

  /// Not contains a substring using a wildcard
  /// The negation of [containsWildcard]
  ApiFilter containsWildcardNot(String value) {
    this._value = value;
    this._operator = 'nrlike';
    return this;
  }

  /// The value is between two values
  /// The format for date is YYYY-MM-DD and for datetime is YYYY-MM-DD HH:MM:SS.
  /// This formats translate to 2018-08-29 14:51:22.
  ///  - Year in 4 digits
  ///  - Months, days, minutes and seconds in two digits, adding leading zero padding when it's a one digit month
  ///  - Hour in 24 hour format
  /// You can use the `now` keyword as value too (alias for current server time)
  ApiFilter between(String start, String end) {
    this._value = "$start,$end";
    this._operator = 'between';
    return this;
  }

  /// The value is not between two values
  /// The negation of [between] documentation
  ApiFilter notBetween(String start, String end) {
    this._value = "$start,$end";
    this._operator = 'nbetween';
    return this;
  }

  /// The value is empty (null or falsy)
  ApiFilter isEmpty() {
    this._value = "";
    this._operator = 'empty';
    return this;
  }

  /// The value is not empty (null or falsy)
  ApiFilter isNotEmpty() {
    this._value = "";
    this._operator = 'nempty';
    return this;
  }

  /// Contains all given related item's IDs
  /// Only works with the O2M-type fields
  /// any other type of fields used will throw an error saying the field cannot be found.
  /// [ids] should be a comma separated list of ids
  ApiFilter all(String ids) {
    this._value = ids;
    this._operator = 'all';
    return this;
  }

  /// Has [count] or more related items's IDs
  /// Only works with the O2M-type fields
  /// any other type of fields used will throw an error saying the field cannot be found.
  /// Example: ApiFilter('contributors').has('2') will return every item with at least 2 contributors relations
  /// [count] The number of minimum relations the field should have
  ApiFilter has(int count) {
    this._value = "$count";
    this._operator = 'has';
    return this;
  }

  /// By default, all chained filters are treated as ANDs, which means all
  /// conditions must match. To create an OR combination, you can use the
  /// function below. When Using chained filter, put this ApiFilter between the
  /// conditions, which should be OR's
  /// see https://docs.directus.io/api/query/filter.html#and-vs-or
  ApiFilter logicalOr() {
    this._value = "or";
    this._operator = 'logical';
    return this;
  }

  /// Get as Map Entry. Since filter is used only as GET-Parameter,
  /// use this function to apply this filter into the queryParameters map
  /// of your request.
  MapEntry<String, String> getMapEntry() {
    return MapEntry('filter[$field][$_operator]', this._value);
  }

  /// Makes toString look like the single get request entry
  toString() {
    MapEntry<String, String> mapEntry = getMapEntry();
    return "${mapEntry.key}=${mapEntry.value}";
  }
}
