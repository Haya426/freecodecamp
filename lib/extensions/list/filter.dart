extension Filter<T> on Stream<List<T>>{ //This means you can use this extension method on any Stream<List<T>>
  Stream<List<T>> filter(bool Function(T) where)=>
      map((items) => items.where(where).toList());
}
//items.where(where) filters this list by applying the where function.
// The where function is expected to return true for elements that 
//should be included in the filtered list and false for those that should be excluded.