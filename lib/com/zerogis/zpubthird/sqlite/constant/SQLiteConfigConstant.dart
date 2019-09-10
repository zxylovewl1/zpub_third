/*
 * 类描述：数据库配置相关信息
 * 作者：郑朝军 on 2019/5/25
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/25
 * 修改备注：
 */
class SQLiteConfigConstant
{
  /*
   *  数据库版本号（版本号从1开始自增长，增量脚本从1开始自增长）
   */
  static int DATABASE_VERSION = 1;

  /*
   *  数据库名称
   */
  static String DATABASE_NAME = "oa.db";

  /*
   *  数据库脚本配置路径信息(在初始化的时候进行配置)
   */
  static List<String> DATABASE_SQL_PATH = [];
}
