// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;


contract MultiSigWallet{
    event Deposit(address indexed sender , uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner , uint indexed txId);
    event Revoke(address indexed owner , uint indexed txId);
    event Execute(uint indexed txId);


    // state balances 
    address[] public owners;

    // use the mapping data structure to check if owner
    mapping (address => bool) public isOwner;

    // number of sig required to approve a transaction
    uint public required;

    // create a struct that wiil store the transation
    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed; 
    }

    // this will store number of transactions

    Transaction[] public transactions;


    // approval of the transaction for each owner
    mapping(uint => mapping(address => bool)) public approved;

    // the constructor will initiate the owners and set the required for transaction approvals

    constructor(address[] memory _owners , uint _required){
        require(_owners.length > 0 , "owners required");
        require( _required > 0  && _required <= _owners.length , "Invalid required no of owners" );

        for(uint x ; x < _owners.length ; x++){
            address owner = _owners[x];
            require(owner != address(0), "Invalid Owner");
            require(!isOwner[owner],"Owner not unique");
            // add the owner 
            owners.push(owner);

            // update owner added in mapping
            isOwner[owner] = true;

        }
        required = _required;
    }
    // modifiers
    modifier txExist(uint _txId){
        require(_txId < transactions.length , "transaction does not exist");
        _;

    }

    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender],"already approved transaction");
        _;
    }

    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed,"transaction executed");
        _;
    }



    modifier onlyOwner(){
        require(isOwner[msg.sender], "Not owner");
        _;
    }
    // end of modifiers
    
    receive() external payable{
        emit Deposit(msg.sender , msg.value);

    }

    function submit( address _to , uint _value, bytes calldata _data) external onlyOwner {
        // adding this transactions to an array of transactions
        transactions.push(Transaction({to : _to, value : _value,data : _data , executed : false}));
        // emiting the event with transaction number
        emit Submit(transactions.length - 1);
        
    }

    function approve(uint _txId  ) 
     external
     onlyOwner
     txExist(_txId) 
     notApproved(_txId) 
     notExecuted(_txId)
     {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender , _txId);

    }

    function _getApprovalCount(uint _txId) private view returns(uint count){
        for(uint z = 0; z < owners.length ; z++){
            if(approved[_txId][owners[z]]){
                count += 1;
            }
        }
        
    }

    function execute(uint _txId) external onlyOwner txExist(_txId) notExecuted(_txId){
        require(_getApprovalCount(_txId) >= required , "transaction not approved");
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;

        (bool success,) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success,"transaction failed");
        emit  Execute(_txId);
    }
    // the owner no longer approves the transaction
    function revoke(uint _txId) external onlyOwner txExist(_txId) notExecuted(_txId){
        require(approved[_txId][msg.sender],"tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender,_txId);//
    }
    
}