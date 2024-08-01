import 'package:flutter/material.dart';
import 'package:rentors/model/DropDownItem.dart';
import 'package:rentors/model/home/HomeModel.dart';

enum DurationTypeEnum { HOURS, DAYS, MONTHS }

// DropDownItem(1, "Hours"),
// DropDownItem(2, "Days"),
// DropDownItem(3, "Months"),
extension DurationType on DurationTypeEnum {
  DropDownItem get item {
    switch (this) {
      case DurationTypeEnum.HOURS:
        return DropDownItem(PriceUnit.HOUR, "Hours");
      case DurationTypeEnum.DAYS:
        return DropDownItem(PriceUnit.DAY, "Days");
      case DurationTypeEnum.MONTHS:
        return DropDownItem(PriceUnit.MONTH, "Months");
      default:
        return null;
    }
  }
}

extension TimeCompare on TimeOfDay {
  double get toDouble {
    return this.hour + this.minute / 60.0;
  }
}

extension PriceUnitType on PriceUnit {
  DropDownItem get item {
    switch (this) {
      case PriceUnit.HOUR:
        return DropDownItem(PriceUnit.HOUR, "Hours");
      case PriceUnit.DAY:
        return DropDownItem(PriceUnit.DAY, "Days");
      case PriceUnit.MONTH:
        return DropDownItem(PriceUnit.MONTH, "Months");
      default:
        return null;
    }
  }
}

extension DateHelper on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }
}
