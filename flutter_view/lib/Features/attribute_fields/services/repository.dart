import 'package:hive_flutter/hive_flutter.dart';

abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T> getById(String id);
  Future<void> add(Entity<T> entity);
  Future<void> update(Entity<T> entity);
  Future<void> delete(Entity<T> entity);
}

class Entity<T> {
  final String id;
  final T entity;
  Entity({required this.id, required this.entity});
}

class HiveRepository<T> implements Repository<T> {
  final Box<T> box;

  HiveRepository(this.box);

  @override
  Future<List<T>> getAll() async {
    return box.values.toList();
  }

  @override
  Future<T> getById(String id) async {
    final value = await box.get(id);
    if (value == null) {
      throw Exception('Entity with id $id not found');
    }
    print('Hive Repo: $value');
    return value;
  }

  @override
  Future<void> add(Entity<T> entity) async {
    await box.put(entity.id, entity.entity);
  }

  @override
  Future<void> update(Entity<T> entity) async {
    await box.put(entity.id, entity.entity);
  }

  @override
  Future<void> delete(Entity<T> entity) async {
    await box.delete(entity.id);
  }
}
