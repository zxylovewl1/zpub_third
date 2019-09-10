import 'package:shared_preferences/shared_preferences.dart';

/*
 * 功能：本地存储工具类
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class SPUtil
{
  /*
   * 保存在手机里面的文件名
   */
  static final String FILE_NAME = "zmoa";

  /*
   * 用户帐号信息
   */
  static final String MEMBER_INFO = "member_info";
  static final String MEMBER_TOKEN = "member_token";
  static final String MEMBER_SVR = "member_svr";
  static final String MEMBER_SVR_MAP = "member_svr_map";

  /*
   * APP唯一标示
   */
  static final String APP_UUID = "app_uuid";

  /*
   * 是否第一次启动
   */
  static final String IS_FIRST_START = "is_first_start";

  static SharedPreferences mSharedPreferences;

  static Future<SharedPreferences> init() async
  {
    mSharedPreferences = await SharedPreferences.getInstance();
  }

  /*
   * 保存数据的方法，我们需要拿到保存数据的具体类型，然后根据类型调用不同的保存方法
   */
  static void put(String key, Object object) async
  {
    if (mSharedPreferences == null)
    {
      init();
    }
    if (object is String)
    {
      mSharedPreferences.setString(key, object);
    }
    else if (object is int)
    {
      mSharedPreferences.setInt(key, object);
    }
    else if (object is bool)
    {
      mSharedPreferences.setBool(key, object);
    }
    else if (object is double)
    {
      mSharedPreferences.setDouble(key, object);
    }
    else if (object is List<String>)
    {
      mSharedPreferences.setStringList(key, object);
    }
  }

  /*
   * 得到保存数据的方法，我们根据默认值得到保存的数据的具体类型，然后调用相对于的方法获取值
   */
  static dynamic get(String key, Object defaultObject)
  {
    if (mSharedPreferences == null)
    {
      init();
    }
    if (defaultObject is String)
    {
      return mSharedPreferences.getString(key);
    }
    else if (defaultObject is int)
    {
      return mSharedPreferences.getInt(key);
    }
    else if (defaultObject is bool)
    {
      return mSharedPreferences.getBool(key);
    }
    else if (defaultObject is double)
    {
      return mSharedPreferences.getDouble(key);
    }
    else if (defaultObject is List<String>)
    {
      return mSharedPreferences.getStringList(key);
    }
  }

  /*
   * 清除所有数据
   */
  static void clear()
  {
    if (mSharedPreferences == null)
    {
      init();
    }
    mSharedPreferences.clear();
  }
}
