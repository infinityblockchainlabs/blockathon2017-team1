pragma solidity ^0.4.17;

contract Venue {
  struct HomeCapacity {
    uint guest;
    uint bedroom;
    uint bed;
    uint bath;
  }
  struct HomeFeature {
    bool internet;
    bool kitchen;
    bool iron;
    bool hangers;
  }
  struct PrimaryData {
    string name; 
    string description; 
    string street; 
    uint price; // Ether unit by wei
    bool isValid;
    uint checkinAt;
    uint checkoutAt;
    uint bookedAt;
  }

  struct Review {
    uint createdTime;
    address owner;
    uint rate;
    string message;
  }

  address public owner;
  address public consumer;
  PrimaryData public detail;
  HomeCapacity public capacity;
  HomeFeature public feature;

  mapping (address => PrimaryData) public bookdataHistory;

  mapping (uint => address) public bookSchedule;
  mapping (uint => address) public checkinSchedule;
  mapping (uint => address) public checkoutSchedule;

  Review[] public reviewHistory;

  modifier onlyOwner() {
    if (msg.sender == owner) {
      _;
    }
  }

  modifier onlyConsumer() {
    if (msg.sender == consumer) {
      _;
    }
  }

  modifier onlyInConsumer() {
    if (bookdataHistory[msg.sender].isValid) {
      _;
    } 
  }

  function Venue(
      string _name,
      string _description,
      string _street,
      uint _price
    ) public
  {
    owner = msg.sender;
    detail.isValid = true;
    detail.name = _name;
    detail.description = _description;
    detail.street = _street;
    detail.price = _price;
  }

  function updateCapacity(
    uint _guest,
    uint _bedroom,
    uint _bed,
    uint _bath
    ) public onlyOwner
  {
    capacity.guest = _guest;
    capacity.bedroom = _bedroom;
    capacity.bed = _bed;
    capacity.bath = _bath;
  }

  function updateFeature (
    bool _internet,
    bool _kitchen,
    bool _iron,
    bool _hangers
    ) public onlyOwner 
  {
    feature.internet = _internet;
    feature.kitchen = _kitchen;
    feature.iron = _iron;
    feature.hangers = _hangers;
  }

  function update (
      string _name,
      string _description,
      string _street,
      uint _price
    ) public onlyOwner
  {
    detail.isValid = true;
    detail.name = _name;
    detail.description = _description;
    detail.street = _street;
    detail.price = _price;
  }

  function cancel(uint refundRate) public {
    uint refundAmount = bookdataHistory[msg.sender].price * refundRate / 100;
    msg.sender.transfer(refundAmount);
    delete(bookdataHistory[msg.sender]);
  }

  function book(uint bookedAt, uint startDate, uint duration) public payable {
    // Capture venue detail
    detail.bookedAt = bookedAt;
    bookdataHistory[msg.sender] = detail;
    // Mark on book map
    for ( uint i = 0; i < duration; i++ ) {
      bookSchedule[startDate + i] = msg.sender;
    }
  }

  function checkin(uint date) public {
    if (bookSchedule[date] == msg.sender) {
      consumer = msg.sender;
      checkinSchedule[date] = msg.sender;
      bookdataHistory[msg.sender].checkinAt = date;
    }
  }

  function checkout(uint date) public onlyConsumer {
    delete(consumer);
    checkoutSchedule[date] = msg.sender;
    bookdataHistory[msg.sender].checkoutAt = date;
  }

  function postReview(uint _rate, string _message, uint _createdTime) public onlyInConsumer {
    reviewHistory.push(Review({owner: msg.sender, rate: _rate, message: _message, createdTime: _createdTime}));
  }
}