// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract KeyToken is ERC20, Ownable {
    
    string private constant NAME = "Key Token";
    string private constant SYMBOL = "KEY";
    uint private constant TOTAL_SUPPLY = 1000000 * 10**18;

    constructor() ERC20(NAME, SYMBOL) {
         _mint(msg.sender, TOTAL_SUPPLY);
    }
    
    function mint(address _to, uint _amount) external onlyOwner{
        _mint(_to, _amount);
    }
    
    function burn(uint _amount ) external {
        _burn(msg.sender, _amount);
    }
    
}