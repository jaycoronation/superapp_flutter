import 'dart:math';

class ChartScale {
  final double maxY;
  final double interval;

  ChartScale(this.maxY, this.interval);
}

ChartScale calculateChartScale(double dataMax, {int divisions = 7}) {
  if (dataMax <= 0)
  {
    return ChartScale(1, 1 / divisions);
  }

  // Step 1: calculate raw interval
  final rawInterval = dataMax / divisions;

  // Step 2: round interval nicely
  final interval = _niceNum(rawInterval, true);

  // Step 3: force maxY to exact multiple of interval
  final maxY = interval * divisions;

  return ChartScale(maxY, interval);
}

double _niceNum(double range, bool round) {
  final exponent = (log(range) / ln10).floor();
  final fraction = range / pow(10, exponent);

  double niceFraction;
  if (round)
  {
    if (fraction < 1.5)
    {
      niceFraction = 1;
    }
    else if (fraction < 3)
    {
      niceFraction = 2;
    }
    else if (fraction < 7)
    {
      niceFraction = 5;
    }
    else
    {
      niceFraction = 10;
    }
  }
  else
  {
    if (fraction <= 1)
    {
      niceFraction = 1;
    }
    else if (fraction <= 2)
    {
      niceFraction = 2;
    }
    else if (fraction <= 5)
    {
      niceFraction = 5;
    }
    else
    {
      niceFraction = 10;
    }
  }
  return niceFraction * pow(10, exponent);
}

int calculateYearInterval(List list) {
  if (list.isEmpty) return 1;

  final int startYear = list.first.year;
  final int endYear = list.last.year;
  final int yearRange = endYear - startYear + 1;
  const int targetLabelCount = 6;

  if (yearRange <= targetLabelCount)
  {
    return 1; // show every year
  }

  return (yearRange / targetLabelCount).ceil();
}

class ChartScale2 {
  final double minY;
  final double maxY;
  final double interval;

  ChartScale2(this.minY, this.maxY, this.interval);
}

ChartScale2 calculateChartScale2(double dataMin, double dataMax, {int divisions = 6}) {
  if (dataMax == dataMin) {
    return ChartScale2(dataMin, dataMax + 1, 1);
  }

  // Range
  final range = _niceNum(dataMax - dataMin, false);

  // Interval
  final interval = _niceNum(range / (divisions - 1), true);

  // Snap min and max to interval
  final minY = (dataMin / interval).floor() * interval;
  final maxY = (dataMax / interval).ceil() * interval;

  return ChartScale2(minY, maxY, interval);
}