class ListModelHelper {
  const ListModelHelper();

  static List<T> getListFromData<T>(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      (json['data'] as List<dynamic>).map(fromJsonT).toList();

  static List<T> getList<T>(
    List<dynamic> list,
    T Function(Object? json) fromJsonT,
  ) =>
      list.map(fromJsonT).toList();
}
