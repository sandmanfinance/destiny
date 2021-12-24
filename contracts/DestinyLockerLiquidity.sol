/*
        _            _           _          _          _          _           _        _   
      /\ \         /\ \        / /\       /\ \       /\ \       /\ \     _  /\ \     /\_\ 
     /  \ \____   /  \ \      / /  \      \_\ \      \ \ \     /  \ \   /\_\\ \ \   / / / 
    / /\ \_____\ / /\ \ \    / / /\ \__   /\__ \     /\ \_\   / /\ \ \_/ / / \ \ \_/ / /  
   / / /\/___  // / /\ \_\  / / /\ \___\ / /_ \ \   / /\/_/  / / /\ \___/ /   \ \___/ /   
  / / /   / / // /_/_ \/_/  \ \ \ \/___// / /\ \ \ / / /    / / /  \/____/     \ \ \_/    
 / / /   / / // /____/\      \ \ \     / / /  \/_// / /    / / /    / / /       \ \ \     
/ / /   / / // /\____\/  _    \ \ \   / / /      / / /    / / /    / / /         \ \ \    
\ \ \__/ / // / /______ /_/\__/ / /  / / /   ___/ / /__  / / /    / / /           \ \ \   
 \ \___\/ // / /_______\\ \/___/ /  /_/ /   /\__\/_/___\/ / /    / / /             \ \_\  
  \/_____/ \/__________/ \_____\/   \_\/    \/_________/\/_/     \/_/               \/_/  
                                                                                          
                                                                                by sandman.finance                                     
 */
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract DestinyLockerLiquidity is Ownable {
    using SafeERC20 for IERC20;

    uint256 public immutable UNLOCK_END_BLOCK;

    event Claim(IERC20 destinyToken, address to);


    /**
     * @notice Constructs the Destiny contract.
     */
    constructor(uint256 blockNumber) {
        UNLOCK_END_BLOCK = blockNumber;
    }

    /**
     * @notice claimSanManLiquidity
     * claimdestinyToken allows the destiny Team to send destiny Liquidity to the new delirum kingdom.
     * It is only callable once UNLOCK_END_BLOCK has passed.
     * Destiny Liquidity Policy: https://docs.destiny.farm/token-info/destiny-token/liquidity-lock-policy
     */

    function claimSanManLiquidity(IERC20 destinyLiquidity, address to) external onlyOwner {
        require(block.number > UNLOCK_END_BLOCK, "Destiny is still dreaming...");

        destinyLiquidity.safeTransfer(to, destinyLiquidity.balanceOf(address(this)));

        emit Claim(destinyLiquidity, to);
    }
}