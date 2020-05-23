import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class Graph extends StatelessWidget {
  
  final List<Series> seriesList;
  final Function addTangente;
  final num lowerBound;
  final num upperBound;

  Graph(this.seriesList, this.addTangente, this.lowerBound, this.upperBound);

  final List<ChartBehavior> behaviors = [
    RangeAnnotation([
      // Y Axis
      LineAnnotationSegment(
        0, RangeAnnotationAxisType.domain,
        color: MaterialPalette.gray.shade500,
        endLabel: 'Y', 
      ),
      // X Axis
      LineAnnotationSegment(
        0, RangeAnnotationAxisType.measure,
        color: MaterialPalette.gray.shade500,
        endLabel: 'X', 
      )
    ])
  ];

  List<TickSpec<num>> createTickSpec(bool y, BuildContext context) {
    // Get ratio of current Widget to make perfect grid
    num ratio = MediaQuery.of(context).size.aspectRatio;
    num min = y ? lowerBound / ratio : lowerBound;
    num max = y ? upperBound / ratio : upperBound;
    double step = (max - min);
    step = y ? (step / (10.0 / ratio)) : (step / 10.0);
    List<TickSpec<num>> tickProvidSpecs = [
      for (var i = min; i <= max; i += step) TickSpec(i, label: i.toStringAsFixed(1))
    ];
    return tickProvidSpecs;
  }

  NumericExtents getViewPort(BuildContext context) {
    // Get ratio of current Widget to make perfect grid
    num ratio = MediaQuery.of(context).size.aspectRatio;
    double min = lowerBound / ratio;
    double max = upperBound / ratio;
    return NumericExtents(min, max);
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(

      // data
      seriesList,

      // X Axis
      domainAxis: NumericAxisSpec(
        tickProviderSpec: StaticNumericTickProviderSpec(
               createTickSpec(false, context),
        ),
        renderSpec: GridlineRendererSpec(
            lineStyle: LineStyleSpec(
              color: MaterialPalette.gray.shade200,
              thickness: 1,
            )
        ),
      ),

      primaryMeasureAxis: NumericAxisSpec(
        tickProviderSpec: StaticNumericTickProviderSpec(
               createTickSpec(true, context),
        ),
        renderSpec: GridlineRendererSpec(
            lineStyle: LineStyleSpec(
              color: MaterialPalette.gray.shade200,
              thickness: 1,
            )
        ),
        viewport: getViewPort(context),
      ),

      behaviors: behaviors,
      selectionModels: [
        SelectionModelConfig(
          type: SelectionModelType.info,
          changedListener: addTangente,
        ),
      ],
    );
  }
}