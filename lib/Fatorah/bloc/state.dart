abstract class FatorahState{}

class InitialFatorahState extends FatorahState{}
class MoreServicesFatorahState extends FatorahState{}
class NewTotalPriceState extends FatorahState{
  String price;
  NewTotalPriceState(this.price);
}
