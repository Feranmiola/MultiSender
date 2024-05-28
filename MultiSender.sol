//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract multisender{

    using SafeERC20 for IERC20;

    function sendTokens(address tokenAddress, address[] calldata recievers, uint[] calldata amount) external{
        uint totalAmount;
        uint totaalAmountSent;

        for(uint i = 1; i <= amount.length; i++){
            totalAmount += amount[i - 1 ];
        }

        IERC20(tokenAddress).safeTransferFrom(msg.sender, address(this), totalAmount);

        for(uint i = 1; i <= recievers.length; i++){
            require(amount[i - 1] <= (totalAmount - totaalAmountSent), "Insufficient Balance");
            
            totaalAmountSent += amount[i - 1];
            
            IERC20(tokenAddress).safeTransfer(recievers[i - 1], amount[i - 1]);

        }


        totalAmount -= totaalAmountSent;

        if(totalAmount > 0){
            IERC20(tokenAddress).safeTransfer(msg.sender, totalAmount);
        }
           
    }

}