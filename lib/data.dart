import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum VehicleType {
  coupe,
  suv,
  kleinwagen,
  limousine,
  cabrio,
  bus,
  kombi,
  andere
}

enum Brand {
  volkswagen,
  audi,
  jeep,
  skoda,
  bmw,
  peugeot,
  ford,
  mazda,
  nissan,
  renault,
  mercedes_benz,
  opel,
  seat,
  citroen,
  honda,
  fiat,
  mini,
  smart,
  hyundai,
  sonstige_autos,
  alfa_romeo,
  subaru,
  volvo,
  mitsubishi,
  kia,
  suzuki,
  lancia,
  porsche,
  toyota,
  chevrolet,
  dacia,
  daihatsu,
  trabant,
  saab,
  chrysler,
  jaguar,
  daewoo,
  rover,
  land_rover,
  lada
}

enum FuelType { benzin, diesel, lpg, andere, hybrid, cng, elektro }

enum Gearbox { manuell, automatik }

class Car {
  Brand? brand;
  String? model;
  VehicleType? vehicleType;
  FuelType? fuelType;
  Gearbox? gearbox;
  int? yearRegistration;
  double? powerPS;
  double? kilometer;
  double? price;

  Car({
    this.brand,
    this.model,
    this.vehicleType,
    this.fuelType,
    this.gearbox,
    this.yearRegistration,
    this.powerPS,
    this.kilometer,
    this.price,
  });

  @override
  String toString() {
    return 'Car(brand: $brand, model: $model, vehicleType: $vehicleType, fuelType: $fuelType, gearbox: $gearbox, yearRegistration: $yearRegistration, powerPS: $powerPS, kilometer: $kilometer, price: $price)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brand': brand?.name,
      'model': model,
      'vehicleType': vehicleType?.name,
      'fuelType': fuelType?.name,
      'gearbox': gearbox?.name,
      'yearOfRegistration': yearRegistration,
      'powerPS': powerPS,
      'kilometer': kilometer,
      'price': price,
    };
  }

  String toJson() => json.encode(toMap());
}


