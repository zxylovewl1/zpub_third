/*
 * 类描述：数据库相关辅助类
 * 作者：郑朝军 on 2019/5/27
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/27
 * 修改备注：
 */
class SQLiteDBHelper
{
  //------------------拼接SQL相关--------------------------------------------------------
  /**
   * 创建 利用HashMap拼接SQL表达式
   *
   * @param fieldValues 举例： map.put("namec", "%图形%");
   * @param exp         条件：举例：exp = and
   * @param text        条件：举例：new String[]{" like '%", "%'"}
   * @return sql表达式
   * 1：id = '2' and name = 2
   * 2：sql =  time = to_date('2018-11-1', 'YYYY-MM-DD')
   */
//  static String createSQLWhereExpression(Map<String, Object> fieldValues, String exp, List<String> text)
//  {
//  int i = 0;
//  String sql;
//  Iterator iterator = fieldValues.entrySet().iterator();
//  StringBuffer stringBuffer = new StringBuffer();
//  while (iterator.hasNext())
//  {
//  Map.Entry<String, Object> entry = (Map.Entry) iterator.next();
//  sql = createSQL(entry, text);
//  if (i == 0)
//  {
//  stringBuffer.append(sql);
//  }
//  else
//  {
//  stringBuffer.append(" " + exp + " " + sql);
//  }
//  i++;
//  }
//  return stringBuffer.toString();
//  }

  static String createSQLWhereExpression(Map<String, Object> fieldValues, String exp, List<String> text)
  {
//    fieldValues
//    String sql;
//    fieldValues.forEach((key, value)
//    {
//      Map.Entry<String, Object> entry = (Map.Entry) iterator.next();
//      sql = createSQL(entry, text);
//      if (i == 0)
//      {
//        stringBuffer.append(sql);
//      }
//      else
//      {
//        sql += " " + exp + " " + sql;
//      }
//    });
//
//    return stringBuffer.toString();
  }

  /**
   * 生成SQL表达式
   * 1：如果key值为：name   则证明直接拼接
   * 2：如果key值为：time,3 则证明为时间格式类型
   *
   * @param entry 条件：举例：exp = and
   * @param text  条件：举例：new String[]{" like '%", "%'"}
   * @return sql表达式
   * 1: sql = namec like '%图形%'
   * 2: sql =  time = to_date('2018-11-1', 'YYYY-MM-DD')
   */
  static String createSQL(Map<String, Object> entry, List<String> text)
  {
//  String key = entry.keys;
//  Object value = entry.getValue();
//  String sql = "";
//  String[] keys = key.split(StringValueConstant.STR_COMMON_COMMA);
//  if (keys.length == 2)
//  {
//  sql = keys[0] + (Integer.parseInt(keys[1]) == 3 ? "=" + DBExpConstant.DB_EXP_TO_DATE + "('" + value + "', " + DBExpConstant.DB_EXP_YYYY_MM_DD + ")"
//      : text[0] + value + text[1]);
//  }
//  else
//  {
//  sql = key + text[0] + value + text[1];
//  }
//  return sql;
  }

  /**
   * 创建 利用HashMap拼接SQL表达式
   *
   * @param fieldValues 举例： map.put("namec", "%图形%");
   * @param exp         条件：举例：exp = and
   * @return sql表达式
   */
  static String createEqualSQLWhereExpression(Map<String, Object> fieldValues, String exp)
  {
    return createSQLWhereExpression(fieldValues, exp, ["= '", "'"]);
  }

  /**
   * 创建 利用HashMap拼接SQL表达式
   *
   * @param fieldValues 举例： map.put("namec", "%图形%");
   * @param exp         条件：举例：exp = and
   * @return
   */
  static String createLikeSQLWhereExpression(Map<String, Object> fieldValues, String exp)
  {
    return createSQLWhereExpression(fieldValues, exp, [" like '%", "%'"]);
  }
}
