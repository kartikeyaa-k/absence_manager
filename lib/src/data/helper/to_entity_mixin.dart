/// A contract to enforce model-to-entity conversion.
///
/// Every model implementing this mixin must provide a [toEntity] method
/// that maps the model to its domain-layer entity.
mixin ToEntity<T> {
  T toEntity();
}
