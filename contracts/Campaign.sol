// SPDX-License-Identifier: Unlicensed

pragma solidity >0.7.0 <=0.9.0;


contract CampaignFactory{

    address[] public deployedCampaigns;

    event campaignCreated(string title,uint requiredAmount,
    address indexed owner,address campaignAddress, string imgURI,
    uint indexed timeStamp,string indexed category);

    function createCampaign(string memory campaignTitle,
    uint requiredCampaignAmount,
    string memory imageURI,
    string memory category,
    string memory storyURI) public {
        Campaign newCampaign = new Campaign(campaignTitle,requiredCampaignAmount,imageURI,storyURI);

        deployedCampaigns.push(address(newCampaign));

        emit campaignCreated(campaignTitle,
        requiredCampaignAmount,
        msg.sender,
        address(newCampaign),
        imageURI,
        block.timestamp,
        category);
    }
}

contract Campaign{
    string public title;
    uint public requiredAmount;
    string public image;
    string public story;
    address payable public owner;
    uint public recievedAmount;

    event donated(address indexed donar,uint indexed amount,uint indexed timestamp);

    constructor(string memory campaignTitle,uint requiredCampaignAmount,
    string memory imageURI,string memory storyURI){
        title=campaignTitle;
        requiredAmount=requiredCampaignAmount;
        image=imageURI;
        story=storyURI;
        owner=payable(msg.sender);
    }

    function donate() public payable{
        require(requiredAmount>recievedAmount,"required Amount fulfilled");
        owner.transfer(msg.value);
        recievedAmount+=msg.value;
        emit donated(msg.sender,msg.value,block.timestamp);
    }

}