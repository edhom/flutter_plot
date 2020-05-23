import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class Graph extends StatelessWidget {
  
  final List<Series> seriesList;

  Graph(this.seriesList);

  final List<ChartBehavior> behaviors = [
    RangeAnnotation([
      // Y Axis
      LineAnnotationSegment(
        0, RangeAnnotationAxisType.domain,
        color: MaterialPalette.gray.shade500,
      ),
      // X Axis
      LineAnnotationSegment(
        0, RangeAnnotationAxisType.measure,
        color: MaterialPalette.gray.shade500,
      )
    ])
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      seriesList,
      domainAxis: NumericAxisSpec(
        renderSpec: GridlineRendererSpec(
            lineStyle: LineStyleSpec(
              color: MaterialPalette.gray.shade200,
              thickness: 1,
            )
        ),
      ),
      
      behaviors: behaviors,
    );
  }
}