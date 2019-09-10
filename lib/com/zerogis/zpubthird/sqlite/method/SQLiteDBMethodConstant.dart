/*
 * 类描述：数据库通用方法接口
 * 作者：郑朝军 on 2019/5/10
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/10
 * 修改备注：
 */
abstract class SQLiteDBMethodConstant
{
  /*
   * 创建一条数据
   *
   * @param sql 一个sql语句
   * @ 异常
   */
  Future<int> creates(String sql);

  /*
   * 创建一条数据
   *
   * @param sql 一个sql语句 【sql=insert into entity(tabname,tabb) value('fld',?)】
   * @param arguments 参数 【arguments=[1]】
   */
  Future<int> createsWithParam(String sql, [List<dynamic> arguments]);

  /*
   * 删除表中符合列名记录(delete* from  entity where fieldName = value)
   *
   * @param tabname     你要删除哪个表
   * @param fieldName 你要删除哪个表的字段举例：id
   * @param value     你要删除哪个表的值举例：1
   * @;
   */
  Future<int> deleteForEq(String tabname, String fieldName, Object value);

  /*
   * 删除表中符合列名记录（默认建为id）
   *
   * @param tabname 表名
   * @param key     要删除id的值：举例：key = 2
   * @;
   */
  Future<int> deleteByKey(String tabname, Object key);

  /*
   * 删除表中所有记录
   *
   * @param tabname 表名
   */
  Future<int> deleteAll(String tabname);

  /*
   * 更新一条数据
   *
   * @param tabname   表名
   * @param values    值，举例：column1=value, column2=value2,...
   * @param condition 条件，举例：id = 1
   */
  Future<int> update(String tabname, String values, String condition);

  /*
   * 查询表对应所有的列名（id除外）
   *
   * @param tabname 表名
   * @return 表中所有的列
   * @; 异常
   */
  Future<List<Map<String, dynamic>>> queryAllColumns(String tabname);

  /*
   * 查询所有
   *
   * @param tabname 表名的class
   * @return 查询所有列表记录
   * @;
   */
  Future<List<Map<String, dynamic>>> queryForAll(String tabname);

  /*
   * 查询有多少条数据
   *
   * @param tabname 表名
   * @return 查询所有列表记录
   * @;
   */
  Future<List<Map<String, dynamic>>> queryCount(String tabname);

  /*
   * 根据键值对查询(select * from entiy where id = '2' and name = 'zcj')
   *
   * @param tabname     表名
   * @param fieldValues 查询列和值的map对象举例： map.put("namec", "%图形%");
   * @return 集合
   */
  Future<List<Map<String, dynamic>>> queryForFieldValues(String tabname, Map<String, Object> fieldValues);

  /*
   * 根据键值对查询(select * from entiy where id = '2' and name = 'zcj')
   *
   * @param tabname     表名
   * @param exp         查询列和值的map对象举例 id = '2' and name = 'zcj'
   * @return 集合
   */
  Future<List<Map<String, dynamic>>> queryByExp(String tabname, String exp);

  /*
   * 根据键值对查询(select * from entiy where id = '2' or name = 'zcj')
   *
   * @param tabname     表名
   * @param fieldValues 查询列和值的map对象举例： map.put("namec", "%图形%");
   * @return 集合
   * @; 异常
   */
  List queryOrFieldValues(String tabname, Map<String, Object> fieldValues);

  /*
   * 根据表名查询(select * from entiy where (传递过来的表达式))
   *
   * @param tabname   表名
   * @param condition 查询条件;
   * @return 集合
   * @; 异常
   */
  List queryForFieldValuesCondition(String tabname, String condition);

  /*
   * 匹配一个(select * from entiy where id = '2')
   *
   * @param tabname   你要查询哪个表的tabname举例：entity
   * @param fieldName 你要查询哪个表的字段举例：id
   * @param value     你要查询哪个表的值举例：1
   * @return
   * @throws SQLException
   */
  Future<List<Map<String, dynamic>>> queryForEq(
      String tabname, String fieldName, Object value);

