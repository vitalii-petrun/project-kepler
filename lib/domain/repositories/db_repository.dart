abstract class DBRepository<T> {
  Future<T> get(String id);
  Stream<List<T>> getAll();
  Future<void> add(T item);
  Future<void> update(String id, T item);
  Future<void> delete(String id);
}
