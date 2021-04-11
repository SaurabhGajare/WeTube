// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// >=0.4.21 <0.9.0

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WeTube is Ownable, ChainlinkClient{

    // mapping of user to video
    // videohash -> (upvote, downvote, owner, )

    uint public videoCount = 0;
    
    mapping(uint => Video) public videos;

    struct Video {
        uint id;
        uint upvote;
        uint downvote;
        string hash;
        string title;
        address payable creator;
    }

    // modifiers
    modifier hashExist(string memory _videoHash) {
        require(bytes(_videoHash).length > 0, "Please upload the video");
        _;
    }

    modifier titleExist(string memory _videoTitle) {
        require(bytes(_videoTitle).length > 0, "Please enter the title");
        _;
    }

    modifier senderExist {
        require(msg.sender != address(0));
        _;
    }

    modifier idExist(uint _videoId) {
        require(_videoId <= videoCount);
        require(_videoId > 0);
        _;
    }


    // functions

    function uploadVideo(string memory _videoHash, string memory _videoTitle) public 
    hashExist(_videoHash) titleExist(_videoTitle) senderExist {

        videoCount++;
        videos[videoCount] = Video(videoCount, 0, 0, _videoHash, _videoTitle, msg.sender);

        // emit videoupload event
    }

    function upVote(uint _videoId) public idExist(_videoId) {
        videos[_videoId].upvote++;
        // emit upvote event 
    }

    function downVote(uint _videoId) public idExist(_videoId){
        videos[_videoId].downvote++;
        //emit downvote event
    }

    function rewardTokens(string memory _videoHash, uint _amount) public payable hashExist(_videoHash) {
        
    }

    function returnPriceFeed() public {

    }

}