Map<String, List<String>> models = {
  'volkswagen': [
    'golf',
    'passat',
    'scirocco',
    'transporter',
    'andere',
    'jetta',
    'polo',
    'eos',
    'touran',
    'lupo',
    'tiguan',
    'sharan',
    'up',
    'fox',
    'beetle',
    'touareg',
    'kaefer',
    'caddy',
    'phaeton',
    'cc',
    'bora',
    'amarok'
  ],
  'skoda': [
    'fabia',
    'yeti',
    'octavia',
    'roomster',
    'andere',
    'citigo',
    'superb'
  ],
  'bmw': [
    '3er',
    '5er',
    '1er',
    '7er',
    'z_reihe',
    '6er',
    'andere',
    'x_reihe',
    'm_reihe',
    'i3'
  ],
  'peugeot': ['2_reihe', '3_reihe', 'andere', '4_reihe', '1_reihe', '5_reihe'],
  'mazda': [
    '3_reihe',
    'andere',
    '6_reihe',
    '5_reihe',
    'rx_reihe',
    'mx_reihe',
    'cx_reihe',
    '1_reihe'
  ],
  'nissan': [
    'navara',
    'micra',
    'andere',
    'primera',
    'juke',
    'qashqai',
    'almera',
    'x_trail',
    'note'
  ],
  'renault': [
    'twingo',
    'clio',
    'scenic',
    'megane',
    'r19',
    'kangoo',
    'andere',
    'modus',
    'espace',
    'laguna'
  ],
  'ford': [
    'c_max',
    'fiesta',
    'escort',
    'focus',
    'mustang',
    'mondeo',
    's_max',
    'galaxy',
    'andere',
    'kuga',
    'ka',
    'transit',
    'fusion',
    'b_max'
  ],
  'mercedes_benz': [
    'a_klasse',
    'andere',
    'e_klasse',
    'b_klasse',
    'c_klasse',
    'vito',
    'sprinter',
    'slk',
    'm_klasse',
    'viano',
    's_klasse',
    'sl',
    'glk',
    'clk',
    'v_klasse',
    'cl',
    'g_klasse',
    'gl'
  ],
  'seat': [
    'arosa',
    'ibiza',
    'mii',
    'leon',
    'exeo',
    'cordoba',
    'alhambra',
    'toledo',
    'altea',
    'andere'
  ],
  'honda': ['civic', 'andere', 'jazz', 'accord', 'cr_reihe'],
  'fiat': [
    'punto',
    'panda',
    'andere',
    'stilo',
    '500',
    'ducato',
    'bravo',
    'seicento',
    'croma',
    'doblo'
  ],
  'mini': ['one', 'cooper', 'andere', 'clubman'],
  'opel': [
    'astra',
    'combo',
    'insignia',
    'corsa',
    'vectra',
    'zafira',
    'omega',
    'andere',
    'signum',
    'agila',
    'meriva',
    'tigra',
    'antara',
    'kadett',
    'vivaro',
    'calibra'
  ],
  'smart': ['fortwo', 'andere', 'roadster', 'forfour'],
  'audi': [
    'a8',
    'a1',
    'tt',
    'a6',
    '80',
    'a4',
    'a3',
    'a2',
    'a5',
    'andere',
    'q5',
    '100',
    'q7',
    '90',
    'q3',
    '200'
  ],
  'alfa_romeo': ['156', '147', '159', 'andere', 'spider', '145'],
  'subaru': ['forester', 'impreza', 'legacy', 'justy', 'andere'],
  'mitsubishi': [
    'andere',
    'colt',
    'galant',
    'carisma',
    'lancer',
    'pajero',
    'outlander'
  ],
  'hyundai': ['andere', 'getz', 'i_reihe', 'santa', 'tucson'],
  'volvo': [
    'v40',
    'v50',
    'andere',
    'c_reihe',
    'xc_reihe',
    'v70',
    's60',
    '850',
    'v60'
  ],
  'lancia': [
    'andere',
    'ypsilon',
    'lybra',
    'musa',
    'elefantino',
    'delta',
    'kappa'
  ],
  'porsche': ['andere', 'boxster', '911', 'cayenne'],
  'citroen': ['berlingo', 'c4', 'andere', 'c3', 'c5', 'c1', 'c2'],
  'toyota': [
    'andere',
    'avensis',
    'corolla',
    'verso',
    'rav',
    'yaris',
    'aygo',
    'auris'
  ],
  'kia': [
    'ceed',
    'rio',
    'andere',
    'sportage',
    'picanto',
    'sorento',
    'carnival'
  ],
  'chevrolet': ['matiz', 'andere', 'spark', 'captiva', 'aveo'],
  'dacia': ['logan', 'duster', 'sandero', 'lodgy', 'andere'],
  'suzuki': ['andere', 'grand', 'swift', 'jimny'],
  'daihatsu': [
    'cuore',
    'sirion',
    'andere',
    'charade',
    'terios',
    'move',
    'materia'
  ],
  'chrysler': ['andere', 'crossfire', '300c', 'ptcruiser', 'grand', 'voyager'],
  'jaguar': ['andere', 'x_type', 's_type'],
  'rover': ['andere', 'discovery', 'rangerover', 'freelander', 'defender'],
  'jeep': ['grand', 'wrangler', 'cherokee', 'andere'],
  'saab': ['andere', '900', '9000'],
  'daewoo': ['matiz', 'andere', 'nubira', 'lanos', 'kalos'],
  'land_rover': [
    'freelander',
    'discovery',
    'defender',
    'range_rover',
    'range_rover_sport',
    'serie_2',
    'andere',
    'range_rover_evoque',
    'serie_3'
  ],
  'trabant': ['andere', '601'],
  'lada': ['andere', 'niva', 'kalina', 'samara']
};
