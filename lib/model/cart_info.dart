class CartInfoModel {
  String goodsId;
  String goodName;
  int count;
  double price;
  String images;
  bool isCheck;

  CartInfoModel(
      {this.goodsId, this.goodName, this.count, this.price, this.images});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodName = json['goodName'];
    count = json['count'];
    price = json['price'];
    isCheck = json['isCheck'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodName'] = this.goodName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['isCheck'] = this.isCheck;
    data['images'] = this.images;
    return data;
  }
}