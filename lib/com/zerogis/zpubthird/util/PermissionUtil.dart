import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/*
 * 类描述：权限申请工具类
 * 作者：郑朝军 on 2019/5/22
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/22
 * 修改备注：
 */
class PermissionUtil
{
  /*
   * 初始化权限
   */
  static Future initPermission(List<PermissionGroup> permissionGroup)
  async
  {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions(permissionGroup);
    permissions.forEach((PermissionGroup key, PermissionStatus value)
    {
      if (value != PermissionStatus.granted)
      {
        if ((Platform.isIOS || Platform.isMacOS) &&
            (key == PermissionGroup.storage ||
                key == PermissionGroup.sms ||
                key == PermissionGroup.phone))
        {}
        else if (Platform.isAndroid &&
            (key == PermissionGroup.reminders ||
                key == PermissionGroup.photos ||
                key == PermissionGroup.mediaLibrary))
        {}
      }
      if (value == PermissionStatus.denied)
      {
        PermissionHandler().openAppSettings();
      }
    });
  }
}
