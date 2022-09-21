// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC721{
    function transferFrom(
        address _from,
        address _to,
        uint _nftId
    ) external;
}

contract DutchAuction{
    uint private constant DURATION = 7 days;
    IERC721 public immutable nft;
    uint public immutable nftId;
    address  public   immutable seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;

    constructor(  

        uint _discountRate,
        uint _startingPrice,
        uint _nftId,
        address _nft

    ){

        require(_startingPrice >= _discountRate * DURATION ,"discount > price");
         startAt = block.timestamp;
         expiresAt = block.timestamp + DURATION;
         seller = payable(msg.sender);
         startingPrice = _startingPrice;
         discountRate = _discountRate;
         nft = IERC721(_nft);
         nftId = _nftId;


    }

    // this function will get the price of the nft

    function getPriceOfNFT() public view returns(uint){
        uint timeElapsed = block.timestamp - startAt;
 

        
        uint price = startingPrice - (discountRate * timeElapsed);
        return price;
    }

    function buy() external payable{
        require(block.timestamp < expiresAt, "auction expired");
        uint price = getPriceOfNFT();
        require(msg.value >= price, "ETH < price");
        nft.transferFrom(seller, msg.sender , nftId);
        uint refund = msg.value - price;
        if(refund > 0 ){
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(payable(seller));
    }

}