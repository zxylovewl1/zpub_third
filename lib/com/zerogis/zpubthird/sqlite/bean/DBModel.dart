/*
 * 类描述：数据库基类对象
 * 作者：郑朝军 on 2019/5/25
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/25
 * 修改备注：
 */
abstract class DBModel
{
  /*
   * 用户ID
   */
  int id;

  Map<String, dynamic> toJson();
}
