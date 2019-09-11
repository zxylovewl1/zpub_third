import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/DigitValueConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/StringValueConstant.dart';

/*
 * 类描述：时间，日期选择器
 * 作者：郑朝军 on 2019/5/23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/23
 * 修改备注：
 */
class PickerUtil
{
  /*
   * 日期选择器
   */
  static Future<DateTime> createDatePicker(BuildContext context,
      {int firstDate: 1000, int lastDate: 3000})
  {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(firstDate),
      lastDate: new DateTime(lastDate),
    );
  }

  /*
   * 日期选择器
   */
  static Future<String> createDatePickerWithStr(BuildContext context,
      {int firstDate: 1000, int lastDate: 3000})
  {
    return createDatePicker(context, firstDate: firstDate, lastDate: lastDate)
        .then((value)
    {
      String yearMonthDay = DateUtil.getDateStrByDateTime(value,
          format: DateFormat.YEAR_MONTH_DAY);
      return yearMonthDay;
    });
  }

  /*
   * 时间选择器
   */
  static Future<TimeOfDay> createTimePicker(BuildContext context,
      {int firstDate: 1000, int lastDate: 3000})
  {
    return showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  /*
   * 时间选择器
   */
  static Future<String> createTimePickerWithStr(BuildContext context,
      {int firstDate: 1000, int lastDate: 3000})
  {
    return createTimePicker(context, firstDate: firstDate, lastDate: lastDate)
        .then((time)
    {
      String hourMinute = MaterialLocalizations.of(context)
          .formatTimeOfDay(time, alwaysUse24HourFormat: true) +
          StringValueConstant.STR_VALUE_COLON +
          StringValueConstant.STR_VALUE_BOTH_ZERO;
      return hourMinute;
    });
  }

  /*
   * 日期或者时间选择器
   * @param valueChangedMethod 回调方法
   * @param disptype 显示类型 【disptype = 3只是年月日】
   */
  static void createDateAndTimePicker(BuildContext context, {
    int firstDate: 1000,
    int lastDate: 3000,
    int disptype: 3,
    @required ValueChanged<String> valueChangedMethod,
  })
  {
    if (disptype == DigitValueConstant.APP_DIGIT_VALUE_3)
    {
      createDatePicker(context, firstDate: firstDate, lastDate: lastDate)
          .then((value)
      {
        String yearMonthDay = DateUtil.getDateStrByDateTime(value,
            format: DateFormat.YEAR_MONTH_DAY);
        valueChangedMethod(yearMonthDay);
      });
    }
    else if (disptype == DigitValueConstant.APP_DIGIT_VALUE_5)
    {
      createDatePicker(context, firstDate: firstDate, lastDate: lastDate)
          .then((value)
      {
        return createTimePicker(context,
            firstDate: firstDate, lastDate: lastDate)
            .then((time)
        {
          String yearMonthDay = DateUtil.getDateStrByDateTime(value,
              format: DateFormat.YEAR_MONTH_DAY);
          String hourMinute = MaterialLocalizations.of(context)
              .formatTimeOfDay(time, alwaysUse24HourFormat: true) +
              StringValueConstant.STR_VALUE_COLON +
              StringValueConstant.STR_VALUE_BOTH_ZERO;
          valueChangedMethod(
              yearMonthDay + StringValueConstant.STR_VALUE_SPACE + hourMinute);
        });
      });
    }
    else if (disptype == DigitValueConstant.APP_DIGIT_VALUE_12)
    {
      createTimePicker(context,
          firstDate: firstDate, lastDate: lastDate)
          .then((time)
      {
        String hourMinute = MaterialLocalizations.of(context)
            .formatTimeOfDay(time, alwaysUse24HourFormat: true) +
            StringValueConstant.STR_VALUE_COLON +
            StringValueConstant.STR_VALUE_BOTH_ZERO;
        valueChangedMethod(hourMinute);
      });
    }
  }
}
