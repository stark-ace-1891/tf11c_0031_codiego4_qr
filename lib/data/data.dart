class Data {
  static final Data _instance = Data._();

  Data._();

  factory Data() {
    return _instance;
  }

  List<Map> qrList = [
    {
      "id": 1,
      "description": "Parrilla de Don Pepe",
      "qr":
          "https://www.youtube.com/watch?v=gSvMkyOA2bc&ab_channel=Eng.MahmoudEnan",
    },
    {
      "id": 2,
      "description": "Parrilla de Don Pepe",
      "qr":
          "https://www.youtube.com/watch?v=gSvMkyOA2bc&ab_channel=Eng.MahmoudEnan",
    },
    {
      "id": 3,
      "description": "Parrilla de Don Pepe",
      "qr":
          "https://www.youtube.com/watch?v=gSvMkyOA2bc&ab_channel=Eng.MahmoudEnan",
    }
  ];
}
