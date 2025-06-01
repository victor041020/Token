// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts@5.3.0/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts@5.3.0/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts@5.3.0/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts@5.3.0/access/Ownable.sol";

error MaxSupplyAlcanzado();

contract Coin is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint256 public maxSupply;

    constructor(address recipient, address initialOwner) ERC20("Coin", "MTK") Ownable(initialOwner) ERC20Permit("Coin") {
        maxSupply = 10_000_000 * 10 ** decimals();
        _mint(recipient, 1_000_000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        if (totalSupply() + amount > maxSupply) {
            revert MaxSupplyAlcanzado();
        }
        _mint(to, amount);
    }
}
