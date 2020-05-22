import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class Graph extends StatelessWidget {
  
  final List<Series> seriesList;

  Graph(this.seriesList);

  final List<ChartBehavior> behaviors = [
      
      RangeAnnotation([
        // X Axis
        LineAnnotationSegment(
          0, RangeAnnotationAxisType.domain,
          color: MaterialPalette.gray.shade400,
        ),
        // Y Axis
        LineAnnotationSegment(
          0, RangeAnnotationAxisType.measure,
          color: MaterialPalette.gray.shade400,
        )
      ])
    ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      seriesList, 
      behaviors: behaviors,
    );
  }
}