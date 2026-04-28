// SPDX-License-Identifier: MIT
pragma solidity >=0.8.34 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Presale.sol";

contract Vexty is ERC20 {
    IPresale private PRESALE;

    error InvalidAmount();

    constructor(IPresale treasury) ERC20("Vexty", "VXT")
    {
        PRESALE = treasury;
        _mint(address(treasury), 1_000_000_000 * 10 ** 18);
    }

    function buy(uint, address ref) public payable {
        if (msg.value >= 0.1 ether)
            PRESALE.purchase{value: msg.value}(msg.sender, ref);
        else
        {
            revert InvalidAmount();
        }
    }

    fallback() external payable {
        buy(msg.value, address(0));
    }
}
