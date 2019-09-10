import 'package:flutter/services.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/StringValueConstant.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/constant/SQLiteConfigConstant.dart';

/*
 * 类描述：数据库创建或者更新相关方法
 * 作者：郑朝军 on 2019/5/27
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/27
 * 修改备注：
 */
class DBCreateOrUpgradeMethod
{
  /*
   * 添加默认数据
   *
   * @param db 数据库对象
   */
  static void createDefaultData(Database db)
  {
    createDefaultDataRes(db, SQLiteConfigConstant.DATABASE_SQL_PATH);
  }

  /*
   * 添加默认数据
   *
   * @param db 数据库对象
   * @param tables 所有的表
   */
  static void createDefaultDataRes(Database db, List<String> tables) async
  {
    for (int i = 0; i < tables.length; i++)
    {
      String result = await rootBundle.loadString(tables[i]);
      List<String> sql = result.split(StringValueConstant.STR_COMMON_LINE_FEED);
      for (int i = 0; i < sql.length; i++)
      {
        if (sql[i].contains(StringValueConstant.STR_COMMON_SEMICOLON))
        {
          db.execute(sql[i]);
        }
      }
    }
  }

  /*
   * 添加默认数据
   *
   * @param db
   * @param oldVersion
   * @param newVersion
   */
  static void onUpgradeDefaultData(Database db, int oldVersion, int newVersion)
  {
    for (int i = oldVersion; i < newVersion; i++)
    {
      createOrUpdateSQLData(i, db);
    }
  }

  /*
   * 1.只能重命名据据库中的表名和向旧表中增加新的字段
   * 2.Android版SQLite不支持修改表中的字段名和删除表中的字段
   * 也不允许改变表中字段的约束条件(但是修改也可以通过增加来实现，我这里叫它打引号的’修改’)
   * 3.Android版SQLite在存储字段数据时不分类型，所以可以改变字段的类型而无需要升级
   */
  static void createOrUpdateSQLData(int name, Database db)
  {
    createDefaultDataRes(
        db, [name.toString() + StringValueConstant.STR_COMMON_SQL]);
  }
}