  /*
   * 模糊查询数据(select * from entiy where id  like '%2%' and name like '%2%')
   *
   * @param tabname         你要查询哪个表的Class举例：Entity
   * @param columnWithValue 模糊查询列和值的map对象举例： map.put("namec", "%图形%");
   */
  List queryForLikeAnd(String tabname, Map<String, Object> columnWithValue);

  /*
   * 模糊查询数据(select * from entiy where id  like '%2%' or name like '%2%')
   *
   * @param tabname         你要查询哪个表的Class举例：Entity
   * @param columnWithValue 模糊查询列和值的map对象举例： map.put("namec", "%图形%");
   */
  List queryForLikeOr(String tabname, Map<String, Object> columnWithValue);

  /*
   * 查询
   * 1：模糊查询数据(select * from entiy where id  like '%2%' or name like '%2%')
   * 2：或者直接查询所有queryForAll(表名)
   *
   * @param tabname         你要查询哪个表的Class举例：Entity
   * @param columnWithValue 模糊查询列和值的map对象举例： map.put("namec", "%图形%");
   * @return
   * @;
   */
  List queryForAllAlsoForLikeAnd(
      String tabname, Map<String, Object> columnWithValue);

  /*
   * 查询Distinct，根据column
   *
   * @param tabname 表名的class
   * @param column  举例：column = name, tabname
   * @return 查询到刷选的记录
   * @;
   */
  List queryDistinct(String tabname, String column);

  /*
   * 查询Distinct，根据column,匹配一个根据条件
   *
   * @param tabname   表名的class
   * @param column    举例：column = name, tabname
   * @param fieldName 你要查询哪个表的字段举例：id
   * @param value     你要查询哪个表的值举例：1
   * @return 查询到刷选的记录
   * @;
   */
  List queryDistinctForEq(
      String tabname, String column, String fieldName, Object value);

  /*
   * 查询Distinct，根据column,匹配根据条件
   *
   * @param tabname 表名的class
   * @param column  举例：column = name, tabname
   * @param exp     条件 举例：exp = "id>1"
   * @return 查询到刷选的记录
   * @;
   */
  List queryDistinctByExp(String tabname, String column, String exp);

  /*
   * 查询降序分页查询
   *
   * @param tabname    表名 举例：tabname = Entity
   * @param columnName 对那个字段进行降序 举例：columnName = id
   * @param limit      分成几页 举例：limit = 0,1
   * @return 对应的集合
   * @;
   */
  List queryOrderByDescLimit(String tabname, String columnName, String limit);

  /*
   * 分页查询
   *
   * @param tabname 表名 举例：tabname = Entity
   * @param limit   分成几页 举例：limit = 0,1
   * @return 对应的集合
   * @;
   */
  List queryLimit(String tabname, String limit);

  /*
   * 分页查询
   *
   * @param tabname 表名 举例：tabname = Entity
   * @param exp     条件：举例 exp = id>0
   * @param limit   分成几页 举例：limit = 0,1
   * @return 对应的集合
   * @;
   */
  Future<List<Map<String, dynamic>>> queryExpLimit(
      String tabname, String exp, int limit);

  /*
   * 查询语句
   *
   * @param tabname 表名
   * @param sql     sql语句
   * @return 集合
   * @; 异常
   */
  Future<List<Map<String, dynamic>>> queryBySQL(String sql);

  /*
   * 查询语句
   *
   * @param sql     sql语句
   * @param arguments     参数
   * @return 集合
   * @; 异常
   */
  Future<List<Map<String, dynamic>>> queryBySQLParam(String sql,
      [List<dynamic> arguments]);

  /*
   * 关闭数据库连接,如果是直接new产生对对象需要调用此方法
   */
  void close();
}
