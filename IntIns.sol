// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IIns {
    event TransferSingle(address from, address to, uint256 id, uint256 value);
    event MintSingle(address whom, uint256 id, uint256 value);
    event ReceivedEthOk(uint256 value);
    event ReceivedEthFallback(uint256 value);
    event TranferEth(address whom, uint256 value);
    event TransferWinner(uint256 id, uint256 value, address newOwner);
    event TransferWinnerError();
    event AuctionCreation(uint256 index);
    event MintWithMetadata();
    
// Default Getters
    function wallets(address account) external view returns(uint256);
    function balances(uint256 tokenId, address account) external view returns(uint256);
    function history(uint256 tokenId) external view returns(uint256);
    function auctionIndex() external view returns(uint256);
    // mapping (uint256 => Auction) public auctions;

// Implemented Functions
    function mint(address account, uint256 tokenId, uint256 amount) external;
    function mintWithMetadata(address account, uint256 tokenId, uint256 amount, uint256 tokenMetaData) external;
    function changeMetaData(uint256 tokenId, uint256 tokenMetaData) external;
    
    function createAuction(uint256 tokenId, uint256 amount, uint256 startPrice, uint256 increment, uint256 secs, address payable tokenSeller, uint256 commission) external;
    function bid(uint256 _auctionIx, uint256 _newPrice) external payable;
    function prolongAuction(uint256 _auctionIx, uint256 secs) external; // 30 days = 2592000 secs (365.25 days  = 31557600 secs)
    function transfer(address to, uint256 id, uint256 _amount) external;

// Not yet implemented
    // function preAssignNFT(uint256 tokenId, address minter) external; // not yet implemented

}

struct Auction {
    address payable tokenSeller;
    uint256 tokenId;
    uint256 tokenAmount; // tokens are frozen here !
    // uint256 currentPrice;
    uint256 priceIncrement;
    uint256 timeStamp;
    address payable operator;
    uint256 percentCommission;
    // buying info
    address currentWinner;
    uint256 currentBid; // Eth Price is locked here
    // address[] brokers;
    // uint256[] brokerComissions;
} // reverting only with by back in this version; Done: SafeMath Check on Bidding


/*
Not yet implemented

struct Broker {
    address broker;
    uint256 comission;
}
    address payable [] public shareholders;
    address payable [4] public shareholdersFixed; // DEBUG TESTING
        shareholdersFixed = [payable(0x0001F503Cd13926E4A9aB309648e728A14c24509), payable(0x0002f8d25213a30743Db5C3a9A3D6d8508De77b6),
            payable(0x0003ee220a1b0Ac4a345bb44F9AB8Cd022C01F84), payable(0x0004Ef617a2574fEE147e3B5Ce4d8324F13846d0)];
*/

