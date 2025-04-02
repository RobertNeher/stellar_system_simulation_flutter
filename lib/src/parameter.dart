class Parameter {
  int windowHeight = 0;
  int windowWidth = 0;
  double centerX = 0;
  double centerY = 0;
  String font = "";
  int fontSize = 0;
  int astronomicalUnit = 0;
  double gravityConstant = 0;
  double scaleFctor = 0;
  int updatePeriod = 0;
  int timeStep = 0;

  Parameter({
    required this.windowHeight,
    required this.windowWidth,
    required this.centerX,
    required this.centerY,
    required this.font,
    required this.fontSize,
    required this.astronomicalUnit,
    required this.gravityConstant,
    required this.scaleFctor,
    required this.updatePeriod,
    required this.timeStep,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      windowHeight: json['windowHeight'],
      windowWidth: json['windowWidth'],
      centerX: json['centerX'],
      centerY: json['centerY'],
      font: json['font'],
      fontSize: json['fontSize'],
      astronomicalUnit: json['astronomicalUnit'],
      gravityConstant: json['gravityConstant'],
      scaleFctor: json['scaleFactor'],
      updatePeriod: json['updatePeriod'],
      timeStep: json['timeStep'],
    );
  }

  @override
  String toString() {
    print("Parameters");
    print("AU: ${this.astronomicalUnit}");
    print("WindowH/W: ${this.windowHeight}/${this.windowWidth}");
    print("Gravity Constant: ${this.gravityConstant}");
    print("centerX/Y: ${this.centerX}/${this.centerY}");
    print("Font: ${this.font}(${this.fontSize})");
    print("Scale: ${this.scaleFctor}");
    print("Timestep: ${this.timeStep}");
    print("Period: ${this.updatePeriod}");
    return super.toString();
  }
}
