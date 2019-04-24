class Array {
//  /**
//   * @params{List} list
//   * @params{Function} cb
//   * @return{List<T>} 新的数组
//   */
  static List<T> map<T>(List list, Function cb) {
    List _list = new List<T>();
    for (var i = 0; i < list.length; i++) {
      _list.add(cb(list[i], i));
    }
    return _list;
  }
}
