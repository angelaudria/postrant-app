import 'package:posrant/service/product_service/product_service.dart';
import 'package:posrant/service/table_service/table_service.dart';

class DummyService {
  List<Map<String, dynamic>> productList = [
    {
      "id": 1,
      "product_name": "Nasi Goreng",
      "price": 25000.0,
      "category": "Makanan",
      "description": "Nasi yang digoreng dengan bumbu khas Indonesia",
      "photo":
          "https://media.istockphoto.com/id/508200257/id/foto/nasi-goreng-dengan-telur-goreng-ayam-dan-udang.jpg?s=612x612&w=0&k=20&c=10n5tLQ6a59P0KI6KPDUEXeS-lhjphR6xj3hzzHSpSE=",
    },
    {
      "id": 2,
      "product_name": "Sate Ayam",
      "price": 15000.0,
      "category": "Makanan",
      "description": "Potongan daging ayam yang ditusuk dan dibakar",
      "photo":
          "https://media.istockphoto.com/id/1154908183/id/foto/sate-ayam-thailand-dengan-saus-kacang.webp?b=1&s=170667a&w=0&k=20&c=J7zgt0-bqO0RNP3CTp9RCBKfPYxkid5Uue9v6n_Zp4I=",
    },
    {
      "id": 3,
      "product_name": "Gado-Gado",
      "price": 18000.0,
      "category": "Makanan",
      "description": "Sayuran segar dengan saus kacang",
      "photo":
          "https://media.istockphoto.com/id/1477364626/id/foto/gado-gado-adalah-masakan-indonesia.webp?b=1&s=170667a&w=0&k=20&c=BDkkU_fmurIZFmfLKaeV-mrxv3D54XuqA9HXLnnxfQU=",
    },
    {
      "id": 4,
      "product_name": "Rendang",
      "price": 35000.0,
      "category": "Makanan",
      "description": "Daging sapi dimasak dalam rempah-rempah kaya",
      "photo":
          "https://media.istockphoto.com/id/1252863118/id/foto/rendang-or-randang.webp?b=1&s=170667a&w=0&k=20&c=1KM38Wxt84twQSt8RKC834gxHoI6lkAPVs0a14pdEfc=",
    },
    {
      "id": 5,
      "product_name": "Soto Ayam",
      "price": 20000.0,
      "category": "Makanan",
      "description": "Sup ayam dengan tambahan bumbu dan rempah-rempah",
      "photo":
          "https://media.istockphoto.com/id/849603518/id/foto/sup-ayam-indonesia-dengan-telur-rebus-tomat-tauge-lemon-cabai-rawit-dengan-latar-belakang-kayu.webp?b=1&s=170667a&w=0&k=20&c=pftM2fNBbAXgK4LviJPXWTjt9fQg6Odt5rpJLnx00iA=",
    },
    {
      "id": 6,
      "product_name": "Martabak Manis",
      "price": 25000.0,
      "category": "Makanan",
      "description": "Adonan tipis yang diisi dengan cokelat atau keju",
      "photo":
          "https://media.istockphoto.com/id/1333932979/id/foto/irisan-martabak-manis.webp?b=1&s=170667a&w=0&k=20&c=8Cn6BgWl_1kZGZKCKyOnFGHdHhdSFmVwT0oM0P4C5Ic=",
    },
    {
      "id": 7,
      "product_name": "Sate Padang",
      "price": 20000.0,
      "category": "Makanan",
      "description": "Sate dengan kuah khas Padang",
      "photo":
          "https://media.istockphoto.com/id/473455072/id/foto/bidang-02.webp?b=1&s=170667a&w=0&k=20&c=2dsm6w1y_DpRLQfH1yhk0qbmb16YgmoxvUAB0e2TGfE=",
    },
    {
      "id": 8,
      "product_name": "Pempek",
      "price": 18000.0,
      "category": "Makanan",
      "description": "Kulit ikan yang digoreng dengan saus cuko",
      "photo":
          "https://media.istockphoto.com/id/1476090742/id/foto/pempek.webp?b=1&s=170667a&w=0&k=20&c=wywn2mbit6xcewzCDl-OnYEtqqH1e0GBpXL9DkAcUxM=",
    },
    {
      "id": 9,
      "product_name": "Sop Buntut",
      "price": 30000.0,
      "category": "Makanan",
      "description": "Sup dengan tulang ekor sapi",
      "photo":
          "https://media.istockphoto.com/id/1401347286/id/foto/sup-buntut-atau-sop-buntut.webp?b=1&s=170667a&w=0&k=20&c=yXWVnWetp9_4xi-X8s7TTTfogqMJeYg_n-XzOHkOC08=",
    },
    {
      "id": 10,
      "product_name": "Pisang Goreng",
      "price": 10000.0,
      "category": "Makanan",
      "description":
          "https://media.istockphoto.com/id/802641122/id/foto/pisang-goreng.webp?b=1&s=170667a&w=0&k=20&c=9d_3hEx6-B_3Nht1FgLLB9NbXCNusRHwG66MvqLSAUQ=",
    }
  ];

  generate() async {
    for (var item in productList) {
      await ProductService().create(
        photo: item["photo"],
        productName: item["product_name"],
        price: item["price"],
        category: item["category"],
        description: item["description"],
      );
    }
  }

  generateTables() async {
    await TableService().deleteAll();
    for (var i = 1; i <= 32; i++) {
      await TableService().create(
        orderIndex: i,
        tableNumber: "$i",
      );
    }
  }
}
