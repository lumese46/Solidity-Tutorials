// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
interface IERC721{
    function transferFrom(
        address _from,
        address _to,
        uint _nftId
    ) external;
}

contract EnglishAuction{
    event Start();
    event end(address _winner , uint _value);
    event Bid(address indexed _bidder, uint _value);
    event Withdraw(address indexed _bidder , uint _value);
    
    // this is for the nft 
    IERC721 public immutable nft;
    // this is for the nft address
    uint public immutable nftId;
    // this is the seller
    address  public    immutable  seller;
    

    // keep track of the state of the auction
    bool public started;
    // end auction
    uint32 public endAt;
    // end time
    bool public ended;
    address public highestBidder;
    uint public highestBid;


    mapping(address => uint) public bids;
    
    // initialize every state variable 
    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = msg.sender;
        highestBid = _startingBid;
        
    }

    function start() external{
        require(msg.sender == seller , "not seller");
        require(!started,"started");
        started = true;

        endAt = uint32(block.timestamp + 120);
        nft.transferFrom(seller, address(this), nftId);

        emit Start();
    }

    function bid() payable external{
        require(started , "not started");
        require(block.timestamp < endAt ,"ended");
        require(msg.value > highestBid , "amount is low");
        // this only adds you if you were outbidded
        if (highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender , msg.value);

    }

    function withdraw() payable external{
        uint bal = bids[msg.sender];
        // to prevent reatrancy
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);


    }

    function EndAuction() external payable{
        require(block.timestamp >= endAt);
        require(!ended,"ended");
        require(started,"not started");
        ended = true;

        if (highestBidder != address(0)){
            //transfer nft 
            nft.transferFrom(address(this), highestBidder, nftId);

            //Pay the seller
            payable(seller).transfer(highestBid);

            

        }else{
            nft.transferFrom(address(this), seller, nftId);
        }
        

        emit end(highestBidder,highestBid);
        
        // record ended time
        

        

    }

    
    

}