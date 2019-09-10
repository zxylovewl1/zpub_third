import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zpub_bas/zpub_bas.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/bean/DBModel.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/constant/SQLiteConfigConstant.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/constant/SQLiteConstant.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/exception/ExceptionMsg.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/helper/SQLiteDBHelper.dart';

import 'package:zpub_third/com/zerogis/zpubthird/sqlite/method/DBCreateOrUpgradeMethod.dart';
import 'package:zpub_third/com/zerogis/zpubthird/sqlite/method/SQLiteDBMethodConstant.dart';

/*
 * 类描述：数据库通用方法
 * 作者：郑朝军 on 2019/5/10
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/10
 * 修改备注：
 */
class SQLiteDBMethod implements SQLiteDBMethodConstant
{
  static SQLiteDBMethod mInstance;

  Database mDatabase;

  static SQLiteDBMethod getInstance()
  {
    if (mInstance == null)
    {
      mInstance = new SQLiteDBMethod();
    }
    return mInstance;
  }

  SQLiteDBMethod()
  {
    if (CxTextUtil.isEmptyList(SQLiteConfigConstant.DATABASE_SQL_PATH))
    {
      throw FlutterError(ExceptionMsg.EXCEPTION_MSG_DB_INIT);
    }
    initData();
  }

  Future<Database> initData()
  async
  {
    String path = await getDatabasesPath();
    path = join(path, SQLiteConfigConstant.DATABASE_NAME);
    mDatabase = await openDatabase(path,
        version: SQLiteConfigConstant.DATABASE_VERSION,
        onCreate: (Database db, int version)
        {
          DBCreateOrUpgradeMethod.createDefaultData(db);
        }, onUpgrade: (Database db, int oldVersion, int newVersion)
        {
          DBCreateOrUpgradeMethod.onUpgradeDefaultData(
              db, oldVersion, newVersion);
        });
    return mDatabase;
  }

  @override
  Future<int> create(DBModel object)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.insert(object.runtimeType.toString(), object.toJson());
      });
    }
    else
    {
      return mDatabase.insert(object.runtimeType.toString(), object.toJson());
    }
  }

  @override
  Future<int> creates(String sql)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawInsert(sql);
      });
    }
    else
    {
      return mDatabase.rawInsert(sql);
    }
  }

  @override
  Future<int> createsWithParam(String sql, [List<dynamic> arguments])
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawInsert(sql, arguments);
      });
    }
    else
    {
      return mDatabase.rawInsert(sql, arguments);
    }
  }

  @override
  Future<int> deleteAll(String tabname)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawDelete("DROP TABLE ?", [tabname]);
      });
    }
    else
    {
      return mDatabase.rawDelete("DROP TABLE ?", [tabname]);
    }
  }

  @override
  Future<int> deleteByKey(String tabname, Object key)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawDelete("DELETE FROM ? WHERE ID=?", [tabname, key]);
      });
    }
    else
    {
      return mDatabase.rawDelete("DELETE FROM ? WHERE ID=?", [tabname, key]);
    }
  }

  @override
  Future<int> deleteForEq(String tabname, String fieldName, Object value)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.delete(tabname, where: fieldName, whereArgs: [value]);
      });
    }
    else
    {
      return mDatabase.delete(tabname, where: fieldName, whereArgs: [value]);
    }
  }

  @override
  Future<int> update(String tabname, String values, String condition)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawUpdate("update " + tabname + " set " + values + " where " + condition);
      });
    }
    else
    {
      return mDatabase.rawUpdate("update " + tabname + " set " + values + " where " + condition);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllColumns(String tabname)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database
            .rawQuery("SELECT * FROM FLD WHERE TABNAME = ?", [tabname]);
      });
    }
    else
    {
      return mDatabase
          .rawQuery("SELECT * FROM FLD WHERE TABNAME = ?", [tabname]);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryBySQL(String sql)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawQuery(sql);
      });
    }
    else
    {
      return mDatabase.rawQuery(sql);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryBySQLParam(String sql,
      [List<dynamic> arguments])
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawQuery(sql, arguments);
      });
    }
    else
    {
      return mDatabase.rawQuery(sql, arguments);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryCount(String tabname)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.rawQuery("SELECT COUNT(*) FROM", [tabname]);
      });
    }
    else
    {
      return mDatabase.rawQuery("SELECT COUNT(*) FROM", [tabname]);
    }
  }

  @override
  List queryDistinct(String tabname, String column)
  {
    return null;
  }

  @override
  List queryDistinctByExp(String tabname, String column, String exp)
  {
    return null;
  }

  @override
  List queryDistinctForEq(String tabname, String column, String fieldName,
      Object value)
  {
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> queryExpLimit(String tabname, String exp,
      int limit)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.query(tabname, where: exp, limit: limit);
      });
    }
    else
    {
      return mDatabase.query(tabname, where: exp, limit: limit);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryForAll(String tabname)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.query(tabname);
      });
    }
    else
    {
      return mDatabase.query(tabname);
    }
  }

  @override
  List queryForAllAlsoForLikeAnd(String tabname,
      Map<String, Object> columnWithValue)
  {
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> queryForEq(String tabname, String fieldName, Object value)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.query(tabname, where: fieldName + "=?", whereArgs: [value]);
      });
    }
    else
    {
      return mDatabase.query(tabname, where: fieldName + "=?", whereArgs: [value]);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryForFieldValues(String tabname, Map<String, Object> fieldValues)
  {
    String exp = SQLiteDBHelper.createEqualSQLWhereExpression(fieldValues, SQLiteConstant.DB_SQL_EXPRESSION_AND);
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.query(tabname, where: exp);
      });
    }
    else
    {
      return mDatabase.query(tabname, where: exp);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryByExp(String tabname, String exp)
  {
    if (mDatabase == null)
    {
      return initData().then((database)
      {
        return database.query(tabname, where: exp);
      });
    }
    else
    {
      return mDatabase.query(tabname, where: exp);
    }
  }

  @override
  List queryForLikeAnd(String tabname, Map<String, Object> columnWithValue)
  {
    return null;
  }

  @override
  List queryForLikeOr(String tabname, Map<String, Object> columnWithValue)
  {
    return null;
  }

  @override
  List queryLimit(String tabname, String limit)
  {
    return null;
  }

  @override
  List queryOrFieldValues(String tabname, Map<String, Object> fieldValues)
  {
    return null;
  }

  @override
  List queryOrderByDescLimit(String tabname, String columnName, String limit)
  {
    return null;
  }

  @override
  List queryForFieldValuesCondition(String tabname, String condition)
  {
    return null;
  }

  void close()
  {
    mDatabase.close();
    mDatabase = null;
  }
}
